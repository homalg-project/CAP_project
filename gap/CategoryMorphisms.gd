#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Category morphism
#!  Any GAP object which is IsHomalgCategoryMorphism can be added to a category
#!  and then becomes a morphism in this category.
#!  Any morphism can belong to one or no category.
#!  After a GAP object is added to the category, it knows which things can be
#!  computed in its category and to which category it belongs.
#!  It knows categorial properties and attributes, and the functions for existential quantifiers
#!  can be applied to the morphism.
#!  If an GAP object in the category was constructed by a categorial construction
#!  it knows its Genesis.
##
#############################################################################

###################################
##
#! @Section Categories
##
###################################

DeclareCategory( "IsHomalgCategoryMorphism",
                 IsHomalgCategoryCell );

###################################
##
#! @Section Functions for all objects
##
###################################

#! @Group Category getter
DeclareAttribute( "HomalgCategory",
                  IsHomalgCategoryMorphism );

DeclareAttribute( "Source",
                  IsHomalgCategoryMorphism );

DeclareAttribute( "Range",
                  IsHomalgCategoryMorphism );

# this attribute is also an implied operation

DeclareAttribute( "Inverse",
                  IsHomalgCategoryMorphism );

###################################
##
#! @Section Technical stuff
##
###################################

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_CREATE_MORPHISM_PRINT" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_MORPHISM" );

###################################
##
## Properties
##
###################################

DeclareProperty( "IsMonomorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsEpimorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsIsomorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsEndomorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsAutomorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsSplitMonomorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsSplitEpimorphism",
                 IsHomalgCategoryMorphism );

## TODO: IsIdentity
DeclareProperty( "IsOne",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsIdempotent",
                 IsHomalgCategoryMorphism );

###################################
##
#! @Section Morphism add functions
##
###################################

DeclareOperation( "Add",
                  [ IsHomalgCategory, IsHomalgCategoryMorphism ] );

###################################
##
#! @Section Morphism functions
##
###################################


DeclareOperation( "PreCompose",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

###################################
##
#! Monomorphism as kernel lift
##
###################################


DeclareOperation( "MonoAsKernelLift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

####################################
##
## Epismorphism as cokernel lift
##
####################################


DeclareOperation( "EpiAsCokernelColift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );


###################################
##
#! @Section Implied operations
##
###################################


DeclareOperation( "PostCompose",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );
