#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Homological algebra algorithms
##
#############################################################################

####################################
##
## Snake-Lemma
##
####################################

DeclareOperationWithCache( "SnakeLemmaConnectingHomomorphism",
                           [ IsCapCategoryMorphism,
                           IsCapCategoryMorphism,
                           IsCapCategoryMorphism,
                           IsCapCategoryMorphism,
                           IsCapCategoryMorphism ] );

DeclareOperationWithCache( "SnakeLemmaConnectingHomomorphismWithKernelAndCokernel",
                           [ IsCapCategoryMorphism,
                           IsCapCategoryMorphism,
                           IsCapCategoryMorphism ] );

############################################################
##
## Spectral sequence algorithm for cohomological bicomplexes
##
############################################################

DeclareOperationWithCache( "GeneralizedDifferentialOfTotalCocomplex",
                           [ IsCocomplex, IsInt, IsInt, IsInt ] );

DeclareOperationWithCache( "SpectralSequenceEntry",
                           [ IsCocomplex, IsInt, IsInt, IsInt ] );

DeclareOperationWithCache( "SpectralSequenceDifferential",
                           [ IsCocomplex, IsInt, IsInt, IsInt ] );