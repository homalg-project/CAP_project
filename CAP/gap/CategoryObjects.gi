# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

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
                 "IsZeroForObjects",
                 # ..
              ] );

###################################
##
## Constructive Object-sets
##
###################################

# This method should usually not be selected when the two morphisms belong to the same category
InstallMethod( IsEqualForObjects,
                [ IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1, object_2 )

    if not HasCapCategory( object_1 ) then
        Error( Concatenation( "the object \"", String( object_1 ), "\" has no CAP category" ) );
    fi;
    if not HasCapCategory( object_2 ) then
        Error( Concatenation( "the object \"", String( object_2 ), "\" has no CAP category" ) );
    fi;

    if not IsIdenticalObj( CapCategory( object_1 ), CapCategory( object_2 ) ) then
        Error( Concatenation( "the object \"", String( object_1 ), "\" and the object \"", String( object_2 ), "\" do not belong to the same CAP category" ) );
    else
        Error( Concatenation( "the object \"", String( object_1 ), "\" and the object \"", String( object_2 ), "\" belong to the same CAP category, but no specific method IsEqualForObjects is installed. Maybe you forgot to finalize the category?" ) );
    fi;
    
end );

##
InstallMethod( \=,
               [ IsCapCategoryObject, IsCapCategoryObject ],
  function( object_1, object_2 )

    if CapCategory( object_1 )!.input_sanity_check_level > 0 or CapCategory( object_2 )!.input_sanity_check_level > 0  then
        if not IsIdenticalObj( CapCategory( object_1 ), CapCategory( object_2 ) ) then
            Error( Concatenation( "the object \"", String( object_1 ), "\" and the object \"", String( object_2 ), "\" do not belong to the same CAP category" ) );
        fi;
    fi;
               
  return IsEqualForObjects( object_1, object_2 );
end );

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
    
    filter := ObjectFilter( category );
    
    if not filter( object ) then
        
        SetFilterObj( object, filter );
        
    fi;
        
    if HasCapCategory( object ) then
        
        if IsIdenticalObj( CapCategory( object ), category ) then
            
            return;
            
        else
            
            Error(
                Concatenation(
                    "an object that lies in the CAP-category with the name\n",
                    Name( CapCategory( object ) ),
                    "\n",
                    "was tried to be added to a different CAP-category with the name\n",
                    Name( category ), ".\n",
                    "(Please note that it is possible for different CAP-categories to have the same name)"
                )
            );
            
        fi;
        
    fi;
    
    SetCapCategory( object, category );
    
end );

InstallMethod( AddObject,
               [ IsCapCategory, IsCapCategoryObject ],
               
  function( category, object )
    
    Add( category, object );
    
end );

InstallMethod( AddObject,
               [ IsCapCategory, IsAttributeStoringRep ],
               
  function( category, object )
    
    SetFilterObj( object, IsCapCategoryObject );
    
    Add( category, object );
    
end );

##
InstallMethod( IsWellDefined,
               [ IsCapCategoryObject ],
  IsWellDefinedForObjects
);

##
InstallMethod( IsZero,
               [ IsCapCategoryObject ],
                  
IsZeroForObjects );

##
InstallMethod( IsEqualForCache,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  IsEqualForCacheForObjects );

##
# generic fallback to IsIdenticalObj
InstallOtherMethod( IsEqualForCacheForObjects,
               [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ],
               
  { cat, obj1, obj2 } -> IsIdenticalObj( obj1, obj2 ) );

##
InstallMethod( AddObjectRepresentation,
               [ IsCapCategory, IsObject ],
               
  function( category, representation )
    
    if not IsSpecializationOfFilter( IsCapCategoryObject, representation ) then
        
        Error( "the object representation must imply IsCapCategoryObject" );
        
    fi;
    
    category!.object_representation := representation;
    category!.object_type := NewType( TheFamilyOfCapCategoryObjects, representation and ObjectFilter( category ) and IsCapCategoryObjectRep and HasCapCategory );
    SetObjectType( category, category!.object_type );
    
end );

##
InstallMethod( RandomObject, [ IsCapCategory, IsInt ], RandomObjectByInteger );

##
InstallMethod( RandomObject, [ IsCapCategory, IsList ], RandomObjectByList );


InstallGlobalFunction( ObjectifyObjectForCAPWithAttributes,
                       
  function( object, category, additional_arguments_list... )
    local arg_list;
    
    arg_list := Concatenation(
        [ object, ObjectType( category ), CapCategory, category ], additional_arguments_list
    );
    
    return CallFuncList( ObjectifyWithAttributes, arg_list );
    
end );

##
InstallMethod( Simplify,
               [ IsCapCategoryObject ],
  function( object )
    
    return SimplifyObject( object, infinity );
    
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
        
        string := "object in ";
        
        Append( string, Name( CapCategory( object ) ) );
        
        return string;
        
    end;
    
    print_graph := CreatePrintingGraph( IsCapCategoryObject and HasCapCategory, object_function );
    
    AddRelationToGraph( print_graph,
                        rec( Source := [ rec( Conditions := "IsZeroForObjects",
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
