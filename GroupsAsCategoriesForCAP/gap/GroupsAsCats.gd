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
DeclareCategory( "IsObjectInGroupAsCategory",
                 IsCapCategoryObject );

DeclareCategory( "IsMorphismInGroupAsCategory",
                 FilterIntersection( IsCapCategoryMorphism, IsAutomorphism ) );

DeclareCategory( "IsGroupAsCategory",
                 IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_GROUP_AS_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "GROUP_AS_CATEGORY",
                  [ IsGroup ] );

DeclareAttribute( "GroupAsCategory",
                  IsGroup );

DeclareAttribute( "GroupAsCategoryUniqueObject",
                  IsGroupAsCategory );

DeclareOperation( "GroupAsCategoryMorphism",
                  [ IsGroupAsCategory, IsMultiplicativeElementWithInverse ] );

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
                  IsMorphismInGroupAsCategory );

DeclareAttribute( "PositionWithinElements",
                  IsMorphismInGroupAsCategory );

####################################
##
#! @Section Operations
##
####################################

##
DeclareOperation( "*",
                  [ IsMorphismInGroupAsCategory, IsMorphismInGroupAsCategory ] );

##
DeclareOperation( "/",
                  [ IsObject, IsGroupAsCategory ] );
