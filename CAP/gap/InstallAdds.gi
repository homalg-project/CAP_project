# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
BindGlobal( "CAP_INTERNAL_ADD_OBJECT_OR_FAIL",
  
  function( category, object_or_fail )
    
    if object_or_fail = fail then
        return;
    fi;
    
    AddObject( category, object_or_fail );
    
end );

BindGlobal( "CAP_INTERNAL_ADD_MORPHISM_OR_FAIL",
  
  function( category, morphism_or_fail )
    
    if morphism_or_fail = fail then
        return;
    fi;
    
    AddMorphism( category, morphism_or_fail );
    
end );

BindGlobal( "CAP_INTERNAL_DISPLAY_ERROR_FOR_FUNCTION_OF_CATEGORY",
  
  function( function_name, category, message )
    
    Error( Concatenation( "in function \033[1m", function_name,
        "\033[0m\n       of category \033[1m",
        Name( category ), ":\033[0m\n\033[1m       ", message, "\033[0m\n" ) );
    
end );

InstallGlobalFunction( CapInternalInstallAdd,
  
  function( record )
    local function_name, install_name, add_name, pre_function, pre_function_full,
          redirect_function, post_function, filter_list, caching,
          cache_name, nr_arguments, argument_list, add_function;
    
    function_name := record.function_name;
    
    if not IsBound( record.installation_name ) then
        
        install_name := function_name;
        
    else
        
        install_name := record.installation_name;
        
    fi;
    
    add_name := Concatenation( "Add", function_name );
    
    if IsBound( record.pre_function ) then
        pre_function := record.pre_function;
    else
        pre_function := function( arg ) return [ true ]; end;
    fi;

    if IsBound( record.pre_function_full ) then
        pre_function_full := record.pre_function_full;
    else
        pre_function_full := function( arg ) return [ true ]; end;
    fi;
    
    if IsBound( record.redirect_function ) then
        redirect_function := record.redirect_function;
    else
        redirect_function := false;
    fi;
    
    if IsBound( record.post_function ) then
        post_function := record.post_function;
    else
        post_function := false;
    fi;
    
    filter_list := record.filter_list;
    
    if IsBound( record.cache_name ) then
        caching := true;
        cache_name := record.cache_name;
        nr_arguments := Length( filter_list );
    else
        caching := false;
    fi;
    
    if IsBound( record.argument_list ) then
        argument_list := record.argument_list;
    else
        argument_list := [ 1 .. Length( filter_list ) ];
    fi;
    
    if record.return_type = "object" then
        add_function := AddObject;
    elif record.return_type = "morphism" then
        add_function := AddMorphism;
    elif record.return_type = "twocell" then
        add_function := AddTwoCell;
    elif record.return_type = "object_or_fail" then
        add_function := CAP_INTERNAL_ADD_OBJECT_OR_FAIL;
    elif record.return_type = "morphism_or_fail" then
        add_function := CAP_INTERNAL_ADD_MORPHISM_OR_FAIL;
    else
        add_function := ReturnTrue;
    fi;
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsFunction ],
                   
      function( category, func )
        
        ValueGlobal( add_name )( category, func, -1 );
        
    end );
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsFunction, IsInt ],
                   
      function( category, func, weight )
        
        ValueGlobal( add_name )( category, [ [ func, [ ] ] ], weight );
        
    end );
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsList ],
                   
      function( category, func )
        
        ValueGlobal( add_name )( category, func, -1 );
        
    end );
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsList, IsInt ],
      
      function( category, method_list, weight )
        local install_func, replaced_filter_list, install_method, popper, i, set_primitive, is_derivation, without_given_name, with_given_name,
              without_given_weight, with_given_weight, number_of_proposed_arguments, current_function_number,
              current_function_argument_number, filter, input_human_readable_identifier_getter, input_sanity_check_functions,
              output_human_readable_identifier_getter, output_sanity_check_function, cap_jit_compiled_function;
        
        if HasIsFinalized( category ) and IsFinalized( category ) then
            Error( "cannot add methods anymore, category is finalized" );
        fi;
        
        if Length( method_list ) = 0 then
            Error( "you must pass at least one function to the add method" );
        fi;
        
        ## If there already is a faster method, do nothing!
        if weight > CurrentOperationWeight( category!.derivations_weight_list, function_name ) then
            return;
        fi;
        
        set_primitive := ValueOption( "SetPrimitive" );
        if set_primitive <> false then
            set_primitive := true;
        fi;
        
        is_derivation := ValueOption( "IsDerivation" );
        if is_derivation <> true then
            is_derivation := false;
        fi;
        
        if weight = -1 then
            weight := 100;
        fi;
        
        if not is_derivation and record.with_given_without_given_name_pair <> fail then
            
            without_given_name := record.with_given_without_given_name_pair[ 1 ];
            with_given_name := record.with_given_without_given_name_pair[ 2 ];
            
            without_given_weight := CurrentOperationWeight( category!.derivations_weight_list, without_given_name );
            with_given_weight := CurrentOperationWeight( category!.derivations_weight_list, with_given_name );
            
            if record.is_with_given = false then
                
                if with_given_weight <= weight then
                    
                    category!.redirects.( without_given_name ) := true;
                    
                else
                    
                    category!.redirects.( without_given_name ) := false;
                    
                fi;
                
            else
                
                if weight <= without_given_weight then
                    
                    category!.redirects.( without_given_name ) := true;
                    
                else
                    
                    category!.redirects.( without_given_name ) := false;
                    
                fi;
                
            fi;
            
        fi;
        
        replaced_filter_list := CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS( filter_list, category );
        
        if caching = true then
            install_method := InstallMethodWithCache;
            PushOptions( rec( Cache := GET_METHOD_CACHE( category, cache_name, nr_arguments )  ) );
            popper := true;
        else
            install_method := InstallMethod;
            popper := false;
        fi;
        
        ## Nr arguments sanity check
        
        number_of_proposed_arguments := Length( argument_list );
        
        for current_function_number in [ 1 .. Length( method_list ) ] do
            
            current_function_argument_number := NumberArgumentsFunction( method_list[ current_function_number ][ 1 ] );
            
            if current_function_argument_number = -1 then
                continue;
            fi;
            
            if current_function_argument_number <> number_of_proposed_arguments then
                Error( "In ", add_name, ": given function ", String( current_function_number ), " has ", String( current_function_argument_number ),
                       " arguments but should have ", String( number_of_proposed_arguments ) );
            fi;
            
        od;
        
        # prepare input sanity check
        input_human_readable_identifier_getter := function( args... )
            local human_readable_identifier, i, j;
            
            if Length( args ) = 0 then
                Error( "this function has to be called with at least one argument" );
            fi;
            
            i := args[ 1 ];

            human_readable_identifier := Concatenation( "the ", String(i), "-th argument of the function \033[1m", record.function_name, "\033[0m of the category named \033[1m", Name( category ), "\033[0m" );
            
            if Length( args ) = 1 then
                return human_readable_identifier;
            elif Length( args ) = 2 then
                j := args[ 2 ];
                return Concatenation( "the ", String(j), "-th entry of ", human_readable_identifier );
            else
                Error( "this function has to be called with at most two arguments" );
            fi;
        end;
        
        input_sanity_check_functions := [];
        for i in [ 1 .. Length( record.filter_list ) ] do
            filter := record.filter_list[ i ];
            
            if not IsString( filter ) then
                input_sanity_check_functions[i] := ReturnTrue;
            elif filter = "category" then
                # the only check would be that the input lies in IsCapCategory, which is already checked by the method selection
                input_sanity_check_functions[i] := ReturnTrue;
            elif filter = "cell" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_CELL_OF_CATEGORY( arg, category, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "object" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( arg, category, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "morphism" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( arg, category, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "twocell" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_TWO_CELL_OF_CATEGORY( arg, category, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "other_cell" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_CELL_OF_CATEGORY( arg, false, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "other_object" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( arg, false, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "other_morphism" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( arg, false, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "other_twocell" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_TWO_CELL_OF_CATEGORY( arg, false, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "list_of_objects" then
                input_sanity_check_functions[i] := function( arg, i )
                    local j;
                    for j in [ 1 .. Length( arg ) ] do
                        CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( arg[ j ], category, function( ) return input_human_readable_identifier_getter( i, j ); end );
                    od;
                end;
            elif filter = "list_of_morphisms" then
                input_sanity_check_functions[i] := function( arg, i )
                    local j;
                    for j in [ 1 .. Length( arg ) ] do
                        CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( arg[ j ], category, function( ) return input_human_readable_identifier_getter( i, j ); end );
                    od;
                end;
            elif filter = "list_of_twocells" then
                input_sanity_check_functions[i] := function( arg, i )
                    local j;
                    for j in [ 1 .. Length( arg ) ] do
                        CAP_INTERNAL_ASSERT_IS_TWO_CELL_OF_CATEGORY( arg[ j ], category, function( ) return input_human_readable_identifier_getter( i, j ); end );
                    od;
                end;
            else
                Display( Concatenation( "Warning: You should add an input sanity check for the following filter: ", String( filter ) ) );
            fi;
        od;
        
        # prepare output sanity check
        output_human_readable_identifier_getter := function( )
            return Concatenation( "the result of the function \033[1m", record.function_name, "\033[0m of the category named \033[1m", Name( category ), "\033[0m" );
        end;
        
        if record.return_type = "object" then
            output_sanity_check_function := function( result )
                CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( result, category, output_human_readable_identifier_getter );
            end;
        elif record.return_type = "morphism" then
            output_sanity_check_function := function( result )
                CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( result, category, output_human_readable_identifier_getter );
            end;
        elif record.return_type = "twocell" then
            output_sanity_check_function := function( result )
                CAP_INTERNAL_ASSERT_IS_TWO_CELL_OF_CATEGORY( result, category, output_human_readable_identifier_getter );
            end;
        elif record.return_type = "object_or_fail" then
            output_sanity_check_function := function( result )
                if result <> fail then
                    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( result, category, output_human_readable_identifier_getter );
                fi;
            end;
        elif record.return_type = "morphism_or_fail" then
            output_sanity_check_function := function( result )
                if result <> fail then
                    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( result, category, output_human_readable_identifier_getter );
                fi;
            end;
        else
            output_sanity_check_function := ReturnTrue;
        fi;

        if IsPackageMarkedForLoading( "CompilerForCAP", ">= 2020.06.17" ) then
            
            cap_jit_compiled_function := ValueGlobal( "CapJitCompiledFunction" );
            
        else
            
            cap_jit_compiled_function := function( args... )
                
                Error( "package CompilerForCAP is not loaded, so please disable compilation" );
                
            end;
            
        fi;
        
        install_func := function( func_to_install, filter_list )
          local new_filter_list, index;
            
            Add( category!.added_functions.( function_name ), [ func_to_install, filter_list ] );
            
            new_filter_list := CAP_INTERNAL_MERGE_FILTER_LISTS( replaced_filter_list, filter_list );
            
            if category!.enable_compilation = true or ( IsList( category!.enable_compilation ) and function_name in category!.enable_compilation ) then
                
                index := Length( category!.added_functions.( function_name ) );
                
                if Size( new_filter_list ) <> Size( argument_list ) then
                    
                    InstallMethod( ValueGlobal( install_name ),
                                new_filter_list,
                        
                        function( arg )
                            
                            if not IsBound( category!.compiled_functions.( function_name )[ index ] ) then
                                
                                category!.compiled_functions.( function_name )[ index ] := cap_jit_compiled_function( func_to_install, arg{ argument_list } );
                                
                            fi;
                            
                            return CallFuncList( category!.compiled_functions.( function_name )[ index ], arg{ argument_list } );
                            
                    end );
                    
                else
                    
                    if not ( IsProperty( ValueGlobal( install_name ) ) and IsIdenticalObj( func_to_install, ReturnTrue ) ) then
                        
                        InstallMethod( ValueGlobal( install_name ),
                                    new_filter_list,
                            function( arg )
                                
                                if not IsBound( category!.compiled_functions.( function_name )[ index ] ) then
                                    
                                    category!.compiled_functions.( function_name )[ index ] := cap_jit_compiled_function( func_to_install, arg );
                                    
                                fi;
                                
                                return CallFuncList( category!.compiled_functions.( function_name )[ index ], arg );
                                
                        end );
                        
                    else
                        
                        ## the call of InstallMethod triggers an error in GAP:
                        ## use `InstallTrueMethod' for <opr>
                        InstallTrueMethod( ValueGlobal( install_name ), new_filter_list[1] );
                        
                    fi;
                    
                fi;
                
            elif category!.overhead then
            
                install_method( ValueGlobal( install_name ),
                                new_filter_list,
                                
                  function( arg )
                    local redirect_return, filter, human_readable_identifier_getter, pre_func_return, result, i, j;
                    
                    if (redirect_function <> false) and (not IsBound( category!.redirects.( function_name ) ) or category!.redirects.( function_name ) <> false) then
                        redirect_return := CallFuncList( redirect_function, Concatenation( [ category ], arg ) );
                        if redirect_return[ 1 ] = true then
                            if category!.predicate_logic then
                                INSTALL_TODO_FOR_LOGICAL_THEOREMS( record.function_name, arg{ argument_list }, redirect_return[ 2 ], category );
                            fi;
                            return redirect_return[ 2 ];
                        fi;
                    fi;
                    
                    if category!.input_sanity_check_level > 0 then
                        for i in [ 1 .. Length( input_sanity_check_functions ) ] do
                            input_sanity_check_functions[ i ]( arg[ i ], i );
                        od;
                        
                        pre_func_return := CallFuncList( pre_function, arg );
                        if pre_func_return[ 1 ] = false then
                            CAP_INTERNAL_DISPLAY_ERROR_FOR_FUNCTION_OF_CATEGORY( record.function_name, category, pre_func_return[ 2 ] );
                        fi;
                        
                        if category!.input_sanity_check_level > 1 then
                            pre_func_return := CallFuncList( pre_function_full, arg );
                            if pre_func_return[ 1 ] = false then
                                CAP_INTERNAL_DISPLAY_ERROR_FOR_FUNCTION_OF_CATEGORY( record.function_name, category, pre_func_return[ 2 ] );
                            fi;
                        fi;
                        
                    fi;
                    
                    result := CallFuncList( func_to_install, arg{ argument_list } );
                    
                    if category!.predicate_logic then
                        INSTALL_TODO_FOR_LOGICAL_THEOREMS( record.function_name, arg{ argument_list }, result, category );
                    fi;
                    
                    if (not is_derivation) then
                        if category!.add_primitive_output then
                            add_function( category, result );
                        elif category!.output_sanity_check_level > 0 then
                            output_sanity_check_function( result );
                        fi;
                    fi;
                    
                    if post_function <> false then
                        
                        Add( arg, result );
                        
                        CallFuncList( post_function, Concatenation( [ category ], arg ) );
                        
                    fi;
                    
                    return result;
                    
                end );
            
            else #category!.overhead = false
                
                if Size( new_filter_list ) <> Size( argument_list ) then
                    
                    InstallMethod( ValueGlobal( install_name ),
                                new_filter_list,
                                    
                        function( arg )
                            
                            return CallFuncList( func_to_install, arg{ argument_list } );
                            
                    end );
                    
                else
                    
                    if not ( IsProperty( ValueGlobal( install_name ) ) and IsIdenticalObj( func_to_install, ReturnTrue ) ) then
                        
                        InstallMethod( ValueGlobal( install_name ),
                                    new_filter_list,
                                    func_to_install
                        );
                        
                    else
                        
                        ## the call of InstallMethod triggers an error in GAP:
                        ## use `InstallTrueMethod' for <opr>
                        InstallTrueMethod( ValueGlobal( install_name ), new_filter_list[1] );
                        
                    fi;
                    
                fi;
                
            fi;
            
        end;
        
        if not IsBound( category!.added_functions.( function_name ) ) then
            
            category!.added_functions.( function_name ) := [ ];
            
        fi;
        
        if not IsBound( category!.compiled_functions.( function_name ) ) then
            
            category!.compiled_functions.( function_name ) := [ ];
            
        fi;
        
        for i in method_list do
            
            if record.installation_name = "IsEqualForObjects" and IsIdenticalObj( i[ 1 ], IsIdenticalObj ) and category!.default_cache_type <> "crisp" and not ValueOption( "SuppressCacheWarning" ) = true then
                Display( "WARNING: IsIdenticalObj is used for deciding the equality of objects but the caching is not set to crisp. Thus, probably the specification that equal input gives equal output is not fulfilled. You can suppress this warning by passing the option \"SuppressCacheWarning := true\" to AddIsEqualForObjects." );
            fi;
            
            install_func( i[ 1 ], i[ 2 ] );
        od;
        
        if popper then
            PopOptions();
        fi;
        
        if set_primitive then
            AddPrimitiveOperation( category!.derivations_weight_list, function_name, weight );
            
            if not ValueOption( "IsFinalDerivation" ) = true then
                category!.primitive_operations.( function_name ) := true;
            fi;
            
        fi;
        
        
        
    end );
    
end );

BindGlobal( "CAP_INTERNAL_INSTALL_WITH_GIVEN_DERIVATION_PAIR", function( without_given_name, with_given_name, object_name, object_arguments )
    
    AddDerivationToCAP( ValueGlobal( with_given_name ),
                        [ [ ValueGlobal( without_given_name ), 1 ] ],
      function( arg )
        
        return CallFuncList( ValueGlobal( without_given_name ), arg{[ 1 .. Length( arg ) - 1 ]} );
        
    end : Description := Concatenation( with_given_name, " by calling ", without_given_name, " with the last argument dropped" ) );
    
    AddDerivationToCAP( ValueGlobal( without_given_name ),
                        [ [ ValueGlobal( with_given_name ), 1 ],
                          [ ValueGlobal( object_name ), 1 ] ],
      function( arg )
        
        return CallFuncList( ValueGlobal( with_given_name ),
                                    Concatenation( arg, [ CallFuncList( ValueGlobal( object_name ), arg{object_arguments} ) ] ) );
        
    end : Description := Concatenation( without_given_name, " by calling ", with_given_name, " with ", object_name, " as last argument" ) );
    
end );

BindGlobal( "CAP_INTERNAL_INSTALL_WITH_GIVEN_DERIVATIONS", function( record )
  local recnames, current_recname, current_rec, without_given_name, with_given_name, object_name, object_arguments;
    
    recnames := RecNames( record );
    
    for current_recname in recnames do
        
        current_rec := record.(current_recname);

        if current_rec.is_with_given then
            
            without_given_name := current_rec.with_given_without_given_name_pair[1];
            with_given_name := current_recname;
            object_name := current_rec.universal_object;
            if current_rec.number_of_diagram_arguments > 0 then
                object_arguments := [ 1 .. current_rec.number_of_diagram_arguments ];
            else
                object_arguments := [ 1 ];
            fi;
            
            CAP_INTERNAL_INSTALL_WITH_GIVEN_DERIVATION_PAIR( without_given_name, with_given_name, object_name, object_arguments );
            
        fi;
        
    od;
end );

InstallGlobalFunction( CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD,
    
  function( record )
    local recnames, current_recname, current_rec;
    
    CAP_INTERNAL_ENHANCE_NAME_RECORD( record );
    
    recnames := RecNames( record );
    
    AddOperationsToDerivationGraph( CAP_INTERNAL_DERIVATION_GRAPH, recnames );
    
    CAP_INTERNAL_INSTALL_WITH_GIVEN_DERIVATIONS( record );
    
    for current_recname in recnames do
        
        current_rec := record.( current_recname );
        
        ## keep track of it in method name rec
        CAP_INTERNAL_METHOD_NAME_RECORD.( current_recname ) := current_rec;
        
        if IsBound( current_rec.no_install ) and current_rec.no_install = true then
            
            continue;
            
        fi;
        
        CapInternalInstallAdd( current_rec );
        
    od;
    
end );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CAP_INTERNAL_METHOD_NAME_RECORD );

## These methods overwrite the automatically generated methods.
## The users do not have to give the category as an argument
## to their functions, but within derivations, the category has
## to be an argument (see any derivation of ZeroObject in DerivedMethods.gi)
##
InstallMethod( AddZeroObject,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    local wrapped_func;
    
    wrapped_func := function( cat ) return func(); end;
    
    AddZeroObject( category, [ [ wrapped_func, [ ] ] ], weight );
    
end );

##
InstallMethod( AddInitialObject,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    local wrapped_func;
    
    wrapped_func := function( cat ) return func(); end;
    
    AddInitialObject( category, [ [ wrapped_func, [ ] ] ], weight );
    
end );

##
InstallMethod( AddTerminalObject,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    local wrapped_func;
    
    wrapped_func := function( cat ) return func(); end;
    
    AddTerminalObject( category, [ [ wrapped_func, [ ] ] ], weight );
    
end );

##
InstallMethod( AddDistinguishedObjectOfHomomorphismStructure,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    local wrapped_func;
    
    wrapped_func := function( cat ) return func(); end;
    
    AddDistinguishedObjectOfHomomorphismStructure( category, [ [ wrapped_func, [ ] ] ], weight );
    
end );
