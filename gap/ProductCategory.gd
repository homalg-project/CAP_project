#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
## Chapter Product category
##
#############################################################################

DeclareOperationWithCache( "DirectProductFunctor",
                           [ IsHomalgCategory, IsInt ] );

DeclareOperationWithCache( "CoproductFunctor",
                           [ IsHomalgCategory, IsInt ] );

DeclareAttribute( "Components",
                  IsHomalgCategory );

DeclareAttribute( "Components",
                  IsHomalgCategoryCell );

DeclareOperation( "\[\]",
                  [ IsHomalgCategory, IsInt ] );

DeclareOperation( "\[\]",
                  [ IsHomalgCategoryCell, IsInt ] );


############################
##
## Section Constructors
##
############################

DeclareOperation( "ProductOp",
                  [ IsList, IsHomalgCategory ] );

DeclareOperation( "ProductOp_OnMorphisms",
                  [ IsList, IsHomalgCategory ] );

DeclareOperation( "ProductOp_OnObjects",
                  [ IsList, IsHomalgCategory ] );

DeclareOperation( "ProductOp_OnTwoCells",
                  [ IsList, IsHomalgCategory ] );

DeclareOperation( "ProductOp",
                  [ IsList, IsHomalgCategoryCell ] );

############################
##
## Section Technical methods
##
############################

DeclareAttribute( "Length",
                  IsHomalgCategory );

DeclareAttribute( "Length",
                  IsHomalgCategoryObject );

DeclareAttribute( "Length",
                  IsHomalgCategoryMorphism );
