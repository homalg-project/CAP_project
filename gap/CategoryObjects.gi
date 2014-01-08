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

InstallTrueMethod( IsDirectSum, HasFirstSummand and HasSecondSummand );

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
    
end );


InstallMethodWithCache( ZeroMorphism,
                        [ IsHomalgCategoryObject, IsHomalgCategoryObject ],
               
  function( obj_source, obj_range )
    
    return PreCompose( MorphismIntoZeroObject( obj_source ), MorphismFromZeroObject( obj_range ) );
    
end );