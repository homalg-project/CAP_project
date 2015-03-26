#############################################################################
##
##                                               CAP package
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

DeclareGlobalVariable( "CAP_INTERNAL_TERMINAL_CATEGORY_AS_CAT_OBJECT" );

DeclareGlobalVariable( "CAP_INTERNAL_TERMINAL_CATEGORY" );

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
                  IsCapCategory );

DeclareAttribute( "UniqueMorphism",
                  IsCapCategory );

#########################################
##
## Functors
##
#########################################

DeclareAttribute( "FunctorFromTerminalCategory",
                  IsCapCategoryCell );


