#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#! @Chapter Cokernel image closure
#!
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

DeclareCategory( "IsCokernelImageClosureObject",
                 IsCapCategoryObject );

DeclareCategory( "IsCokernelImageClosureMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsCokernelImageClosure",
                 IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_COKERNEL_IMAGE_CLOSURE" );

####################################
##
#! @Section Constructors
##
####################################

DeclareAttribute( "CokernelImageClosure",
                  IsCapCategory );

DeclareOperation( "CokernelImageClosureObject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "CokernelImageClosureMorphism",
                  [ IsCokernelImageClosureObject, IsCapCategoryMorphism, IsCokernelImageClosureObject ] );

DeclareAttribute( "AsCokernelImageClosureObject",
                  IsCapCategoryObject );

DeclareAttribute( "AsFinitelyPresentedCokernelImageClosureObject",
                  IsCapCategoryMorphism );

DeclareAttribute( "AsCokernelImageClosureMorphism",
                  IsCapCategoryMorphism );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingCategory",
                  IsCokernelImageClosure );

DeclareAttribute( "GeneratorMorphism",
                  IsCokernelImageClosureObject );

DeclareAttribute( "RelationMorphism",
                  IsCokernelImageClosureObject );

## this exists if the underlying category has biased weak pullbacks
DeclareAttribute( "RelationOfGeneratorMorphism",
                  IsCokernelImageClosureObject );

DeclareAttribute( "MorphismDatum",
                  IsCokernelImageClosureMorphism );

DeclareAttribute( "MorphismWitness",
                  IsCokernelImageClosureMorphism );

DeclareAttribute( "WitnessForBeingCongruentToZero",
                  IsCokernelImageClosureMorphism );

#######################################
##
#! @Section Functors
##
#######################################

##
DeclareAttribute( "FunctorCokernelImageClosureToFreydCategory",
                  IsCapCategory );

##
DeclareAttribute( "FunctorFreydCategoryToCokernelImageClosure",
                  IsCapCategory );

#######################################
##
#! @Section Natural Transformations
##
#######################################

##
DeclareAttribute( "NaturalIsomorphismFromIdentityToFinitePresentationOfCokernelImageClosureObject",
                  IsCapCategory );

##
DeclareAttribute( "NaturalIsomorphismFromFinitePresentationOfCokernelImageClosureObjectToIdentity",
                  IsCapCategory );