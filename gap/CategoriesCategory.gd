#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
#! @Chapter Category of categories
##
#############################################################################

####################################
##
## Global stuff
##
####################################

DeclareGlobalVariable( "CATEGORIES_FOR_HOMALG_Cat" );

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_CREATE_Cat" );

####################################
##
## Categories
##
####################################

DeclareCategory( "IsHomalgCategoryAsCatObject",
                 IsHomalgCategoryObject );

DeclareCategory( "IsHomalgFunctor",
                 IsHomalgCategoryMorphism );

####################################
##
## Constructors
##
####################################

DeclareAttribute( "AsCatObject",
                  IsHomalgCategory );

DeclareAttribute( "AsHomalgCategory",
                  IsHomalgCategoryAsCatObject );

####################################
##
## Functor Constructors
##
####################################

DeclareOperation( "AddObjectFunction",
                  [ IsHomalgFunctor, IsFunction ] );

DeclareAttribute( "ObjectFunction",
                  IsHomalgFunctor );

DeclareOperation( "AddMorphismFunction",
                  [ IsHomalgFunctor, IsFunction ] );

DeclareAttribute( "MorphismFunction",
                  IsHomalgFunctor );

####################################
##
## Functor Constructors
##
####################################

DeclareOperation( "HomalgFunctor",
                  [ IsString, IsHomalgCategory, IsHomalgCategory ] );

####################################
##
## Functor Constructors
##
####################################

DeclareOperation( "ApplyFunctor",
                  [ IsHomalgFunctor, IsHomalgCategoryObject ] );

DeclareOperation( "ApplyFunctor",
                  [ IsHomalgFunctor, IsHomalgCategoryMorphism ] );

####################################
##
## Technical stuff
##
####################################

DeclareOperation( "CatFunctorPreimageList",
                  [ IsHomalgCategoryCell ] );

DeclareAttribute( "ObjectCache",
                  IsHomalgFunctor );

DeclareAttribute( "MorphismCache",
                  IsHomalgFunctor );
