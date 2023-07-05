# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Declarations
#

#! @Chapter Generalized Morphism Category

#! Let $\mathbf{A}$ be an abelian category.
#! We denote its generalized morphism category by $\mathbf{G(A)}$.

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of the category of
#! generalized morphisms.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphismCategory",
                 IsCapCategory );

#! @Description
#! The GAP category of objects in the
#! generalized morphism category.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphismCategoryObject",
                 IsCapCategoryObject );

#! @Description
#! The GAP category of morphisms in the
#! generalized morphism category.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphism",
                 IsCapCategoryMorphism );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is an object $a$ in the generalized morphism category.
#! The output is its underlying honest object
#! @Returns an object in $\mathbf{A}$
#! @Arguments a
DeclareAttribute( "UnderlyingHonestObject",
                  IsGeneralizedMorphismCategoryObject );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is its domain $d \hookrightarrow a \in \mathbf{A}$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}( d, a )$
#! @Arguments alpha
DeclareAttribute( "DomainEmbedding",
                  IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is its generalized image $i \hookrightarrow b \in \mathbf{A}$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}( i, b )$
#! @Arguments alpha
DeclareAttribute( "GeneralizedImageEmbedding",
                  IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is its defect $d \hookrightarrow b \in \mathbf{A}$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}( d, b )$
#! @Arguments alpha
DeclareAttribute( "DefectEmbedding",
                  IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is its generalized kernel $k \hookrightarrow a \in \mathbf{A}$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}( k, a )$
#! @Arguments alpha
DeclareAttribute( "GeneralizedKernelEmbedding",
                  IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is its codomain $b \twoheadrightarrow c \in \mathbf{A}$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}( b, c )$
#! @Arguments alpha
DeclareAttribute( "CodomainProjection",
                  IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is its generalized cokernel $b \twoheadrightarrow c \in \mathbf{A}$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}( b, c )$
#! @Arguments alpha
DeclareAttribute( "GeneralizedCokernelProjection",
                  IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is its codefect $a \twoheadrightarrow c \in \mathbf{A}$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}( a, c )$
#! @Arguments alpha
DeclareAttribute( "CodefectProjection",
                  IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is its generalized coimage $a \twoheadrightarrow c \in \mathbf{A}$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}( a, c )$
#! @Arguments alpha
DeclareAttribute( "GeneralizedCoimageProjection",
                  IsGeneralizedMorphism );
                  
#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is its associated morphism $d \rightarrow c \in \mathbf{A}$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}( d, c )$
#! @Arguments alpha
DeclareAttribute( "AssociatedMorphism",
                  IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is a triple $( d \hookrightarrow a, d \rightarrow c, b \twoheadrightarrow c )$
#! consisting of its domain, associated morphism, and codomain.
#! @Returns a triple of morphisms in $\mathbf{A}$
#! @Arguments alpha
DeclareAttribute( "DomainAssociatedMorphismCodomainTriple",
                  IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is the honest representative in $\mathbf{A}$ of $\alpha$,
#! if it exists, otherwise an error is thrown.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}( a, b )$
#! @Arguments alpha
DeclareAttribute( "HonestRepresentative",
                  IsGeneralizedMorphism );

##
## When calling this method on a generalized morphism, the effect
## differs from the effect of PseudoInverse.
#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b \in \mathbf{A}$.
#! The output is its generalized inverse $b \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,a)$
#! @Arguments alpha
DeclareOperation( "GeneralizedInverse",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The argument is a subobject $\alpha: a \hookrightarrow b \in \mathbf{A}$.
#! The output is the idempotent $b \rightarrow b \in \mathbf{G(A)}$
#! defined by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,b)$
#! @Arguments alpha
DeclareOperation( "IdempotentDefinedBySubobject",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The argument is a factorobject $\alpha: b \twoheadrightarrow a \in \mathbf{A}$.
#! The output is the idempotent $b \rightarrow b \in \mathbf{G(A)}$
#! defined by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,b)$
#! @Arguments alpha
DeclareOperation( "IdempotentDefinedByFactorobject",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The argument is a generalized morphism category $C = \mathbf{G(A)}$.
#! The output is $\mathbf{A}$.
#! @Returns a category
#! @Arguments C
DeclareAttribute( "UnderlyingHonestCategory",
                  IsCapCategory );

####################################
##
#! @Section Operations
##
####################################

#! @Description
#! The arguments are a a factorobject $\beta: b \twoheadrightarrow c$,
#! and a subobject $\alpha: a \hookrightarrow b$.
#! The output is the generalized morphism from the factorobject to the subobject.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(c,a)$
#! @Arguments beta, alpha
DeclareOperation( "GeneralizedMorphismFromFactorToSubobject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The argument is a list $L$ of generalized morphisms by three arrows
#! having the same source.
#! The output is a list of generalized morphisms by three arrows
#! which is the comman restriction of $L$.
#! @Returns a list of generalized morphisms
#! @Arguments L
DeclareOperation( "CommonRestriction",
                  [ IsList ] );

DeclareOperation( "CommonRestrictionOp",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The argument is a list $L = ( \alpha_1, \dots, \alpha_n )$ of generalized morphisms
#! (with same data structures).
#! The output is their concatenation product, i.e.,
#! a generalized morphism $\alpha$ with
#! $\mathrm{UnderlyingHonestObject}( \mathrm{Source}( \alpha ) ) = \bigoplus_{i=1}^n \mathrm{UnderlyingHonestObject}( \mathrm{Source}( \alpha_i ) )$,
#! and
#! $\mathrm{UnderlyingHonestObject}( \mathrm{Range}( \alpha ) ) = \bigoplus_{i=1}^n \mathrm{UnderlyingHonestObject}( \mathrm{Range}( \alpha_i ) )$,
#! and with morphisms in the representation of $\alpha$ given
#! as the direct sums of the corresponding morphisms of the $\alpha_i$.
#! @Returns a generalized moprhism
#! @Arguments L
DeclareOperation( "ConcatenationProduct",
                  [ IsList ] );

DeclareOperation( "ConcatenationProductOp",
                  [ IsList, IsCapCategoryMorphism ] );


####################################
##
#! @Section Properties
##
####################################

#! @Description
#! The argument is a generalized morphism $\alpha$.
#! The output is <C>true</C> if $\alpha$ admits an honest representative,
#! otherwise <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsHonest",
                  IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha$.
#! The output is <C>true</C> if the domain of $\alpha$ is an isomorphism,
#! otherwise <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "HasFullDomain",
                 IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha$.
#! The output is <C>true</C> if the codomain of $\alpha$ is an isomorphism,
#! otherwise <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "HasFullCodomain",
                 IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha$.
#! The output is <C>true</C> if the codomain of $\alpha$ is an isomorphism,
#! otherwise <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsSingleValued",
                 IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha$.
#! The output is <C>true</C> if the domain of $\alpha$ is an isomorphism,
#! otherwise <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsTotal",
                 IsGeneralizedMorphism );

####################################
##
#! @Section Convenience methods
##
####################################

#! This section contains operations which, depending on the current generalized morphism
#! standard of the system and the category, might point to other Operations. Please use them
#! only as convenience and never in serious code.

#! @Description
#!  Creates a new category of generalized morphisms. Might point to
#!  GeneralizedMorphismCategoryByThreeArrows, GeneralizedMorphismCategoryByCospans, or
#!  GeneralizedMorphismCategoryBySpans
#! @Returns a category
#! @Arguments C
DeclareOperation( "GeneralizedMorphismCategory",
                  [ IsCapCategory ] );

#! @Description
#!  Creates an object in the current generalized morphism category, depending on the standard
#! @Returns an object in the generalized morphism category
#! @Arguments A
DeclareOperation( "GeneralizedMorphismObject",
                  [ IsCapCategoryObject ] );

#! @Description
#!  Returns the corresponding morphism to phi in the current generalized morphism category.
#! @Returns a generalized morphism
#! @Arguments phi
DeclareOperation( "AsGeneralizedMorphism",
                  [ IsCapCategoryMorphism ] );

#! @Description
#!  Returns the corresponding morphism to phi and psi in the current generalized morphism category.
#! @Returns a generalized morphism
#! @Arguments phi, psi
DeclareOperation( "GeneralizedMorphism",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#!  Returns the corresponding morphism to iota, phi and psi in the current generalized morphism category.
#! @Returns a generalized morphism
#! @Arguments iota, phi, pi
DeclareOperation( "GeneralizedMorphism",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#!  Returns a generalized morphism with range aid by three arrows or by span, or a generalized morphism
#!  by cospan, depending on the standard.
DeclareOperation( "GeneralizedMorphismWithRangeAid",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#!  Returns a generalized morphism with source aid by three arrows or by cospan, or a generalized morphism
#!  by span, depending on the standard.
DeclareOperation( "GeneralizedMorphismWithSourceAid",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

####################################
##
#! @Section Tools to propagate attributes
##
####################################

DeclareGlobalVariable( "PROPAGATION_LIST_FROM_GENERALIZED_TO_ASSOCIATED_MORPHISM" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_FROM_GENERALIZED_TO_ASSOCIATED_MORPHISM" );
