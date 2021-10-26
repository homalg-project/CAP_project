# SPDX-License-Identifier: GPL-2.0-or-later
# ActionsForCAP: Actions and Coactions for CAP
#
# Declarations
#
#! @Chapter Actions

####################################
##
## Constructors
##
####################################

##
DeclareAttribute( "LeftActionsCategory",
                  IsCapCategoryObject );

DeclareOperation( "LeftActionsCategory",
                  [ IsCapCategoryObject, IsString, IsList ] );

DeclareAttribute( "RightActionsCategory",
                  IsCapCategoryObject );

DeclareOperation( "RightActionsCategory",
                  [ IsCapCategoryObject, IsString, IsList ] );

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
