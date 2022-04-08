# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

BindGlobal( "CAP_JIT_INTERNAL_GET_KEY_AND_POSITIONS_TO_OUTLINE", function ( tree, func_stack )
  local key, positions_to_outline, source, fvar, func, range;
    
    if tree.type = "EXPR_LIST" then
        
        key := "list";
        
        positions_to_outline := [ 1 .. tree.list.length ];
        
    elif CapJitIsCallToGlobalFunction( tree, "ObjectifyObjectForCAPWithAttributes" ) then
        
        key := "args";
        
        # ObjectifyObjectForCAPWithAttributes( rec( ), cat, attr1, val1, attr2, val2, ... );
        positions_to_outline := [ 4, 6 .. tree.args.length ];
        
    elif CapJitIsCallToGlobalFunction( tree, "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes" ) then
        
        key := "args";
        
        # ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat, source, range, attr1, val1, attr2, val2, ... );
        positions_to_outline := Concatenation( [ 3, 4 ], [ 6, 8 .. tree.args.length ] );
        
    else
        
        return fail;
        
    fi;
    
    return rec( key := key, positions_to_outline := positions_to_outline );
    
end );

InstallGlobalFunction( CapJitOutlinedWrappedArguments, function ( tree )
  local result_func, additional_arguments_func;
    
    # functions will be modified inline
    tree := StructuralCopy( tree );
    
    result_func := function ( tree, result, keys, func_stack )
      local info, func, id, new_variable_name, key, i;
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        info := CAP_JIT_INTERNAL_GET_KEY_AND_POSITIONS_TO_OUTLINE( tree, func_stack );
        
        if info = fail then
            
            return tree;
            
        fi;
        
        func := Last( func_stack );
        
        id := CapJitGetNextUnusedVariableID( func );
        
        for i in info.positions_to_outline do
            
            if tree.(info.key).(i).type in [ "EXPR_INT", "EXPR_STRING", "EXPR_CHAR", "EXPR_TRUE", "EXPR_FALSE", "EXPR_REF_GVAR", "EXPR_REF_FVAR" ] then
                continue;
            fi;
            
            new_variable_name := Concatenation( "outlined_", String( id ) );
            id := id + 1;
            
            func.nams := Concatenation( func.nams, [ new_variable_name ] );
            
            CapJitAddBinding( func.bindings, new_variable_name, tree.(info.key).(i) );
            
            tree.(info.key).(i) := rec(
                type := "EXPR_REF_FVAR",
                func_id := func.id,
                name := new_variable_name,
            );
            
        od;
        
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
