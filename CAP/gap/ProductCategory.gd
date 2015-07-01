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

DeclareOperationWithCache( "DirectProductFunctor",
                           [ IsCapCategory, IsInt ] );

DeclareOperationWithCache( "CoproductFunctor",
                           [ IsCapCategory, IsInt ] );

DeclareFilter( "IsCapProductCategory" );


DeclareAttribute( "Components",
                  IsCapCategory );

DeclareAttribute( "Components",
                  IsCapCategoryCell );

DeclareOperation( "\[\]",
                  [ IsCapCategory, IsInt ] );

DeclareOperation( "\[\]",
                  [ IsCapCategoryCell, IsInt ] );


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
                  IsCapCategory );

DeclareAttribute( "Length",
                  IsCapCategoryObject );

DeclareAttribute( "Length",
                  IsCapCategoryMorphism );
