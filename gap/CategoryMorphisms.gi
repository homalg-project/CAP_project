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
## Immediate Methods
##
######################################

InstallTrueMethod( IsMonomorphism and IsEpimorphism, IsHomalgCategoryMorphism and IsIsomorphism );

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

######################################
##
## Implied operations
##
######################################

InstallMethod( PostCompose,
               [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ],
               
  function( right_mor, left_mor )
    
    return PreCompose( left_mor, right_mor );
    
end );

## should we check if the morphism is an isomorphism?
InstallMethod( Inverse,
               [ IsHomalgCategoryMorphism ],
               -1,

  function( mor )
    local category, assumptions, identity_of_range;
    
    category := HomalgCategory( mor );

    #TODO
    assumptions := HasIdentityMorphismFunction( category ) and
                    HasMonoAsKernelLiftFunction( category );
    
    if assumptions then
        
        identity_of_range := IdentityMorphism( Range( mor ) );
        
        return MonoAsKernelLift( mor, identity_of_range );

    fi;

    TryNextMethod( );
  
end );

##
InstallMethod( Inverse,
               [ IsHomalgCategoryMorphism ],
               -1,

  function( mor )
    local category, assumptions, identity_of_source;

    category := HomalgCategory( mor );

    #TODO
    assumptions := HasIdentityMorphismFunction( category ) and
                    HasEpiAsCokernelColiftFunction( category );

    if assumptions then

      identity_of_source := IdentityMorphism( Source( mor ) );

      return EpiAsCokernelColift( mor, identity_of_source );

    fi;

    TryNextMethod( );

end );                        


