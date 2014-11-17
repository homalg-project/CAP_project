#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Categories for homalg
##
#############################################################################

######################################
##
## Reps, types, stuff.
##
######################################

DeclareRepresentation( "IsHomalgCategoryObjectRep",
                       IsAttributeStoringRep and IsHomalgCategoryObject,
                       [ ] );

BindGlobal( "TheFamilyOfHomalgCategoryObjects",
        NewFamily( "TheFamilyOfHomalgCategoryObjects" ) );

BindGlobal( "TheTypeOfHomalgCategoryObjects",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsHomalgCategoryObjectRep ) );

######################################
##
## Immediate Methods
##
######################################

InstallTrueMethod( IsInjective and IsProjective, IsHomalgCategoryObject and IsZero );

#######################################
##
## Technical implications
##
#######################################

# InstallTrueMethod( WasCreatedAsDirectSum, HasFirstSummand and HasSecondSummand );

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_OBJECT,
                       
  function( category, object )
    local entry;
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ object, "HomalgCategory" ] ],
                                                         [ category, object ],
                                                         CATEGORIES_FOR_HOMALG_CAN_COMPUTE_FILTER_LIST
                                                       );
 
    AddToToDoList( entry );
    
    if IsBound( category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_OBJECTS ) then
        
        entry := ToDoListEntryToMaintainFollowingAttributes( [ [ object, "HomalgCategory" ] ],
                                                             [ category, object ],
                                                             category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_OBJECTS
                                                           );
        
        AddToToDoList( entry );
        
    fi;
    
end );

InstallValue( PROPAGATION_LIST_FOR_EQUAL_OBJECTS,
              [  
                 "IsTerminal",
                 "IsInitial",
                 "IsProjective",
                 "IsInjective",
                 "IsZero",
                 # ..
              ] );

###################################
##
#! @Section Zero object
##
###################################

DeclareProperty( "IsZero",
                 IsHomalgCategoryObject );
###################################
##
## Constructive Object-sets
##
###################################

##
InstallMethod( AddIsEqualForObjects,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetObjectEqualityFunction( category, func );
    
end );

InstallMethodWithCacheFromObject( IsEqualForObjects,
                                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ],
                                  
  function( object_1, object_2 )
    local category, return_value;
    
    if IsIdenticalObj( object_1, object_2 ) then
      
      return true;
      
    fi;
    
    category := HomalgCategory( object_1 );
    
    if not IsIdenticalObj( category, HomalgCategory( object_2 ) ) then
      
      return false;
      
    fi;
    
    if HasObjectEqualityFunction( category ) then
    
      return_value := ObjectEqualityFunction( category )( object_1, object_2 );
      
      if return_value then
        
        INSTALL_TODO_LIST_FOR_EQUAL_OBJECTS( object_1, object_2 );
      
      fi;
      
      return return_value;
      
    fi;
    
    return false;
    
end );

##
InstallMethod( \=,
               [ IsHomalgCategoryObject, IsHomalgCategoryObject ],
               
  IsEqualForObjects );

##
InstallGlobalFunction( INSTALL_TODO_LIST_FOR_EQUAL_OBJECTS,
                       
  function( object_1, object_2 )
    local category, i, entry;
    
    category := HomalgCategory( object_1 );
    
    for i in PROPAGATION_LIST_FOR_EQUAL_OBJECTS do
        
        AddToToDoList( ToDoListEntryForEqualAttributes( object_1, i, object_2, i ) );
        
    od;
    
    if IsBound( category!.PROPAGATION_LIST_FOR_EQUAL_OBJECTS ) then
        
        for i in category!.PROPAGATION_LIST_FOR_EQUAL_OBJECTS do
            
            AddToToDoList( ToDoListEntryForEqualAttributes( object_1, i, object_2, i ) );
            
        od;
        
    fi;
    
end );

##
InstallMethod( AddPropertyToMatchAtIsEqualForObjects,
               [ IsHomalgCategory, IsString ],
               
  function( category, name )
    
    if not IsBound( category!.PROPAGATION_LIST_FOR_EQUAL_OBJECTS ) then
        
        category!.PROPAGATION_LIST_FOR_EQUAL_OBJECTS := [ ];
        
    fi;
    
    if Position( category!.PROPAGATION_LIST_FOR_EQUAL_OBJECTS, name ) = fail then
        
        Add( category!.PROPAGATION_LIST_FOR_EQUAL_OBJECTS, name );
        
    fi;
    
end );

#######################################
##
## Operations
##
#######################################

InstallMethod( Add,
               [ IsHomalgCategory, IsHomalgCategoryObject ],
               
  function( category, object )
    local filter;
    
    if HasHomalgCategory( object ) then
        
        if IsIdenticalObj( HomalgCategory( object ), category ) then
            
            return;
            
        else
            
            Error( "this object already has a category" );
            
        fi;
        
    fi;
    
    filter := ObjectFilter( category );
    
    SetFilterObj( object, filter );
    
    SetHomalgCategory( object, category );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_OBJECT( category, object );
    
end );

InstallTrueMethod( CanComputeZeroMorphism, CanComputePreCompose
                                       and CanComputeUniversalMorphismIntoTerminalObject
                                       and CanComputeUniversalMorphismFromInitialObject
                                       and IsAdditiveCategory );

##TODO
InstallMethodWithToDoForIsWellDefined( ZeroMorphism,
                                       [ IsHomalgCategoryObject
                                     and CanComputePreCompose
                                     and CanComputeUniversalMorphismIntoTerminalObject
                                     and IsAdditiveCategory,
                                         IsHomalgCategoryObject
                                     and CanComputeUniversalMorphismFromInitialObject
                                     and IsAdditiveCategory ],
                                       -99999, #FIXME
                                  
  function( obj_source, obj_range )
    
    return PreCompose( UniversalMorphismIntoTerminalObject( obj_source ), UniversalMorphismFromInitialObject( obj_range ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject );

###########################
##
## IsWellDefined
##
###########################

##
InstallMethod( AddIsWellDefinedForObjects,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeIsWellDefinedForObjects( category, true );
    
    SetIsWellDefinedForObjectsFunction( category, func );
    
    InstallMethod( IsWellDefined,
                   [ IsHomalgCategoryObject and ObjectFilter( category ) ],
                   
      function( object )
        
        return func( object );
        
    end );
    
end );

###########################
##
## IsZero
##
###########################

##
InstallMethod( AddIsZeroForObjects,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
  
    SetCanComputeIsZeroForObjects( category, true );
    
    SetIsZeroForObjectsFunction( category, func );
    
    InstallMethod( IsZero,
                   [ IsHomalgCategoryObject and ObjectFilter( category ) ],
                   
      function( object )
        
        return func( object );
        
    end );
  
end );

##
InstallTrueMethod( SetCanComputeIsZeroForObjects, CanComputeIdentityMorphism and CanComputeZeroMorphism and CanComputeIsEqualForMorphisms );

InstallMethod( IsZero,
               [ IsHomalgCategoryObject and CanComputeIdentityMorphism and CanComputeZeroMorphism and CanComputeIsEqualForMorphisms ],
               -9999, #FIXME
               
  function( object )
    
    return IsEqualForMorphisms( IdentityMorphism( object ), ZeroMorphism( object, object ) );
    
end );

###########################
##
## Print
##
###########################

##
InstallGlobalFunction( CATEGORIES_FOR_HOMALG_CREATE_OBJECT_PRINT,
                       
  function( )
    local print_graph, object_function;
    
    object_function := function( object )
      local string;
        
        string := "object in the category ";
        
        Append( string, Name( HomalgCategory( object ) ) );
        
        return string;
        
    end;
    
    print_graph := CreatePrintingGraph( IsHomalgCategoryObject, object_function );
    
    AddRelationToGraph( print_graph,
                        rec( Source := [ rec( Conditions := "IsZero",
                                              PrintString := "zero",
                                              Adjective := true ) ],
                             Range := [ rec( Conditions := "IsInjective",
                                             PrintString := "injective",
                                             Adjective := true ),
                                        rec( Conditions := "IsProjective",
                                             PrintString := "projective",
                                             Adjective := true ) ] ) );
    
    AddRelationToGraph( print_graph,
                    rec( Range := [ rec( Conditions := "WasCreatedAsDirectProduct",
                                         PrintString := "is direct product",
                                         ComputeLevel := 5
                                       ) ],
                         Source := [ rec( Conditions := "WasCreatedAsDirectSum",
                                          PrintString := "is direct sum",
                                          ComputeLevel := 5
                                        ) ] ) );
    
    AddNodeToGraph( print_graph,
                    rec( Conditions := "WasCreatedAsCokernel",
                         PrintString := "is cokernel",
                         ComputeLevel := 5
                       ) );
    
    AddNodeToGraph( print_graph,
                    rec( Conditions := "WasCreatedAsKernel",
                         PrintString := "is kernel",
                         ComputeLevel := 5
                       ) );
    
    InstallPrintFunctionsOutOfPrintingGraph( print_graph );
    
end );

CATEGORIES_FOR_HOMALG_CREATE_OBJECT_PRINT( );
