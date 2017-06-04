#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, Uni Siegen
##                  Sebastian Posur,   Uni Siegen
##
#! @Chapter Graded Module Presentations
##
#############################################################################

#############################
##
#! @Section GAP Categories
##
#############################

#! @Description
#! The GAP category of morphisms in the category
#! of graded left or right presentations.
#! @Arguments object
DeclareCategory( "IsGradedLeftOrRightPresentationMorphism",
                 IsCapCategoryMorphism );

#! @Description
#! The GAP category of morphisms in the category
#! of graded left presentations.
#! @Arguments object
DeclareCategory( "IsGradedLeftPresentationMorphism",
                 IsGradedLeftOrRightPresentationMorphism );

#! @Description
#! The GAP category of morphisms in the category
#! of graded right presentations.
#! @Arguments object
DeclareCategory( "IsGradedRightPresentationMorphism",
                 IsGradedLeftOrRightPresentationMorphism );

#############################
##
#! @Section Constructors
##
#############################

#! @Description
#! The arguments are an object $A$, a homalg matrix $M$,
#! and another object $B$.
#! $A$ and $B$ shall either both be objects in the category
#! of graded left presentations or both be objects in the category
#! of graded right presentations.
#! The output is a morphism $A \rightarrow B$ in the
#! the category of graded left or right presentations whose
#! underlying matrix is given by $M$.
#! @Returns a morphism in $\mathrm{Hom}(A,B)$
#! @Arguments A, M, B
DeclareOperation( "GradedPresentationMorphism",
                  [ IsGradedLeftOrRightPresentation, IsHomalgMatrix, IsGradedLeftOrRightPresentation ] );

DeclareOperation( "GradedPresentationMorphism",
                  [ IsGradedLeftOrRightPresentation, IsLeftOrRightPresentationMorphism, IsGradedLeftOrRightPresentation ] );

DeclareAttribute( "AsGradedPresentationMorphism",
                  IsLeftOrRightPresentationMorphism );

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
                  IsGradedLeftOrRightPresentationMorphism );

#! @Description
#! The argument is a morphism $\alpha$ in the category
#! of left or right presentations.
#! The output is its underlying homalg matrix.
#! @Returns a homalg matrix
#! @Arguments alpha
DeclareAttribute( "UnderlyingMatrix",
                  IsGradedLeftOrRightPresentationMorphism );

DeclareAttribute( "UnderlyingPresentationMorphism",
                  IsGradedLeftOrRightPresentationMorphism );

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
                  [ IsGradedLeftOrRightPresentation, IsInt ] );

#! @Description
#! The argument is an object $A$ in the category of
#! left or right presentations.
#! The output is a morphism from a free module $F$
#! to $A$, which maps the standard generators of
#! the free module to the generators of $A$.
#! @Returns a morphism in $\mathrm{Hom}(F,A)$
#! @Arguments A
DeclareAttribute( "CoverByProjective",
                  IsGradedLeftOrRightPresentation );
