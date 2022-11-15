# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#

#############################################################################
##
## Chapter Product category
##
#############################################################################

DeclareCategory( "IsCapCategoryProductObject",
                 IsCapCategoryObject );

DeclareCategory( "IsCapCategoryProductMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsCapCategoryProductTwoCell",
                 IsCapCategoryTwoCell );

DeclareOperationWithCache( "DirectProductFunctor",
                           [ IsCapCategory, IsInt ] );

DeclareOperationWithCache( "CoproductFunctor",
                           [ IsCapCategory, IsInt ] );

DeclareFilter( "IsCapProductCategory", IsCapCategory );


DeclareAttribute( "Components",
                  IsCapProductCategory );

DeclareAttribute( "Components",
                  IsCapCategoryProductObject );

DeclareAttribute( "Components",
                  IsCapCategoryProductMorphism );

DeclareAttribute( "Components",
                  IsCapCategoryProductTwoCell );

DeclareOperation( "[]",
                  [ IsCapProductCategory, IsInt ] );

DeclareOperation( "[]",
                  [ IsCapCategoryProductObject, IsInt ] );

DeclareOperation( "[]",
                  [ IsCapCategoryProductMorphism, IsInt ] );

DeclareOperation( "[]",
                  [ IsCapCategoryProductTwoCell, IsInt ] );


############################
##
## Section Constructors
##
############################

DeclareOperation( "ProductOp",
                  [ IsList, IsCapCategory ] );

DeclareOperation( "ProductOp_OnMorphisms",
                  [ IsList, IsCapCategory ] );

DeclareOperation( "ProductOp_OnObjects",
                  [ IsList, IsCapCategory ] );

DeclareOperation( "ProductOp_OnTwoCells",
                  [ IsList, IsCapCategory ] );

DeclareOperation( "/",
                  [ IsList, IsCapProductCategory ] );

DeclareOperation( "ProductOp",
                  [ IsList, IsCapCategoryCell ] );

############################
##
## Section Technical methods
##
############################

DeclareAttribute( "Length",
                  IsCapProductCategory );

DeclareAttribute( "Length",
                  IsCapCategoryProductObject );

DeclareAttribute( "Length",
                  IsCapCategoryProductMorphism );
