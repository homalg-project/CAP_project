#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Cocomplexes
##
#############################################################################

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_COCOMPLEX_CATEGORY" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_COMPLEX_CATEGORY" );

DeclareCategory( "IsComplexOrCocomplexCell",
                 IsCapCategoryCell );

DeclareCategory( "IsComplexOrCocomplex",
                 IsCapCategoryObject and IsComplexOrCocomplexCell );


DeclareCategory( "IsCocomplexCell",
                 IsComplexOrCocomplexCell );

DeclareCategory( "IsCocomplex",
                 IsComplexOrCocomplex and IsCocomplexCell );

DeclareCategory( "IsCochainMap",
                 IsCapCategoryMorphism and IsCocomplexCell );


DeclareCategory( "IsComplexCell",
                 IsComplexOrCocomplexCell );

DeclareCategory( "IsComplex",
                 IsCapCategoryObject and IsComplexCell );

DeclareCategory( "IsChainMap",
                 IsCapCategoryMorphism and IsComplexCell );


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
                  IsComplexOrCocomplexCell );

####################################
##
## Getter
##
####################################

DeclareOperation( "Differential",
                  [ IsComplex, IsInt ] );

DeclareOperation( "Differential",
                  [ IsCocomplex, IsInt ] );

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
                  [ IsCocomplex, IsZFunctorMorphism, IsCocomplex ] );

DeclareOperation( "CochainMap",
                  [ IsCocomplex, IsFunction, IsCocomplex ] );

DeclareOperation( "CochainMap",
                  [ IsCocomplex, IsList, IsInt, IsCocomplex ]  );

DeclareOperation( "CochainMap",
                  [ IsCocomplex, IsList, IsCocomplex ]  );

DeclareAttribute( "AsChainMap",
                  IsZFunctorMorphism );

DeclareOperation( "ChainMap",
                  [ IsComplex, IsZFunctorMorphism, IsComplex ] );

DeclareOperation( "ChainMap",
                  [ IsComplex, IsFunction, IsComplex ] );

DeclareOperation( "ChainMap",
                  [ IsComplex, IsList, IsInt, IsComplex ] );

DeclareOperation( "ChainMap",
                  [ IsComplex, IsList, IsComplex ] );

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


