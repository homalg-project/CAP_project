# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

# helper
InstallGlobalFunction( "CAP_JIT_INTERNAL_RESOLVE_EXPR_REF_FVAR_RECURSIVELY", function ( tree, func_stack )
  local func, pos;
    
    while tree.type = "EXPR_REF_FVAR" do
        
        func := First( func_stack, func -> func.id = tree.func_id );
        Assert( 0, func <> fail );
        
        pos := Position( func.nams, tree.name );
        
        Assert( 0, pos <> fail );
        
        # the fvar might be an argument, which has no binding
        if pos <= func.narg then
            
            break;
            
        fi;
        
        tree := CapJitValueOfBinding( func.bindings, tree.name );
        
    od;
    
    return tree;
    
end );

InstallGlobalFunction( CapJitInlinedBindings, function ( tree )
  local inline_var_refs_only, pre_func, result_func, additional_arguments_func;
    
    inline_var_refs_only := ValueOption( "inline_var_refs_only" ) = true;
    
    pre_func := function ( tree, func_stack )
      local new_bindings, value, orig_tree, funccall_stack, funccall, pos, name;
        
        # drop bindings which will be inlined anyway
        # func_stack still references the original functions with unmodified bindings
        if tree.type = "FVAR_BINDING_SEQ" then
            
            # check that tree.names and the record entries are in sync
            # otherwise we might "lose" bindings unexpectedly
            Assert( 0, IsSortedList( tree.names ) );
            Assert( 0, SortedList( Filtered( RecNames( tree ), name -> StartsWith( name, "BINDING_" ) ) ) = List( tree.names, name -> Concatenation( "BINDING_", name ) ) );
            
            new_bindings := rec(
                type := "FVAR_BINDING_SEQ",
                names := [ ],
            );
            
            for name in tree.names do
                
                value := CAP_JIT_INTERNAL_RESOLVE_EXPR_REF_FVAR_RECURSIVELY( CapJitValueOfBinding( tree, name ), func_stack );
                
                # RETURN_VALUE and those not inlined below should be kept
                if name = "RETURN_VALUE" or not (not inline_var_refs_only or value.type = "EXPR_REF_GVAR" or value.type = "EXPR_REF_FVAR") then
                    
                    CapJitAddBinding( new_bindings, name, CapJitValueOfBinding( tree, name ) );
                    
                fi;
                
            od;
            
            return new_bindings;
            
        fi;
        
        orig_tree := tree;
        
        tree := CAP_JIT_INTERNAL_RESOLVE_EXPR_REF_FVAR_RECURSIVELY( tree, func_stack );
        
        # do not try any cancellation (see below) if we should only inline references to variables
        if inline_var_refs_only then
            
            if not IsIdenticalObj( orig_tree, tree ) and (tree.type = "EXPR_REF_GVAR" or tree.type = "EXPR_REF_FVAR") then
                
                Assert( 0, orig_tree.type = "EXPR_REF_FVAR" );
                
                Info( InfoCapJit, 1, "####" );
                Info( InfoCapJit, 1, "Inline reference to binding with name ", orig_tree.name, "." );
                
                return CapJitCopyWithNewFunctionIDs( tree );
                
            else
                
                return orig_tree;
                
            fi;
            
        fi;
        
        # Try to cancel Attribute( Objectify( ... ) ) immediately for performance.
        # Doing this would be easy in result_func but that would defeat the purpose of cancellation BEFORE inlining.
        while true do
            
            funccall_stack := [ ];
            
            value := tree;
            
            while CapJitIsCallToGlobalFunction( value, gvar -> IsAttribute( ValueGlobal( gvar ) ) ) and value.args.length = 1 do
                
                Add( funccall_stack, value );
                
                value := CAP_JIT_INTERNAL_RESOLVE_EXPR_REF_FVAR_RECURSIVELY( value.args.1, func_stack );
                
            od;
            
            while Length( funccall_stack ) > 0 and CapJitIsCallToGlobalFunction( value, gvar -> gvar = "ObjectifyObjectForCAPWithAttributes" or gvar = "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes" ) do
                
                funccall := Remove( funccall_stack );
                
                if funccall.funcref.gvar = "CapCategory" then
                    
                    pos := 2;
                    
                elif funccall.funcref.gvar = "Source" then
                    
                    Assert( 0, value.funcref.gvar = "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes" );
                    
                    pos := 3;
                    
                elif funccall.funcref.gvar = "Range" then
                    
                    Assert( 0, value.funcref.gvar = "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes" );
                    
                    pos := 4;
                    
                else
                    
                    pos := PositionProperty( value.args, a -> a.type = "EXPR_REF_GVAR" and IsIdenticalObj( ValueGlobal( a.gvar ), ValueGlobal( funccall.funcref.gvar ) ) );
                    
                    if pos = fail then
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        Error( "Could not find attribute" );
                        
                    fi;
                    
                    pos := pos + 1;
                    
                fi;
                
                Assert( 0, pos <= value.args.length );
                
                Info( InfoCapJit, 1, "####" );
                Info( InfoCapJit, 1, "Cancel ", value.funcref.gvar, " during inlining." );
                
                value := CAP_JIT_INTERNAL_RESOLVE_EXPR_REF_FVAR_RECURSIVELY( value.args.(pos), func_stack );
                
            od;
            
            if Length( funccall_stack ) = 0 and not IsIdenticalObj( tree, value ) then
                
                tree := value;
                
                # value might again be a function call of an attribute -> iterate from the beginning
                continue;
                
            else
                
                if IsIdenticalObj( orig_tree, tree ) then
                    
                    return orig_tree;
                    
                else
                    
                    return CapJitCopyWithNewFunctionIDs( tree );
                    
                fi;
                
            fi;
            
        od;
        
    end;
    
    result_func := function ( tree, result, keys, func_stack )
      local new_nams, name, value, key, i;
        
        tree := ShallowCopy( tree );
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        # drop names of bindings which have been inlined
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            new_nams := [ ];
            
            for i in [ 1 .. Length( tree.nams ) ] do
                
                name := tree.nams[i];
                
                if i <= tree.narg or name in tree.bindings.names then
                    
                    Add( new_nams, name );
                    
                fi;
                
            od;
            
            Assert( 0, "RETURN_VALUE" in new_nams );
            
            tree.nams := new_nams;
            
        fi;
        
        return tree;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_stack, [ tree ] );
            
        else
            
            return func_stack;
            
        fi;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, result_func, additional_arguments_func, [ ] );
    
end );

InstallGlobalFunction( CapJitInlinedBindingsToVariableReferences, function ( tree )
    
    return CapJitInlinedBindings( tree : inline_var_refs_only := true );
    
end );
