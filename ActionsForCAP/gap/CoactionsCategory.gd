# SPDX-License-Identifier: GPL-2.0-or-later
# ActionsForCAP: Actions and Coactions for CAP
#
# Declarations
#
#! @Chapter Coactions

####################################
##
## Constructors
##
####################################

##
DeclareAttribute( "LeftCoactionsCategory",
                  IsCapCategoryObject );

DeclareOperation( "LeftCoactionsCategory",
                  [ IsCapCategoryObject, IsString, IsList ] );

DeclareAttribute( "RightCoactionsCategory",
                  IsCapCategoryObject );

DeclareOperation( "RightCoactionsCategory",
                  [ IsCapCategoryObject, IsString, IsList ] );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_LEFT_COACTIONS_CATEGORY" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_RIGHT_COACTIONS_CATEGORY" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_LEFT_AND_RIGHT_COACTIONS_CATEGORY" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_ONLY_LEFT_COACTIONS_CATEGORY" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_ONLY_RIGHT_COACTIONS_CATEGORY" );

####################################
##
## Attributes
##
####################################

##
DeclareAttribute( "UnderlyingCoactingObject", IsCapCategory );
