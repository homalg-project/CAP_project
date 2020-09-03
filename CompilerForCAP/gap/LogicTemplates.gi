#
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_LOGIC_TEMPLATES", [
    # if ... then Error( ... ); fi;
    rec(
        variable_names := [ "condition", "message" ],
        src_template := "if condition then Error( message ); fi;",
        dst_template := "",
        returns_value := false,
    ),
    # INSTALL_TODO_FOR_LOGICAL_THEOREMS
    rec(
        variable_names := [ "condition", "objectified_morphism", "source", "range", "category" ],
        src_template := """
            if condition then
                INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Source", [ objectified_morphism ], source, category );
                INSTALL_TODO_FOR_LOGICAL_THEOREMS( "Range", [ objectified_morphism ], range, category );
            fi;
        """,
        dst_template := "",
        returns_value := false,
    ),
    # Assert( level, condition )
    rec(
        variable_names := [ "level", "condition" ],
        src_template := "Assert( level, condition )",
        dst_template := "",
        returns_value := false,
    ),
    # Assert( level, condition, message )
    rec(
        variable_names := [ "level", "condition", "message" ],
        src_template := "Assert( level, condition, message )",
        dst_template := "",
        returns_value := false,
    ),
    # List( List( L, f ), g ) => List( L, x -> g( f( x ) ) )
    rec(
        variable_names := [ "list", "outer_func", "inner_func" ],
        src_template := "List( List( list, inner_func ), outer_func )",
        dst_template := "List( list, x -> outer_func( inner_func( x ) ) )",
        new_funcs := [ [ "x" ] ],
        returns_value := true,
    ),
    # List( L, f )[index] => f( L[index] )
    rec(
        variable_names := [ "list", "func", "index" ],
        src_template := "List( list, func )[index]",
        dst_template := "func( list[index] )",
        returns_value := true,
    ),
] );

InstallGlobalFunction( CapJitAddLogicTemplate, function( template )
    
    # some basic sanity checks
    if not IsRecord( template ) then
        
        Error( "a logic template must be a record" );
        
    fi;
    
    if not IsSubset( RecNames( template ), [ "variable_names", "src_template", "dst_template", "returns_value" ] ) then
        
        Error( "a logic template must have the following required record entries: variable_names, src_template, dst_template, returns_value" );
        
    fi;

    if IsBound( template.variable_filters ) and Length( template.variable_names ) <> Length( template.variable_filters ) then
        
        Error( "the length of the record entries variable_names and variable_filters of a logic template must be equal" );
        
    fi;

    if IsBound( template.needed_packages ) and ( not IsList( template.needed_packages ) or ForAny( template.needed_packages, p -> not IsList( p ) or Length( p ) <> 2 ) ) then
        
        Error( "the record entry needed_packages of a logic template must be a list of pairs" );
        
    fi;
    
    Add( CAP_JIT_LOGIC_TEMPLATES, template );
    
end );

InstallGlobalFunction( CAP_JIT_INTERNAL_TREE_MATCHES_TEMPLATE_TREE, function( tree, template_tree, args... )
  local debug, variables, pre_func, result_func, additional_arguments_func, result;
    
    if not Length( args ) in [ 0, 1 ] then
        
        Error( "CAP_JIT_INTERNAL_TREE_MATCHES_TEMPLATE_TREE cannot be called with more than three arguments" );
        
    fi;

    if Length( args ) = 1 then
        
        Assert( 0, IsBool( args[1] ) );
        
        debug := args[1];
        
    else
        
        debug := false;
        
    fi;
  
    variables := [];

    pre_func := function( tree, additional_arguments )
      local template_tree;
        
        template_tree := additional_arguments[1];

        if template_tree = fail then

            return fail;
            
        fi;
        
        if IsRecord( tree ) and tree.type = "EXPR_FUNC" and template_tree.type = "EXPR_FUNC" then
            
            template_tree.stats := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( template_tree.stats, template_tree.id, tree.id, 0 );
            template_tree.id := tree.id;
            template_tree.real_nloc := tree.nloc;
            template_tree.real_nams := tree.nams;
            
        fi;
        
        return tree;
        
    end;
    
    result_func := function( tree, result, additional_arguments )
      local template_tree, path, var_number, r, key;
        
        template_tree := additional_arguments[1];
        path := additional_arguments[2];
      
        if debug then
            Display( "now matching against" );
            Display( template_tree );
            Display( "result" );
            Display( result );
        fi;
            
        if template_tree = fail then
            
            Assert( 0, result = fail );
            
            return false;
      
        elif IsList( result ) then
            
            for r in result do
                
                if r = false then
                    
                    if debug then
                        Display( "child mismatch" );
                    fi;
                    
                    return false;
                    
                fi;
                
            od;

            if debug then
                Display( "list length match" );
                Display( Length( tree ) = Length( template_tree ) );
            fi;
            
            return Length( tree ) = Length( template_tree );
            
        elif IsRecord( result ) then

            if template_tree.type = "EXPR_REF_GVAR" and StartsWith( template_tree.gvar, "CAP_INTERNAL_JIT_TEMPLATE_VAR_" ) then
                
                var_number := Int( ReplacedString( template_tree.gvar, "CAP_INTERNAL_JIT_TEMPLATE_VAR_", "" ) );
                
                Assert( 0, var_number <> fail );

                if not IsBound( variables[var_number] ) then
                    
                    variables[var_number] := rec(
                        path := path,
                        tree := tree,
                    );

                    if debug then
                        Display( "matched via variable1" );
                        Display( true );
                    fi;
                    
                    return true;
                    
                else

                    if debug then
                        Display( "matched via variable2" );
                        Display( variables[var_number].tree = tree );
                    fi;
                    
                    return variables[var_number].tree = tree;
                    
                fi;
                
            fi;

            if template_tree.type <> tree.type then
                
                if debug then
                    Display( "type mismatch" );
                fi;
                
                return false;
                
            fi;
            
            for key in RecNames( template_tree ) do

                if debug then
                    Display( "checking" );
                    Display( key );
                fi;
                
                # ignore these keys
                if key in [ "nams", "nloc", "real_nams", "real_nloc", "initial_name" ] then
                    
                    continue;
                    
                fi;

                Assert( 0, IsBound( tree.(key) ) );

                # different gvars might point to the same value
                if key = "gvar" then
                    
                    if IsIdenticalObj( ValueGlobal( template_tree.gvar ), ValueGlobal( tree.gvar ) ) then
                        
                        if debug then
                            Display( "match: gvars point to identical values" );
                        fi;
                
                        continue;
                        
                    else
                        
                        if debug then
                            Display( "mismatch: gvars point to non-identical values" );
                        fi;

                        return false;
                        
                    fi;
                        
                fi;
                
                # check if children match
                if IsBound( result.(key) ) then
                    
                    if result.(key) = false then
                        
                        if debug then
                            Display( "result mismatch" );
                            Display( key );
                        fi;
                        
                        return false;
                        
                    else
                        
                        continue;
                        
                    fi;
                    
                fi;
                
                # now there should only remain integers, booleans or strings
                Assert( 0, IsInt( template_tree.(key) ) or IsBool( template_tree.(key) ) or IsString( template_tree.(key) ) );
                
                if template_tree.(key) <> tree.(key) then
                    
                    if debug then
                        Display( "tree mismatch" );
                        Display( key );
                    fi;
                    
                    return false;
                    
                else
                    
                    continue;
                    
                fi;

                Error( "should never get here" );
                
            od;

            if debug then
                Display( "everything matched" );
            fi;
            
            return true;

        else
            
            Error( "this should never happen" );
            
        fi;
        
    end;

    additional_arguments_func := function( tree, key, additional_arguments )
      local template_tree, path;
        
        template_tree := additional_arguments[1];
        path := additional_arguments[2];
      
        if template_tree = fail then
            
            # do nothing
            
        elif IsList( tree ) then
            
            Assert( 0, IsList( template_tree ) );
            
            if IsBound( template_tree[key] ) then
                
                template_tree := template_tree[key];
                
            else
                
                template_tree := fail;
                
            fi;

        elif IsRecord( tree ) then
            
            Assert( 0, IsRecord( template_tree ) );
            
            if tree.type = template_tree.type then
                
                Assert( 0, IsBound( template_tree.(key) ) );
                
                template_tree := template_tree.(key);
                
            else
                
                template_tree := fail;
                
            fi;

        else
            
            Error( "this should never happen" );
            
        fi;

        path := Concatenation( path, [ key ] );

        return [ template_tree, path ];
        
    end;
    
    result := CapJitIterateOverTree( tree, pre_func, result_func, additional_arguments_func, [ template_tree, [] ] );

    if result then
    
        return variables;
    
    else
        
        return fail;
        
    fi;
    
end );

InstallGlobalFunction( CapJitAppliedLogicTemplates, function( tree, jit_args, args... )
  local cleanup_only, template, variable_names, variable_filters, src_template, dst_template, new_funcs, i, template_var_name, src_template_tree, dst_template_tree, variables, matched_src_template_tree, condition_func, path, match, new_tree, parent, variable_path, filter, result, value, dst_tree, pre_func;
    
    if not Length( args ) in [ 0, 1 ] then
        
        Error( "CapJitAppliedLogicTemplates cannot be called with more than three arguments" );
        
    fi;

    if Length( args ) = 1 then
        
        Assert( 0, IsBool( args[1] ) );
        
        cleanup_only := args[1];
        
    else
        
        cleanup_only := false;
        
    fi;
  
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic templates." );
    
    tree := StructuralCopy( tree );
  
    for template in CAP_JIT_LOGIC_TEMPLATES do
        
        variable_names := template.variable_names;
        
        if IsBound( template.variable_filters ) then
            
            # replace strings with actual filters
            variable_filters := List( template.variable_filters, function( f )
                
                if IsString( f ) then
                    
                    return ValueGlobal( f );
                    
                else
                    
                    return f;
                    
                fi;
                
            end );
            
        else
            
            variable_filters := ListWithIdenticalEntries( Length( variable_names ), IsObject );
            
        fi;
        
        Assert( 0, Length( variable_names ) = Length( variable_filters ) );

        if IsBound( template.needed_packages ) then
            
            # check if all needed packages are loaded
            if not ForAll( template.needed_packages, p -> IsPackageMarkedForLoading( p[1], p[2] ) ) then
                
                continue;
                
            fi;
            
        fi;
        
        src_template := template.src_template;
        dst_template := template.dst_template;

        if cleanup_only and dst_template <> "" then
            
            continue;
            
        fi;
        
        if IsBound( template.new_funcs ) then
            
            new_funcs := template.new_funcs;
            
        else
            
            new_funcs := [];
            
        fi;
        
        for i in [ 1 .. Length( variable_names ) ] do
            
            template_var_name := Concatenation( "CAP_INTERNAL_JIT_TEMPLATE_VAR_", String( i ) );

            if not template_var_name in NamesGVars() then
            
                DeclareGlobalVariable( template_var_name );

            fi;
            
            src_template := ReplacedString( src_template, variable_names[i], template_var_name );
            dst_template := ReplacedString( dst_template, variable_names[i], template_var_name );
            
        od;
        
        # to get a syntax tree we have to wrap the template in a function
        
        if template.returns_value then

            src_template_tree := ENHANCED_SYNTAX_TREE( EvalString( Concatenation( "x -> ", src_template ) ) ).stats.statements[1].obj;
            dst_template_tree := ENHANCED_SYNTAX_TREE( EvalString( Concatenation( "x -> ", dst_template ) ) ).stats.statements[1].obj;
        
        else
            
            src_template_tree := ENHANCED_SYNTAX_TREE( EvalString( Concatenation( "function() ", src_template, " ; return; end;" ) ) ).stats.statements[1];
            dst_template_tree := ENHANCED_SYNTAX_TREE( EvalString( Concatenation( "function() ", dst_template, " ; return; end;" ) ) ).stats.statements[1];

        fi;

        while true do
            
            if IsBound( template.debug ) and template.debug then
                
                Display( "try to match template:" );
                Display( src_template );
                
            fi;
            
            # will be modified inplace
            variables := fail;
            matched_src_template_tree := StructuralCopy( src_template_tree );
            
            condition_func := function( tree, path )
                
                # check if we know that the template does not match
                if IsBound( tree.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE ) and tree.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE then
                    
                    return false;
                    
                fi;
                
                # check if we already have a match
                if variables <> fail then
                    
                    return false;
                    
                fi;
                
                # matched_src_template_tree is modified inplace 
                if IsBound( template.debug_path ) and template.debug_path = path then
                    
                    variables := CAP_JIT_INTERNAL_TREE_MATCHES_TEMPLATE_TREE( tree, matched_src_template_tree, true );
                    
                else
                    
                    variables := CAP_JIT_INTERNAL_TREE_MATCHES_TEMPLATE_TREE( tree, matched_src_template_tree );
                    
                fi;

                if variables = fail then
                    
                    tree.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE := true;

                fi;
                
                return variables <> fail;
                
            end;
            
            path := CapJitFindNodeDeep( tree, condition_func );

            if path = fail then
                
                Assert( 0, variables = fail );
                
                if IsBound( template.debug ) and template.debug then
                    
                    Display( "could not find a match" );
                    
                fi;
            
                # no further occurrences -> done
                break;
                
            fi;
            
            if IsBound( template.debug ) and template.debug then
                
                Error( "found match" );
                
            fi;
            
            # not handled yet
            Assert( 0, Length( path ) >= 1 );

            match := CapJitGetNodeByPath( tree, path );

            new_tree := StructuralCopy( tree );
            parent := CapJitGetNodeByPath( new_tree, path{[ 1 .. Length( path )-1 ]} );

            if not IsDenseList( variables ) or Length( variables ) <> Length( variable_names ) then
                
                Error( "matched wrong number of variables" );
                
            fi;
            
            if dst_template = "" then
                
                # can only drop expression if it is in a list of statements
                Assert( 0, IsList( parent ) );
                Assert( 0, IsInt( Last( path ) ) );
                
                Remove( parent, Last( path ) );

                tree := new_tree;

                continue;
                
            fi;
            
            # type check
            for i in [ 1 .. Length( variable_names ) ] do
                
                variable_path := Concatenation( path, variables[i].path );
                filter := variable_filters[i];

                if IsIdenticalObj( filter, IsObject ) then
                    
                    continue;
                    
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
                
            od;
            
            if IsBound( match.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE ) and match.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE then
                
                if IsBound( template.debug ) and template.debug then
                    
                    Error( "type check did not succeed" );
                    
                fi;
                
                continue;
                
            fi;
            
            dst_tree := StructuralCopy( dst_template_tree );

            # set correct function IDs in dst_tree
            pre_func := function( tree, additional_arguments )
              local current_func, condition_func, path, func;

                if IsRecord( tree ) and tree.type = "EXPR_FUNC" then
                    
                    current_func := ShallowCopy( tree );

                    if current_func.nams in new_funcs then
                        
                        current_func.stats := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( current_func.stats, current_func.id, CAP_JIT_INTERNAL_FUNCTION_ID, 0 );
                        current_func.id := CAP_JIT_INTERNAL_FUNCTION_ID;
                        CAP_JIT_INTERNAL_FUNCTION_ID := CAP_JIT_INTERNAL_FUNCTION_ID + 1;

                        current_func.nams := List( current_func.nams, nam -> Concatenation( "logic_new_func_", String( current_func.id ), "_", nam ) );
                        
                    else
                        
                        condition_func := function( tree, path )
                            
                            return tree.type = "EXPR_FUNC" and tree.nams = current_func.nams;
                            
                        end;
                        
                        path := CapJitFindNodeDeep( matched_src_template_tree, condition_func );
                        
                        if path = fail then
                            
                            Error( "could not find matching func in src_template" );

                        fi;

                        func := CapJitGetNodeByPath( matched_src_template_tree, path );

                        current_func.stats := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( current_func.stats, current_func.id, func.id, 0 );
                        current_func.id := func.id;
                        current_func.nloc := func.real_nloc;
                        current_func.nams := func.real_nams;
                        
                    fi;

                    return current_func;
                    
                fi;
                
                return tree;
                
            end;
            
            dst_tree := CapJitIterateOverTree( dst_tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
            
            # insert variables in dst_tree (this has to happen after function IDs are set, since otherwise functions in replaced variables are considered)
            pre_func := function( tree, additional_arguments )
              local var_number;

                if IsRecord( tree ) and tree.type = "EXPR_REF_GVAR" and StartsWith( tree.gvar, "CAP_INTERNAL_JIT_TEMPLATE_VAR_" ) then
                    
                    var_number := Int( ReplacedString( tree.gvar, "CAP_INTERNAL_JIT_TEMPLATE_VAR_", "" ) );
        
                    Assert( 0, var_number <> fail );

                    return variables[var_number].tree;

                fi;
                
                return tree;
                
            end;
            
            dst_tree := CapJitIterateOverTree( dst_tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );

            if IsList( parent ) then
                
                Assert( 0, IsInt( Last( path ) ) );

                parent[Last( path )] := dst_tree;
                
            elif IsRecord( parent ) then
                
                Assert( 0, IsString( Last( path ) ) );

                parent.(Last( path )) := dst_tree;
                
            else
                
                Error( "this should never happen" );
                
            fi;
            
            # if new_tree is well-defined, take it
            if not CapJitContainsRefToFVAROutsideOfFuncStack( new_tree ) then
                
                if IsBound( template.debug ) and template.debug then
                    
                    Error( "success, new_tree is well-defined" );
                    
                fi;
                
                tree := new_tree;

                Info( InfoCapJit, 1, "####" );
                Info( InfoCapJit, 1, "Applied the following template:" );
                Info( InfoCapJit, 1, src_template );
                Info( InfoCapJit, 1, dst_template );
            
            else
                
                if IsBound( template.debug ) and template.debug then
                    
                    Error( "new_tree is not well-defined" );
                    
                fi;
                
                match.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE := true;
                
            fi;

        od;
        
        # reset CAP_INTERNAL_JIT_NO_UNUSED_VARIABLES
        pre_func := function( tree, additional_arguments )
          local level, pos;
            
            if IsRecord( tree ) and IsBound( tree.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE ) then
                
                Unbind( tree.CAP_INTERNAL_JIT_DOES_NOT_MATCH_TEMPLATE );
                
            fi;
            
            return tree;
            
        end;
        
        CapJitIterateOverTree( tree, pre_func, ReturnTrue, ReturnTrue, true );
        
    od;
    
    return tree;
    
end );
