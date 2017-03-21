#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Opposite category
##
#############################################################################

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
    local recnames, current_recname, object_property_list, morphism_property_list, current_entry, current_rec;
    
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
        fi;
        
        if CAP_INTERNAL_METHOD_NAME_RECORD.( current_recname ).property_of = "object" then
            Add( object_property_list, current_entry );
        elif CAP_INTERNAL_METHOD_NAME_RECORD.( current_recname ).property_of = "morphism" then
            Add( morphism_property_list, current_entry );
        fi;
        
    od;
    
    InstallValue( CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_MORPHISMS, morphism_property_list );
    
    InstallValue( CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_OBJECTS, object_property_list );
    
end );

CAP_INTERNAL_FIND_OPPOSITE_PROPERTY_PAIRS();

##
InstallImmediateMethod( Opposite,
                        IsCapCategory and HasOpposite,
                        0,
                        
  function( obj )
    
    SetOpposite( Opposite( obj ), obj );
    
end );

##
InstallImmediateMethod( Opposite,
                        IsCapCategoryObject and HasOpposite,
                        0,
                        
  function( obj )
    
    SetOpposite( Opposite( obj ), obj );
    
end );

##
InstallImmediateMethod( Opposite,
                        IsCapCategoryMorphism and HasOpposite,
                        0,
                        
  function( obj )
    
    SetOpposite( Opposite( obj ), obj );
    
end );

##################################
##
## Construtor
##
##################################

##
InstallMethod( Opposite,
               [ IsCapCategoryObject ],
               
  function( object )
    local opposite_object;
    
    opposite_object := rec( );
    
    ObjectifyWithAttributes( opposite_object, TheTypeOfCapCategoryOppositeObjects,
                             Opposite, object );
    
    Add( Opposite( CapCategory( object ) ), opposite_object );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_OBJECT( object );
    
    return opposite_object;
    
end );

##
InstallMethod( Opposite,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    local opposite_morphism;
    
    opposite_morphism := rec( );
    
    ObjectifyWithAttributes( opposite_morphism, TheTypeOfCapCategoryOppositeMorphisms,
                             Opposite, morphism );
    
    Add( Opposite( CapCategory( morphism ) ), opposite_morphism );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_MORPHISM( morphism );
    
    return opposite_morphism;
    
end );

DeclareGlobalFunction( "CAP_INTERNAL_OPPOSITE_RECURSIVE" );

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
    local recnames, current_recname, category_weight_list, dual_name, current_entry, func,
          current_add, create_func;
    
    recnames := RecNames( CAP_INTERNAL_METHOD_NAME_RECORD );
    
    category_weight_list := category!.derivations_weight_list;
    
    create_func := function( dual_name )
        
        return function( arg )
            local op_arg, result;
            
            op_arg := CAP_INTERNAL_OPPOSITE_RECURSIVE( arg );
            
            result := CallFuncList( ValueGlobal( dual_name ), op_arg );
            
            return CAP_INTERNAL_OPPOSITE_RECURSIVE( result );
            
        end;
        
    end;
    
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
                                "IdenticalTwoCell",
                                "IsomorphismFromImageObjectToKernelOfCokernel" ] then
            continue;
        fi;
        
        if IsBound( current_entry.dual_operation ) then
            dual_name := current_entry.dual_operation;
        else
            dual_name := current_recname;
        fi;
        
        if CurrentOperationWeight( category_weight_list, dual_name ) = infinity then
            continue;
        fi;
        
        func := create_func( dual_name );
        
        current_add := ValueGlobal( Concatenation( "Add", current_recname ) );
        
        current_add( opposite_category, func );
        
    od;
    
end );


##
InstallMethod( Opposite,
               [ IsCapCategory, IsString ],
               
  function( category, name )
    local opposite_category;
    
    if not HasIsFinalized( category ) or not IsFinalized( category ) then
        Error( "Input category must be finalized to create opposite category" );
    fi;
    
    opposite_category := CreateCapCategory( name );
    
    SetWasCreatedAsOppositeCategory( opposite_category, true );
    
    SetOpposite( opposite_category, category );
    
    CAP_INTERNAL_INSTALL_OPPOSITE_ADDS_FROM_CATEGORY( opposite_category, category );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_CATEGORY( category );
    
    Finalize( opposite_category );
    
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

##
InstallImmediateMethod( Source,
                        IsCapCategoryOppositeMorphismRep,
                        0,
                        
  function( morphism )
    
    return Opposite( Range( Opposite( morphism ) ) );
    
end );

##
InstallImmediateMethod( Range,
                        IsCapCategoryOppositeMorphismRep,
                        0,
                        
  function( morphism )
    
    return Opposite( Source( Opposite( morphism ) ) );
    
end );

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_CATEGORY,
                       
  function( category )
    
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

