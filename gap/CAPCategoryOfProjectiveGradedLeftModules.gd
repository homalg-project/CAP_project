#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
#! @Chapter Category of projective graded left modules
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



####################################
##
## Install the categories
##
####################################

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_LEFT_MODULES" );