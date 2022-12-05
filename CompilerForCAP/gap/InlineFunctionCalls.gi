# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID, function ( tree, new_func_id, new_nams )
  local old_func_id, old_nams, result_func;
    
    Assert( 0, tree.type = "EXPR_DECLARATIVE_FUNC" );
    
    old_func_id := tree.id;
    old_nams := tree.nams;
    
    Assert( 0, Length( new_nams ) >= Length( old_nams ) );
    Assert( 0, "RETURN_VALUE" in old_nams );
    # if RETURN_VALUE in new_nams: check that it has the same position as in old_nams
    Assert( 0, not "RETURN_VALUE" in new_nams or SafeUniquePosition( new_nams, "RETURN_VALUE" ) = SafeUniquePosition( old_nams, "RETURN_VALUE" ) );
    
    tree := StructuralCopy( tree );
    
    result_func := function ( tree, result, keys, additional_arguments )
      local new_bindings, key, name;
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" and tree.id = old_func_id then
            
            Assert( 0, tree.nams = old_nams );
            
            tree.id := new_func_id;
            # copy new_nams so the pointer does not leak
            tree.nams := StructuralCopy( new_nams );
            
            # check that tree.bindings.names and the record entries are in sync
            # otherwise we might "lose" bindings unexpectedly
            Assert( 0, IsEqualSet( Filtered( RecNames( tree.bindings ), name -> StartsWith( name, "BINDING_" ) ), List( tree.bindings.names, name -> Concatenation( "BINDING_", name ) ) ) );
            
            new_bindings := rec(
                type := "FVAR_BINDING_SEQ",
                names := [ ],
            );
            
            for name in tree.bindings.names do
                
                CapJitAddBinding( new_bindings, new_nams[SafeUniquePosition( old_nams, name )], CapJitValueOfBinding( tree.bindings, name ) );
                
            od;
            
            tree.bindings := new_bindings;
            
        fi;
        
        if tree.type = "EXPR_REF_FVAR" and tree.func_id = old_func_id then
            
            # assert this before setting the new function ID for easier debugging
            Assert( 0, tree.name in old_nams );
            
            tree.func_id := new_func_id;
            
            tree.name := new_nams[SafeUniquePosition( old_nams, tree.name )];
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, ReturnTrue, true );
    
end );

InstallGlobalFunction( CapJitInlinedFunctionCalls, function ( tree )
  local result_func, additional_arguments_func;
    
    # nams and bindings will be modified inline
    tree := StructuralCopy( tree );
    
    result_func := function ( tree, result, keys, func_stack )
      local target_func, inline_func, new_nams, pos_RETURN_VALUE, key, name;
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        if tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_DECLARATIVE_FUNC" then
            
            target_func := Last( func_stack );
            Assert( 0, target_func <> fail );
            
            inline_func := tree.funcref;
            
            if not (tree.args.length = 0 and inline_func.narg = 0) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "found function call with arguments, please inline arguments first" );
                
            fi;
            
            Info( InfoCapJit, 1, "####" );
            Info( InfoCapJit, 1, "Inline function with the following arguments:" );
            Info( InfoCapJit, 1, inline_func.nams );
            
            # create new local variables and make them unique by prepending the function ID
            new_nams := List( inline_func.nams, name -> Concatenation( "inline_", String( inline_func.id ), "_", name ) );
            pos_RETURN_VALUE := SafeUniquePosition( inline_func.nams, "RETURN_VALUE" );
            
            Assert( 0, IsDuplicateFreeList( new_nams ) );
            
            # prepare function for inlining
            inline_func := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( inline_func, target_func.id, new_nams );
            
            # copy bindings from inline_func to target_func
            for name in inline_func.bindings.names do
                
                CapJitAddBinding( target_func.bindings, name, CapJitValueOfBinding( inline_func.bindings, name ) );
                
            od;
            
            target_func.nams := Concatenation( target_func.nams, new_nams );
            
            Assert( 0, IsDuplicateFreeList( target_func.nams ) );
            
            # replace tree by reference to the original return value
            return rec(
                type := "EXPR_REF_FVAR",
                func_id := target_func.id,
                name := new_nams[pos_RETURN_VALUE],
            );
            
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
    
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, additional_arguments_func, [ ] );
    
end );
