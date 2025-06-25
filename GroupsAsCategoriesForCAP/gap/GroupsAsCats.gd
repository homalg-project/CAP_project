# SPDX-License-Identifier: GPL-2.0-or-later
# GroupsAsCategoriesForCAP: Groups as categories on one object
#
# Declarations
#
#! @Chapter Groups as categories

####################################
##
#! @Section GAP Categories
##
####################################

##
DeclareCategory( "IsGroupAsCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsGroupAsCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsGroupAsCategory",
                 IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_GROUP_AS_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

DeclareAttribute( "GroupAsCategory",
                  IsGroup );

DeclareAttribute( "GroupAsCategoryUniqueObject",
                  IsGroupAsCategory );

DeclareOperation( "GroupAsCategoryMorphism",
                  [ IsObject, IsGroupAsCategory ] );

KeyDependentOperation( "GroupAsCategoryMorphism", IsGroupAsCategory, IsObject, ReturnTrue );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingGroup",
                  IsGroupAsCategory );

DeclareAttribute( "ElementsOfUnderlyingGroup",
                  IsGroupAsCategory );

DeclareAttribute( "UnderlyingGroupElement",
                  IsGroupAsCategoryMorphism );

DeclareAttribute( "PositionWithinElements",
                  IsGroupAsCategoryMorphism );

####################################
##
#! @Section Operations
##
####################################

##
DeclareOperation( "*",
                  [ IsGroupAsCategoryMorphism, IsGroupAsCategoryMorphism ] );

##
DeclareOperation( "/",
                  [ IsObject, IsGroupAsCategory ] );
