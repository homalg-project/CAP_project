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
#! The GAP category of morphisms in the category
#! of left or right presentations.
#! @Arguments object
DeclareCategory( "IsLeftOrRightPresentationMorphism",
                 IsCapCategoryMorphism );

#! @Description
#! The GAP category of morphisms in the category
#! of left presentations.
#! @Arguments object
DeclareCategory( "IsLeftPresentationMorphism",
                 IsLeftOrRightPresentationMorphism );

#! @Description
#! The GAP category of morphisms in the category
#! of right presentations.
#! @Arguments object
DeclareCategory( "IsRightPresentationMorphism",
                 IsLeftOrRightPresentationMorphism );

#############################
##
#! @Section Constructors
##
#############################

#! @Description
#! The arguments are an object $A$, a homalg matrix $M$,
#! and another object $B$.
#! $A$ and $B$ shall either both be objects in the category
#! of left presentations or both be objects in the category
#! of right presentations.
#! The output is a morphism $A \rightarrow B$ in the
#! the category of left or right presentations whose
#! underlying matrix is given by $M$.
#! @Returns a morphism in $\mathrm{Hom}(A,B)$
#! @Arguments A, M, B
DeclareOperation( "PresentationMorphism",
                  [ IsLeftOrRightPresentation, IsHomalgMatrix, IsLeftOrRightPresentation ] );

#! @Description
#! The argument is a homalg matrix $m$.
#! The output is a morphism $F^r \rightarrow F^c$ in the
#! the category of left presentations whose
#! underlying matrix is given by $m$,
#! where $F^r$ and $F^c$ are free left presentations of
#! ranks given by the number of rows and columns of $m$.
#! @Returns a morphism in $\mathrm{Hom}(F^r,F^c)$
#! @Arguments m
DeclareAttribute( "AsMorphismBetweenFreeLeftPresentations",
                  IsHomalgMatrix );

#! @Description
#! The argument is a homalg matrix $m$.
#! The output is a morphism $F^c \rightarrow F^r$ in the
#! the category of right presentations whose
#! underlying matrix is given by $m$,
#! where $F^r$ and $F^c$ are free right presentations of
#! ranks given by the number of rows and columns of $m$.
#! @Returns a morphism in $\mathrm{Hom}(F^c,F^r)$
#! @Arguments m
DeclareAttribute( "AsMorphismBetweenFreeRightPresentations",
                  IsHomalgMatrix );

#############################
##
#! @Section Attributes
##
#############################

#! @Description
#! The argument is a morphism $\alpha$ in the category
#! of left or right presentations over a homalg ring $R$.
#! The output is $R$.
#! @Returns a homalg ring
#! @Arguments R
DeclareAttribute( "UnderlyingHomalgRing",
                  IsLeftOrRightPresentationMorphism );

#! @Description
#! The argument is a morphism $\alpha$ in the category
#! of left or right presentations.
#! The output is its underlying homalg matrix.
#! @Returns a homalg matrix
#! @Arguments alpha
DeclareAttribute( "UnderlyingMatrix",
                  IsLeftOrRightPresentationMorphism );

CapJitAddTypeSignature( "UnderlyingMatrix", [ IsLeftOrRightPresentationMorphism ], function ( input_types )
    
    Assert( 0, IsHomalgRing( UnderlyingRing( input_types[1].category ) ) );
    
    return rec(
        filter := IsHomalgMatrix,
        ring := UnderlyingRing( input_types[1].category ),
    );
    
end );

##############################################
##
#! @Section Non-Categorical Operations
##
##############################################

#! @Description
#! The argument is an object $A$ in the category of
#! left or right presentations over a homalg ring $R$
#! with underlying matrix $M$
#! and an integer $i$.
#! The output is a morphism $F \rightarrow A$ given
#! by the $i$-th row or column of $M$, where $F$
#! is a free left or right presentation of rank $1$.
#! @Returns a morphism in $\mathrm{Hom}(F, A)$
#! @Arguments A, i
DeclareOperation( "StandardGeneratorMorphism",
                  [ IsLeftOrRightPresentation, IsInt ] );

#! @Description
#! The argument is an object $A$ in the category of
#! left or right presentations.
#! The output is a morphism from a free module $F$
#! to $A$, which maps the standard generators of
#! the free module to the generators of $A$.
#! @Returns a morphism in $\mathrm{Hom}(F,A)$
#! @Arguments A
DeclareAttribute( "CoverByFreeModule",
                  IsLeftOrRightPresentation );


