#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareCategory( "IsCategoryWithAttributesObject",
                 IsCapCategoryObject );

DeclareCategory( "IsCategoryWithAttributesMorphism",
                 IsCapCategoryMorphism );

####################################
##
## Attributes of Objects
##
####################################

DeclareAttribute( "UnderlyingCategory",
                  IsCategoryWithAttributesObject );

DeclareAttribute( "UnderlyingCell",
                  IsObject );

DeclareAttribute( "ObjectAttributesAsList",
                  IsCategoryWithAttributesObject );

####################################
##
## Attributes of Morphisms
##
####################################

DeclareAttribute( "UnderlyingCategory",
                  IsCategoryWithAttributesMorphism );

####################################
##
## Global Functions
##
####################################

DeclareGlobalFunction( "CreateObjectConstructorForCategoryWithAttributes" );

DeclareGlobalFunction( "CreateMorphismConstructorForCategoryWithAttributes" );

DeclareGlobalFunction( "EnhancementWithAttributes" );

DeclareGlobalFunction( "CAP_INTERNAL_CREATE_FILTER_LIST_FOR_CATEGORY_WITH_ATTRIBUTES" );


DeclareGlobalFunction( "CAP_INTERNAL_DERIVE_STRUCTURE_FUNCTIONS_OF_UNIVERSAL_OBJECTS_FOR_CATEGORY_WITH_ATTRIBUTES" );

DeclareGlobalFunction( "CAP_INTERNAL_INSTALL_ADDS_FOR_CATEGORY_WITH_ATTRIBUTES" );

####################################
##
## Global Variables
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_STRUCTURE_FUNCTION_RECORD_FOR_CATEGORY_WITH_ATTRIBUTES" );

