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

DeclareOperation( "InternalHomOnComplexWithObject",
                  [ IsCapComplex, IsCapCategoryObject ] );

DeclareOperation( "CartanEilenbergResolution",
                  [ IsCapCocomplex, IsFunction ] );

DeclareOperation( "InternalHomOnCocomplexWithObject",
                  [ IsCapCocomplex, IsCapCategoryObject ] );

DeclareOperation( "InternalHomOnCochainMapWithObject",
                  [ IsCapCochainMap, IsCapComplex, IsCapComplex, IsCapCategoryObject ] );

DeclareOperation( "InternalHomOnCocomplexCocomplexWithObject",
                  [ IsCapCocomplex, IsCapCategoryObject ] );

DeclareAttribute( "FreeResolutionComplexOfModule",
                  IsCapCategoryObject );

DeclareAttribute( "FreeResolutionCocomplexOfModule",
                  IsCapCategoryObject );

DeclareOperation( "ResolutionTo",
                  [ IsCapCategoryObject, IsFunction, IsBool ] );

DeclareOperation( "TransposeComplexOfComplex",
                  [ IsCapComplex ] );


