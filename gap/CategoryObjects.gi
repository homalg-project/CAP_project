#############################################################################
##
##                                               CategoriesForHomalg package
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

InstallTrueMethod( WasCreatedAsDirectSum, HasFirstSummand and HasSecondSummand );

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_OBJECT,
                       
  function( category, object )
    local entry;
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ object, "HomalgCategory" ] ],
                                                         [ category, object ],
                                                         CATEGORIES_FOR_HOMALG_CAN_COMPUTE_FILTER_LIST
                                                       );
 
    AddToToDoList( entry );
    
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
    
    ## Homalg category is set by immediate method
    
    INSTALL_TODO_LIST_ENTRIES_FOR_OBJECT( category, object );
    
end );

InstallTrueMethod( CanComputeZeroMorphism, CanComputePreCompose and CanComputeMorphismIntoZeroObject and CanComputeMorphismFromZeroObject );

##TODO
InstallMethodWithCacheFromObject( ZeroMorphism,
                                  [ IsHomalgCategoryObject and CanComputePreCompose and CanComputeMorphismIntoZeroObject and CanComputeMorphismFromZeroObject,
                                    IsHomalgCategoryObject and CanComputePreCompose and CanComputeMorphismIntoZeroObject and CanComputeMorphismFromZeroObject ],
                                  
  function( obj_source, obj_range )
    
    return PreCompose( MorphismIntoZeroObject( obj_source ), MorphismFromZeroObject( obj_range ) );
    
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
