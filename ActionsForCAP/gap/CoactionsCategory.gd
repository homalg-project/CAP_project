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

##
DeclareAttribute( "LeftCoactionsCategory",
                  IsCapCategoryObject );

DeclareOperation( "LeftCoactionsCategory",
                  [ IsCapCategoryObject, IsString, IsObject ] );

DeclareAttribute( "RightCoactionsCategory",
                  IsCapCategoryObject );

DeclareOperation( "RightCoactionsCategory",
                  [ IsCapCategoryObject, IsString, IsObject ] );

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