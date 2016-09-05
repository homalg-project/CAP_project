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

##
DeclareAttribute( "LeftActionsCategory",
                  IsCapCategoryObject );

DeclareOperation( "LeftActionsCategory",
                  [ IsCapCategoryObject, IsString, IsObject ] );

DeclareAttribute( "RightActionsCategory",
                  IsCapCategoryObject );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_LEFT_ACTIONS_CATEGORY" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_RIGHT_ACTIONS_CATEGORY" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_LEFT_AND_RIGHT_ACTIONS_CATEGORY" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_ONLY_LEFT_ACTIONS_CATEGORY" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_ONLY_RIGHT_ACTIONS_CATEGORY" );

####################################
##
## Attributes
##
####################################

##
DeclareAttribute( "UnderlyingActingObject", IsCapCategory );