# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
InstallValue( CAP_INTERNAL_FINAL_DERIVATION_LIST, [ ] );

BindGlobal( "CAP_INTERNAL_FINAL_DERIVATION_SANITY_CHECK",
  
  function( final_derivation )
    local method_name, filter_list, number_of_proposed_arguments, current_function_argument_number, derivation;
    
    if IsEmpty( final_derivation.derivations ) then
        
        Error( "trying to add a final derivation without any functions to install" );
        
    fi;
    
    if StartsWith( TargetOperation( final_derivation.derivations[1] ), "IsomorphismFrom" ) and Length( final_derivation.derivations ) = 1 then
        
        Print( "WARNING: You are installing a final derivation for ", TargetOperation( final_derivation.derivations[1] ), " which does not include its inverse. You should probably use a bundled final derivation to also install its inverse.\n" );
        
    fi;
    
    for derivation in final_derivation.derivations do
        
        if not TargetOperation( derivation ) in final_derivation.cannot_compute then
            
            Print( "WARNING: A final derivation for ", TargetOperation( final_derivation.derivations[1] ), " installs ", TargetOperation( derivation ), " but does not list it in its exclude list.\n" );
            
        fi;
        
        # see AddDerivation in Derivations.gi
        method_name := TargetOperation( derivation );
        
        if not IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(method_name) ) then
            
            Error( "trying to add a final derivation for a method not in CAP_INTERNAL_METHOD_NAME_RECORD" );
            
        fi;
        
        filter_list := CAP_INTERNAL_METHOD_NAME_RECORD!.(method_name).filter_list;
        
        number_of_proposed_arguments := Length( filter_list );
        
        current_function_argument_number := NumberArgumentsFunction( DerivationFunction( derivation ) );
        
        if current_function_argument_number >= 0 and current_function_argument_number <> number_of_proposed_arguments then
            Error( "While adding a final derivation for ", method_name, ": given function has ", String( current_function_argument_number ),
                   " arguments but should have ", String( number_of_proposed_arguments ) );
        fi;
        
    od;
    
end );

InstallGlobalFunction( AddFinalDerivation, FunctionWithNamedArguments(
  [
    # When compiling categories, a derivation does not cause overhead anymore, so we would like to simply set `Weight` to 0.
    # However, the weight 1 is currently needed to prevent the installation of cyclic derivations.
    [ "Weight", 1 ],
    [ "CategoryFilter", IsCapCategory ],
    [ "WeightLoopMultiple", 2 ],
    [ "CategoryGetters", Immutable( rec( ) ) ],
    [ "FunctionCalledBeforeInstallation", false ],
  ],
  function( CAP_NAMED_ARGUMENTS, target_op, description, can_compute, cannot_compute, func )
    
    AddFinalDerivationBundle(
        description, can_compute, cannot_compute, [ target_op, can_compute, func ] :
        Weight := CAP_NAMED_ARGUMENTS.Weight,
        CategoryFilter := CAP_NAMED_ARGUMENTS.CategoryFilter,
        WeightLoopMultiple := CAP_NAMED_ARGUMENTS.WeightLoopMultiple,
        CategoryGetters := CAP_NAMED_ARGUMENTS.CategoryGetters,
        FunctionCalledBeforeInstallation := CAP_NAMED_ARGUMENTS.FunctionCalledBeforeInstallation
    );
    
end ) );

InstallGlobalFunction( AddFinalDerivationBundle, FunctionWithNamedArguments(
  [
    # When compiling categories, a derivation does not cause overhead anymore, so we would like to simply set `Weight` to 0.
    # However, the weight 1 is currently needed to prevent the installation of cyclic derivations.
    [ "Weight", 1 ],
    [ "CategoryFilter", IsCapCategory ],
    [ "WeightLoopMultiple", 2 ],
    [ "CategoryGetters", Immutable( rec( ) ) ],
    [ "FunctionCalledBeforeInstallation", false ],
  ],
  function( CAP_NAMED_ARGUMENTS, description, can_compute, cannot_compute, additional_functions... )
    local weight, category_filter, loop_multiplier, category_getters, function_called_before_installation, operations_in_graph, operations_to_install, union_of_collected_lists, derivations, used_op_names_with_multiples_and_category_getters, collected_list, dummy_derivation, final_derivation, i, current_additional_func, x;
    
    if IsEmpty( additional_functions ) then
        
        Error( "trying to add a final derivation without any functions to install" );
        
    fi;
    
    weight := CAP_NAMED_ARGUMENTS.Weight;
    category_filter := CAP_NAMED_ARGUMENTS.CategoryFilter;
    loop_multiplier := CAP_NAMED_ARGUMENTS.WeightLoopMultiple;
    category_getters := CAP_NAMED_ARGUMENTS.CategoryGetters;
    function_called_before_installation := CAP_NAMED_ARGUMENTS.FunctionCalledBeforeInstallation;
    
    for i in [ 1 .. Length( additional_functions ) ] do
        
        if not (IsList( additional_functions[i] ) and Length( additional_functions[i] ) in [ 2, 3 ]) then
            
            Error( "additional functions must be given as pairs [ <operation>, <function> ] or triples [ <operation>, <function>, <preconditions> ]" );
            
        fi;
        
        if IsList( Last( additional_functions[i] ) ) then
            
            Error( "passing lists of functions to `AddFinalDerivation` is not supported anymore" );
            
        fi;
        
    od;
    
    operations_in_graph := Operations( CAP_INTERNAL_DERIVATION_GRAPH );
    
    ## Find symbols in functions
    operations_to_install := [ ];
    
    union_of_collected_lists := [ ];
    
    derivations := [ ];
    
    for current_additional_func in additional_functions do
        
        used_op_names_with_multiples_and_category_getters := fail;
        
        # see AddDerivation in Derivations.gi
        #= comment for Julia
        collected_list := CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION( Last( current_additional_func ), operations_in_graph, loop_multiplier, CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS, category_getters );
        
        if Length( current_additional_func ) = 2 then
            
            Print( "WARNING: a final derivation for ", NameFunction( current_additional_func[1] ), " has no explicit preconditions. Calling AddFinalDerivation(Bundle) without explicit preconditions is deprecated and will not be supported after 2024.03.31.\n" );
            
            current_additional_func := [ current_additional_func[1], collected_list, current_additional_func[2] ];
            
        fi;
        # =#
        
        Assert( 0, Length( current_additional_func ) = 3 );
        
        used_op_names_with_multiples_and_category_getters := [ ];
        
        for x in current_additional_func[2] do
            
            if Length( x ) < 2 or not IsFunction( x[1] ) or not IsInt( x[2] ) then
                
                Error( "preconditions must be of the form `[op, mult, getter]`, where `getter` is optional" );
                
            fi;
            
            if (Length( x ) = 2 or (Length( x ) = 3 and x[3] = fail)) and x[1] = current_additional_func[1] then
                
                Error( "A final derivation for ", NameFunction( current_additional_func[1] ), " has itself as a precondition. This is not supported because we cannot compute a well-defined weight.\n" );
                
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
        
        #= comment for Julia
        if Length( collected_list ) <> Length( used_op_names_with_multiples_and_category_getters ) or not ForAll( collected_list, c -> c in used_op_names_with_multiples_and_category_getters ) then
            
            SortBy( used_op_names_with_multiples_and_category_getters, x -> x[1] );
            SortBy( collected_list, x -> x[1] );
            
            Print(
                "WARNING: You have installed a final derivation for ", NameFunction( current_additional_func[1] ), " with preconditions ", used_op_names_with_multiples_and_category_getters,
                " but the automated detection has detected the following list of preconditions: ", collected_list, ".\n",
                "If this is a bug in the automated detection, please report it.\n"
            );
            
        fi;
        # =#
        
        Add( derivations, MakeDerivation(
            Concatenation( description, " (final derivation)" ),
            NameFunction( current_additional_func[1] ),
            used_op_names_with_multiples_and_category_getters,
            weight,
            current_additional_func[3],
            category_filter
        ) );
        
        # Operations may use operations from the same final derivation as long as the latter are installed before the former.
        # In this case, the used operations are no preconditions and thus should not go into union_of_collected_lists.
        used_op_names_with_multiples_and_category_getters := Filtered( used_op_names_with_multiples_and_category_getters, x -> not x[1] in operations_to_install );
        
        Add( operations_to_install, NameFunction( current_additional_func[1] ) );
        
        union_of_collected_lists := CAP_INTERNAL_MERGE_PRECONDITIONS_LIST( union_of_collected_lists, used_op_names_with_multiples_and_category_getters );
        
    od;
    
    # see AddDerivation in Derivations.gi
    used_op_names_with_multiples_and_category_getters := [ ];
    
    for x in can_compute do
        
        if Length( x ) < 2 or not IsFunction( x[1] ) or not IsInt( x[2] ) then
            
            Error( "preconditions must be of the form `[op, mult, getter]`, where `getter` is optional" );
            
        fi;
        
        # CAP_INTERNAL_FINAL_DERIVATION_SANITY_CHECK ensures that all installed operations appear in cannot_compute
        if (Length( x ) = 2 or (Length( x ) = 3 and x[3] = fail)) and x[1] in cannot_compute then
            
            Error( "A final derivation for ", TargetOperation( derivations[1] ), " has precondition ", x[1], " which is also in its exclude list.\n" );
            
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
            "WARNING: You have installed a final derivation for ", TargetOperation( derivations[1] ), " with preconditions ", used_op_names_with_multiples_and_category_getters,
            " but the following list of preconditions was expected: ", union_of_collected_lists, ".\n",
            "If this is a bug in the automated detection, please report it.\n"
        );
        
    fi;
    
    # only used to check if we can install all the derivations in `derivations`
    dummy_derivation := MakeDerivation(
        "dummy derivation",
        "internal dummy function of a final derivation",
        used_op_names_with_multiples_and_category_getters,
        1,
        ReturnTrue,
        category_filter
    );
    
    final_derivation := rec(
        dummy_derivation := dummy_derivation,
        cannot_compute := List( cannot_compute, x -> NameFunction( x ) ),
        derivations := derivations,
        function_called_before_installation := function_called_before_installation,
    );
    
    CAP_INTERNAL_FINAL_DERIVATION_SANITY_CHECK( final_derivation );
    
    Add( CAP_INTERNAL_FINAL_DERIVATION_LIST, final_derivation );
    
end ) );

InstallMethod( Finalize,
               [ IsCapCategory ],
 
 FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, category )
    local derivation_list, weight_list, current_install, current_final_derivation, weight, old_weights, categorical_properties, diff, properties_with_logic, property, i, derivation, operation, property_name;
    
    if IsFinalized( category ) then
        
        return true;
        
    fi;
    
    if not CAP_NAMED_ARGUMENTS.FinalizeCategory then
        
        return false;
        
    fi;
    
    # prepare for the checks below (usually this is done when the first add function is called, but we support the case that no add function is called at all)
    if not IsBound( category!.initially_known_categorical_properties ) then
        
        category!.initially_known_categorical_properties := ShallowCopy( ListKnownCategoricalProperties( category ) );
        
        InstallDerivationsUsingOperation( category!.derivations_weight_list, "none" );
        
    fi;
    
    # Warn about categories marked as being computable but not having an implementation of IsCongruentForMorphisms.
    # Since IsCongruentForMorphisms currently is derived from IsEqualForMorphisms, the latter also has to be taken into account.
    if category!.is_computable and not CanCompute( category, "IsEqualForMorphisms" ) and not CanCompute( category, "IsCongruentForMorphisms") then
        
        Print( "WARNING: The category with name \"", Name( category ), "\" is marked as being computable but has no implementation of `IsCongruentForMorphisms`.\n" );
        
    fi;
    
    #= comment for Julia
    if ValueOption( "disable_derivations" ) = true then
        
        derivation_list := [ ];
        
    else
        # =#
        
        derivation_list := ShallowCopy( CAP_INTERNAL_FINAL_DERIVATION_LIST );
        
        #= comment for Julia
    fi;
    # =#
    
    weight_list := category!.derivations_weight_list;
    
    while true do
        
        current_install := fail;
        
        for i in [ 1 .. Length( derivation_list ) ] do
            
            current_final_derivation := derivation_list[ i ];
            
            # check if all conditions for installing the final derivation are met
            
            if not IsApplicableToCategory( current_final_derivation.dummy_derivation, category ) then
                
                continue;
                
            fi;
            
            if ForAny( current_final_derivation.cannot_compute, operation_name -> CurrentOperationWeight( weight_list, operation_name ) < infinity ) then
                
                continue;
                
            fi;
            
            if OperationWeightUsingDerivation( weight_list, current_final_derivation.dummy_derivation ) = infinity then
                
                continue;
                
            fi;
            
            # if we get here, everything matched
            current_install := i;
            break;
            
        od;
        
        if current_install = fail then
            
            break;
            
        else
            
            current_final_derivation := Remove( derivation_list, current_install );
            
            ## call function before adding the method
            
            if current_final_derivation.function_called_before_installation <> false then
                
                current_final_derivation.function_called_before_installation( category );
                
            fi;
            
            for derivation in current_final_derivation.derivations do
                
                weight := OperationWeightUsingDerivation( weight_list, derivation );
                
                Assert( 0, weight <> infinity );
                
                # When installing a final derivation bundle, the installation of the first operations in the bundle
                # might trigger (normal) derivations of later operations it the bundle, which might be cheaper then
                # the derivations provided in the bundle.
                if weight <= CurrentOperationWeight( weight_list, TargetOperation( derivation ) ) then
                    
                    InstallDerivationForCategory( derivation, weight, category : IsFinalDerivation := true );
                    
                fi;
                
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
    
    # actually install normal derivations
    for operation in Operations( DerivationGraph( weight_list ) ) do
        
        if DerivationOfOperation( weight_list, operation ) <> fail then
            
            InstallDerivationForCategory( DerivationOfOperation( weight_list, operation ), CurrentOperationWeight( weight_list, operation ), category );
            
        fi;
        
    od;
    
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
    
    if not category!.is_computable and CanCompute( category, "IsCongruentForMorphisms" ) then
        
        Print( "WARNING: The category with name \"", Name( category ), "\" is marked as being not computable but has an implementation of `IsCongruentForMorphisms`.\n" );
        
    fi;
    
    return true;
    
end ) );
