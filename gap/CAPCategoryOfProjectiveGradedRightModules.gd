#############################################################################
##
## CAPCategoryOfProjectiveGradedModules package
##
## Copyright 2016, Martin Bies,       ITP Heidelberg
##
#! @Chapter Category of projective graded right modules
##
#############################################################################

####################################
##
#! @Section Constructors
##
####################################

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

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_RIGHT_MODULES" );