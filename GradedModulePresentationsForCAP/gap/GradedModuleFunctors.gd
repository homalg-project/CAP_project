#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, Uni Siegen
##                  Sebastian Posur,   Uni Siegen
##
#############################################################################

DeclareOperation( "ResolutionFunctor",
                  [ IsCapCategory, IsFunction, IsBool ] );

DeclareOperation( "ResolutionFunctorToComplex",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "ResolutionFunctorToCocomplex",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "HorseShoeLemma",
                  [ IsCapCocomplex, IsCapCocomplex, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "CartanEilenbergResolution",
                  [ IsCapComplex, IsCapFunctor ] );

DeclareAttribute( "DualOnComplex",
                  IsCapComplex );

DeclareOperation( "CartanEilenbergResolution",
                  [ IsCapCocomplex, IsFunction ] );

DeclareAttribute( "DualOnCocomplex",
                  IsCapCocomplex );

DeclareOperation( "DualOnCochainMap",
                  [ IsCapCochainMap, IsCapComplex, IsCapComplex ] );

DeclareOperation( "DualOnCocomplexCocomplex",
                  [ IsCapCocomplex ] );

DeclareAttribute( "FreeResolutionComplex",
                  IsCapCategoryObject );

DeclareAttribute( "FreeResolutionCocomplex",
                  IsCapCategoryObject );

DeclareOperation( "ResolutionTo",
                  [ IsCapCategoryObject, IsFunction, IsBool ] );

DeclareOperation( "TransposeComplexOfComplex",
                  [ IsCapComplex ] );

DeclareAttribute( "ResolutionLength",
                  IsCapComplex );

DeclareOperation( "TotalComplexOfBicomplex",
                  [ IsCapComplex, IsInt ] );

DeclareOperation( "EmbeddingInObjectOfTotalComplex",
                  [ IsCapComplex, IsInt, IsInt, IsInt ] );

DeclareOperation( "GeneralizedEmbeddingOfHomology",
                  [ IsCapComplex, IsInt ] );

DeclareOperation( "GeneralizedMorphismBetweenHomologies",
                  [ IsCapComplex, IsCapComplex, IsCapCategoryMorphism, IsInt ] );

DeclareOperation( "ConnectingMorphismFromCocomplexToCartanEilenbergResolution",
                  [ IsCapCocomplex, IsInt, IsFunction ] );

DeclareOperation( "GeneralizedEmbeddingOfSpectralSequenceEntry",
                  [ IsCapComplex, IsInt, IsInt, IsCapComplex, IsCapCocomplex, IsCapCategoryMorphism ] );

DeclareOperation( "PurityFiltrationBySpectralSequence",
                  [ IsCapComplex, IsInt, IsCapComplex, IsCapCocomplex, IsCapCategoryMorphism ] );

DeclareAttribute( "FunctorGradedDualLeft", IsHomalgGradedRing );

DeclareAttribute( "FunctorGradedDualRight", IsHomalgGradedRing );

DeclareAttribute( "FunctorDoubleGradedDualLeft", IsHomalgGradedRing );
                   
DeclareAttribute( "FunctorDoubleGradedDualRight", IsHomalgGradedRing );
