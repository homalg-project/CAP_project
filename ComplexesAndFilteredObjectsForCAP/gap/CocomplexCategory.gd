#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Cocomplexes
##
#############################################################################

DeclareGlobalFunction( "INSTALL_OPERATIONS_FOR_COCOMPLEX_CATEGORY" );

DeclareGlobalFunction( "INSTALL_OPERATIONS_FOR_COMPLEX_CATEGORY" );

DeclareCategory( "IsCapComplexOrCocomplexCell",
                 IsCapCategoryCell );

DeclareCategory( "IsCapComplexOrCocomplex",
                 IsCapCategoryObject and IsCapComplexOrCocomplexCell );


DeclareCategory( "IsCapCocomplexCell",
                 IsCapComplexOrCocomplexCell );

DeclareCategory( "IsCapCocomplex",
                 IsCapComplexOrCocomplex and IsCapCocomplexCell );

DeclareCategory( "IsCapCochainMap",
                 IsCapCategoryMorphism and IsCapCocomplexCell );


DeclareCategory( "IsCapComplexCell",
                 IsCapComplexOrCocomplexCell );

DeclareCategory( "IsCapComplex",
                 IsCapCategoryObject and IsCapComplexCell );

DeclareCategory( "IsCapChainMap",
                 IsCapCategoryMorphism and IsCapComplexCell );


####################################
##
## Category
##
####################################

DeclareAttribute( "CocomplexCategory",
                  IsCapCategory );

DeclareAttribute( "ComplexCategory",
                  IsCapCategory );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "UnderlyingZFunctorCell",
                  IsCapComplexOrCocomplexCell );

####################################
##
## Getter
##
####################################

DeclareOperation( "\[\]",
                  [ IsCapComplexCell, IsInt ] );

DeclareOperation( "\[\]",
                  [ IsCapCocomplexCell, IsInt ] );

DeclareOperation( "Differential",
                  [ IsCapComplex, IsInt ] );

DeclareOperation( "Differential",
                  [ IsCapCocomplex, IsInt ] );

#################################################
##
## Constructors
##
#################################################

DeclareAttribute( "AsCocomplex",
                  IsZFunctorObject );

DeclareOperation( "CocomplexFromMorphismList",
                  [ IsList, IsInt ] );

DeclareOperation( "CocomplexFromMorphismList",
                  [ IsList ] );

DeclareAttribute( "AsComplex",
                  IsZFunctorObject );

DeclareOperation( "ComplexFromMorphismList",
                  [ IsList, IsInt ] );

DeclareOperation( "ComplexFromMorphismList",
                  [ IsList ] );

DeclareAttribute( "AsCochainMap",
                  IsZFunctorMorphism );

DeclareOperation( "CochainMap",
                  [ IsCapCocomplex, IsZFunctorMorphism, IsCapCocomplex ] );

DeclareOperation( "CochainMap",
                  [ IsCapCocomplex, IsFunction, IsCapCocomplex ] );

DeclareOperation( "CochainMap",
                  [ IsCapCocomplex, IsList, IsInt, IsCapCocomplex ]  );

DeclareOperation( "CochainMap",
                  [ IsCapCocomplex, IsList, IsCapCocomplex ]  );

DeclareAttribute( "AsChainMap",
                  IsZFunctorMorphism );

DeclareOperation( "ChainMap",
                  [ IsCapComplex, IsZFunctorMorphism, IsCapComplex ] );

DeclareOperation( "ChainMap",
                  [ IsCapComplex, IsFunction, IsCapComplex ] );

DeclareOperation( "ChainMap",
                  [ IsCapComplex, IsList, IsInt, IsCapComplex ] );

DeclareOperation( "ChainMap",
                  [ IsCapComplex, IsList, IsCapComplex ] );

KeyDependentOperation( "AsPointedCocomplex", IsCapCategoryObject, IsInt, ReturnTrue );

KeyDependentOperation( "AsPointedComplex", IsCapCategoryObject, IsInt, ReturnTrue );

KeyDependentOperation( "AsPointedCochainMap", IsCapCategoryMorphism, IsInt, ReturnTrue );

KeyDependentOperation( "AsPointedChainMap", IsCapCategoryMorphism, IsInt, ReturnTrue );

#################################################
##
## Functors
##
#################################################

DeclareOperationWithCache( "ComplexToCocomplexFunctor",
                           [ IsCapCategory ] );

DeclareOperationWithCache( "CocomplexToComplexFunctor",
                           [ IsCapCategory ] );

KeyDependentOperation( "HomologyFunctor",
                       IsCapCategory, IsInt, ReturnTrue );

KeyDependentOperation( "CohomologyFunctor",
                       IsCapCategory, IsInt, ReturnTrue );


