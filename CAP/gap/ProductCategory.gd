#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
## Chapter Product category
##
#############################################################################

DeclareCategory( "IsCapCategoryProductCell",
                  IsCapCategoryCell );

DeclareCategory( "IsCapCategoryProductObject",
                 IsCapCategoryProductCell and IsCapCategoryObject );

DeclareCategory( "IsCapCategoryProductMorphism",
                 IsCapCategoryProductCell and IsCapCategoryMorphism );

DeclareCategory( "IsCapCategoryProductTwoCell",
                 IsCapCategoryProductCell and IsCapCategoryTwoCell );

DeclareOperationWithCache( "DirectProductFunctor",
                           [ IsCapCategory, IsInt ] );

DeclareOperationWithCache( "CoproductFunctor",
                           [ IsCapCategory, IsInt ] );

DeclareFilter( "IsCapProductCategory" );


DeclareAttribute( "Components",
                  IsCapCategory and IsCapProductCategory );

DeclareAttribute( "Components",
                  IsCapCategoryProductCell );

DeclareOperation( "\[\]",
                  [ IsCapCategory and IsCapProductCategory, IsInt ] );

DeclareOperation( "\[\]",
                  [ IsCapCategoryProductCell, IsInt ] );


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

DeclareOperation( "ProductOp",
                  [ IsList, IsCapCategoryCell ] );

############################
##
## Section Technical methods
##
############################

DeclareAttribute( "Length",
                  IsCapCategory and IsCapProductCategory );

DeclareAttribute( "Length",
                  IsCapCategoryProductObject );

DeclareAttribute( "Length",
                  IsCapCategoryProductMorphism );
