# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Declarations
#

#! @Chapter Generalized Morphism Category by Cospans

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of the category of
#! generalized morphisms by cospans.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphismCategoryByCospans",
                  IsGeneralizedMorphismCategory );

#! @Description
#! The GAP category of objects in the
#! generalized morphism category by cospans.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphismCategoryByCospansObject",
                 IsGeneralizedMorphismCategoryObject );

#! @Description
#! The GAP category of morphisms in the
#! generalized morphism category by cospans.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphismByCospan",
                 IsGeneralizedMorphism );

####################################
##
## Technical stuff
##
####################################

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_COSPANS" );

DeclareFilter( "WasCreatedAsGeneralizedMorphismCategoryByCospans" );

####################################
##
#! @Section Properties
##
####################################

#! @Description
#! The argument is a generalized morphism $\alpha$ by 
#! a cospan $a \rightarrow b \leftarrow c$.
#! The output is <C>true</C> if $b \leftarrow c$
#! is congruent to an identity morphism,
#! <C>false</C> otherwise.
#! @Arguments alpha
DeclareProperty( "HasIdentityAsReversedArrow",
                 IsGeneralizedMorphismByCospan );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is an object $a$ in the generalized morphism category by cospans.
#! The output is its underlying honest object.
#! @Returns an object in $\mathbf{A}$
#! @Arguments a
DeclareAttribute( "UnderlyingHonestObject",
                  IsGeneralizedMorphismCategoryByCospansObject );

#! @Description
#! The argument is a generalized morphism $\alpha$ by 
#! a cospan $a \rightarrow b \leftarrow c$.
#! The output is its arrow $a \rightarrow b$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}(a,c)$
#! @Arguments alpha
DeclareAttribute( "Arrow",
                  IsGeneralizedMorphismByCospan );

#! @Description
#! The argument is a generalized morphism $\alpha$ by 
#! a cospan $a \rightarrow b \leftarrow c$.
#! The output is its reversed arrow $b \leftarrow c$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}(c,b)$
#! @Arguments alpha
DeclareAttribute( "ReversedArrow",
                  IsGeneralizedMorphismByCospan );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$ by 
#! a cospan.
#! The output is its normalized cospan pair $(a \rightarrow d, d \leftarrow b)$.
#! @Returns a pair of morphisms in $\mathbf{A}$.
#! @Arguments alpha
DeclareAttribute( "NormalizedCospanTuple",
                  IsGeneralizedMorphismByCospan );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$ by 
#! a cospan.
#! The output is its pseudo inverse $b \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,a)$
#! @Arguments alpha
DeclareAttribute( "PseudoInverse",
                  IsGeneralizedMorphismByCospan );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b \in \mathbf{A}$.
#! The output is its generalized inverse $b \rightarrow a$ by cospan.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,a)$
#! @Arguments alpha
DeclareAttribute( "GeneralizedInverseByCospan",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a subobject $\alpha: a \hookrightarrow b \in \mathbf{A}$.
#! The output is the idempotent $b \rightarrow b \in \mathbf{G(A)}$ by cospan
#! defined by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,b)$
#! @Arguments alpha
DeclareAttribute( "IdempotentDefinedBySubobjectByCospan",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a factorobject $\alpha: b \twoheadrightarrow a \in \mathbf{A}$.
#! The output is the idempotent $b \rightarrow b \in \mathbf{G(A)}$ by cospan
#! defined by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,b)$
#! @Arguments alpha
DeclareAttribute( "IdempotentDefinedByFactorobjectByCospan",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$ by 
#! a cospan. The output is its normalization by cospan.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(a,b)$
#! @Arguments alpha
DeclareAttribute( "NormalizedCospan",
                  IsGeneralizedMorphismByCospan );

####################################
##
#! @Section Operations
##
####################################

#! @Description
#! The arguments are a a factorobject $\beta: b \twoheadrightarrow c$,
#! and a subobject $\alpha: a \hookrightarrow b$.
#! The output is the generalized morphism by cospan from the factorobject to the subobject.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(c,a)$
#! @Arguments beta, alpha
DeclareOperation( "GeneralizedMorphismFromFactorToSubobjectByCospan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The arguments are morphisms $\alpha: a \rightarrow b$ and $\beta: c \rightarrow b$ in $\mathbf{A}$.
#! The output is a generalized morphism by cospan
#! with arrow $\alpha$ and reversed arrow $\beta$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(a,c)$
#! @Arguments alpha, beta
DeclareOperation( "GeneralizedMorphismByCospan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are morphisms $\alpha: a \leftarrow b$,
#! $\beta: b \rightarrow c$,
#! and $\gamma: c \leftarrow d$ in $\mathbf{A}$.
#! The output is a generalized morphism by cospan
#! defined by the composition of the given three arrows
#! regarded as generalized morphisms.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(a,d)$
#! @Arguments alpha, beta, gamma
DeclareOperation( "GeneralizedMorphismByCospan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are morphisms $\alpha: a \leftarrow b$,
#! and $\beta: b \rightarrow c$ in $\mathbf{A}$.
#! The output is a generalized morphism by cospan
#! defined by the composition of the given two arrows
#! regarded as generalized morphisms.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(a,c)$
#! @Arguments alpha, beta
DeclareOperation( "GeneralizedMorphismByCospanWithSourceAid",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$ in $\mathbf{A}$.
#! The output is the honest generalized morphism by cospan defined by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(a,b)$
#! @Arguments alpha
DeclareAttribute( "AsGeneralizedMorphismByCospan",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an abelian category $\mathbf{A}$.
#! The output is its generalized morphism category $\mathbf{G(A)}$ by cospans.
#! @Returns a category
#! @Arguments A
DeclareAttribute( "GeneralizedMorphismCategoryByCospans",
                  IsCapCategory );

#! @Description
#! The argument is an object $a$ in an abelian category $\mathbf{A}$.
#! The output is the object in the generalized morphism category by cospans
#! whose underlying honest object is $a$.
#! @Returns an object in $\mathbf{G(A)}$
#! @Arguments a
DeclareAttribute( "GeneralizedMorphismByCospansObject",
                  IsCapCategoryObject );

####################################
##
#! @Section Constructors of lifts of exact functors and natrual (iso)morphisms
##
####################################

#! @Description
#!  Lift the <E>exact</E> functor <A>F</A> to a functor <M>A \to B</M>,
#!  where <M>A := </M> <C>GeneralizedMorphismCategoryByCospans( SourceOfFunctor( </C><A>F</A><C> ) )</C>
#!  and <M>B := </M> <C>GeneralizedMorphismCategoryByCospans( RangeOfFunctor( </C><A>F</A><C> ) )</C>.
#! @Arguments F, name
DeclareOperation( "AsGeneralizedMorphismByCospan",
        [ IsCapFunctor, IsString ] );
