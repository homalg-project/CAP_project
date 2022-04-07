# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitHoistedExpressions, function ( tree )
  local expressions_to_hoist, pre_func, result_func, additional_arguments_func;
    
    # functions and hoisted variables will be modified inline
    tree := StructuralCopy( tree );
    
    expressions_to_hoist := rec( );
    
    pre_func := function ( tree, additional_arguments )
        
        if CapJitIsCallToGlobalFunction( tree, gvar -> gvar in [ "ObjectifyObjectForCAPWithAttributes", "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes" ] ) then
            
            # special case: the first argument of Objectify*WithAttributes is affected by side effects and thus must not be hoisted
            tree.args.1.CAP_JIT_DO_NOT_HOIST := true;
            
        fi;
        
        return tree;
        
    end;
    
    result_func := function ( tree, result, keys, func_id_stack )
      local levels, level, pos, func_id, name;
        
        levels := Union( List( keys, name -> result.(name) ) );
        
        if tree.type = "EXPR_REF_FVAR" then
            
            # references to variables always restrict the scope to the corresponding function
            Add( levels, Position( func_id_stack, tree.func_id ) );
            
        elif tree.type = "FVAR_BINDING_SEQ" then
            
            # bindings restrict the scope to the current function
            Add( levels, Length( func_id_stack ) );
            
        elif tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            # a function binds its variables, so the level of the function variables can be ignored (at this point, the function stack does not yet include the current func)
            levels := Difference( levels, [ Length( func_id_stack ) + 1 ] );
            
        fi;
        
        # we do not want to create global variables, because this would break precompilation -> the minimum level is 1
        level := MaximumList( levels, 1 );
        
        for name in keys do
            
            if IsBound( tree.(name).CAP_JIT_DO_NOT_HOIST ) and tree.(name).CAP_JIT_DO_NOT_HOIST = true then
                
                # we do not need this information anymore
                Unbind( tree.(name).CAP_JIT_DO_NOT_HOIST );
                
                continue;
                
            fi;
            
            # Check if child expressions have a lower level than the current level.
            # If yes, this child expression will be hoisted, except if they already are "static", e.g. variable references or function expressions.
            if MaximumList( result.(name), 1 ) < level and StartsWith( tree.(name).type, "EXPR_" ) and not tree.(name).type in [ "EXPR_REF_FVAR", "EXPR_REF_GVAR", "EXPR_DECLARATIVE_FUNC", "EXPR_INT", "EXPR_STRING", "EXPR_TRUE", "EXPR_FALSE" ] then
                
                pos := MaximumList( result.(name), 1 );
                
                func_id := func_id_stack[pos];
                
                if not IsBound( expressions_to_hoist.(func_id) ) then
                    
                    expressions_to_hoist.(func_id) := [ ];
                    
                fi;
                
                Add( expressions_to_hoist.(func_id), rec(
                    parent := tree,
                    key := name,
                ) );
                
            fi;
            
        od;
        
        return levels;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_id_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            Assert( 0, IsBound( tree.id ) );
            
            return Concatenation( func_id_stack, [ tree.id ] );
            
        fi;
        
        return func_id_stack;
        
    end;
    
    # populate `expressions_to_hoist`
    CapJitIterateOverTree( tree, pre_func, result_func, additional_arguments_func, [ ] );
    
    # now actually hoist the expressions
    pre_func := function ( tree, additional_arguments )
      local info, parent, key, expr, id, new_variable_name, to_delete, info2, i;
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" and IsBound( expressions_to_hoist.(tree.id) ) then
            
            id := CapJitGetNextUnusedVariableID( tree );
            
            while Length( expressions_to_hoist.(tree.id) ) > 0 do
                
                info := expressions_to_hoist.(tree.id)[1];
                
                parent := info.parent;
                key := info.key;
                expr := parent.(key);
                
                new_variable_name := Concatenation( "hoisted_", String( id ) );
                id := id + 1;
                
                tree.nams := Concatenation( tree.nams, [ new_variable_name ] );
                
                CapJitAddBinding( tree.bindings, new_variable_name, expr );
                
                # search for all occurences of parent.(key) (always matching for i=1)
                to_delete := [ ];
                for i in [ 1 .. Length( expressions_to_hoist.(tree.id) ) ] do
                    
                    info2 := expressions_to_hoist.(tree.id)[i];
                    
                    if CapJitIsEqualForEnhancedSyntaxTrees( expr, info2.parent.(info2.key) ) then
                        
                        info2.parent.(info2.key) := rec(
                            type := "EXPR_REF_FVAR",
                            func_id := tree.id,
                            name := new_variable_name,
                        );
                        
                        Add( to_delete, i );
                        
                    fi;
                    
                od;
                
                Assert( 0, 1 in to_delete );
                
                expressions_to_hoist.(tree.id) := expressions_to_hoist.(tree.id){Difference( [ 1 .. Length( expressions_to_hoist.(tree.id) ) ], to_delete )};
                
            od;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
