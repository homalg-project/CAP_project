# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Declarations
#

#! @Chapter Generalized Morphism Category by Spans

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of the category of
#! generalized morphisms by spans.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphismCategoryBySpans",
                 IsGeneralizedMorphismCategory );

#! @Description
#! The GAP category of objects in the
#! generalized morphism category by spans.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphismCategoryBySpansObject",
                 IsGeneralizedMorphismCategoryObject );

#! @Description
#! The GAP category of morphisms in the
#! generalized morphism category by spans.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphismBySpan",
                 IsGeneralizedMorphism );

####################################
##
## Technical stuff
##
####################################

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_SPANS" );

DeclareFilter( "WasCreatedAsGeneralizedMorphismCategoryBySpans" );

####################################
##
#! @Section Properties
##
####################################

#! @Description
#! The argument is a generalized morphism $\alpha$ by 
#! a span $a \leftarrow b \rightarrow c$.
#! The output is <C>true</C> if $a \leftarrow b$
#! is congruent to an identity morphism,
#! <C>false</C> otherwise.
#! @Arguments alpha
DeclareProperty( "HasIdentityAsReversedArrow",
                 IsGeneralizedMorphismBySpan );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is an object $a$ in the generalized morphism category by spans.
#! The output is its underlying honest object.
#! @Returns an object in $\mathbf{A}$
#! @Arguments a
DeclareAttribute( "UnderlyingHonestObject",
                  IsGeneralizedMorphismCategoryBySpansObject );

#! @Description
#! The argument is a generalized morphism $\alpha$ by 
#! a span $a \leftarrow b \rightarrow c$.
#! The output is its arrow $b \rightarrow c$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}(b,c)$
#! @Arguments alpha
DeclareAttribute( "Arrow",
                  IsGeneralizedMorphismBySpan );

#! @Description
#! The argument is a generalized morphism $\alpha$ by 
#! a span $a \leftarrow b \rightarrow c$.
#! The output is its reversed arrow $a \leftarrow b$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}(b,a)$
#! @Arguments alpha
DeclareAttribute( "ReversedArrow",
                  IsGeneralizedMorphismBySpan );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$ by 
#! a span.
#! The output is its normalized span pair $(a \leftarrow d, d \rightarrow b)$.
#! @Returns a pair of morphisms in $\mathbf{A}$.
#! @Arguments alpha
DeclareAttribute( "NormalizedSpanTuple",
                  IsGeneralizedMorphismBySpan );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$ by 
#! a span.
#! The output is its pseudo inverse $b \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,a)$
#! @Arguments alpha
DeclareAttribute( "PseudoInverse",
                  IsGeneralizedMorphismBySpan );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b \in \mathbf{A}$.
#! The output is its generalized inverse $b \rightarrow a$ by span.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,a)$
#! @Arguments alpha
DeclareAttribute( "GeneralizedInverseBySpan",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a subobject $\alpha: a \hookrightarrow b \in \mathbf{A}$.
#! The output is the idempotent $b \rightarrow b \in \mathbf{G(A)}$ by span
#! defined by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,b)$
#! @Arguments alpha
DeclareAttribute( "IdempotentDefinedBySubobjectBySpan",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a factorobject $\alpha: b \twoheadrightarrow a \in \mathbf{A}$.
#! The output is the idempotent $b \rightarrow b \in \mathbf{G(A)}$ by span
#! defined by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,b)$
#! @Arguments alpha
DeclareAttribute( "IdempotentDefinedByFactorobjectBySpan",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$ by 
#! a span. The output is its normalization by span.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(a,b)$
#! @Arguments alpha
DeclareAttribute( "NormalizedSpan",
                  IsGeneralizedMorphismBySpan );

####################################
##
#! @Section Operations
##
####################################

#! @Description
#! The arguments are a a factorobject $\beta: b \twoheadrightarrow c$,
#! and a subobject $\alpha: a \hookrightarrow b$.
#! The output is the generalized morphism by span from the factorobject to the subobject.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(c,a)$
#! @Arguments beta, alpha
DeclareOperation( "GeneralizedMorphismFromFactorToSubobjectBySpan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The arguments are morphisms $\alpha: a \leftarrow c$ and $\beta: c \rightarrow b$ in $\mathbf{A}$.
#! The output is a generalized morphism by span
#! with arrow $\beta$ and reversed arrow $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(a,b)$
#! @Arguments alpha, beta
DeclareOperation( "GeneralizedMorphismBySpan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are morphisms $\alpha: a \leftarrow b$,
#! $\beta: b \rightarrow c$,
#! and $\gamma: c \leftarrow d$ in $\mathbf{A}$.
#! The output is a generalized morphism by span
#! defined by the composition of the given three arrows
#! regarded as generalized morphisms.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(a,d)$
#! @Arguments alpha, beta, gamma
DeclareOperation( "GeneralizedMorphismBySpan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are morphisms $\alpha: a \rightarrow b$,
#! and $\beta: b \leftarrow c$ in $\mathbf{A}$.
#! The output is a generalized morphism by span
#! defined by the composition of the given two arrows
#! regarded as generalized morphisms.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(a,c)$
#! @Arguments alpha, beta
DeclareOperation( "GeneralizedMorphismBySpanWithRangeAid",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$ in $\mathbf{A}$.
#! The output is the honest generalized morphism by span defined by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(a,b)$
#! @Arguments alpha
DeclareAttribute( "AsGeneralizedMorphismBySpan",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an abelian category $\mathbf{A}$.
#! The output is its generalized morphism category $\mathbf{G(A)}$ by spans.
#! @Returns a category
#! @Arguments A
DeclareAttribute( "GeneralizedMorphismCategoryBySpans",
                  IsCapCategory );

#! @Description
#! The argument is an object $a$ in an abelian category $\mathbf{A}$.
#! The output is the object in the generalized morphism category by spans
#! whose underlying honest object is $a$.
#! @Returns an object in $\mathbf{G(A)}$
#! @Arguments a
DeclareAttribute( "GeneralizedMorphismBySpansObject",
                  IsCapCategoryObject );


