# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

InstallGlobalFunction( CapJitInlinedBindings, function ( tree )
    
    return CAP_JIT_INTERNAL_INLINED_BINDINGS( tree, [ ], ValueOption( "inline_var_refs_only" ) = true, ValueOption( "inline_fully" ) = true );
    
end );

InstallGlobalFunction( CAP_JIT_INTERNAL_INLINED_BINDINGS, function ( tree, initial_func_stack, inline_var_refs_only, inline_fully )
  local pre_func, new_bindings, result_func, additional_arguments_func;
    
    pre_func := function ( tree, func_stack )
      local new_bindings, value, func, info, name, i;
        
        if IsBound( tree.CAP_JIT_DO_NOT_INLINE ) and tree.CAP_JIT_DO_NOT_INLINE = true then
            
            return fail;
            
        fi;
        
        # `new_bindings` will be attached to functions
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            tree := ShallowCopy( tree );
            
        fi;
        
        # drop bindings which will be inlined anyway
        # func_stack still references the original functions with unmodified bindings
        if tree.type = "FVAR_BINDING_SEQ" then
            
            # check that tree.names and the record entries are in sync
            # otherwise we might "lose" bindings unexpectedly
            Assert( 0, IsEqualSet( Filtered( RecNames( tree ), name -> StartsWith( name, "BINDING_" ) ), List( tree.names, name -> Concatenation( "BINDING_", name ) ) ) );
            
            new_bindings := rec(
                type := "FVAR_BINDING_SEQ",
                names := [ ],
            );
            
            for name in tree.names do
                
                value := CapJitValueOfBinding( tree, name );
                
                # RETURN_VALUE and those not inlined below should be kept
                if name = "RETURN_VALUE" or not (not inline_var_refs_only or value.type = "EXPR_REF_GVAR" or value.type = "EXPR_REF_FVAR") then
                    
                    CapJitAddBinding( new_bindings, name, value );
                    
                fi;
                
            od;
            
            return new_bindings;
            
        fi;
        
        # iterate in case the inlined value is an EXPR_REF_FVAR again
        while true do
            
            if tree.type = "EXPR_REF_FVAR" then
                
                func := SafeUniqueEntry( func_stack, func -> func.id = tree.func_id );
                
                # the fvar might be an argument, which has no binding
                if SafeUniquePosition( func.nams, tree.name ) > func.narg then
                    
                    value := CapJitValueOfBinding( func.bindings, tree.name );
                    
                    if not inline_var_refs_only or value.type = "EXPR_REF_GVAR" or value.type = "EXPR_REF_FVAR" then
                        
                        Info( InfoCapJit, 1, "####" );
                        Info( InfoCapJit, 1, "Inline binding with name ", tree.name, "." );
                        
                        tree := CapJitCopyWithNewFunctionIDs( value );
                        
                        continue;
                        
                    fi;
                    
                fi;
                
            fi;
            
            break;
            
        od;
        
        if not inline_fully and not inline_var_refs_only then
            
            info := CAP_JIT_INTERNAL_GET_KEY_AND_POSITIONS_TO_OUTLINE( tree, func_stack );
            
            if info <> fail then
                
                tree := ShallowCopy( tree );
                tree.(info.key) := ShallowCopy( tree.(info.key) );
                
                for i in info.positions_to_outline do
                    
                    tree.(info.key).(i) := ShallowCopy( tree.(info.key).(i) );
                    
                    tree.(info.key).(i).CAP_JIT_DO_NOT_INLINE := true;
                    
                od;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    result_func := function ( tree, result, keys, func_stack )
      local info, key, fvar, func, value, new_nams, name, i;
        
        if result = fail then
            
            Assert( 0, IsBound( tree.CAP_JIT_DO_NOT_INLINE ) and tree.CAP_JIT_DO_NOT_INLINE = true );
            
            Unbind( tree.CAP_JIT_DO_NOT_INLINE );
            
            return tree;
            
        fi;
        
        tree := ShallowCopy( tree );
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        if not inline_fully and not inline_var_refs_only then
            
            info := CAP_JIT_INTERNAL_GET_KEY_AND_POSITIONS_TO_OUTLINE( tree, func_stack );
            
            if info <> fail then
                
                key := info.key;
                
                for i in info.positions_to_outline do
                    
                    if tree.(key).(i).type in [ "EXPR_INT", "EXPR_STRING", "EXPR_CHAR", "EXPR_TRUE", "EXPR_FALSE", "EXPR_REF_GVAR" ] then
                        continue;
                    fi;
                    
                    Assert( 0, tree.(key).(i).type = "EXPR_REF_FVAR" );
                    
                    fvar := tree.(key).(i);
                    
                    func := SafeUniqueEntry( func_stack, func -> func.id = fvar.func_id );
                    
                    # the fvar might be an argument, which has no binding
                    if SafeUniquePosition( func.nams, fvar.name ) <= func.narg then
                        continue;
                    fi;
                    
                    value := CapJitValueOfBinding( func.bindings, fvar.name );
                    
                    if not IsBound( func.new_bindings ) then
                        
                        func.new_bindings := rec( );
                        
                    fi;
                    
                    if IsBound( func.new_bindings.(fvar.name) ) then
                        
                        continue;
                        
                    fi;
                    
                    func.new_bindings.(fvar.name) := CAP_JIT_INTERNAL_INLINED_BINDINGS( value, func_stack, inline_var_refs_only, inline_fully );
                    
                od;
                
                return tree;
                
            fi;
            
        fi;
        
        # drop names of bindings which have been inlined
        # and add new bindings
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
            
            if IsBound( tree.new_bindings ) then
                
                for name in RecNames( tree.new_bindings ) do
                    
                    Add( tree.nams, name );
                    
                    CapJitAddBinding( tree.bindings, name, tree.new_bindings.(name) );
                    
                od;
                
                Unbind( tree.new_bindings );
                
            fi;
            
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
    
    return CapJitIterateOverTree( tree, pre_func, result_func, additional_arguments_func, initial_func_stack );
    
end );

InstallGlobalFunction( CapJitInlinedBindingsToVariableReferences, function ( tree )
    
    return CapJitInlinedBindings( tree : inline_var_refs_only := true );
    
end );

InstallGlobalFunction( CapJitInlinedBindingsFully, function ( tree )
    
    return CapJitInlinedBindings( tree : inline_fully := true );
    
end );
