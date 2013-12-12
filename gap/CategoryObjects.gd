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
#! @Section Element functions
##
###################################

DeclareAttribute( "HomalgCategoryOfObject",
                  [ IsHomalgCategoryObject ] );

DeclareAttribute( "IdentityMorphism",
                  [ IsHomalgCategoryObject ] );