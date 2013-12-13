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

DeclareRepresentation( "IsHomalgCategoryMorphismRep",
                       IsAttributeStoringRep and IsHomalgCategoryMorphism,
                       [ ] );

BindGlobal( "TheFamilyOfHomalgCategoryMorphisms",
        NewFamily( "TheFamilyOfHomalgCategoryMorphisms" ) );

BindGlobal( "TheTypeOfHomalgCategoryMorphisms",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsHomalgCategoryMorphismRep ) );

######################################
##
## Operations
##
######################################

InstallMethod( Add,
               [ IsHomalgCategory, IsHomalgCategoryMorphism ],
               
  function( category, morphism )
    local obj_filter, filter;
    
    if HasHomalgCategory( morphism ) then
        
        if IsIdenticalObj( HomalgCategory( morphism ), category ) then
            
            return;
            
        else
            
            Error( "this morphism already has a category" );
            
        fi;
        
    fi;
    
    Add( category, Source( morphism ) );
    
    Add( category, Range( morphism ) );
    
    filter := MorphismFilter( category );
    
    SetFilterObj( morphism, filter );
    
    ## Homalg category is set by immediate method
    
end );

