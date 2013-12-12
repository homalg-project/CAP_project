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
                IsHomalgCategoryObject ) );

#######################################
##
## Operations
##
#######################################

InstallMethod( IdentityMorphism,
               [ IsHomalgCategoryObject ],
               
  function( object )
    local category;
    
    category := HomalgCategoryOfObject( object );
    
    return IdentityMorphism( category )( object );
    
end );