# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitHoistedExpressions, function ( tree )
  local expressions_to_hoist, result_func, additional_arguments_func, HOISTED_VARIABLE_ID, pre_func;
    
    # functions and hoisted variables will be modified inline
    tree := StructuralCopy( tree );
    
    expressions_to_hoist := [ ];
    
    result_func := function ( tree, result, func_id_stack )
      local levels, level, func_id, name;
        
        if IsList( result ) then
            
            levels := Union( result );
            
        elif IsRecord( result ) then
            
            Assert( 0, IsRecord( tree ) );
            
            levels := Union( List( RecNames( result ), name -> result.(name) ) );
            
            if tree.type in [ "EXPR_REF_FVAR", "STAT_ASS_FVAR" ] then
                
                # references and assignments to variables always restrict the scope
                Add( levels, Position( func_id_stack, tree.func_id ) );
                
            elif tree.type = "STAT_RETURN_OBJ" then
                
                # return statements restrict the scope to the current function
                Add( levels, Length( func_id_stack ) );
                
            elif tree.type = "EXPR_FUNC" then
                
                # a function binds its variables, so the level of the function variables can be ignored (at this point, the function stack does not yet include the current func)
                levels := Difference( levels, [ Length( func_id_stack ) + 1 ] );
                
            fi;
            
            # we do not want to create global variables, because this would break precompilation -> the minimum level is 1
            level := MaximumList( levels, 1 );
            
            for name in RecNames( result ) do
                
                # Check if child expressions have a lower level than the current level.
                # If yes, this child expression will be hoisted, except if they already are "static", e.g. variable references or function expressions.
                if MaximumList( result.(name), 1 ) < level and IsRecord( tree.(name) ) and StartsWith( tree.(name).type, "EXPR_" ) and not tree.(name).type in [ "EXPR_REF_FVAR", "EXPR_REF_GVAR", "EXPR_FUNC", "EXPR_INT", "EXPR_STRING", "EXPR_TRUE", "EXPR_FALSE" ] then
                    
                    func_id := func_id_stack[MaximumList( result.(name), 1 )];
                    
                    if not IsBound( expressions_to_hoist[func_id] ) then
                        
                        expressions_to_hoist[func_id] := [ ];
                        
                    fi;
                    
                    Add( expressions_to_hoist[func_id], rec(
                            parent := tree,
                            key := name,
                    ) );
                    
                fi;
                
            od;
            
        else
            
            Error( "this should never happen" );
            
        fi;
        
        return levels;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_id_stack )
        
        if IsRecord( tree ) and tree.type = "EXPR_FUNC" then
            
            Assert( 0, IsBound( tree.id ) );
            
            return Concatenation( func_id_stack, [ tree.id ] );
            
        fi;
        
        return func_id_stack;
        
    end;
    
    # populate `expressions_to_hoist`
    CapJitIterateOverTree( tree, ReturnFirst, result_func, additional_arguments_func, [ ] );
    
    # we have to work from top to bottom, because we first have to lift the innermost expressions (which correspond to the outermost functions)
    
    HOISTED_VARIABLE_ID := 1;
    
    pre_func := function ( tree, additional_arguments )
      local new_variable_assignments, info, parent, key, expr, new_variable_name, to_delete, info2, i;
        
        if IsRecord( tree ) and tree.type = "EXPR_FUNC" and IsBound( expressions_to_hoist[tree.id] ) then
            
            new_variable_assignments := [ ];
            
            while Length( expressions_to_hoist[tree.id] ) > 0 do
                
                info := expressions_to_hoist[tree.id][1];
                
                parent := info.parent;
                key := info.key;
                expr := StructuralCopy( parent.(key) );
                
                new_variable_name := Concatenation( "cap_jit_hoisted_expression_", String( HOISTED_VARIABLE_ID ) );
                HOISTED_VARIABLE_ID := HOISTED_VARIABLE_ID + 1;
                
                tree.nams := Concatenation( tree.nams, [ new_variable_name ] );
                tree.nloc := tree.nloc + 1;
                
                Add( new_variable_assignments, rec(
                    type := "STAT_ASS_FVAR",
                    func_id := tree.id,
                    name := new_variable_name,
                    initial_name := new_variable_name,
                    rhs := expr,
                ) );
                
                # search for all occurences of parent.(key) (always matching for i=1)
                to_delete := [ ];
                for i in [ 1 .. Length( expressions_to_hoist[tree.id] ) ] do
                    
                    info2 := expressions_to_hoist[tree.id][i];
                    
                    if CapJitIsEqualForEnhancedSyntaxTrees( expr, info2.parent.(info2.key) ) then
                        
                        info2.parent.(info2.key) := rec(
                            type := "EXPR_REF_FVAR",
                            func_id := tree.id,
                            name := new_variable_name,
                            initial_name := new_variable_name,
                        );
                        
                        Add( to_delete, i );
                        
                    fi;
                    
                od;
                
                Assert( 0, 1 in to_delete );
                
                expressions_to_hoist[tree.id] := expressions_to_hoist[tree.id]{Difference( [ 1 .. Length( expressions_to_hoist[tree.id] ) ], to_delete )};
                
            od;
            
            tree.stats.statements := Concatenation(
                new_variable_assignments,
                tree.stats.statements
            );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
