#############################################################################
##
##                  GeneralizedMorphismsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Generalized Morphism Category
##
#############################################################################

#! Let $\mathbf{A}$ be an abelian category.
#! We denote its generalized morphism category by $\mathbf{G(A)}$.

####################################
##
#! @Section GAP Categories
##
####################################

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
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is its domain $d \hookrightarrow a \in \mathbf{A}$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}( d, a )$
#! @Arguments alpha
DeclareAttributeWithToDoForIsWellDefined( "DomainOfGeneralizedMorphism",
                                          IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is its codomain $b \twoheadrightarrow c \in \mathbf{A}$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}( b, c )$
#! @Arguments alpha
DeclareAttributeWithToDoForIsWellDefined( "Codomain",
                                          IsGeneralizedMorphism );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$.
#! The output is its associated morphism $d \rightarrow c \in \mathbf{A}$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}( d, c )$
#! @Arguments alpha
DeclareAttributeWithToDoForIsWellDefined( "AssociatedMorphism",
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
DeclareAttributeWithToDoForIsWellDefined( "HonestRepresentative",
                                          IsGeneralizedMorphism );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b \in \mathbf{A}$.
#! The output is its generalized inverse $b \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,a)$
#! @Arguments alpha
DeclareAttribute( "GeneralizedInverse",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a subobject $\alpha: a \hookrightarrow b \in \mathbf{A}$.
#! The output is the idempotent $b \rightarrow b \in \mathbf{G(A)}$
#! defined by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,b)$
#! @Arguments alpha
DeclareAttribute( "IdempotentDefinedBySubobject",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a factorobject $\alpha: b \twoheadrightarrow a \in \mathbf{A}$.
#! The output is the idempotent $b \rightarrow b \in \mathbf{G(A)}$
#! defined by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,b)$
#! @Arguments alpha
DeclareAttribute( "IdempotentDefinedByFactorobject",
                  IsCapCategoryMorphism );

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
