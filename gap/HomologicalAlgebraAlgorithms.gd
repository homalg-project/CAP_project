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

##################################################################################
##
## Spectral sequence algorithm for descending filtered cocomplexes (cohomological)
##
##################################################################################

## convention: a descending filtered cocomplex is a cocomplex of descending filtered objects


#############################################################################
##
## Spectral sequence algorithm for ascending filtered complexes (homological)
##
#############################################################################

## convention: an ascending filtered complex is a complex of ascending filtered objects

DeclareOperationWithCache( "GeneralizedDifferentialOfAscendingFilteredComplex",
                           [ IsComplex, IsInt, IsInt, IsInt ] );

DeclareOperationWithCache( "SpectralSequenceEntryOfAscendingFilteredComplex",
                           [ IsComplex, IsInt, IsInt, IsInt ] );

DeclareOperationWithCache( "SpectralSequenceDifferentialOfAscendingFilteredComplex",
                           [ IsComplex, IsInt, IsInt, IsInt ] );
