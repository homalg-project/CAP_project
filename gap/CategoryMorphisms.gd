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
DeclareProperty( "CanComputeInverse",
                 IsHomalgCategoryMorphism );

DeclareAttribute( "Inverse",
                  IsHomalgCategoryMorphism );

###################################
##
#! @Section Technical stuff
##
###################################

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_MORPHISM" );

DeclareProperty( "CanComputeIdentityMorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeZeroObject",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeMorphismFromZeroObject",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeMorphismIntoZeroObject",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeZeroMorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeDirectSum",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeProjectionInFirstFactor",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeProjectionInSecondFactor",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeInjectionFromFirstSummand",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeInjectionFromSecondSummand",
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

DeclareProperty( "CanComputePreCompose",
                 IsHomalgCategoryMorphism );

DeclareOperation( "PreCompose",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

###################################
##
#! Monomorphism as kernel lift
##
###################################

DeclareProperty( "CanComputeMonoAsKernelLift",
                 IsHomalgCategoryMorphism );

DeclareOperation( "MonoAsKernelLift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

####################################
##
## Epismorphism as cokernel lift
##
####################################

DeclareProperty( "CanComputeEpiAsCokernelColift",
                 IsHomalgCategoryMorphism );

DeclareOperation( "EpiAsCokernelColift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

###################################
##
## Kernel
##
###################################

DeclareProperty( "CanComputeKernel",
                 IsHomalgCategoryMorphism );

# DeclareOperation( "Kernel",
#                   [ IsHomalgCategoryMorphism ] );

DeclareProperty( "CanComputeKernelEmb",
                 IsHomalgCategoryMorphism );

DeclareAttribute( "KernelEmb",
                  IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeKernelLift",
                 IsHomalgCategoryMorphism );

DeclareOperation( "KernelLift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

###################################
##
## Cokernel
##
###################################

DeclareProperty( "CanComputeCokernel",
                 IsHomalgCategoryMorphism );

DeclareAttribute( "Cokernel",
                  IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeCokernelProj",
                 IsHomalgCategoryMorphism );

DeclareAttribute( "CokernelProj",
                  IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeCokernelColift",
                 IsHomalgCategoryMorphism );

DeclareOperation( "CokernelColift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

###################################
##
#! @Section Implied operations
##
###################################

DeclareProperty( "CanComputePostCompose",
                 IsHomalgCategoryMorphism );

DeclareOperation( "PostCompose",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );
