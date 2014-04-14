#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
#! @Chapter Product category
##
#############################################################################

DeclareAttribute( "DirectProductFunctor",
                  IsHomalgCategory );

DeclareAttribute( "Components",
                  IsHomalgCategory );

DeclareAttribute( "Components",
                  IsHomalgCategoryObject );

DeclareAttribute( "Components",
                  IsHomalgCategoryMorphism );

DeclareOperation( "\[\]",
                  [ IsHomalgCategory, IsInt ] );

DeclareOperation( "\[\]",
                  [ IsHomalgCategoryObject, IsInt ] );

DeclareOperation( "\[\]",
                  [ IsHomalgCategoryMorphism, IsInt ] );

############################
##
#! @Section Constructors
##
############################

DeclareOperation( "ProductOp",
                  [ IsList, IsHomalgCategory ] );

DeclareOperation( "ProductOp",
                  [ IsList, IsHomalgCategoryObject ] );

DeclareOperation( "ProductOp",
                  [ IsList, IsHomalgCategoryMorphism ] );

############################
##
#! @Section Technical methods
##
############################

DeclareAttribute( "Length",
                  IsHomalgCategory );

DeclareAttribute( "Length",
                  IsHomalgCategoryObject );

DeclareAttribute( "Length",
                  IsHomalgCategoryMorphism );
