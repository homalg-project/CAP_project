############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, University of Siegen
##                  Sebastian Posur,   University of Siegen
##
#! @Chapter Semisimple Categories
##
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of objects in a semisimple category.
#! @Arguments object
DeclareCategory( "IsSemisimpleCategoryObject",
                 IsCapCategoryObject );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! @Returns an object
#! @Arguments L
DeclareOperation( "SemisimpleCategoryObject", [ IsList ] );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is an object $A$ in a semisimple category.
#! @Returns a list
#! @Arguments A
DeclareAttribute( "Support",
                  IsSemisimpleCategoryObject );