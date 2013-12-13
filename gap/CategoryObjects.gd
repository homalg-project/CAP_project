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