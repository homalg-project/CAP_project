#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
#! @Chapter Category morphism
##
#############################################################################

###################################
##
#! @Section Categories
##
###################################

DeclareCategory( "IsHomalgCategoryMorphism",
                 IsObject );

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
## Properties
##
###################################                                 

DeclareProperty( "IsMonomorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsEpimorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsIsomorphism",
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

DeclareOperation( "DirectSumOp",
                  [ IsList, IsHomalgCategoryMorphism ] );

DeclareOperation( "MonoAsKernelLift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareOperation( "EpiAsCokernelColift",                  
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

###################################
##
#! @Section Kernel and Cokernel
##
###################################
                  
DeclareAttribute( "Kernel",
                  IsHomalgCategoryMorphism );

DeclareAttribute( "KernelEmb",
                  IsHomalgCategoryMorphism );

DeclareOperation( "KernelLift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

###################################
##
#! @Section Implied operations
##
###################################

DeclareOperation( "PostCompose",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );
