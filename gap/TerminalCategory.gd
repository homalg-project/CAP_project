#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Terminal category
##
#############################################################################

#########################################
##
## Setup for terminal category
##
#########################################

DeclareGlobalVariable( "CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY_AS_CAT_OBJECT" );

DeclareGlobalVariable( "CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY" );

#########################################
##
## Filter
##
#########################################

DeclareFilter( "IsTerminalCategory" );

#########################################
##
## Attributes
##
#########################################

DeclareAttribute( "UniqueObject",
                  IsHomalgCategory );

DeclareAttribute( "UniqueMorphism",
                  IsHomalgCategory );

#########################################
##
## Functors
##
#########################################

DeclareAttribute( "FunctorFromTerminalCategory",
                  IsHomalgCategoryCell );


