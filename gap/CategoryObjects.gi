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
                                                         [ "CanComputeMonoAsKernelLift",
                                                           "CanComputeEpiAsCokernelLift",
                                                           "CanComputeIdentityMorphism",
                                                           "CanComputeInverse",
                                                           "CanComputeKernel",
                                                           "CanComputeKernelEmb",
                                                           "CanComputeKernelLift",
                                                           "CanComputePreCompose",
                                                           "CanComputePostCompose",
                                                           "CanComputeZeroObject",
                                                           "CanComputeMorphismFromZeroObject",
                                                           "CanComputeMorphismIntoZeroObject",
                                                           "CanComputeZeroMorphism",
                                                           "CanComputeDirectSum",
                                                           "CanComputeProjectionInFirstFactor",
                                                           "CanComputeProjectionInSecondFactor",
                                                           "CanComputeInjectionFromFirstSummand",
                                                           "CanComputeInjectionFromSecondSummand"
                                                         # ...
                                                         ] );
 
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
InstallMethodWithCache( ZeroMorphism,
                        [ IsHomalgCategoryObject and CanComputePreCompose and CanComputeMorphismIntoZeroObject and CanComputeMorphismFromZeroObject,
                          IsHomalgCategoryObject and CanComputePreCompose and CanComputeMorphismIntoZeroObject and CanComputeMorphismFromZeroObject ],
               
  function( obj_source, obj_range )
    
    return PreCompose( MorphismIntoZeroObject( obj_source ), MorphismFromZeroObject( obj_range ) );
    
end );