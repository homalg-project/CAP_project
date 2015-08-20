#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Coactions
##
#############################################################################

####################################
##
## Constructors
##
####################################

DeclareAttribute( "LeftCoactionsCategory",
                  IsCapCategoryObject );

DeclareAttribute( "RightCoactionsCategory",
                  IsCapCategoryObject );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_LEFT_COACTIONS_CATEGORY" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_RIGHT_COACTIONS_CATEGORY" );