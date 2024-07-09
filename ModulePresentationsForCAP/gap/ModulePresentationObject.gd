# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Declarations
#
#! @Chapter Module Presentations

#############################
##
#! @Section GAP Categories
##
#############################

#! @Description
#! The GAP category of objects in the category
#! of left presentations or right presentations.
#! @Arguments object
DeclareCategory( "IsLeftOrRightPresentation",
                 IsCapCategoryObject );

#! @Description
#! The GAP category of objects in the category
#! of left presentations.
#! @Arguments object
DeclareCategory( "IsLeftPresentation",
                 IsLeftOrRightPresentation );

#! @Description
#! The GAP category of objects in the category
#! of right presentations.
#! @Arguments object
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
DeclareProperty( "IsFree",
                 IsCapCategoryMorphism );

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

CapJitAddTypeSignature( "UnderlyingMatrix", [ IsLeftOrRightPresentation ], function ( input_types )
    
    Assert( 0, IsHomalgRing( UnderlyingRing( input_types[1].category ) ) );
    
    return rec(
        filter := IsHomalgMatrix,
        ring := UnderlyingRing( input_types[1].category ),
    );
    
end );

#! @Description
#! The argument is an object $A$ in the category of left or right presentations
#! over a homalg ring $R$.
#! The output is $R$.
#! @Returns a homalg ring
#! @Arguments A
DeclareAttribute( "UnderlyingHomalgRing",
                  IsLeftOrRightPresentation );

#! @Description
#! The argument is an object $A$ in the category of left or right presentations.
#! The output is the embedding of the annihilator $I$ of $A$
#! into the free module $F$ of rank $1$.
#! In particular, the annihilator itself is seen as a left or right presentation.
#! @Returns a morphism in $\mathrm{Hom}(I, F)$
#! @Arguments A
DeclareAttribute( "Annihilator",
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
