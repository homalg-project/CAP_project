# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

##
InstallMethod( CategoryConstructor,
               [ IsRecord ],
               
  function( options )
    local known_options_with_filters, name, object_datum_type, morphism_datum_type, is_computable, filter, CC, underlying_category, default_func_strings, info, unknown_filters, create_func_name, create_func, func_string, weight, func_string_and_weight, underlying_arguments, add, func, option_name, prop;
    
    ## check given options
    known_options_with_filters := rec(
        name := IsString,
        category_filter := IsFilter,
        category_object_filter := IsFilter,
        category_morphism_filter := IsFilter,
        object_datum_type := IsObject, # IsFilter or IsRecord
        morphism_datum_type := IsObject, # IsFilter or IsRecord
        commutative_ring_of_linear_category := R -> IsRing( R ) and HasIsCommutative( R ) and IsCommutative( R ),
        range_category_of_homomorphism_structure := cat -> IsCapCategory( cat ) or cat = "self",
        properties := IsList,
        object_constructor := IsFunction,
        object_datum := IsFunction,
        morphism_constructor := IsFunction,
        morphism_datum := IsFunction,
        list_of_operations_to_install := IsList,
        is_computable := IsBool,
        supports_empty_limits := IsBool,
        underlying_category_getter_string := IsString,
        underlying_category := IsCapCategory,
        underlying_object_getter_string := IsString,
        underlying_morphism_getter_string := IsString,
        top_object_getter_string := IsString,
        top_morphism_getter_string := IsString,
        generic_output_source_getter_string := IsString,
        generic_output_range_getter_string := IsString,
        create_func_bool := IsObject,
        create_func_object := IsObject,
        create_func_morphism := IsObject,
        create_func_list_of_objects := IsObject,
    );
    
    for option_name in RecNames( options ) do
        
        if IsBound( known_options_with_filters.(option_name) ) then
            
            filter := known_options_with_filters.(option_name);
            
            if not filter( options.(option_name) ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "The value of the option `", option_name, "` must lie in the filter ", filter );
                
            fi;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "The following option is not known to `CategoryConstructor`: ", option_name );
            
        fi;
        
    od;
    
    ## create category
    if IsBound( options.name ) then
        
        name := options.name;
        
    else
        
        name := Concatenation( "AutomaticCapCategory", String( CAP_INTERNAL_NAME_COUNTER( ) ) );
        
    fi;
    
    if IsBound( options.object_datum_type ) then
        
        object_datum_type := options.object_datum_type;
        
    else
        
        object_datum_type := fail;
        
    fi;
    
    if IsBound( options.morphism_datum_type ) then
        
        morphism_datum_type := options.morphism_datum_type;
        
    else
        
        morphism_datum_type := fail;
        
    fi;
    
    if IsBound( options.is_computable ) then
        
        is_computable := options.is_computable;
        
    else
        
        # use default value in CreateCapCategory
        is_computable := fail;
        
    fi;
    
    CC := CreateCapCategoryWithDataTypes(
        name, options.category_filter,
        options.category_object_filter, options.category_morphism_filter, IsCapCategoryTwoCell,
        object_datum_type, morphism_datum_type, fail
        : is_computable := is_computable
    );
    
    if IsBound( options.supports_empty_limits ) then
        
        CC!.supports_empty_limits := options.supports_empty_limits;
        
    fi;
    
    CC!.compiler_hints := rec( );
    
    if IsBound( options.commutative_ring_of_linear_category ) then
        
        SetCommutativeRingOfLinearCategory( CC, options.commutative_ring_of_linear_category );
        
    fi;
    
    if IsBound( options.range_category_of_homomorphism_structure ) then
        
        if options.range_category_of_homomorphism_structure = "self" then
            SetRangeCategoryOfHomomorphismStructure( CC, CC );
        else
            SetRangeCategoryOfHomomorphismStructure( CC, options.range_category_of_homomorphism_structure );
        fi;
        
    fi;
    
    ## set categorical properties
    if IsBound( options.properties ) then
        
        if not IsSubset( Set( Filtered( Concatenation( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST ), x -> x <> fail ) ), options.properties ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "The value of the option `properties` must be a list of categorical properties, see CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST." );
            
        fi;
        
        for prop in options.properties do
            
            Setter( ValueGlobal( prop ) )( CC, true );
            
        od;
        
    fi;
    
    ## add constructors and data
    if IsBound( options.object_constructor ) then
        
        AddObjectConstructor( CC, options.object_constructor );
        
    fi;
    
    if IsBound( options.object_datum ) then
        
        AddObjectDatum( CC, options.object_datum );
        
    fi;
    
    if IsBound( options.morphism_constructor ) then
        
        AddMorphismConstructor( CC, options.morphism_constructor );
        
    fi;
    
    if IsBound( options.morphism_datum ) then
        
        AddMorphismDatum( CC, options.morphism_datum );
        
    fi;
    
    ## install operations
    if not IsBound( options.list_of_operations_to_install ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "Missing mandatory option `list_of_operations_to_install`." );
        
    elif not ForAll( options.list_of_operations_to_install, name -> IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(name) ) ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "The value of the option `list_of_operations_to_install` must be a list of names of CAP operations." );
        
    fi;
    
    # plausibility check
    if not "IsEqualForMorphisms" in options.list_of_operations_to_install then
        
        if "IsEqualToIdentityMorphism" in options.list_of_operations_to_install then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Display( "WARNING: You want to lift `IsEqualToIdentityMorphism` but not `IsEqualForMorphisms` in CategoryConstructor. Since the specification of the former depends on the latter, this is probably an error." );
            
        fi;
        
        if "IsEqualToZeroMorphism" in options.list_of_operations_to_install then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Display( "WARNING: You want to lift `IsEqualToZeroMorphism` but not `IsEqualForMorphisms` in CategoryConstructor. Since the specification of the former depends on the latter, this is probably an error." );
            
        fi;
        
    fi;
    
    default_func_strings := rec(
        bool := """
            function( input_arguments... )
                
                return operation_name( underlying_arguments... );
                
            end
        """,
        object := """
            function( input_arguments... )
              local underlying_result;
                
                underlying_result := operation_name( underlying_arguments... );
                
                return top_object_getter( cat, underlying_result );
                
            end
        """,
        morphism := """
            function( input_arguments... )
              local underlying_result;
                
                underlying_result := operation_name( underlying_arguments... );
                
                return top_morphism_getter( cat, top_source, underlying_result, top_range );
                
            end
        """,
        list_of_objects := """
            function( input_arguments... )
              local underlying_result;
              
              underlying_result := operation_name( underlying_arguments... );
              
              return List( underlying_result, object -> top_object_getter( cat, object ) );
              
            end
        """,
    );
    
    Info( InfoCategoryConstructor, 2,  "Lifting the following operations for ", Name( CC ), ":\n" );
    
    for name in options.list_of_operations_to_install do
        
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(name);
        
        # check if filters and return_type are known
        unknown_filters := Filtered( info.filter_list, filter -> not filter in [ "category", "object", "morphism", "integer", "element_of_commutative_ring_of_linear_structure", "list_of_elements_of_commutative_ring_of_linear_structure", "nonneg_integer_or_infinity", "list_of_objects", "list_of_morphisms", "list_of_lists_of_morphisms", "pair_of_morphisms", "list_of_integers_and_list_of_morphisms" ] );
        
        if not IsEmpty( unknown_filters ) then
            
            Info( InfoCategoryConstructor, 3, "cannot yet handle the following filters required for ", name, ": ", unknown_filters );
            continue;
            
        fi;
        
        if not IsBound( default_func_strings.(info.return_type) ) then
            
            Info( InfoCategoryConstructor, 3, "cannot yet handle return_type=\"", info.return_type, "\" required for ", name );
            continue;
            
        fi;
        
        create_func_name := Concatenation( "create_func_", info.return_type );
        
        # check if we have a suitable create_func_*
        if not IsBound( options.(create_func_name) ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "Missing mandatory option `", create_func_name, "`." );
            
        fi;
        
        create_func := options.(create_func_name);
        
        if create_func = "default" then
            
            if not IsBound( options.underlying_category ) then
                
                Error( "when using \"default\" for some `create_func_*`, the option `underlying_category` must be set" );
                
            fi;
            
            func_string := default_func_strings.(info.return_type);
            
            # the default strings simply apply the operation in the underlying category
            weight := OperationWeight( options.underlying_category, info.function_name );
            
        elif IsFunction( create_func ) then
            
            func_string_and_weight := create_func( name, CC );
            
            if IsList( func_string_and_weight ) and Length( func_string_and_weight ) = 2 and IsInt( func_string_and_weight[2] ) then
                
                func_string := func_string_and_weight[1];
                weight := func_string_and_weight[2];
                
            else
                
                func_string := func_string_and_weight;
                weight := -1;
                
            fi;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( create_func_name, " must be a function or the string \"default\"" );
            
        fi;
        
        if not IsString( func_string ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "the value returned by ", create_func_name, " must be a string" );
            
        fi;
        
        func_string := ReplacedStringViaRecord( func_string, rec(
            operation_name := name,
            input_arguments := info.input_arguments_names,
            number_of_arguments := String( Length( info.input_arguments_names ) ),
        ) );
        
        if PositionSublist( func_string, "underlying_arguments" ) <> fail then
            
            if not IsBound( options.underlying_category_getter_string ) or not IsBound( options.underlying_object_getter_string ) or not IsBound( options.underlying_morphism_getter_string ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "for generating underlying_arguments you must pass category, object and morphism getter strings" );
                
            fi;
            
            underlying_arguments := List( [ 1 .. Length( info.filter_list ) ], function( i )
              local filter, argument_name;
                
                filter := info.filter_list[i];
                argument_name := info.input_arguments_names[i];
                
                if filter = "category" then
                    
                    return Concatenation( options.underlying_category_getter_string, "( ", argument_name, " )" );
                    
                elif filter = "object" then
                    
                    return Concatenation( options.underlying_object_getter_string, "( cat, ", argument_name, " )" );
                    
                elif filter = "morphism" then
                    
                    return Concatenation( options.underlying_morphism_getter_string, "( cat, ", argument_name, " )" );
                    
                elif filter = "integer" or filter = "element_of_commutative_ring_of_linear_structure" or filter = "list_of_elements_of_commutative_ring_of_linear_structure" or filter = "nonneg_integer_or_infinity" then
                    
                    return argument_name;
                    
                elif filter = "list_of_objects" then
                    
                    return Concatenation( "List( ", argument_name, ", x -> ", options.underlying_object_getter_string, "( cat, x ) )" );
                    
                elif filter = "list_of_morphisms" then
                    
                    return Concatenation( "List( ", argument_name, ", x -> ", options.underlying_morphism_getter_string, "( cat, x ) )" );
                    
                elif filter = "list_of_lists_of_morphisms" then
                    
                    return Concatenation( "List( ", argument_name, ", x -> List( x, y -> ", options.underlying_morphism_getter_string, "( cat, y ) ) )" );
                    
                elif filter = "pair_of_morphisms" then
                    
                    return Concatenation( "Pair( ", options.underlying_morphism_getter_string, "( cat, ", argument_name, "[1] ), ", options.underlying_morphism_getter_string, "( cat, ", argument_name, "[2] ) )" );
                    
                elif filter = "list_of_integers_and_list_of_morphisms" then
                    
                    return Concatenation( "Pair( ", argument_name, "[1], List( ", argument_name, "[2], x -> ", options.underlying_morphism_getter_string, "( cat, x ) ) )" );
                    
                else
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "this should never happen" );
                    
                fi;
                
            end );
            
            func_string := ReplacedStringViaRecord( func_string, rec(
                underlying_arguments := underlying_arguments,
            ) );
            
        fi;
        
        if PositionSublist( info.return_type, "object" ) <> fail then
            
            if PositionSublist( func_string, "top_object_getter" ) <> fail then
            
                if IsBound( options.top_object_getter_string ) then
                    
                    func_string := ReplacedStringViaRecord( func_string, rec(
                        top_object_getter := options.top_object_getter_string,
                    ) );
                    
                else
                    
                    Error( "option `top_object_getter_string` must be set in a call to `CategoryConstructor`" );
                    
                fi;
                
            fi;
            
        fi;
        
        if StartsWith( info.return_type, "morphism" ) then
            
            if IsBound( info.output_source_getter_string ) and IsBound( info.can_always_compute_output_source_getter ) and info.can_always_compute_output_source_getter then
                
                func_string := ReplacedStringViaRecord( func_string, rec(
                    top_source := info.output_source_getter_string,
                ) );
                
            elif IsBound( options.generic_output_source_getter_string ) then
                
                func_string := ReplacedStringViaRecord( func_string, rec(
                    top_source := options.generic_output_source_getter_string,
                ) );
                
            elif IsBound( info.output_source_getter_string ) and
              ## the last resort used by SyntacticCategory,
              ## ensure that the operation to compute the source is at least marked for installation:
              IsBound( info.output_source_getter_preconditions ) and
              ForAll( info.output_source_getter_preconditions, pair -> IsList( pair ) and Length( pair ) = 2 ) and
              ForAll( info.output_source_getter_preconditions, pair -> pair[1] in options.list_of_operations_to_install ) then
                
                func_string := ReplacedStringViaRecord( func_string, rec(
                    top_source := info.output_source_getter_string,
                ) );
                
            fi;
            
            if IsBound( info.output_range_getter_string ) and IsBound( info.can_always_compute_output_range_getter ) and info.can_always_compute_output_range_getter then
                
                func_string := ReplacedStringViaRecord( func_string, rec(
                    top_range := info.output_range_getter_string,
                ) );
                
            elif IsBound( options.generic_output_range_getter_string ) then
                
                func_string := ReplacedStringViaRecord( func_string, rec(
                    top_range := options.generic_output_range_getter_string,
                ) );
                
            elif IsBound( info.output_range_getter_string ) and
              ## the last resort used by SyntacticCategory,
              ## ensure that the operation to compute the target is at least marked for installation:
              IsBound( info.output_range_getter_preconditions ) and
              ForAll( info.output_range_getter_preconditions, pair -> IsList( pair ) and Length( pair ) = 2 ) and
              ForAll( info.output_range_getter_preconditions, pair -> pair[1] in options.list_of_operations_to_install ) then
                
                func_string := ReplacedStringViaRecord( func_string, rec(
                    top_range := info.output_range_getter_string,
                ) );
                
            fi;
            
            # if source and range cannot be computed we cannot do anything
            if PositionSublist( func_string, "top_source" ) <> fail or PositionSublist( func_string, "top_range" ) <> fail then
                
                Info( InfoCategoryConstructor, 3, "cannot compute source and/or range of ", name );
                continue;
                
            fi;
            
            if PositionSublist( func_string, "top_morphism_getter" ) <> fail then
            
                if IsBound( options.top_morphism_getter_string ) then
                    
                    func_string := ReplacedStringViaRecord( func_string, rec(
                        top_morphism_getter := options.top_morphism_getter_string,
                    ) );
                    
                else
                    
                    Error( "option `top_morphism_getter_string` must be set in a call to `CategoryConstructor`" );
                    
                fi;
                
            fi;
            
        fi;
        
        Info( InfoCategoryConstructor, 2, name );
        
        add := ValueGlobal( Concatenation( "Add", name ) );
        
        func := EvalString( func_string );
        
        if weight <> -1 then
            
            add( CC, func, weight );
            
        else
            
            add( CC, func );
            
        fi;
        
    od;
    
    Info( InfoCategoryConstructor, 2, "" );
    
    return CC;
    
end );
