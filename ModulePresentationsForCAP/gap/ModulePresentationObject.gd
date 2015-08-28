#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

#############################
##
## Category
##
#############################

DeclareCategory( "IsLeftOrRightPresentation",
                 IsCapCategoryObject );

DeclareCategory( "IsLeftPresentation",
                 IsLeftOrRightPresentation );

DeclareCategory( "IsRightPresentation",
                 IsLeftOrRightPresentation );

#############################
##
## Constructors
##
#############################

DeclareOperation( "AsLeftPresentation",
                  [ IsHomalgMatrix ] );

DeclareOperation( "AsRightPresentation",
                  [ IsHomalgMatrix ] );

DeclareGlobalFunction( "AsLeftOrRightPresentation" );

DeclareOperation( "FreeLeftPresentation",
                  [ IsInt, IsHomalgRing ] );

DeclareOperation( "FreeRightPresentation",
                  [ IsInt, IsHomalgRing ] );

#############################
##
## Properties
##
#############################


DeclareFamilyProperty( "IsFree",
                       IsCapCategoryMorphism,
                       "ModuleCategory",
                       "object" );

#############################
##
## Attributes
##
#############################

DeclareAttribute( "UnderlyingMatrix",
                  IsLeftOrRightPresentation );

DeclareAttribute( "UnderlyingHomalgRing",
                  IsLeftOrRightPresentation );

##############################################
##
## Non categorical methods
##
##############################################

DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT",
                           [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ] );

DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT",
                           [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ] );
