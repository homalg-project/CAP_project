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

#! @Description
#! The argument is a homalg graded ring $R$ and a boolean. If the boolean is true, then checks on the input data of constructors 
#! for objects and morphisms are performed. If it is false, these checks are not performed. The latter is therefore better suited
#! for high performance applications, but might however suffer from corrupted data.
#! @Returns a category
#! @Arguments R
DeclareOperation( "CAPCategoryOfProjectiveGradedLeftModules",
                  [ IsHomalgGradedRing, IsBool ] );



####################################
##
## Install the categories
##
####################################

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_LEFT_MODULES" );