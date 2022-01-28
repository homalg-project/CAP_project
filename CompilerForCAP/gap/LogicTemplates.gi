# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_LOGIC_TEMPLATES", [ ] );
InstallGlobalFunction( CapJitAddLogicTemplate, function ( template )
    
    # the logic template will later be enhanced in-place -> make a copy
    template := StructuralCopy( template );
    
    Add( CAP_JIT_LOGIC_TEMPLATES, template );
    
end );

InstallGlobalFunction( CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE, function ( template )
  local diff, template_var_name, tmp_tree, pre_func, additional_arguments_func, i;
    
    # Caution: this function must only be called once the needed packages of the template are loaded!
    
    # some basic sanity checks
    if not IsRecord( template ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a logic template must be a record" );
        
    fi;
    
    if not IsSubset( RecNames( template ), [ "variable_names", "src_template", "dst_template", "returns_value" ] ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a logic template must have the following required record entries: variable_names, src_template, dst_template, returns_value" );
        
    fi;
    
    diff := Difference( RecNames( template ), [ "variable_names", "variable_filters", "src_template", "dst_template", "new_funcs", "returns_value", "needed_packages", "debug", "debug_path" ] );
    
    if not IsEmpty( diff ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a logic template has unknown components: ", diff );
        
    fi;
    
    if IsBound( template.variable_filters ) and Length( template.variable_names ) <> Length( template.variable_filters ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the length of the record entries variable_names and variable_filters of a logic template must be equal" );
        
    fi;

    if IsBound( template.needed_packages ) and (not IsList( template.needed_packages ) or ForAny( template.needed_packages, p -> not IsList( p ) or Length( p ) <> 2 )) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the record entry needed_packages of a logic template must be a list of pairs" );
        
    fi;
    
    if IsBound( template.variable_filters ) then
        
        # replace strings with actual filters
        template.variable_filters := List( template.variable_filters, function ( f )
            
            if IsString( f ) then
                
                return ValueGlobal( f );
                
            else
                
                return f;
                
            fi;
            
        end );
        
    else
        
        # default variable filters: IsObject
        template.variable_filters := ListWithIdenticalEntries( Length( template.variable_names ), IsObject );
        
    fi;
    
    # default new funcs: none
    if not IsBound( template.new_funcs ) then
        
        template.new_funcs := [ ];
        
    fi;
    
    # replace variables by CAP_INTERNAL_JIT_TEMPLATE_VAR_i
    for i in [ 1 .. Length( template.variable_names ) ] do
        
        template_var_name := Concatenation( "CAP_INTERNAL_JIT_TEMPLATE_VAR_", String( i ) );
        
        if not IsBoundGlobal( template_var_name ) then
            
            DeclareGlobalVariable( template_var_name );
            
        fi;
        
        template.src_template := ReplacedString( template.src_template, template.variable_names[i], template_var_name );
        template.dst_template := ReplacedString( template.dst_template, template.variable_names[i], template_var_name );
        
    od;
    
    # get src_template_tree from src_template
    if not IsBound( template.src_template_tree ) then
        
        # to get a syntax tree we have to wrap the template in a function
        if template.returns_value then
            
            tmp_tree := ENHANCED_SYNTAX_TREE( EvalString( Concatenation( "x -> ", template.src_template ) ) );
            
        else
            
            tmp_tree := ENHANCED_SYNTAX_TREE( EvalString( Concatenation( "function () ", template.src_template, " end;" ) ) );
            
        fi;
        
        Assert( 0, tmp_tree.bindings.names = [ "RETURN_VALUE" ] );
        
        template.src_template_tree := CapJitValueOfBinding( tmp_tree.bindings, "RETURN_VALUE" );
        
    fi;
    
    # get dst_template_tree from dst_template
    if not IsBound( template.dst_template_tree ) then
        
        # to get a syntax tree we have to wrap the template in a function
        if template.returns_value then
            
            tmp_tree := ENHANCED_SYNTAX_TREE( EvalString( Concatenation( "x -> ", template.dst_template ) ) );
            
        else
            
            tmp_tree := ENHANCED_SYNTAX_TREE( EvalString( Concatenation( "function () ", template.dst_template, " end;" ) ) );
            
        fi;
        
        Assert( 0, tmp_tree.bindings.names = [ "RETURN_VALUE" ] );
        
        template.dst_template_tree := CapJitValueOfBinding( tmp_tree.bindings, "RETURN_VALUE" );
        
    fi;
    
    # Match functions in dst_template_tree to those in src_template_tree and set function IDs accordingly.
    # Functions from src_template_tree can appear multiple times in dst_template_tree, so in dst_template_tree the same function ID can occur multiple times.
    # However, we do not allow the same ID to occur multiple times in a single function stack, as this would cause ambiguities.
    pre_func := function ( tree, func_id_stack )
      local dst_func, new_nams, condition_func, src_template_path, src_func;
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            dst_func := tree;
            
            # tree is a subtree of dst_tree_template. dst_tree_template should not have seen any inlining etc., so RETURN_VALUE should still be the last variable
            Assert( 0, Last( dst_func.nams ) = "RETURN_VALUE" );
            
            # the entries of new_funcs do not include RETURN_VALUE
            if dst_func.nams{[ 1 .. Length( dst_func.nams ) - 1 ]} in template.new_funcs then
                
                # dst_func already has a unique ID, so we can keep it, but we want new nams
                new_nams := List( dst_func.nams, nam -> Concatenation( "logic_new_func_", nam ) );
                new_nams[Length( new_nams )] := "RETURN_VALUE";
                
                dst_func := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( dst_func, dst_func.id, new_nams );
                
            else
                
                # find matching function in src_template_tree
                condition_func := function ( tree, path )
                    
                    return tree.type = "EXPR_DECLARATIVE_FUNC" and tree.nams = dst_func.nams;
                    
                end;
                
                src_template_path := CapJitFindNodeDeep( template.src_template_tree, condition_func );
                
                if src_template_path = fail then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "could not find matching func in src_template" );
                    
                fi;
                
                src_func := CapJitGetNodeByPath( template.src_template_tree, src_template_path );
                
                Assert( 0, src_func.nams = dst_func.nams );
                
                if src_func.id in func_id_stack then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "A function in src_template is used multiple times in dst_template in a nested way. This is not supported." );
                    
                fi;
                
                dst_func := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( dst_func, src_func.id, src_func.nams );
                
            fi;
            
            return dst_func;
            
        fi;
        
        return tree;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_id_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_id_stack, [ tree.id ] );
            
        else
            
            return func_id_stack;
            
        fi;
        
    end;
    
    template.dst_template_tree := CapJitIterateOverTree( template.dst_template_tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [ ] );
    
    template.is_fully_enhanced := true;
    
end );

# ID_FUNC( value ) => value
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "ID_FUNC( value )",
        dst_template := "value",
        returns_value := true,
    )
);

# List( List( L, f ), g ) => List( L, x -> g( f( x ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "outer_func", "inner_func" ],
        src_template := "List( List( list, inner_func ), outer_func )",
        dst_template := "List( list, x -> outer_func( inner_func( x ) ) )",
        new_funcs := [ [ "x" ] ],
        returns_value := true,
    )
);

# List( ListN( L1, L2, f ), g ) => ListN( L1, L2, { x, y } -> g( f( x, y ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list1", "list2", "outer_func", "inner_func" ],
        src_template := "List( ListN( list1, list2, inner_func ), outer_func )",
        dst_template := "ListN( list1, list2, { x, y } -> outer_func( inner_func( x, y ) ) )",
        new_funcs := [ [ "x", "y" ] ],
        returns_value := true,
    )
);

# ListN( List( L, f1 ), List( L, f2 ), g ) => List( L, x -> g( f1( x ), f2( x ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "inner_func1", "inner_func2", "outer_func" ],
        src_template := "ListN( List( list, inner_func1 ), List( list, inner_func2 ), outer_func )",
        dst_template := "List( list, x -> outer_func( inner_func1( x ), inner_func2( x ) ) )",
        new_funcs := [ [ "x" ] ],
        returns_value := true,
    )
);

# List( Concatenation( list ), func ) => Concatenation( List( list, x -> List( x, func ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "func" ],
        src_template := "List( Concatenation( list ), func )",
        dst_template := "Concatenation( List( list, x -> List( x, func ) ) )",
        new_funcs := [ [ "x" ] ],
        returns_value := true,
    )
);

# List( L{poss}, f ) => List( L, f ){poss}
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "poss", "func" ],
        src_template := "List( list{poss}, func )",
        dst_template := "List( list, func ){poss}",
        returns_value := true,
    )
);

# func( L )[index] => List( L, func )[index]
# Note: We always "push down" the function, because:
# If L is a `Concatenation`, we cannot resolve the index on the left hand side, but we can push the function further down on the right hand side.
# This causes some minor overhead if the index is fixed (e.g. for ProjectionInFactorOfDirectSum) because f is applied to the whole list
# instead of only the element given by the index, but such examples are rare.
# We only apply this if the object of which we take the index is given by a call to `List` or `List( List )` to make sure
# we actually have a list (this can be changed once we have a proper type system).
# Additionally, this should only trigger for homogeneous lists, i.e. `func` must be applicable to all elements of `L`.
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "func1", "list", "func2", "index" ],
        src_template := "func1( List( list, func2 )[index] )",
        dst_template := "List( List( list, func2 ), func1 )[index]",
        returns_value := true,
    )
);
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "listlist", "func1", "func2", "row", "index1", "index2" ],
        src_template := "func1( List( listlist, x -> List( row, func2 ) )[index1][index2] )",
        dst_template := "List( listlist, x -> List( List( row, func2 ), func1 ) )[index1][index2]",
        returns_value := true,
    )
);

# List( list_of_lists[index], func ) => List( list_of_lists, list -> List( list, func ) )[index]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list_of_lists", "index", "func" ],
        src_template := "List( list_of_lists[index], func )",
        dst_template := "List( list_of_lists, list -> List( list, func ) )[index]",
        new_funcs := [ [ "list" ] ],
        returns_value := true,
    )
);

# Length( List( list, func ) ) => Length( list )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "func" ],
        src_template := "Length( List( list, func ) )",
        dst_template := "Length( list )",
        returns_value := true,
    )
);

# [ 1 .. end ][i] => i
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "end", "index" ],
        src_template := "[ 1 .. end ][index]",
        dst_template := "index",
        returns_value := true,
    )
);

InstallGlobalFunction( CAP_JIT_INTERNAL_TREE_MATCHES_TEMPLATE_TREE, function ( tree, template_tree )
  local debug, variables, func_id_replacements, pre_func, result_func, additional_arguments_func, result;
    
    debug := ValueOption( "debug" ) = true;
    
    variables := [ ];
    func_id_replacements := [ ];
    
    pre_func := function ( template_tree, additional_arguments )
      local tree, new_template_tree;
        
        tree := additional_arguments[1];
        
        if tree = fail then
            
            return fail;
            
        fi;
        
        if template_tree.type = "EXPR_DECLARATIVE_FUNC" and tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            # we are only interested in two cases:
            # a) the functions actually only differ by ID, i.e. the names of all local variables and bindings agree
            # b) there are no local variables (i.e. only a single return statement), but the argument names might differ
            if template_tree.narg = tree.narg and template_tree.variadic = tree.variadic and ((template_tree.nams = tree.nams and template_tree.bindings.names = tree.bindings.names) or (Length( template_tree.nams ) = template_tree.narg + 1 and Length( tree.nams ) = tree.narg + 1 )) then
                
                Assert( 0, not IsBound( func_id_replacements[template_tree.id] ) );
                
                # map from template function to actual function
                func_id_replacements[template_tree.id] := rec(
                    func_id := tree.id,
                    nams := tree.nams,
                );
                
                template_tree := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( template_tree, tree.id, tree.nams );
                
            else
                
                return fail;
                
            fi;
            
        fi;
        
        return template_tree;
        
    end;
    
    result_func := function ( template_tree, result, keys, additional_arguments )
      local tree, tree_path, var_number, r, key;
        
        tree := additional_arguments[1];
        tree_path := additional_arguments[2];
        
        if debug then
            # COVERAGE_IGNORE_BLOCK_START
            Display( "now matching against" );
            Display( template_tree );
            Display( "result" );
            Display( result );
            # COVERAGE_IGNORE_BLOCK_END
        fi;
        
        # check if we already bailed out in pre_func
        if result = fail then
            
            return false;
            
        fi;
        
        # handle CAP_INTERNAL_JIT_TEMPLATE_VAR_i
        if template_tree.type = "EXPR_REF_GVAR" and StartsWith( template_tree.gvar, "CAP_INTERNAL_JIT_TEMPLATE_VAR_" ) then
            
            var_number := Int( ReplacedString( template_tree.gvar, "CAP_INTERNAL_JIT_TEMPLATE_VAR_", "" ) );
            
            Assert( 0, var_number <> fail );
            
            if not IsBound( variables[var_number] ) then
                
                variables[var_number] := rec(
                    path := tree_path,
                    tree := tree,
                );
                
                if debug then
                    # COVERAGE_IGNORE_BLOCK_START
                    Display( "matched via variable1" );
                    Display( true );
                    # COVERAGE_IGNORE_BLOCK_END
                fi;
                
                return true;
                
            else
                
                if debug then
                    # COVERAGE_IGNORE_BLOCK_START
                    Display( "matched via variable2" );
                    Display( CapJitIsEqualForEnhancedSyntaxTrees( variables[var_number].tree, tree ) );
                    # COVERAGE_IGNORE_BLOCK_END
                fi;
                
                return CapJitIsEqualForEnhancedSyntaxTrees( variables[var_number].tree, tree );
                
            fi;
            
        fi;
        
        if template_tree.type <> tree.type then
            
            if debug then
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "type mismatch" );
            fi;
            
            return false;
            
        fi;
        
        if template_tree.type = "SYNTAX_TREE_LIST" and template_tree.length <> tree.length then
            
            if debug then
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "list length mismatch" );
            fi;
            
            return false;
            
        fi;
        
        # <keys> are only the keys with children, but we want to test all keys -> loop over RecNames( template_tree )
        for key in RecNames( template_tree ) do
            
            if debug then
                # COVERAGE_IGNORE_BLOCK_START
                Display( "checking" );
                Display( key );
                # COVERAGE_IGNORE_BLOCK_END
            fi;
            
            # ignore these keys
            if key in [ "CAP_JIT_NOT_RESOLVABLE", "CAP_JIT_IGNORE_OPERATION", "data_type" ] then
                
                continue;
                
            fi;
            
            Assert( 0, IsBound( tree.(key) ) );
            
            # different gvars might point to the same value
            if key = "gvar" then
                
                if IsIdenticalObj( ValueGlobal( template_tree.gvar ), ValueGlobal( tree.gvar ) ) then
                    
                    if debug then
                        # COVERAGE_IGNORE_NEXT_LINE
                        Display( "match: gvars point to identical values" );
                    fi;
                    
                    continue;
                    
                else
                    
                    if debug then
                        # COVERAGE_IGNORE_NEXT_LINE
                        Display( "mismatch: gvars point to non-identical values" );
                    fi;
                    
                    return false;
                    
                fi;
                
            fi;
            
            # check if children match
            if IsBound( result.(key) ) then
                
                if result.(key) = false then
                    
                    if debug then
                        # COVERAGE_IGNORE_BLOCK_START
                        Display( "child mismatch" );
                        Display( key );
                        # COVERAGE_IGNORE_BLOCK_END
                    fi;
                    
                    return false;
                    
                else
                    
                    continue;
                    
                fi;
                
            fi;
            
            # now there should only remain integers, booleans, strings or list of strings
            Assert( 0, IsInt( template_tree.(key) ) or IsBool( template_tree.(key) ) or IsString( template_tree.(key) ) or (IsList( template_tree.(key) ) and ForAll( template_tree.(key), x -> IsString( x ) )) );
            
            if template_tree.(key) <> tree.(key) then
                
                if debug then
                    # COVERAGE_IGNORE_BLOCK_START
                    Display( "tree mismatch" );
                    Display( key );
                    # COVERAGE_IGNORE_BLOCK_END
                fi;
                
                return false;
                
            else
                
                continue;
                
            fi;
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "should never get here" );
            
        od;
        
        if debug then
            # COVERAGE_IGNORE_NEXT_LINE
            Display( "everything matched" );
        fi;
        
        return true;
        
    end;
    
    additional_arguments_func := function ( template_tree, key, additional_arguments )
      local tree, tree_path, func_id_replacement, pos_name;
        
        tree := additional_arguments[1];
        tree_path := Concatenation( additional_arguments[2], [ key ] );
        
        if tree <> fail then
            
            if template_tree.type <> tree.type then
                
                tree := fail;
                
            elif template_tree.type = "SYNTAX_TREE_LIST" and not IsBound( tree.(key) ) then
                
                # tree.(key) might not be bound for SYNTAX_TREE_LIST
                tree := fail;
                
            else
                
                Assert( 0, IsBound( tree.(key) ) );
                
                tree := tree.(key);
                
            fi;
            
        fi;
        
        return [ tree, tree_path ];
        
    end;
    
    result := CapJitIterateOverTree( template_tree, pre_func, result_func, additional_arguments_func, [ tree, [ ] ] );
    
    if result then
        
        return rec( variables := variables, func_id_replacements := func_id_replacements );
        
    else
        
        return fail;
        
    fi;
    
end );

InstallGlobalFunction( CapJitAppliedLogicTemplates, function ( tree, jit_args )
  local template;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic templates." );
    
    for template in CAP_JIT_LOGIC_TEMPLATES do
        
        tree := CAP_JIT_INTERNAL_APPLIED_LOGIC_TEMPLATE( tree, template, jit_args );
        
    od;
    
    return tree;
    
end );

InstallGlobalFunction( CAP_JIT_INTERNAL_APPLIED_LOGIC_TEMPLATE, function ( tree, template, jit_args )
  local matching_info, condition_func, path, match, new_tree, parent, variables, func_id_replacements, variable_path, filter, result, value, pre_func, dst_tree, i;
    
    tree := StructuralCopy( tree );
    
    if IsBound( template.needed_packages ) then
        
        # check if all needed packages are loaded
        if not ForAll( template.needed_packages, p -> IsPackageMarkedForLoading( p[1], p[2] ) ) then
            
            return tree;
            
        fi;
        
    fi;
    
    if not IsBound( template.is_fully_enhanced ) or template.is_fully_enhanced <> true then
        
        CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE( template );
        
    fi;
    
    while true do
        
        if IsBound( template.debug ) and template.debug then
            
            # COVERAGE_IGNORE_BLOCK_START
            Display( "try to match template:" );
            Display( template.src_template );
            # COVERAGE_IGNORE_BLOCK_END
            
        fi;
        
        # will be modified inplace
        matching_info := fail;
        
        condition_func := function ( tree, path )
            
            # check if we know that the template does not match
            if IsBound( tree.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE ) and tree.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE then
                
                return false;
                
            fi;
            
            # check if we already have a match
            if matching_info <> fail then
                
                return false;
                
            fi;
            
            matching_info := CAP_JIT_INTERNAL_TREE_MATCHES_TEMPLATE_TREE( tree, template.src_template_tree : debug := IsBound( template.debug_path ) and template.debug_path = path );
            
            if matching_info = fail then
                
                tree.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE := true;
                
            fi;
            
            return matching_info <> fail;
            
        end;
        
        path := CapJitFindNodeDeep( tree, condition_func );
        
        if path = fail then
            
            Assert( 0, matching_info = fail );
            
            if IsBound( template.debug ) and template.debug then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "could not find a match" );
                
            fi;
            
            # no further occurrences -> done
            break;
            
        fi;
        
        if IsBound( template.debug ) and template.debug then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "found match" );
            
        fi;
        
        # not handled yet
        Assert( 0, Length( path ) >= 1 );
        
        match := CapJitGetNodeByPath( tree, path );
        
        new_tree := StructuralCopy( tree );
        
        parent := CapJitGetNodeByPath( new_tree, path{[ 1 .. Length( path ) - 1 ]} );
        
        variables := matching_info.variables;
        func_id_replacements := matching_info.func_id_replacements;
        
        if not IsDenseList( variables ) or Length( variables ) <> Length( template.variable_names ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "matched wrong number of variables" );
            
        fi;
        
        # type check
        for i in [ 1 .. Length( template.variable_names ) ] do
            
            variable_path := Concatenation( path, variables[i].path );
            filter := template.variable_filters[i];
            
            if IsIdenticalObj( filter, IsObject ) then
                
                continue;
                
            fi;
            
            value := CapJitGetNodeByPath( tree, variable_path );
            
            if IsBound( value.data_type ) then
                
                if not IsSpecializationOfFilter( filter, value.data_type.filter ) then
                    
                    match.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE := true;
                    
                    break;
                    
                fi;
                
            else
                
                if Length( jit_args ) <> tree.narg or tree.variadic then
                    
                    Info( InfoCapJit, 1, "####" );
                    Info( InfoCapJit, 1, "Logic template has variable filters but we are executing without jit args (or function is variadic)." );
                    
                    match.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE := true;
                    
                    break;
                    
                fi;
                
                result := CapJitGetExpressionValueFromJitArgs( tree, variable_path, jit_args );
                
                if result[1] = false then
                    
                    match.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE := true;
                    
                    break;
                    
                fi;
                
                value := result[2];
                
                if not filter( value ) then
                    
                    match.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE := true;
                    
                    break;
                    
                fi;
                
            fi;
            
        od;
        
        if IsBound( match.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE ) and match.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE then
            
            if IsBound( template.debug ) and template.debug then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "type check did not succeed" );
                
            fi;
            
            continue;
            
        fi;
        
        # adjust function IDs and insert variables in dst_template_tree
        pre_func := function ( tree, additional_arguments )
          local var_number, replacement;
            
            if tree.type = "EXPR_DECLARATIVE_FUNC" and IsBound( func_id_replacements[tree.id] ) then
                
                replacement := func_id_replacements[tree.id];
                
                return CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( tree, replacement.func_id, replacement.nams );
                
            fi;
            
            if tree.type = "EXPR_REF_GVAR" and StartsWith( tree.gvar, "CAP_INTERNAL_JIT_TEMPLATE_VAR_" ) then
                
                var_number := Int( ReplacedString( tree.gvar, "CAP_INTERNAL_JIT_TEMPLATE_VAR_", "" ) );
                
                Assert( 0, var_number <> fail );
                
                # new function IDs will be set below
                return StructuralCopy( variables[var_number].tree );
                
            fi;
            
            return tree;
            
        end;
        
        dst_tree := CapJitIterateOverTree( template.dst_template_tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
        
        # make sure we have new function IDs
        dst_tree := CapJitCopyWithNewFunctionIDs( dst_tree );
        
        parent.(Last( path )) := dst_tree;
        
        # if new_tree is well-defined, take it
        if not CapJitContainsRefToFVAROutsideOfFuncStack( new_tree ) then
            
            if IsBound( template.debug ) and template.debug then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "success, new_tree is well-defined" );
                
            fi;
            
            tree := new_tree;
            
            Info( InfoCapJit, 1, "####" );
            Info( InfoCapJit, 1, "Applied the following template:" );
            Info( InfoCapJit, 1, template.src_template );
            Info( InfoCapJit, 1, template.dst_template );
            
        else
            
            if IsBound( template.debug ) and template.debug then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "new_tree is not well-defined" );
                
            fi;
            
            match.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE := true;
            
        fi;
        
    od;
    
    # reset CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE
    pre_func := function ( tree, additional_arguments )
      local level, pos;
        
        if IsBound( tree.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE ) then
            
            Unbind( tree.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE );
            
        fi;
        
        return tree;
        
    end;
    
    CapJitIterateOverTree( tree, pre_func, ReturnTrue, ReturnTrue, true );
    
    return tree;
    
end );
