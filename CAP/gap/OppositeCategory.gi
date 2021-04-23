# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
#! @Chapter Opposite category

###################################
##
#! @Section Filter
##
###################################

DeclareRepresentation( "IsCapCategoryOppositeObjectRep",
                       IsAttributeStoringRep and IsCapCategoryObjectRep,
                       [ ] );

DeclareRepresentation( "IsCapCategoryOppositeMorphismRep",
                       IsAttributeStoringRep and IsCapCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfCapCategoryOppositeObjects",
        NewType( TheFamilyOfCapCategoryObjects,
                IsCapCategoryOppositeObjectRep ) );

BindGlobal( "TheTypeOfCapCategoryOppositeMorphisms",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsCapCategoryOppositeMorphismRep ) );


###################################
##
#! @Section Functor is an involution
##
###################################



BindGlobal( "CAP_INTERNAL_FIND_OPPOSITE_PROPERTY_PAIRS",
  function( )
    local recnames, current_recname, object_property_list, morphism_property_list, current_entry, current_rec,
          category_property_list, elem;
    
    recnames := RecNames( CAP_INTERNAL_METHOD_NAME_RECORD );
    
    object_property_list := [ ];
    
    morphism_property_list := [ ];
    
    for current_recname in recnames do
        
        current_rec := CAP_INTERNAL_METHOD_NAME_RECORD.( current_recname );
        
        if not IsBound( current_rec.property_of ) then
            continue;
        fi;
        
        if not IsBound( current_rec.dual_operation ) or
           current_rec.dual_operation = current_recname then
            current_entry := current_rec.installation_name;
        else
            current_entry := [ current_rec.installation_name,
                               CAP_INTERNAL_METHOD_NAME_RECORD.( current_rec.dual_operation ).installation_name ];
            current_entry := [ Concatenation( current_entry[ 1 ], " vs ", current_entry[ 2 ] ), current_entry ];
        fi;
        
        if CAP_INTERNAL_METHOD_NAME_RECORD.( current_recname ).property_of = "object" then
            Add( object_property_list, current_entry );
        elif CAP_INTERNAL_METHOD_NAME_RECORD.( current_recname ).property_of = "morphism" then
            Add( morphism_property_list, current_entry );
        fi;
        
    od;
    
    InstallValue( CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_MORPHISMS, morphism_property_list );
    
    InstallValue( CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_OBJECTS, object_property_list );
    
    category_property_list := [ ];
    
    for elem in CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST do
        
        if not IsBound( elem[1] ) then
            continue;
        fi;
        
        if not IsBound( elem[2] ) then
            Add( category_property_list, [ elem[1], elem[1] ] );
        else
            Add( category_property_list, elem );
        fi;
        
    od;
    
    InstallValue( CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_CATEGORY, category_property_list );
    
end );

CAP_INTERNAL_FIND_OPPOSITE_PROPERTY_PAIRS();

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
    
    if IsCapCategory( obj ) or IsCapCategoryCell( obj ) then
        return Opposite( obj );
    elif IsList( obj ) then
        return List( obj, CAP_INTERNAL_OPPOSITE_RECURSIVE );
    else
        return obj;
    fi;
    
end );

BindGlobal( "CAP_INTERNAL_INSTALL_OPPOSITE_ADDS_FROM_CATEGORY",
  
  function( opposite_category, category )
    local recnames, current_recname, current_entry, dual_operation_name,
          filter_list, input_arguments_names, return_type, func_string,
          dual_preprocessor_func_string, preprocessor_string, dual_arguments,
          dual_postprocessor_func_string, postprocessor_string, return_statement,
          func, current_add, list_of_attributes, attr, tester, setter, getter;
    
    recnames := RecNames( CAP_INTERNAL_METHOD_NAME_RECORD );
    
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
        
        if not IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.( dual_operation_name ) ) then
            
            Error( "the dual operation must be a CAP operation" );
            
        fi;
        
        if not CanCompute( category, dual_operation_name ) then
            continue;
        fi;
        
        if current_entry.filter_list[1] <> "category" then
            
            Display( Concatenation(
                "WARNING: The opposite category cannot deal with operations which do not get the category as the first argument. ",
                "The installation of ", current_recname, " will be skipped. ",
                "To get rid of this warning, add \"category\" as the first entry of `filter_list` in the corresponding method record entry. ",
                "For more information about the implications of doing so, search for `filter_list` in the documentation of CAP."
            ) );
            continue;
            
        fi;
        
        filter_list := current_entry.filter_list;
        input_arguments_names := current_entry.input_arguments_names;
        return_type := current_entry.return_type;
        
        func_string :=
            """
            function ( input_arguments )
              local dual_preprocessor_func, prep_arg, result, dual_postprocessor_func;
                
                preprocessor_string
                
                result := dual_operation_name( dual_arguments );
                
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
                prep_arg := dual_preprocessor_func( input_arguments );
                """,
                rec(
                    dual_preprocessor_func_string := dual_preprocessor_func_string,
                    input_arguments := input_arguments_names,
                )
            );
            
            dual_arguments := List( [ 1 .. Length( filter_list ) ], i -> Concatenation( "prep_arg[", String( i ), "]" ) );
            
        else
            
            preprocessor_string := "";
            
            dual_arguments := List( [ 1 .. Length( filter_list ) ], function( i )
              local filter, argument_name;
                
                filter := filter_list[i];
                argument_name := input_arguments_names[i];
                
                # we only take the first filter in a filter list into account
                if not IsString( filter ) and IsList( filter ) then
                    
                    filter := filter[1];
                    
                fi;
                
                if filter = "category" or filter = "object" or filter = "morphism" then
                    
                    return Concatenation( "Opposite( ", argument_name, " )" );
                    
                elif filter = IsInt or filter = IsRingElement or filter = IsCyclotomic then
                    
                    return argument_name;
                    
                elif filter = "list_of_objects" or filter = "list_of_morphisms" then
                    
                    return Concatenation( "List( ", argument_name, ", Opposite )" );
                    
                else
                    
                    Error( "this case is not handled yet" );
                    
                fi;
                
            end );
            
            if current_entry.dual_arguments_reversed then
                
                # only reverse the arguments following the category
                dual_arguments := Concatenation( [ dual_arguments[1] ], Reversed( dual_arguments{ [ 2 .. Length( dual_arguments ) ] } ) );
                
            fi;
            
        fi;
        
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
                
                return_statement := "return MorphismConstructor( cat, ObjectConstructor( cat, Range( result ) ), result, ObjectConstructor( cat, Source( result ) ) )";
                
            elif return_type = "object_or_fail" then
                
                return_statement := "if result = fail then return fail; else return ObjectConstructor( cat, result ); fi";
                
            elif return_type = "morphism_or_fail" then
                
                return_statement := "if result = fail then return fail; else return MorphismConstructor( cat, ObjectConstructor( cat, Range( result ) ), result, ObjectConstructor( cat, Source( result ) ) ); fi";
                
            elif return_type = "list_of_morphisms" then
                
                return_statement := "return List( result, mor -> MorphismConstructor( cat, ObjectConstructor( cat, Range( mor ) ), mor, ObjectConstructor( cat, Source( mor ) ) ) )";
                
            elif return_type = "bool" then
                
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
        
        current_add := ValueGlobal( Concatenation( "Add", current_recname ) );
        
        current_add( opposite_category, func );
        
    od;
    
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
    
end );


##
InstallMethod( Opposite,
               [ IsCapCategory, IsString ],
               
  function( category, name )
    local opposite_category, to_be_finalized;
    
    if not HasIsFinalized( category ) or not IsFinalized( category ) then
        Error( "Input category must be finalized to create opposite category" );
    fi;
    
    opposite_category := CreateCapCategory( name );
    
    opposite_category!.category_as_first_argument := true;
    
    opposite_category!.compiler_hints := rec(
        category_attribute_names := [
            "Opposite",
        ],
    );
    
    AddObjectRepresentation( opposite_category, IsCapCategoryOppositeObjectRep );
    AddMorphismRepresentation( opposite_category, IsCapCategoryOppositeMorphismRep );
    
    SetWasCreatedAsOppositeCategory( opposite_category, true );
    
    SetOpposite( opposite_category, category );
    SetOpposite( category, opposite_category );
    
    AddObjectConstructor( opposite_category, function( cat, object )
      local opposite_object;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( object, Opposite( cat ), {} -> "the object datum given to the object constructor of <cat>" );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        if HasOpposite( object ) then
            
            return Opposite( object );
            
        fi;
        
        opposite_object := ObjectifyObjectForCAPWithAttributes( rec( ), cat,
                                                                Opposite, object );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        if CapCategory( object )!.predicate_logic then
            
            INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_OBJECT( object );
            
        fi;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        SetOpposite( object, opposite_object );
        
        return opposite_object;
        
    end );
    
    AddMorphismConstructor( opposite_category, function( cat, source, morphism, range )
      local opposite_morphism;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( morphism, Opposite( cat ), {} -> "the morphism datum given to the morphism constructor of <cat>" );
        
        if IsEqualForObjects( Source( morphism ), Opposite( range ) ) = false then
            
            Error( "the source of the morphism datum must be equal to <Opposite( range )>" );
            
        fi;
        
        if IsEqualForObjects( Range( morphism ), Opposite( source ) ) = false then
            
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
            
            INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_MORPHISM( morphism );
            
        fi;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        SetOpposite( morphism, opposite_morphism );
        
        return opposite_morphism;
        
    end );
    
    CAP_INTERNAL_INSTALL_OPPOSITE_ADDS_FROM_CATEGORY( opposite_category, category );
    
    if category!.predicate_logic then
        
        INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_CATEGORY( category );
        
    fi;
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
    
    if to_be_finalized = false then
        
        return opposite_category;
        
    else
        
        Finalize( opposite_category );
        
    fi;
    
    return opposite_category;
    
end );

##
InstallMethod( Opposite,
               [ IsCapCategory ],
               
  function( category )
    local opposite_category;
    
    opposite_category := Concatenation( "Opposite of ", Name( category ) );
    
    return Opposite( category, opposite_category );
    
end );

##################################
##
## Methods
##
##################################

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_CATEGORY,
                       
  function( category )
    local entry;
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ category, "Opposite" ] ],
                                                         [ category, [ Opposite, category ] ],
                                                         CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_CATEGORY );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ category, "Opposite" ] ],
                                                         [ [ Opposite, category ], category ],
                                                         CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_CATEGORY );
    
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
        [ IsCapCategoryOppositeObjectRep ],
        
  function( object )

    Display( Opposite( object ) );

    Print( "\nAn object in ", Name( CapCategory( object ) ), " given by the above data\n" );
    
end );

##
InstallMethod( Display,
        [ IsCapCategoryOppositeMorphismRep ],
        
  function( morphism )

    Display( Opposite( morphism ) );

    Print( "\nA morphism in ", Name( CapCategory( morphism ) ), " given by the above data\n" );
    
end );
