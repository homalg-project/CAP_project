# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
#! @Chapter Opposite category

###################################
##
#! @Section Functor is an involution
##
###################################


##################################
##
## Constructor
##
##################################

##
InstallMethod( Opposite,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return Opposite( Opposite( CapCategory( object ) ), object );
    
end );

##
InstallOtherMethod( Opposite,
                    [ IsCapCategory, IsCapCategoryObject ],
                    
  function( opposite_cat, object )
    
    return ObjectConstructor( opposite_cat, object );
    
end );

##
InstallMethod( Opposite,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return Opposite( Opposite( CapCategory( morphism ) ), morphism );
    
end );

##
InstallOtherMethod( Opposite,
                    [ IsCapCategory, IsCapCategoryMorphism ],
                    
  function( opposite_cat, morphism )
    local source, range;
    
    source := ObjectConstructor( opposite_cat, Range( morphism ) );
    
    range := ObjectConstructor( opposite_cat, Source( morphism ) );
    
    return MorphismConstructor( opposite_cat, source, morphism, range );
    
end );

InstallGlobalFunction( CAP_INTERNAL_OPPOSITE_RECURSIVE,
  
  function( obj )
    
    if IsCapCategory( obj ) then
        return OppositeCategory( obj );
    elif IsCapCategoryObject( obj ) then
        return ObjectDatum( CapCategory( obj ), obj );
    elif IsCapCategoryMorphism( obj ) then
        return MorphismDatum( CapCategory( obj ), obj );
    elif IsList( obj ) then
        return List( obj, CAP_INTERNAL_OPPOSITE_RECURSIVE );
    else
        return obj;
    fi;
    
end );

BindGlobal( "CAP_INTERNAL_INSTALL_OPPOSITE_ADDS_FROM_CATEGORY",
  
  function( opposite_category, category, only_primitive_operations, only_primitive_operations_and_hom_structure )
    local recnames, list_of_underlying_operations, operations_of_homomorphism_structure,
          installed_operations_of_homomorphism_structure_and_external_hom, H,
          current_recname, current_entry, dual_operation_name, filter_list, input_arguments_names, return_type, func_string,
          preprocessor_string, dual_arguments, tmp,
          postprocessor_string, output_source_getter_string, output_range_getter_string, return_statement,
          func, weight, list_of_attributes, attr, tester, setter;
    
    ## Take care of attributes
    ## TODO: if there are more instances, set markers in the MethodRecord
    list_of_attributes := [ CommutativeRingOfLinearCategory ];
    
    for attr in list_of_attributes do
        
        tester := Tester( attr );
        
        if not tester( opposite_category ) and tester( category ) then
            
            setter := Setter( attr );
            
            setter( opposite_category, attr( category ) );
            
        fi;
        
    od;
    
    recnames := AsSortedList( RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) );
    
    ## No support for twocells
    recnames := Difference( recnames,
                        [ "HorizontalPreCompose",
                          "HorizontalPostCompose",
                          "VerticalPreCompose",
                          "VerticalPostCompose",
                          "IdenticalTwoCell" ] );
    
    if only_primitive_operations or only_primitive_operations_and_hom_structure then
        list_of_underlying_operations := ListPrimitivelyInstalledOperationsOfCategory( category );
    else
        list_of_underlying_operations := ListInstalledOperationsOfCategory( category );
    fi;
    
    operations_of_homomorphism_structure :=
      [ "DistinguishedObjectOfHomomorphismStructure",
        "HomomorphismStructureOnObjects",
        "HomomorphismStructureOnMorphisms",
        "HomomorphismStructureOnMorphismsWithGivenObjects",
        "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
        "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects",
        "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
        ];
    
    if not IsEmpty( Intersection( list_of_underlying_operations, operations_of_homomorphism_structure ) ) then
        
        SetRangeCategoryOfHomomorphismStructure( opposite_category, RangeCategoryOfHomomorphismStructure( category ) );
        
    fi;
    
    if only_primitive_operations_and_hom_structure then
        
        installed_operations_of_homomorphism_structure_and_external_hom :=
          Intersection( ListInstalledOperationsOfCategory( category ),
                  [ "DistinguishedObjectOfHomomorphismStructure",
                    "HomomorphismStructureOnObjects",
                    "HomomorphismStructureOnMorphisms",
                    "HomomorphismStructureOnMorphismsWithGivenObjects",
                    "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
                    "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects",
                    "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
                    "MorphismsOfExternalHom",
                    "BasisOfExternalHom",
                    "CoefficientsOfMorphism",
                    ] );
        
        ## the opposite category has the same enrichment as the original category:
        if HasRangeCategoryOfHomomorphismStructure( category ) then
            
            H := RangeCategoryOfHomomorphismStructure( category );
            
            SetRangeCategoryOfHomomorphismStructure( opposite_category, H );
            
            ## be sure the above assignment succeeded:
            Assert( 0, IsIdenticalObj( H, RangeCategoryOfHomomorphismStructure( opposite_category ) ) );
            
            list_of_underlying_operations := Concatenation( list_of_underlying_operations, installed_operations_of_homomorphism_structure_and_external_hom );
            
            list_of_underlying_operations := Set( list_of_underlying_operations );
            
        fi;
        
    fi;
    
    for current_recname in recnames do
        
        current_entry := CAP_INTERNAL_METHOD_NAME_RECORD.( current_recname );
        
        ## Conservative
        if not IsBound( current_entry.dual_operation ) then
            continue;
        fi;
        
        dual_operation_name := current_entry.dual_operation;
        
        if not dual_operation_name in list_of_underlying_operations then
            continue;
        fi;
        
        filter_list := current_entry.filter_list;
        input_arguments_names := current_entry.input_arguments_names;
        return_type := current_entry.return_type;
        
        func_string :=
            """
            function ( input_arguments... )
              local dual_preprocessor_func, prep_arg, result, dual_postprocessor_func;
                
                preprocessor_string
                
                result := dual_operation_name( dual_arguments... );
                
                postprocessor_string
                
                return_statement
                
            end
            """;
        
        if IsBound( current_entry.dual_preprocessor_func_string ) then
            
            preprocessor_string := ReplacedStringViaRecord(
                """
                dual_preprocessor_func := dual_preprocessor_func_string;
                prep_arg := dual_preprocessor_func( input_arguments... );
                #% CAP_JIT_DROP_NEXT_STATEMENT
                Assert( 0, IsIdenticalObj( prep_arg[1], OppositeCategory( cat ) ) );
                """,
                rec(
                    dual_preprocessor_func_string := current_entry.dual_preprocessor_func_string,
                    input_arguments := input_arguments_names,
                )
            );
            
            Assert( 0, filter_list[1] = "category" );
            
            dual_arguments := List( [ 2 .. Length( filter_list ) ], i -> Concatenation( "prep_arg[", String( i ), "]" ) );
            
        else
            
            preprocessor_string := "";
            
            Assert( 0, filter_list[1] = "category" );
            
            dual_arguments := List( [ 2 .. Length( filter_list ) ], function( i )
              local filter, argument_name;
                
                filter := filter_list[i];
                argument_name := input_arguments_names[i];
                
                if filter = "object" then
                    
                    return Concatenation( "ObjectDatum( cat, ", argument_name, " )" );
                    
                elif filter = "morphism" then
                    
                    return Concatenation( "MorphismDatum( cat, ", argument_name, " )" );
                    
                elif filter in [ "integer", "element_of_commutative_ring_of_linear_structure", "nonneg_integer_or_infinity", "list_of_elements_of_commutative_ring_of_linear_structure" ] then
                    
                    return argument_name;
                    
                elif filter = "list_of_objects" then
                    
                    return Concatenation( "List( ", argument_name, ", x -> ObjectDatum( cat, x ) )" );
                    
                elif filter = "list_of_morphisms" then
                    
                    return Concatenation( "List( ", argument_name, ", x -> MorphismDatum( cat, x ) )" );
                    
                elif filter = "list_of_integers_and_list_of_morphisms" then
                    
                    return Concatenation( "Pair( ", argument_name, "[1], List( ", argument_name, "[2], x -> MorphismDatum( cat, x ) ) )" );
                    
                else
                    
                    Error( "this case is not handled yet" );
                    
                fi;
                
            end );
            
            if current_entry.dual_arguments_reversed then
                
                dual_arguments := Reversed( dual_arguments );
                
            fi;
            
            if current_entry.is_with_given and IsBound( current_entry.dual_with_given_objects_reversed ) and current_entry.dual_with_given_objects_reversed then
                
                tmp := dual_arguments[1];
                dual_arguments[1] := dual_arguments[Length( dual_arguments)];
                dual_arguments[Length( dual_arguments)] := tmp;
                
            fi;
            
        fi;
        
        dual_arguments := Concatenation( [ "OppositeCategory( cat )" ], dual_arguments );
        
        if IsBound( current_entry.dual_postprocessor_func_string ) then
            
            postprocessor_string := Concatenation( "dual_postprocessor_func := ", current_entry.dual_postprocessor_func_string, ";" );
            
            return_statement := "return dual_postprocessor_func( result );";
            
        else
            
            postprocessor_string := "";
            
            if return_type = "object" then
                
                return_statement := "return ObjectConstructor( cat, result );";
                
            elif return_type = "morphism" then
                
                return_statement := "return MorphismConstructor( cat, output_source_getter, result, output_range_getter );";
                
                if IsBound( current_entry.output_source_getter_string ) and IsBound( current_entry.can_always_compute_output_source_getter ) and current_entry.can_always_compute_output_source_getter then
                    
                    output_source_getter_string := current_entry.output_source_getter_string;
                    
                else
                    
                    output_source_getter_string := "ObjectConstructor( cat, Range( result ) )";
                    
                fi;
                
                if IsBound( current_entry.output_range_getter_string ) and IsBound( current_entry.can_always_compute_output_range_getter ) and current_entry.can_always_compute_output_range_getter then
                    
                    output_range_getter_string := current_entry.output_range_getter_string;
                    
                else
                    
                    output_range_getter_string := "ObjectConstructor( cat, Source( result ) )";
                    
                fi;
                
                return_statement := ReplacedStringViaRecord( return_statement, rec(
                    output_source_getter := output_source_getter_string,
                    output_range_getter := output_range_getter_string,
                ) );
                
            elif return_type = "list_of_morphisms" then
                
                return_statement := "return List( result, mor -> MorphismConstructor( cat, ObjectConstructor( cat, Range( mor ) ), mor, ObjectConstructor( cat, Source( mor ) ) ) );";
                
            elif return_type = "list_of_objects" then
                
                return_statement := "return List( result, obj -> ObjectConstructor( cat, obj ) );";
                
            elif return_type = "bool" then
                
                return_statement := "return result;";
                
            elif return_type = "nonneg_integer_or_infinity" then
                
                return_statement := "return result;";

            else
                
                Error( "this case is not handled yet" );
                
            fi;
            
        fi;
        
        func_string := ReplacedStringViaRecord( func_string, rec(
            input_arguments := input_arguments_names,
            preprocessor_string := preprocessor_string,
            dual_arguments := dual_arguments,
            dual_operation_name := dual_operation_name,
            postprocessor_string := postprocessor_string,
            return_statement := return_statement
        ) );
        
        func := EvalString( func_string );
        
        weight := OperationWeight( category, dual_operation_name );
        
        AddCapOperation( current_recname, opposite_category, func, weight );
        
    od;
    
end );


##
InstallMethod( Opposite,
               [ IsCapCategory, IsString ],
               
 FunctionWithNamedArguments(
  [
    [ "only_primitive_operations", false ],
    [ "only_primitive_operations_and_hom_structure", false ],
  ],
  function( CAP_NAMED_ARGUMENTS, category, name )
    local opposite_category, known_properties, opposite_property_pairs, pair;
    
    if not IsFinalized( category ) then
        Error( "Input category must be finalized to create opposite category" );
    fi;
    
    opposite_category := CreateCapCategoryWithDataTypes(
        name, WasCreatedAsOppositeCategory,
        IsCapCategoryOppositeObject, IsCapCategoryOppositeMorphism, IsCapCategoryTwoCell,
        CapJitDataTypeOfObjectOfCategory( category ), CapJitDataTypeOfMorphismOfCategory( category ), CapJitDataTypeOfTwoCellOfCategory( category )
        : is_computable := category!.is_computable
    );
    
    if IsBound( category!.supports_empty_limits ) then
        
        opposite_category!.supports_empty_limits := category!.supports_empty_limits;
        
    fi;
    
    opposite_category!.compiler_hints := rec(
        category_attribute_names := [
            "OppositeCategory",
        ],
    );
    
    SetOppositeCategory( opposite_category, category );
    SetOpposite( opposite_category, category );
    
    # A category might have multiple different instances of opposite categories.
    # Only the first instance is used for attributes (of the category and its objects and morphisms).
    if not HasOpposite( category ) then
        
        SetOpposite( category, opposite_category );
        
    fi;
    
    known_properties := ListKnownCategoricalProperties( category );
    
    opposite_property_pairs := Filtered( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST, x -> x[2] <> fail );
    
    for pair in opposite_property_pairs do
        
        # plausibility check
        if not Reversed( pair ) in opposite_property_pairs then
            
            Error( "The pair of categorical properties <pair> was registered using `AddCategoricalProperty`, but the reversed pair was not." );
            
        fi;
        
        if pair[1] in known_properties then
            
            Setter( ValueGlobal( pair[2] ) )( opposite_category, true );
            
        fi;
        
    od;
    
    AddObjectConstructor( opposite_category, function( cat, object )
      local opposite_object;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( object, OppositeCategory( cat ), {} -> "the object datum given to the object constructor of <cat>" );
        
        # A category might have multiple different instances of opposite categories.
        # Only the first instance is used for attributes (of the category and its objects and morphisms).
        #% CAP_JIT_DROP_NEXT_STATEMENT
        if HasOpposite( object ) and IsIdenticalObj( Opposite( OppositeCategory( cat ) ), cat ) then
            
            return Opposite( object );
            
        fi;
        
        opposite_object := CreateCapCategoryObjectWithAttributes( cat,
                                                                  Opposite, object );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        if CapCategory( object )!.predicate_logic then
            
            #= comment for Julia
            INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_OBJECT( object );
            # =#
            
        fi;
        
        # A category might have multiple different instances of opposite categories.
        # Only the first instance is used for attributes (of the category and its objects and morphisms).
        #% CAP_JIT_DROP_NEXT_STATEMENT
        if IsIdenticalObj( Opposite( OppositeCategory( cat ) ), cat ) then
            
            SetOpposite( object, opposite_object );
            
        fi;
        
        return opposite_object;
        
    end );
    
    AddObjectDatum( opposite_category, function( cat, opposite_object )
        
        return Opposite( opposite_object );
        
    end );
    
    AddMorphismConstructor( opposite_category, function( cat, source, morphism, range )
      local opposite_morphism;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( morphism, OppositeCategory( cat ), {} -> "the morphism datum given to the morphism constructor of <cat>" );
        
        if not IsEqualForObjects( OppositeCategory( cat ), Source( morphism ), Opposite( range ) ) then
            
            Error( "the source of the morphism datum must be equal to <Opposite( range )>" );
            
        fi;
        
        if not IsEqualForObjects( OppositeCategory( cat ), Range( morphism ), Opposite( source ) ) then
            
            Error( "the range of the morphism datum must be equal to <Opposite( source )>" );
            
        fi;
        
        # A category might have multiple different instances of opposite categories.
        # Only the first instance is used for attributes (of the category and its objects and morphisms).
        #% CAP_JIT_DROP_NEXT_STATEMENT
        if HasOpposite( morphism ) and IsIdenticalObj( Opposite( OppositeCategory( cat ) ), cat ) then
            
            return Opposite( morphism );
            
        fi;
        
        opposite_morphism := CreateCapCategoryMorphismWithAttributes( cat,
                                                                      source, range,
                                                                      Opposite, morphism );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        if CapCategory( morphism )!.predicate_logic then
            
            #= comment for Julia
            INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_MORPHISM( morphism );
            # =#
            
        fi;
        
        # A category might have multiple different instances of opposite categories.
        # Only the first instance is used for attributes (of the category and its objects and morphisms).
        #% CAP_JIT_DROP_NEXT_STATEMENT
        if IsIdenticalObj( Opposite( OppositeCategory( cat ) ), cat ) then
            
            SetOpposite( morphism, opposite_morphism );
            
        fi;
        
        return opposite_morphism;
        
    end );
    
    AddMorphismDatum( opposite_category, function( cat, opposite_morphism )
        
        return Opposite( opposite_morphism );
        
    end );
    
    CAP_INTERNAL_INSTALL_OPPOSITE_ADDS_FROM_CATEGORY( opposite_category, category, CAP_NAMED_ARGUMENTS.only_primitive_operations, CAP_NAMED_ARGUMENTS.only_primitive_operations_and_hom_structure );
    
    Finalize( opposite_category );
    
    if category!.predicate_logic then
        
        #= comment for Julia
        INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_CATEGORY( category );
        # =#
        
    fi;
    
    return opposite_category;
    
end ) );

##
InstallMethod( Opposite,
               [ IsCapCategory ],
               
 FunctionWithNamedArguments(
  [
    [ "only_primitive_operations", false ],
    [ "only_primitive_operations_and_hom_structure", false ],
  ],
  function( CAP_NAMED_ARGUMENTS, category )
    local opposite_category;
    
    opposite_category := Concatenation( "Opposite( ", Name( category ), " )" );
    
    return Opposite( category, opposite_category : only_primitive_operations := CAP_NAMED_ARGUMENTS.only_primitive_operations, only_primitive_operations_and_hom_structure := CAP_NAMED_ARGUMENTS.only_primitive_operations_and_hom_structure );
    
end ) );

##################################
##
## Methods
##
##################################

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_CATEGORY,
                       
  function( category )
    local opposite_property_pairs, entry, pair;
    
    opposite_property_pairs := Filtered( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST, x -> x[2] <> fail );
    
    # prepare special format for ToDoListEntryToMaintainFollowingAttributes
    opposite_property_pairs := List( opposite_property_pairs, x -> [ "", x ] );
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ category, "Opposite" ] ],
                                                         [ category, [ Opposite, category ] ],
                                                         opposite_property_pairs );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ category, "Opposite" ] ],
                                                         [ [ Opposite, category ], category ],
                                                         opposite_property_pairs );
    
    AddToToDoList( entry );
    
end );

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_MORPHISM,
                       
  function( morphism )
    local entry;
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ morphism, "Opposite" ] ],
                                                         [ morphism, [ Opposite, morphism ] ],
                                                         CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_MORPHISMS );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ morphism, "Opposite" ] ],
                                                         [ [ Opposite, morphism ], morphism ],
                                                         CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_MORPHISMS );
    
    AddToToDoList( entry );
    
end );

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_OBJECT,
                       
  function( object )
    local entry_list, entry;
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ object, "Opposite" ] ],
                                                         [ object, [ Opposite, object ] ],
                                                         CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_OBJECTS );

    AddToToDoList( entry );
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ object, "Opposite" ] ],
                                                         [ [ Opposite, object ], object ],
                                                         CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_OBJECTS );
    
    AddToToDoList( entry );
    
end );

##
InstallMethod( DisplayString,
        [ IsCapCategoryOppositeObject ],
        
  function( object )
    
    return Concatenation( DisplayString( Opposite( object ) ), "\nAn object in ", Name( CapCategory( object ) ), " given by the above data\n" );
    
end );

##
InstallMethod( DisplayString,
        [ IsCapCategoryOppositeMorphism ],
        
  function( morphism )
    
    return Concatenation( DisplayString( Opposite( morphism ) ), "\nA morphism in ", Name( CapCategory( morphism ) ), " given by the above data\n" );
    
end );
