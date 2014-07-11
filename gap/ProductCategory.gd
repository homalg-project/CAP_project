#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
## Chapter Product category
##
#############################################################################

DeclareOperationWithCache( "DirectProductFunctor",
                           [ IsHomalgCategory, IsInt ] );

DeclareOperationWithCache( "CoproductFunctor",
                           [ IsHomalgCategory, IsInt ] );

DeclareAttribute( "Components",
                  IsHomalgCategory );

DeclareAttribute( "Components",
                  IsHomalgCategoryCell );

DeclareOperation( "\[\]",
                  [ IsHomalgCategory, IsInt ] );

DeclareOperation( "\[\]",
                  [ IsHomalgCategoryObject, IsInt ] );

DeclareOperation( "\[\]",
                  [ IsHomalgCategoryMorphism, IsInt ] );

############################
##
## Section Constructors
##
############################

DeclareOperation( "ProductOp",
                  [ IsList, IsHomalgCategory ] );

DeclareOperation( "ProductOp_OnMorphisms",
                  [ IsList, IsHomalgCategory ] );

DeclareOperation( "ProductOp_OnObjects",
                  [ IsList, IsHomalgCategory ] );

DeclareOperation( "ProductOp",
                  [ IsList, IsHomalgCategoryObject ] );

DeclareOperation( "ProductOp",
                  [ IsList, IsHomalgCategoryMorphism ] );

############################
##
## Section Technical methods
##
############################

DeclareAttribute( "Length",
                  IsHomalgCategory );

DeclareAttribute( "Length",
                  IsHomalgCategoryObject );

DeclareAttribute( "Length",
                  IsHomalgCategoryMorphism );
