# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitHoistedExpressions, function ( tree )
  local expressions_to_hoist, pre_func, result_func, additional_arguments_func, HOISTED_VARIABLE_ID;
    
    # functions and hoisted variables will be modified inline
    tree := StructuralCopy( tree );
    
    expressions_to_hoist := [ ];
    
    pre_func := function ( tree, additional_arguments )
        
        if CapJitIsCallToGlobalFunction( tree, gvar -> gvar in [ "ObjectifyObjectForCAPWithAttributes", "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes" ] ) then
            
            # special case: the first argument of Objectify*WithAttributes is affected by side effects and thus must not be hoisted
            tree.args.1.CAP_JIT_DO_NOT_HOIST := true;
            
        fi;
        
        return tree;
        
    end;
    
    result_func := function ( tree, result, keys, additional_arguments )
      local func_id_stack, func_path_stack, path, levels, level, pos, func_id, func_path, relative_path, name;
        
        func_id_stack := additional_arguments.func_id_stack;
        func_path_stack := additional_arguments.func_path_stack;
        path := additional_arguments.path;
        
        levels := Union( List( keys, name -> result.(name) ) );
        
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
        
        for name in keys do
            
            if IsBound( tree.(name).CAP_JIT_DO_NOT_HOIST ) and tree.(name).CAP_JIT_DO_NOT_HOIST = true then
                
                # we do not need this information anymore
                Unbind( tree.(name).CAP_JIT_DO_NOT_HOIST );
                
                continue;
                
            fi;
            
            # Check if child expressions have a lower level than the current level.
            # If yes, this child expression will be hoisted, except if they already are "static", e.g. variable references or function expressions.
            if MaximumList( result.(name), 1 ) < level and StartsWith( tree.(name).type, "EXPR_" ) and not tree.(name).type in [ "EXPR_REF_FVAR", "EXPR_REF_GVAR", "EXPR_FUNC", "EXPR_INT", "EXPR_STRING", "EXPR_TRUE", "EXPR_FALSE" ] then
                
                pos := MaximumList( result.(name), 1 );
                
                func_id := func_id_stack[pos];
                func_path := func_path_stack[pos];
                
                if not IsBound( expressions_to_hoist[func_id] ) then
                    
                    expressions_to_hoist[func_id] := [ ];
                    
                fi;
                
                Assert( 0, StartsWith( path, func_path ) );
                
                relative_path := path{[ Length( func_path ) + 1 .. Length( path ) ]};
                
                Add( expressions_to_hoist[func_id], rec(
                    parent := tree,
                    key := name,
                    relative_path := relative_path,
                ) );
                
            fi;
            
        od;
        
        return levels;
        
    end;
    
    additional_arguments_func := function ( tree, key, additional_arguments )
      local func_id_stack, func_path_stack, path;
        
        func_id_stack := additional_arguments.func_id_stack;
        func_path_stack := additional_arguments.func_path_stack;
        path := additional_arguments.path;
        
        if tree.type = "EXPR_FUNC" then
            
            Assert( 0, IsBound( tree.id ) );
            
            func_id_stack := Concatenation( func_id_stack, [ tree.id ] );
            func_path_stack := Concatenation( func_path_stack, [ path ] );
            
        fi;
        
        path := Concatenation( path, [ key ] );
        
        return rec( func_id_stack := func_id_stack, func_path_stack := func_path_stack, path := path );
        
    end;
    
    # populate `expressions_to_hoist`
    CapJitIterateOverTree( tree, pre_func, result_func, additional_arguments_func, rec( func_id_stack := [ ], func_path_stack := [ ], path := [ ] ) );
    
    # we have to work from top to bottom, because we first have to lift the innermost expressions (which correspond to the outermost functions)
    
    HOISTED_VARIABLE_ID := 1;
    
    pre_func := function ( tree, additional_arguments )
      local new_variable_assignments, new_variable_assignments_if_true, new_variable_assignments_if_false, info, parent, key, expr, new_variable_name, hoisted_relative_paths, to_delete, info2, new_variable_assignment, conditional, i;
        
        if tree.type = "EXPR_FUNC" and IsBound( expressions_to_hoist[tree.id] ) then
            
            new_variable_assignments := [ ];
            # used in the context of EXPR_CONDITIONALs:
            # for performance reasons we do not want to hoist the expressions above the conditional
            new_variable_assignments_if_true := [ ];
            new_variable_assignments_if_false := [ ];
            
            while Length( expressions_to_hoist[tree.id] ) > 0 do
                
                info := expressions_to_hoist[tree.id][1];
                
                parent := info.parent;
                key := info.key;
                expr := StructuralCopy( parent.(key) );
                
                new_variable_name := Concatenation( "cap_jit_hoisted_expression_", String( HOISTED_VARIABLE_ID ) );
                HOISTED_VARIABLE_ID := HOISTED_VARIABLE_ID + 1;
                
                tree.nams := Concatenation( tree.nams, [ new_variable_name ] );
                tree.nloc := tree.nloc + 1;
                
                hoisted_relative_paths := [ ];
                
                # search for all occurences of parent.(key) (always matching for i=1)
                to_delete := [ ];
                for i in [ 1 .. Length( expressions_to_hoist[tree.id] ) ] do
                    
                    info2 := expressions_to_hoist[tree.id][i];
                    
                    if CapJitIsEqualForEnhancedSyntaxTrees( expr, info2.parent.(info2.key) ) then
                        
                        info2.parent.(info2.key) := rec(
                            type := "EXPR_REF_FVAR",
                            func_id := tree.id,
                            name := new_variable_name,
                        );
                        
                        Add( hoisted_relative_paths, info2.relative_path );
                        
                        Add( to_delete, i );
                        
                    fi;
                    
                od;
                
                Assert( 0, 1 in to_delete );
                
                expressions_to_hoist[tree.id] := expressions_to_hoist[tree.id]{Difference( [ 1 .. Length( expressions_to_hoist[tree.id] ) ], to_delete )};
                
                new_variable_assignment := rec(
                    type := "STAT_ASS_FVAR",
                    func_id := tree.id,
                    name := new_variable_name,
                    rhs := expr,
                );
                
                if Last( tree.stats.statements ).type = "STAT_RETURN_OBJ" and Last( tree.stats.statements ).obj.type = "EXPR_CONDITIONAL" then
                    
                    # check if the hoisted expression is only used in the if resp. else branch
                    if ForAll( hoisted_relative_paths, relative_path -> StartsWith( relative_path, [ "stats", "statements", "1", "obj", "expr_if_true" ] ) ) then
                        
                        Add( new_variable_assignments_if_true, new_variable_assignment );
                        
                    elif ForAll( hoisted_relative_paths, relative_path -> StartsWith( relative_path, [ "stats", "statements", "1", "obj", "expr_if_false" ] ) ) then
                        
                        Add( new_variable_assignments_if_false, new_variable_assignment );
                        
                    else
                        
                        Add( new_variable_assignments, new_variable_assignment );
                        
                    fi;
                    
                else
                    
                    Add( new_variable_assignments, new_variable_assignment );
                    
                fi;
                
            od;
            
            if Last( tree.stats.statements ).type = "STAT_RETURN_OBJ" and Last( tree.stats.statements ).obj.type = "EXPR_CONDITIONAL" then
                
                conditional := Last( tree.stats.statements ).obj;
                
                tree.stats.statements.(tree.stats.statements.length) := rec(
                    type := "STAT_IF_ELSE",
                    branches := AsSyntaxTreeList( [
                        rec(
                            type := "BRANCH_IF",
                            condition := conditional.condition,
                            body := rec(
                                type := "STAT_SEQ_STAT",
                                statements := AsSyntaxTreeList(
                                    Concatenation(
                                        new_variable_assignments_if_true,
                                        [
                                            rec(
                                                type := "STAT_RETURN_OBJ",
                                                obj := conditional.expr_if_true,
                                            ),
                                        ]
                                    )
                                ),
                            ),
                        ),
                        rec(
                            type := "BRANCH_IF",
                            condition := rec(
                                type := "EXPR_TRUE",
                            ),
                            body := rec(
                                type := "STAT_SEQ_STAT",
                                statements := AsSyntaxTreeList(
                                    Concatenation(
                                        new_variable_assignments_if_false,
                                        [
                                            rec(
                                                type := "STAT_RETURN_OBJ",
                                                obj := conditional.expr_if_false,
                                            ),
                                        ]
                                    )
                                ),
                            ),
                        ),
                    ] ),
                );
                
            fi;
            
            tree.stats.statements := ConcatenationForSyntaxTreeLists(
                AsSyntaxTreeList( new_variable_assignments ),
                tree.stats.statements
            );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
