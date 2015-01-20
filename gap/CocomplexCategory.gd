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
                 IsHomalgCategoryCell );

DeclareCategory( "IsCocomplex",
                 IsHomalgCategoryObject and IsCocomplexCell );

DeclareCategory( "IsCochainMap",
                 IsHomalgCategoryMorphism and IsCocomplexCell );

####################################
##
## Category
##
####################################

DeclareAttribute( "CocomplexCategory",
                  IsHomalgCategory );

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

KeyDependentOperation( "AsPointedCocomplex", IsHomalgCategoryObject, IsInt, RETURN_TRUE );

KeyDependentOperation( "AsPointedCochainMap", IsHomalgCategoryMorphism, IsInt, RETURN_TRUE );