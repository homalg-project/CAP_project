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
## Algorithms for spectral sequences
##
############################################################

DeclareOperationWithCache( "GetSpectralSequenceObjectFromConsecutiveGeneralizedDifferentials",
                           [ IsGeneralizedMorphism, IsGeneralizedMorphism ] );

DeclareOperationWithCache( "GetSpectralSequenceDifferentialFromConsecutiveGeneralizedDifferentials",
                           [ IsGeneralizedMorphism, IsGeneralizedMorphism, IsGeneralizedMorphism ] );

############################################################
##
## Spectral sequence algorithm for cohomological bicomplexes
##
############################################################

DeclareOperationWithCache( "GeneralizedDifferentialOfTotalCocomplex",
                           [ IsCapCocomplex, IsInt, IsInt, IsInt ] );

DeclareOperationWithCache( "SpectralSequenceEntry",
                           [ IsCapCocomplex, IsInt, IsInt, IsInt ] );

DeclareOperationWithCache( "SpectralSequenceDifferential",
                           [ IsCapCocomplex, IsInt, IsInt, IsInt ] );

############################################################
##
## Spectral sequence algorithm for homological bicomplexes
##
############################################################

DeclareOperationWithCache( "GeneralizedDifferentialOfTotalComplex",
                           [ IsCapComplex, IsInt, IsInt, IsInt ] );

DeclareOperationWithCache( "SpectralSequenceEntry",
                           [ IsCapComplex, IsInt, IsInt, IsInt ] );

DeclareOperationWithCache( "SpectralSequenceDifferential",
                           [ IsCapComplex, IsInt, IsInt, IsInt ] );

##################################################################################
##
## Spectral sequence algorithm for descending filtered cocomplexes (cohomological)
##
##################################################################################

## convention: a descending filtered cocomplex is a cocomplex of descending filtered objects

DeclareOperationWithCache( "GeneralizedDifferentialOfDescendingFilteredCocomplex",
                           [ IsCapCocomplex, IsInt, IsInt, IsInt ] );

DeclareOperationWithCache( "SpectralSequenceEntryOfDescendingFilteredCocomplex",
                           [ IsCapCocomplex, IsInt, IsInt, IsInt ] );

DeclareOperationWithCache( "SpectralSequenceDifferentialOfDescendingFilteredCocomplex",
                           [ IsCapCocomplex, IsInt, IsInt, IsInt ] );

#############################################################################
##
## Spectral sequence algorithm for ascending filtered complexes (homological)
##
#############################################################################

## convention: an ascending filtered complex is a complex of ascending filtered objects

DeclareOperationWithCache( "GeneralizedDifferentialOfAscendingFilteredComplex",
                           [ IsCapComplex, IsInt, IsInt, IsInt ] );

DeclareOperationWithCache( "SpectralSequenceEntryOfAscendingFilteredComplex",
                           [ IsCapComplex, IsInt, IsInt, IsInt ] );

DeclareOperationWithCache( "SpectralSequenceDifferentialOfAscendingFilteredComplex",
                           [ IsCapComplex, IsInt, IsInt, IsInt ] );
