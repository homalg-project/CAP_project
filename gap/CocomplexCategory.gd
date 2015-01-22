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

DeclareCategory( "IsCocomplexCell",
                 IsCapCategoryCell );

DeclareCategory( "IsCocomplex",
                 IsCapCategoryObject and IsCocomplexCell );

DeclareCategory( "IsCochainMap",
                 IsCapCategoryMorphism and IsCocomplexCell );

####################################
##
## Category
##
####################################

DeclareAttribute( "CocomplexCategory",
                  IsCapCategory );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "UnderlyingZFunctorCell",
                  IsCocomplex );

####################################
##
## Getter
##
####################################

DeclareOperation( "Differential",
                  [ IsCocomplex, IsInt ] );

#################################################
##
## Constructors
##
#################################################

DeclareAttribute( "AsCocomplex",
                  IsZFunctorObject );

DeclareAttribute( "AsCochainMap",
                  IsZFunctorMorphism );

DeclareOperation( "CochainMap",
                  [ IsCocomplex, IsZFunctorMorphism, IsCocomplex ] );

KeyDependentOperation( "AsPointedCocomplex", IsCapCategoryObject, IsInt, RETURN_TRUE );

KeyDependentOperation( "AsPointedCochainMap", IsCapCategoryMorphism, IsInt, RETURN_TRUE );