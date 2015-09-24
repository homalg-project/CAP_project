#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
##! @Chapter Category of projective graded modules
##
#############################################################################

####################################
##
## Constructors
##
####################################

DeclareAttribute( "CAPCategoryOfProjectiveGradedLeftModules",
                  IsHomalgGradedRing );
                  
DeclareAttribute( "CAPCategoryOfProjectiveGradedRightModules",
                  IsHomalgGradedRing );

####################################
##
## Install the categories
##
####################################
                  
DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_LEFT_MODULES" );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_RIGHT_MODULES" );