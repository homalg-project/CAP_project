#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
#! @Chapter Category object
##
#############################################################################

###################################
##
#! @Section Categories
##
###################################

DeclareCategory( "IsHomalgCategoryObject",
                 IsObject );

DeclareFilter( "IsDirectSum" );

###################################
##
#! @Section Functions for all objects
##
###################################

#! @Description
#! This is the place where the category of an object is stored,
#! once it is set. This also makes sure that an object only belongs to
#! one category
#! @Group Category getter
DeclareAttribute( "HomalgCategory",
                  IsHomalgCategoryObject );

###################################
##
#! @Section Add function
##
###################################

DeclareOperation( "Add",
                  [ IsHomalgCategory, IsHomalgCategoryObject ] );

###################################
##
#! @Section Direct sum attributes
##
###################################

DeclareOperation( "DirectSumOp",
                  [ IsList, IsHomalgCategoryObject ] );

DeclareAttribute( "FirstSummand",
                  IsHomalgCategoryObject );

DeclareAttribute( "SecondSummand",
                  IsHomalgCategoryObject );

DeclareAttribute( "ProjectionToFirstSummand",
                  IsHomalgCategoryObject );

DeclareAttribute( "ProjectionToSecondSummand",
                  IsHomalgCategoryObject );

DeclareAttribute( "InjectionFromFirstSummand",
                  IsHomalgCategoryObject );

DeclareAttribute( "InjectionFromSecondSummand",
                  IsHomalgCategoryObject );

###################################
##
#! @Section Element functions
##
###################################

DeclareAttribute( "IdentityMorphism",
                  IsHomalgCategoryObject );

DeclareAttribute( "ZeroObject",
                  IsHomalgCategoryObject );

DeclareAttribute( "MorphismFromZeroObject",
                  IsHomalgCategoryObject );

DeclareAttribute( "MorphismIntoZeroObject",
                  IsHomalgCategoryObject );

DeclareOperation( "ZeroMorphism",
                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );