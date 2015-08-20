#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Actions
##
#############################################################################

####################################
##
## Constructors
##
####################################

DeclareOperation( "LeftActionsCategory",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareOperation( "RightActionsCategory",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_LEFT_ACTIONS_CATEGORY" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_RIGHT_ACTIONS_CATEGORY" );

