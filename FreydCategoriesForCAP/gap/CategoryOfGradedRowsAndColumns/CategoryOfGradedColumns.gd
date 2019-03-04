#############################################################################
##
## FreydCategoriesForCAP package
##
## Copyright 2019, Martin Bies,       ULB Brussels
##
#! @Chapter Category of graded columns
##
#############################################################################

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The argument is a homalg graded ring $R$.
#! The output is the category of graded columns over $R$.
#! @Returns a category
#! @Arguments R
DeclareAttribute( "CAPCategoryOfGradedColumns",
                  IsHomalgGradedRing );



####################################
##
## Install the categories
##
####################################

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_GRADED_COLUMNS" );
