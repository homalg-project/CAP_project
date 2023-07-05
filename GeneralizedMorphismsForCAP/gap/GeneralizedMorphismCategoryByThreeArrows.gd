# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Declarations
#

#! @Chapter Generalized Morphism Category by Three Arrows

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of the category of
#! generalized morphisms by three arrows.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphismCategoryByThreeArrows",
                 IsGeneralizedMorphismCategory );

#! @Description
#! The GAP category of objects in the
#! generalized morphism category by three arrows.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphismCategoryByThreeArrowsObject",
                 IsGeneralizedMorphismCategoryObject );

#! @Description
#! The GAP category of morphisms in the
#! generalized morphism category by three arrows.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphismByThreeArrows",
                 IsGeneralizedMorphism );

####################################
##
## Technical stuff
##
####################################

DeclareFilter( "WasCreatedAsGeneralizedMorphismCategoryByThreeArrows" );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_BY_THREE_ARROWS_CATEGORY" );

####################################
##
#! @Section Properties
##
####################################

#! @Description
#! The argument is a generalized morphism $\alpha$ by
#! three arrows $a \leftarrow b \rightarrow c \leftarrow d$.
#! The output is <C>true</C> if $a \leftarrow b$ and $c \leftarrow d$
#! are congruent to identity morphisms,
#! <C>false</C> otherwise.
#! @Arguments alpha
DeclareProperty( "HasIdentitiesAsReversedArrows",
                 IsGeneralizedMorphismByThreeArrows );

#! @Description
#! The argument is a generalized morphism $\alpha$ by
#! three arrows $a \leftarrow b \rightarrow c \leftarrow d$.
#! The output is <C>true</C> if $a \leftarrow b$
#! is congruent to an identity morphism,
#! <C>false</C> otherwise.
#! @Arguments alpha
DeclareProperty( "HasIdentityAsSourceAid",
                 IsGeneralizedMorphismByThreeArrows );

#! @Description
#! The argument is a generalized morphism $\alpha$ by
#! three arrows $a \leftarrow b \rightarrow c \leftarrow d$.
#! The output is <C>true</C> if $c \leftarrow d$
#! is congruent to an identity morphism,
#! <C>false</C> otherwise.
#! @Arguments alpha
DeclareProperty( "HasIdentityAsRangeAid",
                 IsGeneralizedMorphismByThreeArrows );

InstallTrueMethod( HasIdentitiesAsReversedArrows, HasIdentityAsRangeAid and HasIdentityAsSourceAid );

InstallTrueMethod( HasIdentityAsRangeAid, HasIdentitiesAsReversedArrows );

InstallTrueMethod( HasIdentityAsSourceAid, HasIdentitiesAsReversedArrows );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is an object $a$ in the generalized morphism category by three arrows.
#! The output is its underlying honest object.
#! @Returns an object in $\mathbf{A}$
#! @Arguments a
DeclareAttribute( "UnderlyingHonestObject",
                  IsGeneralizedMorphismCategoryByThreeArrowsObject );

#! @Description
#! The argument is a generalized morphism $\alpha$ by
#! three arrows $a \leftarrow b \rightarrow c \leftarrow d$.
#! The output is its source aid $a \leftarrow b$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}(b,a)$
#! @Arguments alpha
DeclareAttribute( "SourceAid",
                  IsGeneralizedMorphismByThreeArrows );

#! @Description
#! The argument is a generalized morphism $\alpha$ by
#! three arrows $a \leftarrow b \rightarrow c \leftarrow d$.
#! The output is its range aid $c \leftarrow d$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}(d,c)$
#! @Arguments alpha
DeclareAttribute( "RangeAid",
                   IsGeneralizedMorphismByThreeArrows );

#! @Description
#! The argument is a generalized morphism $\alpha$ by
#! three arrows $a \leftarrow b \rightarrow c \leftarrow d$.
#! The output is its range aid $b \rightarrow c$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}(b,c)$
#! @Arguments alpha
DeclareAttribute( "Arrow",
                  IsGeneralizedMorphismByThreeArrows );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$ by
#! three arrows.
#! The output is its pseudo inverse $b \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,a)$
#! @Arguments alpha
DeclareAttribute( "PseudoInverse",
                  IsGeneralizedMorphismByThreeArrows );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b \in \mathbf{A}$.
#! The output is its generalized inverse $b \rightarrow a$ by three arrows.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,a)$
#! @Arguments alpha
DeclareAttribute( "GeneralizedInverseByThreeArrows",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a subobject $\alpha: a \hookrightarrow b \in \mathbf{A}$.
#! The output is the idempotent $b \rightarrow b \in \mathbf{G(A)}$ by three arrows
#! defined by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,b)$
#! @Arguments alpha
DeclareAttribute( "IdempotentDefinedBySubobjectByThreeArrows",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a factorobject $\alpha: b \twoheadrightarrow a \in \mathbf{A}$.
#! The output is the idempotent $b \rightarrow b \in \mathbf{G(A)}$ by three arrows
#! defined by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,b)$
#! @Arguments alpha
DeclareAttribute( "IdempotentDefinedByFactorobjectByThreeArrows",
                  IsCapCategoryMorphism );

## TODO: Write reference in the context of the Serre quotient category
DeclareAttribute( "SubcategoryMembershipFunctionForGeneralizedMorphismCategoryByThreeArrows",
                  IsCapCategory );

####################################
##
#! @Section Operations
##
####################################

#! @Description
#! The arguments are a a factorobject $\beta: b \twoheadrightarrow c$,
#! and a subobject $\alpha: a \hookrightarrow b$.
#! The output is the generalized morphism by three arrows from the factorobject to the subobject.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(c,a)$
#! @Arguments beta, alpha
DeclareOperation( "GeneralizedMorphismFromFactorToSubobjectByThreeArrows",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The argument is a list $L$ of generalized morphisms by three arrows
#! having the same range.
#! The output is a list of generalized morphisms by three arrows
#! which is the comman coastriction of $L$.
#! @Returns a list of generalized morphisms
#! @Arguments L
DeclareOperation( "CommonCoastriction",
                  [ IsList ] );

DeclareOperation( "CommonCoastrictionOp",
                  [ IsList, IsCapCategoryMorphism ] );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The arguments are morphisms 
#! $\alpha: a \leftarrow b$,
#! $\beta: b \rightarrow c$,
#! and $\gamma: c \leftarrow d$ in $\mathbf{A}$.
#! The output is a generalized morphism by three arrows
#! with source aid $\alpha$, arrow $\beta$, and range aid $\gamma$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(a,d)$
#! @Arguments alpha, beta, gamma
DeclareOperation( "GeneralizedMorphismByThreeArrows",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

## Compatibility (non-canonical)
DeclareOperation( "GeneralizedMorphismByThreeArrows",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are morphisms 
#! $\alpha: a \leftarrow b$,
#! and $\beta: b \rightarrow c$ in $\mathbf{A}$.
#! The output is a generalized morphism by three arrows
#! defined by the composition of the given two arrows
#! regarded as generalized morphisms.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(a,c)$
#! @Arguments alpha, beta
DeclareOperation( "GeneralizedMorphismByThreeArrowsWithSourceAid",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are morphisms 
#! $\beta: b \rightarrow c$,
#! and $\gamma: c \leftarrow d$ in $\mathbf{A}$.
#! The output is a generalized morphism by three arrows
#! defined by the composition of the given two arrows
#! regarded as generalized morphisms.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,d)$
#! @Arguments beta, gamma
DeclareOperation( "GeneralizedMorphismByThreeArrowsWithRangeAid",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$ in $\mathbf{A}$.
#! The output is the honest generalized morphism by three arrows defined by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(a,b)$
#! @Arguments alpha
DeclareAttribute( "AsGeneralizedMorphismByThreeArrows",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an abelian category $\mathbf{A}$.
#! The output is its generalized morphism category $\mathbf{G(A)}$ by three arrows.
#! @Returns a category
#! @Arguments A
DeclareAttribute( "GeneralizedMorphismCategoryByThreeArrows",
                  IsCapCategory );

#! @Description
#! The argument is an object $a$ in an abelian category $\mathbf{A}$.
#! The output is the object in the generalized morphism category by three arrows
#! whose underlying honest object is $a$.
#! @Returns an object in $\mathbf{G(A)}$
#! @Arguments a
DeclareAttribute( "GeneralizedMorphismByThreeArrowsObject",
                  IsCapCategoryObject );
