# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

InstallGlobalFunction( CapJitHoistedExpressions, function ( tree )
    
    return CAP_JIT_INTERNAL_HOISTED_EXPRESSIONS_OR_BINDINGS( tree, false );
    
end );

InstallGlobalFunction( CapJitHoistedBindings, function ( tree )
    
    return CAP_JIT_INTERNAL_HOISTED_EXPRESSIONS_OR_BINDINGS( tree, true );
    
end );

InstallGlobalFunction( CAP_JIT_INTERNAL_HOISTED_EXPRESSIONS_OR_BINDINGS, function ( tree, only_hoist_bindings )
  local expressions_to_hoist, references_to_function_variables, pre_func, result_func, additional_arguments_func;
    
    # functions and hoisted variables will be modified inline
    tree := StructuralCopy( tree );
    
    expressions_to_hoist := rec( );
    
    if only_hoist_bindings then
        
        references_to_function_variables := rec( );
        
    fi;
    
    pre_func := function ( tree, additional_arguments )
      local name;
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            expressions_to_hoist.(tree.id) := [ ];
            
            if only_hoist_bindings then
                
                references_to_function_variables.(tree.id) := rec( );
                
                for name in tree.nams do
                    
                    references_to_function_variables.(tree.id).(name) := [ ];
                    
                od;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    result_func := function ( tree, result, keys, func_stack )
      local levels, level, type_matches, pos, func_id, name;
        
        levels := Union( List( keys, name -> result.(name) ) );
        
        if tree.type = "EXPR_REF_FVAR" then
            
            # if EXPR_REF_FVAR references a function argument, `result` will be a record
            if only_hoist_bindings and IsList( result ) then
                
                Add( references_to_function_variables.(tree.func_id).(tree.name), tree );
                
                return result;
                
            fi;
            
            # references to variables always restrict the scope to the corresponding function
            AddSet( levels, SafePositionProperty( func_stack, f -> f.id = tree.func_id ) );
            
        elif tree.type = "FVAR_BINDING_SEQ" then
            
            # bindings restrict the scope to the current function
            AddSet( levels, Length( func_stack ) );
            
        elif tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            # a function binds its variables, so the level of the function variables can be ignored (at this point, the function stack does not yet include the current func)
            RemoveSet( levels, Length( func_stack ) + 1 );
            
        fi;
        
        # we do not want to create global variables, because this would break precompilation -> the minimum level is 1
        level := MaximumList( levels, 1 );
        
        for name in keys do
            
            # Hoisting the return value would require special care below, so we skip it because
            # the return value is not a user-visible binding and
            # hoisting the return value is not relevant for our use case (outlining wrapped arguments to the highest level possible).
            if only_hoist_bindings and name = "BINDING_RETURN_VALUE" then
                continue;
            fi;
            
            if only_hoist_bindings then
                
                type_matches := tree.type = "FVAR_BINDING_SEQ";
                
            else
                
                type_matches := StartsWith( tree.(name).type, "EXPR_" ) and not tree.(name).type in [ "EXPR_REF_FVAR", "EXPR_REF_GVAR", "EXPR_DECLARATIVE_FUNC", "EXPR_INT", "EXPR_STRING", "EXPR_TRUE", "EXPR_FALSE" ];
                
            fi;
            
            # Check if child expressions have a lower level than the current level.
            # If yes, this child expression will be hoisted, except if they already are "static", e.g. variable references or function expressions.
            if type_matches and MaximumList( result.(name), 1 ) < level then
                
                pos := MaximumList( result.(name), 1 );
                
                func_id := func_stack[pos].id;
                
                Add( expressions_to_hoist.(func_id), rec(
                    parent := tree,
                    key := name,
                    old_func := Last( func_stack ),
                ) );
                
            fi;
            
        od;
        
        return levels;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_stack, [ tree ] );
            
        fi;
        
        return func_stack;
        
    end;
    
    # populate `expressions_to_hoist`
    CapJitIterateOverTreeWithCachedBindingResults( tree, pre_func, result_func, additional_arguments_func, [ ] );
    
    # now actually hoist the expressions
    pre_func := function ( tree, additional_arguments )
      local id, info, parent, key, expr, new_variable_name, to_delete, info2, old_variable_name, old_func, i, ref;
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            id := CapJitGetNextUnusedVariableID( tree );
            
            if not IsBound( expressions_to_hoist.(tree.id) ) then
                
                # CapJitIterateOverTreeWithCachedBindingResults only visits used bindings
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "found unused bindings, please drop unused bindings first" );
                
            fi;
            
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
                        
                        if only_hoist_bindings then
                            
                            Assert( 0, info2.parent.type = "FVAR_BINDING_SEQ" );
                            Assert( 0, StartsWith( info2.key, "BINDING_" ) );
                            
                            old_variable_name := info2.key{[ 9 .. Length( info2.key ) ]};
                            
                            old_func := info2.old_func;
                            
                            for ref in references_to_function_variables.(info2.old_func.id).(old_variable_name) do
                                
                                Assert( 0, ref.type = "EXPR_REF_FVAR" );
                                
                                ref.func_id := tree.id;
                                ref.name := new_variable_name;
                                
                            od;
                            
                            # drop old binding
                            Remove( info2.old_func.nams, SafePosition( info2.old_func.nams, old_variable_name ) );
                            CapJitUnbindBinding( info2.old_func.bindings, old_variable_name );
                            
                        else
                            
                            info2.parent.(info2.key) := rec(
                                type := "EXPR_REF_FVAR",
                                func_id := tree.id,
                                name := new_variable_name,
                            );
                            
                        fi;
                        
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

InstallValue( CAP_JIT_EXPENSIVE_FUNCTION_NAMES, [ ] );

InstallGlobalFunction( CapJitExtractedExpensiveOperationsFromLoops, function ( tree )
  local EXTRACT_EXPRESSIONS;
    
    # functions and hoisted variables will be modified inline
    tree := StructuralCopy( tree );
    
    EXTRACT_EXPRESSIONS := function ( tree, func_stack, domain_infos )
      local pre_func, result_func;
        
        pre_func := function ( tree, additional_arguments )
            
            if tree.type = "EXPR_DECLARATIVE_FUNC" then
                
                if not IsIdenticalObj( tree, Last( func_stack ) ) then
                    
                    # manual recursion in result_func
                    return fail;
                    
                fi;
                
            fi;
            
            if CapJitIsCallToGlobalFunction( tree, gvar -> true ) then
                
                if tree.funcref.gvar in CAP_JIT_INTERNAL_NAMES_OF_LOOP_FUNCTIONS and tree.args.length = 2 and tree.args.2.type = "EXPR_DECLARATIVE_FUNC" then
                    
                    Assert( 0, tree.args.2.narg = 1 );
                    
                    # If expressions depend on bindings, we cannot hoist them without also hoisting the binding -> only consider fully inlined functions for now.
                    if Length( tree.args.2.nams ) = 2 then
                        
                        # manual recursion in result_func
                        return fail;
                        
                    fi;
                    
                elif ForAny( tree.args, a -> a.type = "EXPR_DECLARATIVE_FUNC" ) and not tree.funcref.gvar in [ "ListN", "Iterated", "CapFixpoint", "LazyHList" ] then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Print( "WARNING: Could not detect domain of function in call of ", tree.funcref.gvar, ". Please write a bug report including this message.\n" );
                    
                fi;
                
            fi;
            
            return tree;
            
        end;
        
        result_func := function ( tree, result, keys, additional_arguments )
          local hoisted_expression, levels, domain_result, func_result, orig, key;
            
            hoisted_expression := function ( expr, levels )
              local old_length, new_length, target_level, func, loop_func, info, new_variable_name, value, new_expr, level, pos, name;
                
                if not StartsWith( expr.type, "EXPR_" ) then
                    
                    return expr;
                    
                fi;
                
                if expr.type in [ "EXPR_REF_FVAR", "EXPR_REF_GVAR", "EXPR_DECLARATIVE_FUNC", "EXPR_INT", "EXPR_STRING", "EXPR_TRUE", "EXPR_FALSE" ] then
                    
                    return expr;
                    
                fi;
                
                levels := ShallowCopy( levels );
                
                # we never hoist to level 0 -> always implicitly depend on level 1
                AddSet( levels, 1 );
                
                # recursively collect all levels on which expr depends
                old_length := 0;
                new_length := Length( levels );
                while old_length <> new_length do
                    
                    for level in levels do
                        
                        if domain_infos[level] <> fail then
                            
                            levels := Union( levels, domain_infos[level].domain_levels );
                            
                        fi;
                        
                    od;
                    
                    old_length := new_length;
                    new_length := Length( levels );
                    
                od;
                
                # find longest prefix without missing levels (as long as the domain is known)
                for pos in Reversed( [ 1 .. Length( levels ) ] ) do
                    
                    target_level := levels[pos];
                    
                    if pos = target_level or domain_infos[target_level] = fail then
                        
                        break;
                        
                    fi;
                    
                od;
                
                Assert( 0, target_level > 0 );
                
                func := func_stack[target_level];
                levels := Filtered( levels, l -> l > target_level );
                
                # if we would hoist to the current level, do nothing
                if target_level = Length( func_stack ) then
                    
                    Assert( 0, IsEmpty( levels ) );
                    
                    return expr;
                    
                fi;
                
                for level in Reversed( levels ) do
                    
                    loop_func := func_stack[level];
                    
                    info := domain_infos[level];
                    
                    if not info.is_prepared then
                        
                        info.is_prepared := true;
                        
                        Assert( 0, info.funccall.funcref.gvar in [ "List", "Sum", "Product", "ForAll", "ForAny", "Number", "Filtered", "First", "Last" ] and info.funccall.args.length = 2 and info.funccall.args.2.type = "EXPR_DECLARATIVE_FUNC" );
                        Assert( 0, info.funccall.args.2.narg = 1 );
                        Assert( 0, Length( info.funccall.args.2.nams ) = 2 );
                        
                        # prepare funccall
                        info.funccall.funcref.gvar := Concatenation( info.funccall.funcref.gvar, "WithKeys" );
                        
                        info.funccall.args.2.narg := 2;
                        Add( info.funccall.args.2.nams, "key", 1 );
                        
                        # hoist domain
                        Assert( 0, IsIdenticalObj( info.funccall.args.1, info.domain ) );
                        
                        if info.domain_is_expensive then
                            
                            info.funccall.args.1 := hoisted_expression( info.funccall.args.1, info.domain_levels );
                            
                        fi;
                        
                    fi;
                    
                    Assert( 0, loop_func.narg = 2 );
                    Assert( 0, Length( loop_func.nams ) >= 3 );
                    Assert( 0, loop_func.nams[1] = "key" );
                    Assert( 0, loop_func.nams[3] = "RETURN_VALUE" );
                    
                    # The check in pre_func makes sure that all domains are fully inlined at the beginning.
                    # Thus, if `loop_func` has proper bindings, the values of those must be hoisted expressions
                    # and those expressions must either depend on all levels until `level` or `domain_infos[level] = fail`.
                    # By the construction above, `domain_infos[level] <> fail` and `expr` does not depend on all levels until `level` and thus
                    # cannot depend on the values of the bindings of `loop_func`.
                    # Thus, we can simply use the first three nams for the newly created function below.
                    
                    expr := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := "ListWithKeys",
                        ),
                        args := AsSyntaxTreeList( [
                            info.domain,
                            rec(
                                type := "EXPR_DECLARATIVE_FUNC",
                                id := loop_func.id,
                                narg := 2,
                                variadic := false,
                                nams := loop_func.nams{[ 1 .. 3 ]},
                                bindings := rec(
                                    type := "FVAR_BINDING_SEQ",
                                    names := [ "RETURN_VALUE" ],
                                    BINDING_RETURN_VALUE := expr,
                                ),
                            ),
                        ] ),
                    );
                    
                od;
                
                new_variable_name := fail;
                
                for name in func.bindings.names do
                    
                    # We cannot reuse the return value.
                    if name = "RETURN_VALUE" then
                        
                        continue;
                        
                    fi;
                    
                    value := CapJitValueOfBinding( func.bindings, name );
                    
                    Assert( 0, not IsIdenticalObj( value, expr ) ); # this would mean that we hoist to the same level, but this is excluded above
                    
                    if CapJitIsEqualForEnhancedSyntaxTrees( value, expr ) then
                        
                        new_variable_name := name;
                        
                        break;
                        
                    fi;
                    
                od;
                
                if new_variable_name = fail then
                    
                    new_variable_name := Concatenation( "hoisted_", String( CapJitGetNextUnusedVariableID( func ) ) );
                    
                    func.nams := Concatenation( func.nams, [ new_variable_name ] );
                    
                    CapJitAddBinding( func.bindings, new_variable_name, CapJitCopyWithNewFunctionIDs( expr ) );
                    
                fi;
                
                new_expr := rec(
                    type := "EXPR_REF_FVAR",
                    func_id := func.id,
                    name := new_variable_name,
                );
                
                for level in levels do
                    
                    loop_func := func_stack[level];
                    
                    # some of these list accesses can usually be hoisted, but we leave this to the generic hoisting afterwards
                    new_expr := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := "[]",
                        ),
                        args := AsSyntaxTreeList( [
                            new_expr,
                            rec(
                                type := "EXPR_REF_FVAR",
                                func_id := loop_func.id,
                                name := "key",
                            ),
                        ] ),
                    );
                    
                od;
                
                return new_expr;
                
            end;
            
            if result = fail then
                
                if tree.type = "EXPR_DECLARATIVE_FUNC" then
                    
                    # recurse with unknown domain
                    return EXTRACT_EXPRESSIONS( tree, Concatenation( func_stack, [ tree ] ), Concatenation( domain_infos, [ fail ] ) );
                    
                else
                    
                    Assert( 0, CapJitIsCallToGlobalFunction( tree, gvar -> gvar in CAP_JIT_INTERNAL_NAMES_OF_LOOP_FUNCTIONS ) );
                    Assert( 0, tree.args.length = 2 );
                    Assert( 0, tree.args.2.type = "EXPR_DECLARATIVE_FUNC" );
                    
                    orig := tree.args.1;
                    
                    domain_result := EXTRACT_EXPRESSIONS( tree.args.1, func_stack, domain_infos );
                    
                    func_result := EXTRACT_EXPRESSIONS( tree.args.2, Concatenation( func_stack, [ tree.args.2 ] ), Concatenation( domain_infos, [ rec( is_prepared := false, funccall := tree, domain := tree.args.1, domain_levels := domain_result.levels, domain_is_expensive := domain_result.is_expensive ) ] ) );
                    
                    # if the domain has been hoisted by the call to `EXTRACT_EXPRESSIONS`, it is not expensive anymore
                    if not IsIdenticalObj( orig, tree.args.1 ) then
                        
                        domain_result.is_expensive := false;
                        
                    fi;
                    
                    return rec( levels := Union( domain_result.levels, func_result.levels ), is_expensive := domain_result.is_expensive or func_result.is_expensive );
                    
                fi;
                
            else
                
                levels := Union( List( keys, name -> result.(name).levels ) );
                
                if tree.type = "EXPR_REF_FVAR" then
                    
                    # references to variables always restrict the scope to the corresponding function
                    AddSet( levels, SafePositionProperty( func_stack, f -> f.id = tree.func_id ) );
                    
                    # We could also add the domain levels here, but that would lead to larger chunks being hoisted which hinders deduplication.
                    
                elif tree.type = "FVAR_BINDING_SEQ" then
                    
                    # bindings restrict the scope to the current function
                    AddSet( levels, Length( func_stack ) );
                    
                elif tree.type = "EXPR_DECLARATIVE_FUNC" then
                    
                    # a function binds its variables, so the level of the function variables can be ignored
                    RemoveSet( levels, Length( func_stack ) );
                    
                fi;
                
                for key in keys do
                    
                    # We could exclude level 1 in the comparison, but that would lead to larger chunks being hoisted which hinders deduplication,
                    # and only affects code independent of the input which should be rare.
                    # Additionally, in the future we would like to hoist to level 0.
                    if result.(key).is_expensive and levels <> result.(key).levels then # result.(key).levels is a subset of levels, so this is equivalent to being a proper subset
                        
                        orig := tree.(key);
                        
                        tree.(key) := hoisted_expression( tree.(key), result.(key).levels );
                        
                        if not IsIdenticalObj( orig, tree.(key) ) then
                            
                            # if this was actually hoisted, the result is not expensive anymore
                            result.(key).is_expensive := false;
                            
                        fi;
                        
                    fi;
                    
                od;
                
                return rec( levels := levels, is_expensive := ForAny( keys, key -> result.(key).is_expensive ) or CapJitIsCallToGlobalFunction( tree, gvar -> gvar in CAP_JIT_EXPENSIVE_FUNCTION_NAMES ) );
                
            fi;
            
        end;
        
        return CapJitIterateOverTree( tree, pre_func, result_func, ReturnTrue, true );
        
    end;
    
    EXTRACT_EXPRESSIONS( tree, [ ], [ ] );
    
    return tree;
    
end );
