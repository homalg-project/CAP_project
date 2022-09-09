# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
InstallValue( CAP_INTERNAL_FINAL_DERIVATION_LIST,
              rec( final_derivation_list := [ ] ) );

BindGlobal( "CAP_INTERNAL_FINAL_DERIVATION_SANITY_CHECK",
  
  function( derivation )
    local methods_to_check, method_name, filter_list, number_of_proposed_arguments, current_function_argument_number, method;
    
    if PositionSublist( String( derivation.category_filter ), "CanCompute" ) <> fail then
        
        Print( "WARNING: The CategoryFilter of a final derivation for ", NameFunction( derivation.target_op ), " uses `CanCompute`. Please register all preconditions explicitly.\n" );
        
    fi;
    
    if StartsWith( NameFunction( derivation.target_op ), "IsomorphismFrom" ) and IsEmpty( derivation.additional_functions ) then
        
        Print( "WARNING: You are installing a final derivation for ", derivation.target_op, " which does not include its inverse. You should probably use a bundled final derivation to also install its inverse.\n" );
        
    fi;
    
    methods_to_check := Concatenation( [ [ derivation.target_op, derivation.func ] ], derivation.additional_functions );
    
    for method in methods_to_check do
        
        if not method[1] in derivation.cannot_compute then
            
            Print( "WARNING: A final derivation for ", NameFunction( derivation.target_op ), " installs ", NameFunction( method[1] ), " but does not list it in its exclude list.\n" );
            
        fi;
        
        # see AddDerivation in Derivations.gi
        method_name := NameFunction( method[1] );
        
        if not IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(method_name) ) then
            
            Error( "trying to add a final derivation for a method not in CAP_INTERNAL_METHOD_NAME_RECORD" );
            
        fi;
        
        filter_list := CAP_INTERNAL_METHOD_NAME_RECORD!.(method_name).filter_list;
        
        number_of_proposed_arguments := Length( filter_list );
        
        current_function_argument_number := NumberArgumentsFunction( method[2] );
        
        if current_function_argument_number >= 0 and current_function_argument_number <> number_of_proposed_arguments then
            Error( "While adding a final derivation for ", method_name, ": given function has ", String( current_function_argument_number ),
                   " arguments but should have ", String( number_of_proposed_arguments ) );
        fi;
        
    od;
    
    if NumberArgumentsFunction( derivation.category_filter ) = 0 or NumberArgumentsFunction( derivation.category_filter ) > 1 then
        
        Error( "the CategoryFilter of a final derivation must accept exactly one argument" );
        
    fi;
    
end );


InstallGlobalFunction( AddFinalDerivation,
               
  function( target_op, can_compute, cannot_compute, func, additional_functions... )
    local final_derivation, loop_multiplier, category_getters, function_called_before_installation, operations_in_graph, operations_to_install, collected_list, union_of_collected_lists, used_op_names_with_multiples_and_category_getters, i, current_additional_func, x;
    
    if IsList( func ) then
        Error( "passing a list of functions to `AddFinalDerivation` is not supported anymore" );
    fi;

    final_derivation := rec( );
    
    final_derivation.weight := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Weight", 1 );
    final_derivation.description := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Description", "" );
    final_derivation.category_filter := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "CategoryFilter", IsCapCategory );
    loop_multiplier := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "WeightLoopMultiple", 2 );
    category_getters := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "CategoryGetters", rec( ) );
    function_called_before_installation := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "FunctionCalledBeforeInstallation", false );
    
    for i in [ 1 .. Length( additional_functions ) ] do
        if IsList( additional_functions[i][2] ) then
            Error( "passing lists of functions to `AddFinalDerivation` is not supported anymore" );
        fi;
    od;
    final_derivation.additional_functions := additional_functions;
    
    operations_in_graph := Operations( CAP_INTERNAL_DERIVATION_GRAPH );
    
    ## Find symbols in functions
    operations_to_install := [ ];
    
    collected_list := CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION( func, operations_in_graph, loop_multiplier, CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS, category_getters );
    final_derivation.used_ops_with_multiples := collected_list;
    
    Add( operations_to_install, NameFunction( target_op ) );
    
    union_of_collected_lists := collected_list;
    
    for current_additional_func in final_derivation.additional_functions do
        
        collected_list := CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION( current_additional_func[2], operations_in_graph, loop_multiplier, CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS, category_getters );
        
        current_additional_func[3] := collected_list;
        
        # Operations may use operations from the same final derivation as long as the latter are installed before the former.
        # In this case, the used operations are no preconditions and thus should not go into union_of_collected_lists.
        collected_list := Filtered( collected_list, x -> not x[1] in operations_to_install );
        
        Add( operations_to_install, NameFunction( current_additional_func[1] ) );
        
        union_of_collected_lists := CAP_INTERNAL_MERGE_PRECONDITIONS_LIST( union_of_collected_lists, collected_list );
        
    od;
    
    # see MakeDerivation in Derivations.gi
    used_op_names_with_multiples_and_category_getters := [ ];
    
    for x in can_compute do
        
        if Length( x ) < 2 or not IsFunction( x[1] ) or not IsInt( x[2] ) then
            
            Error( "preconditions must be of the form `[op, mult, getter]`, where `getter` is optional" );
            
        fi;
        
        # CAP_INTERNAL_FINAL_DERIVATION_SANITY_CHECK ensures that all installed operations appear in cannot_compute
        if (Length( x ) = 2 or (Length( x ) = 3 and x[3] = fail)) and x[1] in cannot_compute then
            
            Error( "A final derivation for ", NameFunction( target_op ), " has precondition ", x[1], " which is also in its exclude list.\n" );
            
        fi;
        
        if Length( x ) = 2 then
            
            Add( used_op_names_with_multiples_and_category_getters, [ NameFunction( x[1] ), x[2], fail ] );
            
        elif Length( x ) = 3 then
            
            if x <> fail and not (IsFunction( x[3] ) and NumberArgumentsFunction( x[3] ) = 1) then
                
                Error( "the category getter must be a single-argument function" );
                
            fi;
            
            Add( used_op_names_with_multiples_and_category_getters, [ NameFunction( x[1] ), x[2], x[3] ] );
            
        else
            
            Error( "The list of preconditions must be a list of pairs or triples." );
            
        fi;
        
    od;
    
    if Length( union_of_collected_lists ) <> Length( used_op_names_with_multiples_and_category_getters ) or not ForAll( union_of_collected_lists, c -> c in used_op_names_with_multiples_and_category_getters ) then
        
        SortBy( used_op_names_with_multiples_and_category_getters, x -> x[1] );
        SortBy( union_of_collected_lists, x -> x[1] );
        
        Print(
            "WARNING: You have installed a final derivation for ", NameFunction( target_op ), " with preconditions ", used_op_names_with_multiples_and_category_getters,
            " but the automated detection has detected the following list of preconditions: ", union_of_collected_lists, ".\n",
            "If this is a bug in the automated detection, please report it. If the preconditions cannot be detected automatically, use the option `ConditionsListComplete := true`.\n"
        );
        
    fi;
    
    final_derivation.target_op := target_op;
    final_derivation.can_compute := used_op_names_with_multiples_and_category_getters;
    final_derivation.cannot_compute := cannot_compute;
    final_derivation.func := func;
    final_derivation.function_called_before_installation := function_called_before_installation;
    
    CAP_INTERNAL_FINAL_DERIVATION_SANITY_CHECK( final_derivation );
    
    Add( CAP_INTERNAL_FINAL_DERIVATION_LIST.final_derivation_list, final_derivation );
    
end );

InstallMethod( Finalize,
               [ IsCapCategory ],
  
  function( category )
    local derivation_list, weight_list, current_install, current_final_derivation, filter, category_operation_weights, weight, operation_weights, operation_name, operation_weight, add_name, old_weights, categorical_properties, diff, properties_with_logic, property, i, x, current_additional_func, property_name;
    
    if IsFinalized( category ) then
        
        return true;
        
    fi;
    
    if ValueOption( "FinalizeCategory" ) = false then
        
        return false;
        
    fi;
    
    # prepare for the checks below (usually this is done when the first add function is called, but we support the case that no add function is called at all)
    if not IsBound( category!.initially_known_categorical_properties ) then
        
        category!.initially_known_categorical_properties := ShallowCopy( ListKnownCategoricalProperties( category ) );
        
        InstallDerivationsUsingOperation( category!.derivations_weight_list, "none" );
        
    fi;
    
    derivation_list := ShallowCopy( CAP_INTERNAL_FINAL_DERIVATION_LIST.final_derivation_list );
    
    if not category!.is_computable then
        
        derivation_list := Filtered( derivation_list, der -> not NameFunction( der!.target_op ) = "IsCongruentForMorphisms" );
        
    fi;
    
    weight_list := category!.derivations_weight_list;
    
    while true do
        
        current_install := fail;
        
        for i in [ 1 .. Length( derivation_list ) ] do
            
            current_final_derivation := derivation_list[ i ];
            
            # check the category filter
            # see IsApplicableToCategory in Derivations.gi
            filter := current_final_derivation.category_filter;
            
            if IsFilter( filter ) then
                
                if not(Tester( filter )( category ) and filter( category )) then
                    
                    continue;
                    
                fi;
                
            elif IsFunction( filter ) then
                
                if not filter( category ) then
                    
                    continue;
                    
                fi;
                
            else
                
                Error( "Category filter is not a filter or function" );
                
            fi;
            
            # check the exclude list
            if ForAny( current_final_derivation.cannot_compute, j -> CurrentOperationWeight( weight_list, NameFunction( j ) ) < infinity ) then
                
                continue;
                
            fi;
            
            # check the preconditions
            # see OperationWeightUsingDerivation in Derivations.gi
            category_operation_weights := weight_list!.operation_weights;
            
            weight := current_final_derivation.weight;
            
            for x in current_final_derivation.can_compute do
                
                if x[3] = fail then
                    
                    operation_weights := category_operation_weights;
                    
                else
                    
                    operation_weights := x[3](category)!.derivations_weight_list!.operation_weights;
                    
                fi;
                
                operation_name := x[1];
                
                if not IsBound( operation_weights.(operation_name) ) then
                    
                    weight := infinity;
                    break;
                    
                fi;
                
                operation_weight := operation_weights.(operation_name);
                
                if operation_weight = infinity then
                    
                    weight := infinity;
                    break;
                    
                fi;
                
                weight := weight + operation_weight * x[2];
                
            od;
            
            if weight = infinity then
                
                continue;
                
            fi;
            
            # if we get here, everything matched
            current_install := i;
            break;
            
        od;
        
        if current_install = fail then
            
            break;
            
        else
            
            current_final_derivation := Remove( derivation_list, i );
            
            weight := current_final_derivation.weight;
            
            for x in current_final_derivation.used_ops_with_multiples do
                
                if x[3] = fail then
                    
                    operation_weights := category_operation_weights;
                    
                else
                    
                    operation_weights := x[3](category)!.derivations_weight_list!.operation_weights;
                    
                fi;
                
                operation_name := x[1];
                
                if not IsBound( operation_weights.(operation_name) ) then
                    
                    weight := infinity;
                    break;
                    
                fi;
                
                operation_weight := operation_weights.(operation_name);
                
                if operation_weight = infinity then
                    
                    weight := infinity;
                    break;
                    
                fi;
                
                weight := weight + operation_weight * x[2];
                
            od;
            
            Assert( 0, weight <> infinity );
            
            Info( DerivationInfo, 1, Concatenation( "install(",
                                          String( weight ),
                                          ") ",
                                          NameFunction( current_final_derivation.target_op ),
                                          ": ",
                                          current_final_derivation.description, " (final derivation)\n" ) );
            
            ## call function before adding the method
            
            if current_final_derivation.function_called_before_installation <> false then
                
                current_final_derivation.function_called_before_installation( category );
                
            fi;
            
            ## Add method
            add_name := ValueGlobal( Concatenation( [ "Add", NameFunction( current_final_derivation.target_op ) ] ) );
            
            # use the add method with signature IsCapCategory, IsList, IsInt to avoid
            # the convenience for AddZeroObject etc.
            add_name( category, [ Pair( current_final_derivation.func, [ ] ) ], weight : IsFinalDerivation := true );

            for current_additional_func in current_final_derivation.additional_functions do
                
                weight := current_final_derivation.weight;
                
                for x in current_additional_func[3] do
                    
                    if x[3] = fail then
                        
                        operation_weights := category_operation_weights;
                        
                    else
                        
                        operation_weights := x[3](category)!.derivations_weight_list!.operation_weights;
                        
                    fi;
                    
                    operation_name := x[1];
                    
                    if not IsBound( operation_weights.(operation_name) ) then
                        
                        weight := infinity;
                        break;
                        
                    fi;
                    
                    operation_weight := operation_weights.(operation_name);
                    
                    if operation_weight = infinity then
                        
                        weight := infinity;
                        break;
                        
                    fi;
                    
                    weight := weight + operation_weight * x[2];
                    
                od;
                
                Assert( 0, weight <> infinity );
                
                Info( DerivationInfo, 1, Concatenation( "install(",
                                              String( weight ),
                                              ") ",
                                              NameFunction( current_additional_func[ 1 ] ),
                                              ": ",
                                              current_final_derivation.description, "\n" ) );
                
                add_name := ValueGlobal( Concatenation( [ "Add", NameFunction( current_additional_func[ 1 ] ) ] ) );
                
                
                # use the add method with signature IsCapCategory, IsList, IsInt to avoid
                # the convenience for AddZeroObject etc.
                add_name( category, [ Pair( current_additional_func[2], [ ] ) ], weight : IsFinalDerivation := true );
                
            od;
            
        fi;
        
    od;
    
    if category!.overhead then
        
        # Check if reevaluation triggers new derivations. Derivations are installed recursively by `InstallDerivationsUsingOperation`, so this should never happen.
        # See the WARNING below for possible causes why it still might happen.
        old_weights := StructuralCopy( weight_list!.operation_weights );
        
        Info( DerivationInfo, 1, "Starting reevaluation of derivation weight list of the category name \"", Name( category ), "\"\n" );
        
        Reevaluate( weight_list );
        
        Info( DerivationInfo, 1, "Finished reevaluation of derivation weight list of the category name \"", Name( category ), "\"\n" );
        
        categorical_properties := ListKnownCategoricalProperties( category );
        
        if not IsSubset( categorical_properties, category!.initially_known_categorical_properties ) then
            
            Print( "WARNING: The category named \"", Name( category ), "\" has lost the following categorical properties since installation of the first function:\n" );
            Display( Difference( category!.initially_known_categorical_properties, categorical_properties ) );
            
        fi;
        
        if weight_list!.operation_weights <> old_weights then
            
            Print( "WARNING: The installed derivations of the category named \"", Name( category ), "\" have changed by reevaluation, which is not expected at this point.\n" );
            Print( "This might be due to one of the following reasons:\n" );
            Print( "* The category might have gained a new setting like `supports_empty_limits` since adding the first function. Such settings should always be set before adding functions.\n" );
            Print( "* The category filter of some derivation might not fulfill the specification.\n" );
            
            diff := Difference( categorical_properties, category!.initially_known_categorical_properties );
            
            if not IsEmpty( diff ) then
                
                Print( "* The category has gained the following new categorical properties since adding the first function: ", diff, ". Properties should always be set before adding functions for operations which might trigger derivations involving the properties.\n" );
                
            fi;
            
            Print( "For debugging, call `ActivateDerivationInfo( )`, retry, and look at the derivations between \"Starting reevaluation of ...\" and \"Finished reevaluation of ...\".\n" );
            
        fi;
        
    fi;
    
    SetIsFinalized( category, true );
    
    if category!.overhead then
        
        properties_with_logic := RecNames( category!.logical_implication_files.Propositions );
        
        # INSTALL_LOGICAL_IMPLICATIONS_HELPER indirectly calls `InstallTrueMethod` many times -> suspend method reordering
        SuspendMethodReordering( );
        
        for property_name in properties_with_logic do
            
            property := ValueGlobal( property_name );
            
            if Tester( property )( category ) and property( category ) then
                
                INSTALL_LOGICAL_IMPLICATIONS_HELPER( category, property_name );
                
            fi;
            
        od;
        
        ResumeMethodReordering( );
        
    fi;
    
    return true;
    
end );
