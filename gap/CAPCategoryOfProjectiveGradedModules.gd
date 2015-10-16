#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#! @Chapter Category of projective graded modules
##
#############################################################################

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The argument is a homalg graded ring $R$.
#! The output is the category of projective graded left modules over $R$.
#! @Returns a category
#! @Arguments R
DeclareAttribute( "CAPCategoryOfProjectiveGradedLeftModules",
                  IsHomalgGradedRing );

#! @Description
#! The argument is a homalg graded ring $R$.
#! The output is the category of projective graded right modules over $R$.
#! @Returns a category
#! @Arguments R                  
DeclareAttribute( "CAPCategoryOfProjectiveGradedRightModules",
                  IsHomalgGradedRing );

####################################
##
## Install the categories
##
####################################
                  
DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_LEFT_MODULES" );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_RIGHT_MODULES" );