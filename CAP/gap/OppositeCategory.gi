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
## Construtor
##
##################################

##
InstallMethod( Opposite,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return ObjectConstructor( Opposite( CapCategory( object ) ), object );
    
end );

##
InstallMethod( Opposite,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return MorphismConstructor( Opposite( CapCategory( morphism ) ), Opposite( Range( morphism ) ), morphism, Opposite( Source( morphism ) ) );
    
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
  
  function( opposite_category, category )
    local only_primitive_operations, recnames, current_recname, current_entry, dual_operation_name,
          filter_list, input_arguments_names, return_type, func_string,
          dual_preprocessor_func_string, preprocessor_string, dual_arguments, tmp,
          dual_postprocessor_func_string, postprocessor_string, output_source_getter_string, output_range_getter_string, return_statement,
          func, weight, current_add, list_of_attributes, attr, tester, setter, getter;
    
    only_primitive_operations := ValueOption( "only_primitive_operations" ) = true;
    
    ## Take care of attributes
    ## TODO: if there are more instances, set markers in the MethodRecord
    list_of_attributes := [ "RangeCategoryOfHomomorphismStructure", "CommutativeRingOfLinearCategory" ];
    
    for attr in list_of_attributes do
        
        tester := ValueGlobal( Concatenation( "Has", attr ) );
        
        if not tester( opposite_category ) and tester( category ) then
            
            setter := ValueGlobal( Concatenation( "Set", attr ) );
            
            getter := ValueGlobal( attr );
            
            setter( opposite_category, getter( category ) );
            
        fi;
        
    od;
    
    recnames := AsSortedList( RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) );
    
    for current_recname in recnames do
        
        current_entry := CAP_INTERNAL_METHOD_NAME_RECORD.( current_recname );
        
        if IsBound( current_entry.no_install ) and current_entry.no_install = true then
            continue;
        fi;
        
        ## No support for twocells
        if current_recname in [ "HorizontalPreCompose",
                                "HorizontalPostCompose",
                                "VerticalPreCompose",
                                "VerticalPostCompose",
                                "IdenticalTwoCell" ] then
            continue;
        fi;
        
        ## Conservative
        if not IsBound( current_entry.dual_operation ) then
            continue;
        fi;
        
        dual_operation_name := current_entry.dual_operation;
        
        if not CanCompute( category, dual_operation_name ) then
            continue;
        fi;
        
        if only_primitive_operations and not dual_operation_name in ListPrimitivelyInstalledOperationsOfCategory( category ) then
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
                
                return_statement;
                
            end
            """;
        
        if IsBound( current_entry.dual_preprocessor_func ) then
            
            if IsOperation( current_entry.dual_preprocessor_func ) or IsKernelFunction( current_entry.dual_preprocessor_func ) then
                
                dual_preprocessor_func_string := NameFunction( current_entry.dual_preprocessor_func );
                
            else
                
                dual_preprocessor_func_string := String( current_entry.dual_preprocessor_func );
                
            fi;
            
            preprocessor_string := ReplacedStringViaRecord(
                """
                dual_preprocessor_func := dual_preprocessor_func_string;
                prep_arg := dual_preprocessor_func( input_arguments... );
                #% CAP_JIT_DROP_NEXT_STATEMENT
                Assert( 0, IsIdenticalObj( prep_arg[1], OppositeCategory( cat ) ) );
                """,
                rec(
                    dual_preprocessor_func_string := dual_preprocessor_func_string,
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
                    
                elif filter = IsInt or filter = IsRingElement or filter = IsCyclotomic then
                    
                    return argument_name;
                    
                elif filter = "list_of_objects" then
                    
                    return Concatenation( "List( ", argument_name, ", x -> ObjectDatum( cat, x ) )" );
                    
                elif filter = "list_of_morphisms" then
                    
                    return Concatenation( "List( ", argument_name, ", x -> MorphismDatum( cat, x ) )" );
                    
                elif filter = "nonneg_integer_or_infinity" then
                    
                    return argument_name;
                    
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
        
        if IsBound( current_entry.dual_postprocessor_func ) then
            
            if IsOperation( current_entry.dual_postprocessor_func ) or IsKernelFunction( current_entry.dual_postprocessor_func ) then
                
                dual_postprocessor_func_string := NameFunction( current_entry.dual_postprocessor_func );
                
            else
                
                dual_postprocessor_func_string := String( current_entry.dual_postprocessor_func );
                
            fi;
            
            postprocessor_string := Concatenation( "dual_postprocessor_func := ", dual_postprocessor_func_string, ";" );
            
            return_statement := "return dual_postprocessor_func( result )";
            
        else
            
            postprocessor_string := "";
            
            if return_type = "object" then
                
                return_statement := "return ObjectConstructor( cat, result )";
                
            elif return_type = "morphism" then
                
                return_statement := "return MorphismConstructor( cat, output_source_getter, result, output_range_getter )";
                
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
                
            elif return_type = "object_or_fail" then
                
                return_statement := "if result = fail then return fail; else return ObjectConstructor( cat, result ); fi";
                
            elif return_type = "morphism_or_fail" then
                
                return_statement := "if result = fail then return fail; else return MorphismConstructor( cat, ObjectConstructor( cat, Range( result ) ), result, ObjectConstructor( cat, Source( result ) ) ); fi";
                
            elif return_type = "list_of_morphisms" then
                
                return_statement := "return List( result, mor -> MorphismConstructor( cat, ObjectConstructor( cat, Range( mor ) ), mor, ObjectConstructor( cat, Source( mor ) ) ) )";
                
            elif return_type = "list_of_objects" then
                
                return_statement := "return List( result, obj -> ObjectConstructor( cat, obj ) )";
                
            elif return_type = "bool" then
                
                return_statement := "return result";
                
            elif return_type = "nonneg_integer_or_infinity" then
                
                return_statement := "return result";

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
        
        weight := CurrentOperationWeight( category!.derivations_weight_list, dual_operation_name );
        
        Assert( 0, weight < infinity );
        
        current_add := ValueGlobal( Concatenation( "Add", current_recname ) );
        
        current_add( opposite_category, func, weight );
        
    od;
    
end );


##
InstallMethod( Opposite,
               [ IsCapCategory, IsString ],
               
  function( category, name )
    local opposite_category, known_properties, opposite_property_pairs, pair;
    
    if not IsFinalized( category ) then
        Error( "Input category must be finalized to create opposite category" );
    fi;
    
    opposite_category := CreateCapCategory( name, WasCreatedAsOppositeCategory, IsCapCategoryOppositeObject, IsCapCategoryOppositeMorphism, IsCapCategoryTwoCell );
    
    opposite_category!.category_as_first_argument := true;
    
    if IsBound( category!.supports_empty_limits ) then
        
        opposite_category!.supports_empty_limits := category!.supports_empty_limits;
        
    fi;
    
    opposite_category!.compiler_hints := rec(
        category_attribute_names := [
            "OppositeCategory",
        ],
        category_filter := WasCreatedAsOppositeCategory,
        object_filter := IsCapCategoryOppositeObject,
        morphism_filter := IsCapCategoryOppositeMorphism,
    );
    
    SetOppositeCategory( opposite_category, category );
    
    SetOpposite( opposite_category, category );
    SetOpposite( category, opposite_category );
    
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
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        if HasOpposite( object ) then
            
            return Opposite( object );
            
        fi;
        
        opposite_object := ObjectifyObjectForCAPWithAttributes( rec( ), cat,
                                                                Opposite, object );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        if CapCategory( object )!.predicate_logic then
            
            #= comment for Julia
            INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_OBJECT( object );
            # =#
            
        fi;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        SetOpposite( object, opposite_object );
        
        return opposite_object;
        
    end );
    
    AddObjectDatum( opposite_category, function( cat, opposite_object )
        
        return Opposite( opposite_object );
        
    end );
    
    AddMorphismConstructor( opposite_category, function( cat, source, morphism, range )
      local opposite_morphism;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( morphism, OppositeCategory( cat ), {} -> "the morphism datum given to the morphism constructor of <cat>" );
        
        if IsEqualForObjects( OppositeCategory( cat ), Source( morphism ), Opposite( range ) ) = false then
            
            Error( "the source of the morphism datum must be equal to <Opposite( range )>" );
            
        fi;
        
        if IsEqualForObjects( OppositeCategory( cat ), Range( morphism ), Opposite( source ) ) = false then
            
            Error( "the range of the morphism datum must be equal to <Opposite( source )>" );
            
        fi;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        if HasOpposite( morphism ) then
            
            return Opposite( morphism );
            
        fi;
        
        opposite_morphism := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat,
                                                                                      source, range,
                                                                                      Opposite, morphism );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        if CapCategory( morphism )!.predicate_logic then
            
            #= comment for Julia
            INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_MORPHISM( morphism );
            # =#
            
        fi;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        SetOpposite( morphism, opposite_morphism );
        
        return opposite_morphism;
        
    end );
    
    AddMorphismDatum( opposite_category, function( cat, opposite_morphism )
        
        return Opposite( opposite_morphism );
        
    end );
    
    CAP_INTERNAL_INSTALL_OPPOSITE_ADDS_FROM_CATEGORY( opposite_category, category );
    
    Finalize( opposite_category );
    
    if category!.predicate_logic then
        
        #= comment for Julia
        INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_CATEGORY( category );
        # =#
        
    fi;
    
    return opposite_category;
    
end );

##
InstallMethod( Opposite,
               [ IsCapCategory ],
               
  function( category )
    local opposite_category;
    
    opposite_category := Concatenation( "Opposite( ", Name( category ), " )" );
    
    return Opposite( category, opposite_category );
    
end );

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
InstallMethod( Display,
        [ IsCapCategoryOppositeObject ],
        
  function( object )

    Display( Opposite( object ) );

    Print( "\nAn object in ", Name( CapCategory( object ) ), " given by the above data\n" );
    
end );

##
InstallMethod( Display,
        [ IsCapCategoryOppositeMorphism ],
        
  function( morphism )

    Display( Opposite( morphism ) );

    Print( "\nA morphism in ", Name( CapCategory( morphism ) ), " given by the above data\n" );
    
end );
