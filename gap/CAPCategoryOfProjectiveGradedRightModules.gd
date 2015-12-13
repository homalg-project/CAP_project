#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
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

#! @Description
#! The argument is a homalg graded ring $R$ and a boolean. If the boolean is true, then checks on the input data of constructors 
#! for objects and morphisms is performed. If it is false, these checks are not performed. The latter is therefore better suited
#! for high performance applications.
#! @Returns a category
#! @Arguments R
DeclareOperation( "CAPCategoryOfProjectiveGradedRightModules",
                  [ IsHomalgGradedRing, IsBool ] );



####################################
##
## Install the categories
##
####################################

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_RIGHT_MODULES" );