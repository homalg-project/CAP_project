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

DeclareOperation( "LeftCoactionsCategory",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareOperation( "RightCoactionsCategory",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_LEFT_COACTIONS_CATEGORY" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_RIGHT_COACTIONS_CATEGORY" );