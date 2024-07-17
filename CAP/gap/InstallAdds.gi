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
    local function_name, CAP_operation, add_name, add_function, pre_function, pre_function_full,
          redirect_function, post_function, filter_list,
          add_value_to_category_function, replaced_filter_list,
          enhanced_filter_list, get_convenience_function;
    
    function_name := record.function_name;
    
    if not IsBound( record.installation_name ) then
        
        CAP_operation := ValueGlobal( function_name );
        
    else
        
        CAP_operation := ValueGlobal( record.installation_name );
        
    fi;
    
    add_name := Concatenation( "Add", function_name );
    add_function := ValueGlobal( add_name );
    
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
    
    if record.return_type = "object" then
        add_value_to_category_function := AddObject;
    elif record.return_type = "morphism" then
        add_value_to_category_function := AddMorphism;
    elif record.return_type = "twocell" then
        add_value_to_category_function := AddTwoCell;
    elif record.return_type = "object_or_fail" then
        add_value_to_category_function := CAP_INTERNAL_ADD_OBJECT_OR_FAIL;
    elif record.return_type = "morphism_or_fail" then
        add_value_to_category_function := CAP_INTERNAL_ADD_MORPHISM_OR_FAIL;
    else
        add_value_to_category_function := ReturnTrue;
    fi;
    
    # declare operation with category as first argument and install convenience method
    if record.install_convenience_without_category then
        
        replaced_filter_list := CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS( filter_list );
        
        if filter_list[2] in [ "object", "morphism", "twocell" ] then
            
            get_convenience_function := oper -> { arg } -> CallFuncList( oper, Concatenation( [ CapCategory( arg[1] ) ], arg ) );
            
        elif filter_list[2] = "list_of_objects" or filter_list[2] = "list_of_morphisms" then
            
            get_convenience_function := oper -> { arg } -> CallFuncList( oper, Concatenation( [ CapCategory( arg[1][1] ) ], arg ) );
            
        elif filter_list[3] in [ "object", "morphism", "twocell" ] then
            
            get_convenience_function := oper -> { arg } -> CallFuncList( oper, Concatenation( [ CapCategory( arg[2] ) ], arg ) );
            
        elif filter_list[4] = "list_of_objects" or filter_list[4] = "list_of_morphisms" then
            
            get_convenience_function := oper -> { arg } -> CallFuncList( oper, Concatenation( [ CapCategory( arg[3][1] ) ], arg ) );
            
        else
            
            Error( Concatenation( "please add a way to derive the category from the arguments of ", function_name ) );
            
        fi;
        
        InstallOtherMethod( CAP_operation, replaced_filter_list{[ 2 .. Length( replaced_filter_list ) ]}, get_convenience_function( CAP_operation ) );
        
    fi;
    
    # convenience for Julia lists
    #= comment for Julia
    if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
        
        if "list_of_objects" in filter_list or "list_of_morphisms" in filter_list or "list_of_twocells" in filter_list then
            
            replaced_filter_list := CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS_FOR_JULIA( filter_list );
            
            Assert( 0, ValueGlobal( "IsJuliaObject" ) in replaced_filter_list );
            
            InstallOtherMethod( CAP_operation,
                    replaced_filter_list,
                    { arg } -> CallFuncList( CAP_operation,
                            List( arg, function( ar ) if ValueGlobal( "IsJuliaObject" )( ar ) then return ValueGlobal( "ConvertJuliaToGAP" )( ar ); fi; return ar; end ) ) );
            
            Assert( 0, record.install_convenience_without_category );
            
            InstallOtherMethod( CAP_operation,
                    replaced_filter_list{[ 2 .. Length( replaced_filter_list ) ]},
                    { arg } -> CallFuncList( CAP_operation,
                            List( arg, function( ar ) if ValueGlobal( "IsJuliaObject" )( ar ) then return ValueGlobal( "ConvertJuliaToGAP" )( ar ); fi; return ar; end ) ) );
            
        fi;
        
    fi;
    # =#
    
    InstallMethod( add_function,
                   [ IsCapCategory, IsFunction ],
                   
      function( category, func )
        
        add_function( category, func, -1 );
        
    end );
    
    InstallMethod( add_function,
                   [ IsCapCategory, IsFunction, IsInt ],
                   
     FunctionWithNamedArguments(
      [
        [ "IsPrecompiledDerivation", false ],
      ],
      function( CAP_NAMED_ARGUMENTS, category, func, weight )
        
        add_function( category, [ [ func, [ ] ] ], weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
        
    end ) );
    
    InstallMethod( add_function,
                   [ IsCapCategory, IsList ],
                   
      function( category, func )
        
        add_function( category, func, -1 );
        
    end );
    
    InstallMethod( add_function,
                   [ IsCapCategory, IsList, IsInt ],
     
     FunctionWithNamedArguments(
      [
        [ "IsDerivation", false ],
        [ "IsFinalDerivation", false ],
        [ "IsPrecompiledDerivation", false ],
      ],
      function( CAP_NAMED_ARGUMENTS, category, method_list, weight )
        local is_derivation, is_final_derivation, is_precompiled_derivation, replaced_filter_list, needs_wrapping,
            number_of_proposed_arguments, current_function_argument_number, current_additional_filter_list_length,
            input_sanity_check_functions, output_human_readable_identifier_list, output_sanity_check_function,
            output_data_type, assert_is_value_of_return_type, install_func, name, current_function_number, i;
        
        if IsFinalized( category ) then
            Error( "cannot add methods anymore, category is finalized" );
        fi;
        
        if Length( method_list ) = 0 then
            Error( "you must pass at least one function to the add method" );
        fi;
        
        is_derivation := CAP_NAMED_ARGUMENTS.IsDerivation;
        
        is_final_derivation := CAP_NAMED_ARGUMENTS.IsFinalDerivation;
        
        is_precompiled_derivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation;
        
        if Length( Positions( [ is_derivation, is_final_derivation, is_precompiled_derivation ], true ) ) > 1 then
            
            Error( "at most one of the options `IsDerivation`, `IsFinalDerivation` and `IsPrecompiledDerivation` may be set" );
            
        fi;
        
        # prepare for the checks in Finalize
        if not IsBound( category!.initially_known_categorical_properties ) then
            
            category!.initially_known_categorical_properties := ShallowCopy( ListKnownCategoricalProperties( category ) );
            
            InstallDerivationsUsingOperation( category!.derivations_weight_list, "none" );
            
        fi;
        
        if weight = -1 then
            weight := 100;
        fi;
        
        # If there already is a faster method: do nothing but display a warning because this should not happen usually.
        if weight > CurrentOperationWeight( category!.derivations_weight_list, function_name ) then
            
            # * Not all derivations are properly dualized, so it can happen that a derivation for the dual of an operation is cheaper then the operation.
            #   This would automatically be fixed by https://github.com/homalg-project/CAP_project/issues/1078.
            # * There are some derivations of weight 1 for thin categories which are triggered immediately and which CategoryConstructor tries to overwrite with weight 100.
            if not WasCreatedAsOppositeCategory( category ) and CurrentOperationWeight( category!.derivations_weight_list, function_name ) <> 1 then
                
                Print( "WARNING: Ignoring a function added for ", function_name, " with weight ", weight, " to \"", Name( category ), "\" because there already is a function installed with weight ", CurrentOperationWeight( category!.derivations_weight_list, function_name ), "." );
                
                if is_precompiled_derivation then
                    
                    Print( " Probably you have to rerun the precompilation to adjust the weights in the precompiled code." );
                    
                fi;
                
                Print( "\n" );
                
            fi;
            
            return;
            
        fi;
        
        # Display a warning when overwriting primitive operations with derivations.
        if (is_derivation or is_final_derivation or is_precompiled_derivation) and IsBound( category!.primitive_operations.( function_name ) ) and category!.primitive_operations.( function_name ) then
            
            # * Not all derivations are properly dualized, so it can happen that a derivation for the dual of an operation is cheaper then the operation.
            #   This would automatically be fixed by https://github.com/homalg-project/CAP_project/issues/1078.
            # * There is a test in Locales creating a category via CategoryConstructor (which uses weight 100) and then installs a really cheap method for UniqueMorphism which triggers a bunch of cheap derivations.
            if not WasCreatedAsOppositeCategory( category ) and weight > 4 then
                
                Print( "WARNING: Overriding a function for ", function_name, " primitively added to \"", Name( category ), "\" with a derivation." );
                
                if is_precompiled_derivation then
                    
                    Print( " Probably you have to rerun the precompilation to adjust the weights in the precompiled code." );
                    
                fi;
                
                Print( "\n" );
                
            fi;
            
        fi;
        
        replaced_filter_list := CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS( filter_list, category );
        
        ## Nr arguments sanity check
        
        # backwards compatibility for categories with `category!.category_as_first_argument = false`
        needs_wrapping := IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = false and not (is_derivation or is_final_derivation);
        
        if needs_wrapping then
            
            Print( "WARNING: Setting `category!.category_as_first_argument` to `false` is deprecated and will not be supported after 2024.08.29.\n" );
            
            number_of_proposed_arguments := Length( filter_list ) - 1;
            
        else
            
            number_of_proposed_arguments := Length( filter_list );
            
        fi;
        
        for current_function_number in [ 1 .. Length( method_list ) ] do
            
            current_function_argument_number := NumberArgumentsFunction( method_list[ current_function_number ][ 1 ] );
            
            if current_function_argument_number >= 0 and current_function_argument_number <> number_of_proposed_arguments then
                Error( "In ", add_name, ": given function ", String( current_function_number ), " has ", String( current_function_argument_number ),
                       " arguments but should have ", String( number_of_proposed_arguments ) );
            fi;
            
            if not needs_wrapping then
                
                current_additional_filter_list_length := Length( method_list[ current_function_number ][ 2 ] );
                
                if current_additional_filter_list_length > 0 and current_additional_filter_list_length <> number_of_proposed_arguments then
                    Error( "In ", add_name, ": the additional filter list of given function ", String( current_function_number ), " has length ",
                           String( current_additional_filter_list_length ), " but should have length ", String( number_of_proposed_arguments ), " (or 0)" );
                fi;
                
            else
                
                method_list[ current_function_number ][ 1 ] := CAP_INTERNAL_CREATE_NEW_FUNC_WITH_ONE_MORE_ARGUMENT_WITH_RETURN( method_list[ current_function_number ][ 1 ] );
                
                if not IsEmpty( method_list[ current_function_number ][ 2 ] ) then
                    
                    method_list[ current_function_number ][ 2 ] := Concatenation( [ IsCapCategory ], method_list[ current_function_number ][ 2 ] );
                    
                fi;
                
            fi;
            
        od;
        
        # prepare input sanity check
        input_sanity_check_functions := List( [ 1 .. Length( record.filter_list ) ], function ( i )
          local filter_string, data_type, assert_is_value_of_type;
            
            filter_string := record.filter_list[ i ];
            
            data_type := CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( filter_string, category );
            
            if data_type <> fail then
                
                return CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( data_type, [ "the ", i, "-th argument of the function \033[1m", record.function_name, "\033[0m of the category named \033[1m", Name( category ), "\033[0m" ] );
                
            else
                
                return ReturnTrue;
                
            fi;
            
        end );
        
        # prepare output sanity check
        output_human_readable_identifier_list := [ "the result of the function \033[1m", record.function_name, "\033[0m of the category named \033[1m", Name( category ), "\033[0m" ];
        
        if EndsWith( record.return_type, "_or_fail" ) then
            
            output_data_type := CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( record.return_type{[ 1 .. Length( record.return_type ) - 8 ]}, category );
            
        else
            
            output_data_type := CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( record.return_type, category );
            
        fi;
        
        if output_data_type <> fail then
            
            assert_is_value_of_return_type := CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( output_data_type, output_human_readable_identifier_list );
            
            if EndsWith( record.return_type, "_or_fail" ) then
                
                output_sanity_check_function := function( result )
                    
                    if result <> fail then
                        
                        assert_is_value_of_return_type( result );
                        
                    fi;
                    
                end;
                
            else
                
                output_sanity_check_function := assert_is_value_of_return_type;
                
            fi;
            
        else
            
            output_sanity_check_function := ReturnTrue;
            
        fi;
        
        install_func := function( func_to_install, additional_filters )
          local new_filter_list, index;
            
            Add( category!.added_functions.( function_name ), [ func_to_install, additional_filters ] );
            
            new_filter_list := CAP_INTERNAL_MERGE_FILTER_LISTS( replaced_filter_list, additional_filters );
            
            if category!.overhead then
                
                InstallMethodWithCache( CAP_operation,
                                new_filter_list,
                                
                  function( arg )
                    local redirect_return, pre_func_return, collect_timing_statistics, start_time, result, end_time, i;
                    
                    if not IsFinalized( category ) and not category!.primitive_operations.( function_name ) then
                        
                        Print(
                            "WARNING: You are calling an operation in an unfinalized category with name \"", Name( category ),
                            "\". This is fine for debugging purposes, but for production use you should finalize the category by calling `Finalize` (with the option `FinalizeCategory := true` if needed).\n"
                        );
                        
                    fi;
                    
                    if redirect_function <> false then
                        redirect_return := CallFuncList( redirect_function, arg );
                        if redirect_return[ 1 ] = true then
                            if category!.predicate_logic then
                                INSTALL_TODO_FOR_LOGICAL_THEOREMS( record.function_name, arg{[ 2 .. Length( arg ) ]}, redirect_return[ 2 ], category );
                            fi;
                            return redirect_return[ 2 ];
                        fi;
                    fi;
                    
                    if category!.input_sanity_check_level > 0 then
                        for i in [ 1 .. Length( input_sanity_check_functions ) ] do
                            input_sanity_check_functions[ i ]( arg[ i ] );
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
                    
                    collect_timing_statistics := category!.timing_statistics_enabled and not is_derivation and not is_final_derivation;
                    
                    if collect_timing_statistics then
                        
                        start_time := Runtime( );
                        
                    fi;
                    
                    result := CallFuncList( func_to_install, arg );
                    
                    if collect_timing_statistics then
                        
                        end_time := Runtime( );
                        
                        Add( category!.timing_statistics.( function_name ), end_time - start_time );
                        
                    fi;
                    
                    if category!.predicate_logic then
                        INSTALL_TODO_FOR_LOGICAL_THEOREMS( record.function_name, arg{[ 2 .. Length( arg ) ]}, result, category );
                    fi;
                    
                    if not is_derivation and not is_final_derivation then
                        if category!.add_primitive_output then
                            add_value_to_category_function( category, result );
                        elif category!.output_sanity_check_level > 0 then
                            output_sanity_check_function( result );
                        fi;
                    fi;
                    
                    if post_function <> false then
                        
                        CallFuncList( post_function, Concatenation( arg, [ result ] ) );
                        
                    fi;
                    
                    return result;
                    
                end : InstallMethod := InstallOtherMethod, Cache := GET_METHOD_CACHE( category, function_name, Length( filter_list ) ) );
            
            else #category!.overhead = false
                
                InstallOtherMethod( CAP_operation,
                            new_filter_list,
                    
                    function( arg )
                        
                        return CallFuncList( func_to_install, arg );
                        
                end );
                
            fi;
            
        end;
        
        if not IsBound( category!.added_functions.( function_name ) ) then
            
            category!.added_functions.( function_name ) := [ ];
            
        fi;
        
        if not IsBound( category!.timing_statistics.( function_name ) ) then
            
            category!.timing_statistics.( function_name ) := [ ];
            
        fi;
        
        for i in method_list do
            
            name := Name( category );
            
            # set name for debugging purposes
            if NameFunction( i[ 1 ] ) in [ "unknown", "_EVALSTRINGTMP" ] then
                
                if is_derivation then
                    
                    SetNameFunction( i[ 1 ], Concatenation( "Derivation (first added to ", name, ") of ", function_name ) );
                    
                elif is_final_derivation then
                    
                    SetNameFunction( i[ 1 ], Concatenation( "Final derivation (first added to ", name, ") of ", function_name ) );
                    
                elif is_precompiled_derivation then
                    
                    SetNameFunction( i[ 1 ], Concatenation( "Precompiled derivation added to ", name, " for ", function_name ) );
                    
                else
                    
                    SetNameFunction( i[ 1 ], Concatenation( "Function added to ", name, " for ", function_name ) );
                    
                fi;
                
            fi;
            
            install_func( i[ 1 ], i[ 2 ] );
            
        od;
        
        if not is_derivation then
            
            # Final derivations are not handled by the original derivation mechanism and are thus just like primitive operations for it.
            AddPrimitiveOperation( category!.derivations_weight_list, function_name, weight );
            
        fi;
        
        if is_derivation or is_final_derivation or is_precompiled_derivation then
            
            category!.primitive_operations.( function_name ) := false;
            
        else
            
            category!.primitive_operations.( function_name ) := true;
            
        fi;
        
    end ) );
    
end );

BindGlobal( "CAP_INTERNAL_INSTALL_WITH_GIVEN_DERIVATION_PAIR", function( without_given_rec, with_given_rec )
  local without_given_name, with_given_name, without_given_arguments_names, with_given_arguments_names, with_given_object_position, with_given_via_without_given_function, with_given_arguments_strings, additional_preconditions, x, pos, without_given_via_with_given_function;
    
    without_given_name := without_given_rec.function_name;
    with_given_name := with_given_rec.function_name;
    
    without_given_arguments_names := without_given_rec.input_arguments_names;
    with_given_arguments_names := with_given_rec.input_arguments_names;
    
    with_given_object_position := without_given_rec.with_given_object_position;
    
    with_given_via_without_given_function := EvalString( ReplacedStringViaRecord(
        """
        function( with_given_arguments... )
            
            return without_given_name( without_given_arguments... );
            
        end
        """,
        rec(
            with_given_arguments := with_given_arguments_names,
            without_given_arguments := without_given_arguments_names,
            without_given_name := without_given_name,
        )
    ) );
    
    if with_given_object_position = "Source" then
        
        with_given_arguments_strings := Concatenation( without_given_arguments_names, [ without_given_rec.output_source_getter_string ] );
        
        if not IsBound( without_given_rec.output_source_getter_preconditions ) then
            
            Print( "WARNING: Cannot install with given derivation pair for ", without_given_name, " because <without_given_rec.output_source_getter_preconditions> is not set.\n" );
            return;
            
        fi;
        
        additional_preconditions := without_given_rec.output_source_getter_preconditions;
        
    elif with_given_object_position = "Range" then
        
        with_given_arguments_strings := Concatenation( without_given_arguments_names, [ without_given_rec.output_range_getter_string ] );
        
        if not IsBound( without_given_rec.output_range_getter_preconditions ) then
            
            Print( "WARNING: Cannot install with given derivation pair for ", without_given_name, " because <without_given_rec.output_range_getter_preconditions> is not set.\n" );
            return;
            
        fi;
        
        additional_preconditions := without_given_rec.output_range_getter_preconditions;
        
    elif with_given_object_position = "both" then
        
        with_given_arguments_strings := Concatenation(
            [ without_given_arguments_names[1] ],
            [ without_given_rec.output_source_getter_string ],
            without_given_arguments_names{[ 2 .. Length( without_given_arguments_names ) ]},
            [ without_given_rec.output_range_getter_string ]
        );
        
        if not IsBound( without_given_rec.output_source_getter_preconditions ) then
            
            Print( "WARNING: Cannot install with given derivation pair for ", without_given_name, " because <without_given_rec.output_source_getter_preconditions> is not set.\n" );
            return;
            
        fi;
        
        if not IsBound( without_given_rec.output_range_getter_preconditions ) then
            
            Print( "WARNING: Cannot install with given derivation pair for ", without_given_name, " because <without_given_rec.output_range_getter_preconditions> is not set.\n" );
            return;
            
        fi;
        
        # merge output_source_getter_preconditions and output_range_getter_preconditions
        additional_preconditions := without_given_rec.output_source_getter_preconditions;
        
        for x in without_given_rec.output_range_getter_preconditions do
            
            pos := PositionProperty( additional_preconditions, y -> y[1] = x[1] );
            
            if pos = fail then
                
                Add( additional_preconditions, x );
                
            else
                
                additional_preconditions[pos][2] := additional_preconditions[pos][2] + x[2];
                
            fi;
            
        od;
        
    else
        
        Error( "this should never happen" );
        
    fi;
    
    without_given_via_with_given_function := EvalString( ReplacedStringViaRecord(
        """
        function( without_given_arguments... )
            
            return with_given_name( with_given_arguments... );
            
        end
        """,
        rec(
            without_given_arguments := without_given_arguments_names,
            with_given_arguments := with_given_arguments_strings,
            with_given_name := with_given_name,
        )
    ) );
    
    AddDerivationToCAP(
        ValueGlobal( with_given_name ),
        Concatenation( with_given_name, " by calling ", without_given_name, " with the WithGiven argument(s) dropped" ),
        [ [ ValueGlobal( without_given_name ), 1 ] ],
        with_given_via_without_given_function
        : is_with_given_derivation := true
    );
    
    AddDerivationToCAP(
        ValueGlobal( without_given_name ),
        Concatenation( without_given_name, " by calling ", with_given_name, " with the WithGiven object(s)" ),
        Concatenation( [ [ ValueGlobal( with_given_name ), 1 ] ], List( additional_preconditions, x -> [ ValueGlobal( x[1] ), x[2] ] ) ),
        without_given_via_with_given_function
        : is_with_given_derivation := true
    );
    
end );

BindGlobal( "CAP_INTERNAL_INSTALL_WITH_GIVEN_DERIVATIONS", function( record )
  local recnames, current_rec, without_given_rec, with_given_rec, current_recname;
    
    recnames := RecNames( record );
    
    for current_recname in recnames do
        
        current_rec := record.(current_recname);
        
        if current_rec.is_with_given then
            
            without_given_rec := record.(current_rec.with_given_without_given_name_pair[1]);
            with_given_rec := record.(current_rec.with_given_without_given_name_pair[2]);
            
            CAP_INTERNAL_INSTALL_WITH_GIVEN_DERIVATION_PAIR( without_given_rec, with_given_rec );
            
        fi;
        
    od;
    
end );

InstallGlobalFunction( CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD,
    
  function( record )
    local recnames, current_recname, current_rec;
    
    recnames := RecNames( record );
    
    AddOperationsToDerivationGraph( CAP_INTERNAL_DERIVATION_GRAPH, recnames );
    
    for current_recname in recnames do
        
        current_rec := record.( current_recname );
        
        if not IsBound( current_rec.function_name ) then
            
            Error( "the record has no entry `function_name`, probably you forgot to call CAP_INTERNAL_ENHANCE_NAME_RECORD" );
            
        fi;
        
        ## keep track of it in method name rec
        CAP_INTERNAL_METHOD_NAME_RECORD.( current_recname ) := current_rec;
        
        CapInternalInstallAdd( current_rec );
        
    od;
    
    # for the sanity checks in AddDerivation, the record already has to be attached to CAP_INTERNAL_METHOD_NAME_RECORD at this point
    CAP_INTERNAL_INSTALL_WITH_GIVEN_DERIVATIONS( record );
    
end );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CAP_INTERNAL_METHOD_NAME_RECORD );
