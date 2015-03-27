#############################################################################
##
##                                               CAP package
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

DeclareRepresentation( "IsCapCategoryObjectRep",
                       IsAttributeStoringRep and IsCapCategoryObject,
                       [ ] );

BindGlobal( "TheFamilyOfCapCategoryObjects",
        NewFamily( "TheFamilyOfCapCategoryObjects" ) );

BindGlobal( "TheTypeOfCapCategoryObjects",
        NewType( TheFamilyOfCapCategoryObjects,
                IsCapCategoryObjectRep ) );

######################################
##
## Immediate Methods
##
######################################

InstallTrueMethod( IsInjective and IsProjective, IsCapCategoryObject and IsZero );

#######################################
##
## Technical implications
##
#######################################

# InstallTrueMethod( WasCreatedAsDirectSum, HasFirstSummand and HasSecondSummand );

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_OBJECT,
                       
  function( category, object )
    local entry;
    
#     entry := ToDoListEntryToMaintainFollowingAttributes( [ [ object, "CapCategory" ] ],
#                                                          [ category, object ],
#                                                          CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST
#                                                        );
#  
#     AddToToDoList( entry );
    
    if IsBound( category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_OBJECTS ) then
        
        entry := ToDoListEntryToMaintainFollowingAttributes( [ [ object, "CapCategory" ] ],
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
## Constructive Object-sets
##
###################################

##
InstallMethod( AddIsEqualForObjects,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetObjectEqualityFunction( category, func );
    
end );

InstallMethodWithCacheFromObject( IsEqualForObjects,
                                  [ IsCapCategoryObject, IsCapCategoryObject ],
                                  
  function( object_1, object_2 )
    local category, return_value;
    
    if IsIdenticalObj( object_1, object_2 ) then
      
      return true;
      
    fi;
    
    category := CapCategory( object_1 );
    
    if not IsIdenticalObj( category, CapCategory( object_2 ) ) then
      
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
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  IsEqualForObjects );

##
InstallGlobalFunction( INSTALL_TODO_LIST_FOR_EQUAL_OBJECTS,
                       
  function( object_1, object_2 )
    local category, i, entry;
    
    category := CapCategory( object_1 );
    
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
               [ IsCapCategory, IsString ],
               
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
               [ IsCapCategory, IsCapCategoryObject ],
               
  function( category, object )
    local filter;
    
    if HasCapCategory( object ) then
        
        if IsIdenticalObj( CapCategory( object ), category ) then
            
            return;
            
        else
            
            Error( "this object already has a category" );
            
        fi;
        
    fi;
    
    filter := ObjectFilter( category );
    
    SetFilterObj( object, filter );
    
    SetCapCategory( object, category );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_OBJECT( category, object );
    
end );

InstallTrueMethodAndStoreImplication( CanComputeZeroMorphism, CanComputePreCompose
                                       and CanComputeUniversalMorphismIntoTerminalObject
                                       and CanComputeUniversalMorphismFromInitialObject
                                       and IsAdditiveCategory );

##TODO
InstallMethodWithToDoForIsWellDefined( ZeroMorphism,
                                       [ IsCapCategoryObject
                                     and CanComputePreCompose
                                     and CanComputeUniversalMorphismIntoTerminalObject
                                     and IsAdditiveCategory,
                                         IsCapCategoryObject
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
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeIsWellDefinedForObjects( category, true );
    
    SetIsWellDefinedForObjectsFunction( category, func );
    
    InstallMethod( IsWellDefined,
                   [ IsCapCategoryObject and ObjectFilter( category ) ],
                   
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
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
  
    SetCanComputeIsZeroForObjects( category, true );
    
    SetIsZeroForObjectsFunction( category, func );
    
    InstallMethod( IsZero,
                   [ IsCapCategoryObject and ObjectFilter( category ) ],
                   
      function( object )
        
        return func( object );
        
    end );
  
end );

##
InstallTrueMethodAndStoreImplication( CanComputeIsZeroForObjects, CanComputeIdentityMorphism and CanComputeZeroMorphism and CanComputeIsEqualForMorphisms );

InstallMethod( IsZero,
               [ IsCapCategoryObject and CanComputeIdentityMorphism and CanComputeZeroMorphism and CanComputeIsEqualForMorphisms ],
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
InstallGlobalFunction( CAP_INTERNAL_CREATE_OBJECT_PRINT,
                       
  function( )
    local print_graph, object_function;
    
    object_function := function( object )
      local string;
        
        string := "object in the category ";
        
        Append( string, Name( CapCategory( object ) ) );
        
        return string;
        
    end;
    
    print_graph := CreatePrintingGraph( IsCapCategoryObject, object_function );
    
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

CAP_INTERNAL_CREATE_OBJECT_PRINT( );

InstallMethod( String,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return Concatenation( "An object in ", Name( CapCategory( object ) ) );
    
end );
