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
    
    if IsBound( template.is_fully_enhanced ) and template.is_fully_enhanced = true then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the logic template is already fully enhanced" );
        
    fi;
    
    # some basic sanity checks
    if not IsRecord( template ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a logic template must be a record" );
        
    fi;
    
    if not IsSubset( RecNames( template ), [ "variable_names", "src_template", "dst_template" ] ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a logic template must have the following required record entries: variable_names, src_template, dst_template" );
        
    fi;
    
    diff := Difference( RecNames( template ), [ "variable_names", "variable_filters", "src_template", "src_template_tree", "dst_template", "dst_template_tree", "new_funcs", "needed_packages", "debug", "debug_path" ] );
    
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
        tmp_tree := ENHANCED_SYNTAX_TREE( EvalString( Concatenation( "x -> ", template.src_template ) ) );
        
        Assert( 0, tmp_tree.bindings.names = [ "RETURN_VALUE" ] );
        
        template.src_template_tree := CapJitValueOfBinding( tmp_tree.bindings, "RETURN_VALUE" );
        
    fi;
    
    # get dst_template_tree from dst_template
    if not IsBound( template.dst_template_tree ) then
        
        # to get a syntax tree we have to wrap the template in a function
        tmp_tree := ENHANCED_SYNTAX_TREE( EvalString( Concatenation( "x -> ", template.dst_template ) ) );
        
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
    )
);

# List( List( L, f ), g ) => List( L, x -> g( f( x ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "outer_func", "inner_func" ],
        src_template := "List( List( list, inner_func ), outer_func )",
        dst_template := "List( list, x -> outer_func( inner_func( x ) ) )",
        new_funcs := [ [ "x" ] ],
    )
);

# List( ListN( L1, L2, f ), g ) => ListN( L1, L2, { x, y } -> g( f( x, y ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list1", "list2", "outer_func", "inner_func" ],
        src_template := "List( ListN( list1, list2, inner_func ), outer_func )",
        dst_template := "ListN( list1, list2, { x, y } -> outer_func( inner_func( x, y ) ) )",
        new_funcs := [ [ "x", "y" ] ],
    )
);

# ListN( List( L, f1 ), List( L, f2 ), g ) => List( L, x -> g( f1( x ), f2( x ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "inner_func1", "inner_func2", "outer_func" ],
        src_template := "ListN( List( list, inner_func1 ), List( list, inner_func2 ), outer_func )",
        dst_template := "List( list, x -> outer_func( inner_func1( x ), inner_func2( x ) ) )",
        new_funcs := [ [ "x" ] ],
    )
);

# List( Concatenation( list ), func ) => Concatenation( List( list, x -> List( x, func ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "func" ],
        src_template := "List( Concatenation( list ), func )",
        dst_template := "Concatenation( List( list, x -> List( x, func ) ) )",
        new_funcs := [ [ "x" ] ],
    )
);

# List( L{poss}, f ) => List( L, f ){poss}
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "poss", "func" ],
        src_template := "List( list{poss}, func )",
        dst_template := "List( list, func ){poss}",
    )
);

# func( L )[index] => List( L, func )[index]
# Note: We always "push down" the function, because:
# If L is a `Concatenation`, we cannot resolve the index on the left hand side, but we can push the function further down on the right hand side.
# This causes some minor overhead if the index is fixed (e.g. for ProjectionInFactorOfDirectSum) because f is applied to the whole list
# instead of only the element given by the index, but such examples are rare.
# Additionally, this should only trigger for homogeneous lists, i.e. `func` must be applicable to all elements of `L`.
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "func", "index" ],
        variable_filters := [ IsList, IsFunction, IsInt ],
        src_template := "func( list[index] )",
        dst_template := "List( list, func )[index]",
    )
);

# List( list_of_lists[index], func ) => List( list_of_lists, list -> List( list, func ) )[index]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list_of_lists", "index", "func" ],
        src_template := "List( list_of_lists[index], func )",
        dst_template := "List( list_of_lists, list -> List( list, func ) )[index]",
        new_funcs := [ [ "list" ] ],
    )
);

# Length( List( list, func ) ) => Length( list )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "func" ],
        src_template := "Length( List( list, func ) )",
        dst_template := "Length( list )",
    )
);

# [ 1 .. end ][i] => i
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "end", "index" ],
        src_template := "[ 1 .. end ][index]",
        dst_template := "index",
    )
);

InstallGlobalFunction( CAP_JIT_INTERNAL_TREE_MATCHES_TEMPLATE_TREE, function ( tree, template_tree, variable_filters, debug )
  local i, variables, func_id_replacements, pre_func, result_func, additional_arguments_func, result;
    
    # bail out early if type mismatches
    if template_tree.type <> "SYNTAX_TREE_VARIABLE" and tree.type <> template_tree.type then
        
        return fail;
        
    fi;
    
    # after inlining, most syntax tree nodes are of type EXPR_FUNCCALL -> we can bail out early for some frequent conditions (i.e. check the type of funcref and args)
    if template_tree.type = "EXPR_FUNCCALL" then
        
        # by the check above, tree.type = template_tree.type = "EXPR_FUNCCALL"
        
        if template_tree.funcref.type <> "SYNTAX_TREE_VARIABLE" then
            
            if tree.funcref.type <> template_tree.funcref.type then
                
                return fail;
                
            fi;
            
            if template_tree.funcref.type = "EXPR_REF_GVAR" and not IsIdenticalObj( ValueGlobal( tree.funcref.gvar ), ValueGlobal( template_tree.funcref.gvar ) ) then
                
                return fail;
                
            fi;
            
        fi;
        
        if tree.args.length <> template_tree.args.length then
            
            return fail;
            
        fi;
        
        for i in [ 1 .. template_tree.args.length ] do
            
            if template_tree.args.(i).type <> "SYNTAX_TREE_VARIABLE" and tree.args.(i).type <> template_tree.args.(i).type then
                
                return fail;
                
            fi;
            
        od;
        
    fi;
    
    variables := [ ];
    func_id_replacements := rec( );
    
    pre_func := function ( template_tree, tree )
      local new_template_tree;
        
        if template_tree.type <> "SYNTAX_TREE_VARIABLE" and tree.type <> template_tree.type then
            
            return fail;
            
        fi;
        
        if template_tree.type = "SYNTAX_TREE_LIST" and template_tree.length <> tree.length then
            
            return fail;
            
        fi;
        
        if template_tree.type = "EXPR_DECLARATIVE_FUNC" and tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            # we are only interested in two cases:
            # a) the functions actually only differ by ID, i.e. the names of all local variables and bindings agree
            # b) there are no local variables (i.e. only a single return statement), but the argument names might differ
            if template_tree.narg = tree.narg and template_tree.variadic = tree.variadic and ((template_tree.nams = tree.nams and template_tree.bindings.names = tree.bindings.names) or (Length( template_tree.nams ) = template_tree.narg + 1 and Length( tree.nams ) = tree.narg + 1 )) then
                
                Assert( 0, not IsBound( func_id_replacements.(template_tree.id) ) );
                
                # map from template function to actual function
                func_id_replacements.(template_tree.id) := rec(
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
    
    result_func := function ( template_tree, result, keys, tree )
      local var_number, filter, key;
        
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
        
        # handle syntax tree variables (CAP_INTERNAL_JIT_TEMPLATE_VAR_i)
        if template_tree.type = "SYNTAX_TREE_VARIABLE" then
            
            var_number := template_tree.id;
            
            if not IsBound( variables[var_number] ) then
                
                filter := variable_filters[var_number];
                
                if IsIdenticalObj( filter, IsObject ) or (IsBound( tree.data_type ) and IsSpecializationOfFilter( filter, tree.data_type.filter )) then
                    
                    variables[var_number] := tree;
                    
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
                        Display( "type could not be inferred or did not match" );
                        # COVERAGE_IGNORE_BLOCK_END
                    fi;
                    
                    return false;
                    
                fi;
                
            else
                
                if debug then
                    # COVERAGE_IGNORE_BLOCK_START
                    Display( "matched via variable2" );
                    Display( CapJitIsEqualForEnhancedSyntaxTrees( variables[var_number], tree ) );
                    # COVERAGE_IGNORE_BLOCK_END
                fi;
                
                return CapJitIsEqualForEnhancedSyntaxTrees( variables[var_number], tree );
                
            fi;
            
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
            if key = "data_type" or key = "CAP_JIT_NOT_RESOLVABLE" then
                
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
    
    additional_arguments_func := function ( template_tree, key, tree )
        
        return tree.(key);
        
    end;
    
    result := CapJitIterateOverTree( template_tree, pre_func, result_func, additional_arguments_func, tree );
    
    if result then
        
        return rec( variables := variables, func_id_replacements := func_id_replacements );
        
    else
        
        return fail;
        
    fi;
    
end );

InstallGlobalFunction( CapJitAppliedLogicTemplates, function ( tree )
  local template;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic templates." );
    
    for template in CAP_JIT_LOGIC_TEMPLATES do
        
        if IsBound( template.needed_packages ) then
            
            # check if all needed packages are loaded
            if not ForAll( template.needed_packages, p -> IsPackageMarkedForLoading( p[1], p[2] ) ) then
                
                continue;
                
            fi;
            
        fi;
        
        if not IsBound( template.is_fully_enhanced ) or template.is_fully_enhanced <> true then
            
            CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE( template );
            
        fi;
        
    od;
    
    return CAP_JIT_INTERNAL_APPLIED_LOGIC_TEMPLATES( tree, Filtered( CAP_JIT_LOGIC_TEMPLATES, t -> IsBound( template.is_fully_enhanced ) and template.is_fully_enhanced = true ) );
    
end );

InstallGlobalFunction( CAP_JIT_INTERNAL_APPLIED_LOGIC_TEMPLATES, function ( tree, templates )
  local path_debugging_enabled, pre_func, additional_arguments_func;
    
    Assert( 0, ForAll( templates, template -> IsBound( template.is_fully_enhanced ) and template.is_fully_enhanced ) );
    
    path_debugging_enabled := ForAny( templates, template -> IsBound( template.debug_path ) );
    
    pre_func := function ( tree, additional_arguments )
      local func_id_stack, matching_info, variables, func_id_replacements, well_defined, pre_func, result_func, additional_arguments_func, dst_tree, template;
        
        func_id_stack := additional_arguments[1];
        # path = additional_arguments[2] is only needed for debugging and only available if path debugging is enabled
        
        for template in templates do
            
            # Try to apply the same logic template multiple times.
            # If it does not match multiple times, this does not increase the runtime noticeably
            # but if it does, the runtime improves noticeably.
            while true do
                
                if IsBound( template.debug ) and template.debug then
                    
                    # COVERAGE_IGNORE_BLOCK_START
                    Display( "try to match template:" );
                    Display( template.src_template );
                    # COVERAGE_IGNORE_BLOCK_END
                    
                fi;
                
                matching_info := CAP_JIT_INTERNAL_TREE_MATCHES_TEMPLATE_TREE( tree, template.src_template_tree, template.variable_filters, IsBound( template.debug_path ) and template.debug_path = additional_arguments[2] );
                
                if matching_info = fail then
                    
                    break;
                    
                fi;
                
                if IsBound( template.debug ) and template.debug then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "found match" );
                    
                fi;
                
                variables := matching_info.variables;
                func_id_replacements := matching_info.func_id_replacements;
                
                if not IsDenseList( variables ) or Length( variables ) <> Length( template.variable_names ) then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "matched wrong number of variables" );
                    
                fi;
                
                # will be modified inplace
                well_defined := true;
                
                # adjust function IDs and insert variables in dst_template_tree
                pre_func := function ( tree, func_id_stack )
                  local replacement;
                    
                    if not well_defined then
                        
                        # abort iteration
                        return fail;
                        
                    fi;
                    
                    if tree.type = "EXPR_DECLARATIVE_FUNC" and IsBound( func_id_replacements.(tree.id) ) then
                        
                        replacement := func_id_replacements.(tree.id);
                        
                        return CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( tree, replacement.func_id, replacement.nams );
                        
                    fi;
                    
                    return tree;
                    
                end;
                
                result_func := function ( tree, result, keys, func_id_stack )
                  local key;
                    
                    if not well_defined then
                        
                        return fail;
                        
                    fi;
                    
                    if tree.type = "SYNTAX_TREE_VARIABLE" then
                        
                        # check if the resulting tree would be well-defined
                        if CapJitContainsRefToFVAROutsideOfFuncStack( variables[tree.id], func_id_stack ) then
                            
                            well_defined := false;
                            
                            # abort iteration
                            return fail;
                            
                        fi;
                        
                        # new function IDs will be set below
                        return StructuralCopy( variables[tree.id] );
                        
                    fi;
                    
                    tree := ShallowCopy( tree );
                    
                    for key in keys do
                        
                        tree.(key) := result.(key);
                        
                    od;
                    
                    return tree;
                    
                end;
                
                additional_arguments_func := function ( tree, key, func_id_stack )
                    
                    if tree.type = "EXPR_DECLARATIVE_FUNC" then
                        
                        func_id_stack := Concatenation( func_id_stack, [ tree.id ] );
                        
                    fi;
                    
                    return func_id_stack;
                    
                end;
                
                dst_tree := CapJitIterateOverTree( template.dst_template_tree, pre_func, result_func, additional_arguments_func, func_id_stack );
                
                # if new_tree is well-defined, take it
                if well_defined then
                    
                    if IsBound( template.debug ) and template.debug then
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        Error( "success, dst_tree is well-defined" );
                        
                    fi;
                    
                    Info( InfoCapJit, 1, "####" );
                    Info( InfoCapJit, 1, "Applied the following template:" );
                    Info( InfoCapJit, 1, template.src_template );
                    Info( InfoCapJit, 1, template.dst_template );
                    
                    # make sure we have new function IDs
                    # Functions from src_template_tree can appear multiple times in dst_template_tree, so in dst_template_tree the same function ID can occur multiple times.
                    # Since we require function IDs to be unique in a tree except in this special case, we now have to create a copy with new IDs.
                    tree := CapJitCopyWithNewFunctionIDs( dst_tree );
                    
                    continue;
                    
                else
                    
                    if IsBound( template.debug ) and template.debug then
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        Error( "dst_tree is not well-defined" );
                        
                    fi;
                    
                    break;
                    
                fi;
                
            od;
            
        od;
        
        return tree;
        
    end;
    
    if path_debugging_enabled then
        
        # COVERAGE_IGNORE_BLOCK_START
        # path is only needed when path debugging is enabled
        additional_arguments_func := function ( tree, key, additional_arguments )
          local path, func_id_stack;
            
            func_id_stack := additional_arguments[1];
            path := additional_arguments[2];
            
            if tree.type = "EXPR_DECLARATIVE_FUNC" then
                
                func_id_stack := Concatenation( func_id_stack, [ tree.id ] );
                
            fi;
            
            path := Concatenation( path, [ key ] );
            
            return [ func_id_stack, path ];
            
        end;
        # COVERAGE_IGNORE_BLOCK_END
        
    else
        
        additional_arguments_func := function ( tree, key, additional_arguments )
            
            if tree.type = "EXPR_DECLARATIVE_FUNC" then
                
                return [ Concatenation( additional_arguments[1], [ tree.id ] ) ];
                
            else
                
                return additional_arguments;
                
            fi;
            
        end;
        
    fi;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [ [ ], [ ] ] );
    
end );
