#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
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

DeclareAttribute( "Object",
                  IsHomalgCategory );

DeclareAttribute( "Morphism",
                  IsHomalgCategory );
