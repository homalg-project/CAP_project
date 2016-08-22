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
#! The GAP category of morphisms in a semisimple category.
#! @Arguments object
DeclareCategory( "IsSemisimpleCategoryMorphism",
                 IsCapCategoryMorphism );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! @Returns a morphism
#! @Arguments L
DeclareOperation( "SemisimpleCategoryMorphism", 
                  [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ] );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! @Returns a list of vector space morphisms.
#! @Arguments alpha
DeclareAttribute( "SemisimpleCategoryMorphismList",
                  IsSemisimpleCategoryMorphism );

#! @Description
#! @Returns a list of vector space morphisms.
#! @Arguments alpha
DeclareAttribute( "Support",
                  IsSemisimpleCategoryMorphism );
