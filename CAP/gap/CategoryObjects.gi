#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
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

#######################################
##
## Technical implications
##
#######################################

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
    
end );

InstallMethod( AddObject,
               [ IsCapCategory, IsObject ],
               
  function( category, object )
    
    SetFilterObj( object, IsCapCategoryObject );
    
    Add( category, object );
    
end );

##
InstallMethod( IsWellDefinedForObjects,
               [ IsCapCategoryObject ],
  IsWellDefined
);

##
InstallMethod( IsZeroForObjects,
               [ IsCapCategoryObject ],
                  
IsZero );

##
InstallMethod( IsEqualForCacheForObjects,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  IsEqualForCache );

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
        
        string := "object in ";
        
        Append( string, Name( CapCategory( object ) ) );
        
        return string;
        
    end;
    
    print_graph := CreatePrintingGraph( IsCapCategoryObject and HasCapCategory, object_function );
    
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
    
    
    InstallPrintFunctionsOutOfPrintingGraph( print_graph, -1 );
    
end );

CAP_INTERNAL_CREATE_OBJECT_PRINT( );

InstallMethod( String,
               [ IsCapCategoryObject and HasCapCategory ],
               
  function( object )
    
    return Concatenation( "An object in ", Name( CapCategory( object ) ) );
    
end );
