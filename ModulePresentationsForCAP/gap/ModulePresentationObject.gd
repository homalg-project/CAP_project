#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Module Presentations
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
#! @Section Constructors
##
#############################

#! @Description
#! The argument is a homalg matrix $M$ over a ring $R$.
#! The output is an object in the category of left presentations
#! over $R$. This object has $M$ as its underlying matrix.
#! @Returns an object
#! @Arguments M
DeclareOperation( "AsLeftPresentation",
                  [ IsHomalgMatrix ] );

#! @Description
#! The argument is a homalg matrix $M$ over a ring $R$.
#! The output is an object in the category of right presentations
#! over $R$. This object has $M$ as its underlying matrix.
#! @Returns an object
#! @Arguments M
DeclareOperation( "AsRightPresentation",
                  [ IsHomalgMatrix ] );

DeclareGlobalFunction( "AsLeftOrRightPresentation" );

#! @Description
#! The arguments are a non-negative integer $r$
#! and a homalg ring $R$.
#! The output is an object in the category of left presentations
#! over $R$. It is represented by the $0 \times r$ matrix and
#! thus it is free of rank $r$.
#! @Returns an object
#! @Arguments r, R
DeclareOperation( "FreeLeftPresentation",
                  [ IsInt, IsHomalgRing ] );

#! @Description
#! The arguments are a non-negative integer $r$
#! and a homalg ring $R$.
#! The output is an object in the category of right presentations
#! over $R$. It is represented by the $r \times 0$ matrix and
#! thus it is free of rank $r$.
#! @Returns an object
#! @Arguments r, R
DeclareOperation( "FreeRightPresentation",
                  [ IsInt, IsHomalgRing ] );

#############################
##
## Properties
##
#############################

## TODO
DeclareFamilyProperty( "IsFree",
                       IsCapCategoryMorphism,
                       "ModuleCategory",
                       "object" );

#############################
##
## Attributes
##
#############################

#! @Description
#! The argument is an object $A$ in the category of left or right presentations
#! over a homalg ring $R$.
#! The output is the underlying matrix which presents $A$.
#! @Returns a homalg matrix
#! @Arguments A
DeclareAttribute( "UnderlyingMatrix",
                  IsLeftOrRightPresentation );

#! @Description
#! The argument is an object $A$ in the category of left or right presentations
#! over a homalg ring $R$.
#! The output is $R$.
#! @Returns a homalg ring
#! @Arguments A
DeclareAttribute( "UnderlyingHomalgRing",
                  IsLeftOrRightPresentation );

##############################################
##
## Non-categorical methods
##
##############################################

DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT",
                           [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ] );

DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT",
                           [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ] );
