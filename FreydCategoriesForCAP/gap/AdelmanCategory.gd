# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Adelman category

#! Let $A$ be an additive category.
#! The Adelman category of $A$ is the free abelian category induced by $A$.
#! An object $x$ of the Adelman category of $A$ consists of a composable pair
#! $(\rho: a \rightarrow b, \gamma: b \rightarrow c)$
#! in $A$.
#! We call $\rho$ the <Emph>relation morphism</Emph>,
#! and $\gamma$ the <Emph>corelation morphism</Emph> of $x$.
#!
#! Given two objects
#! $x = (\rho: a \rightarrow b, \gamma: b \rightarrow c)$
#! and
#! $y = (\rho': a' \rightarrow b', \gamma': b' \rightarrow c')$,
#! a morphism $\alpha$ from $x$ to $y$ in the Adelman category of $A$ consists of
#! a morphism $\beta: b \rightarrow b'$,
#! called the <Emph>morphism datum</Emph>,
#! that has to fit into some commutative diagram of the form

#! @BeginLatexOnly
#! \begin{center}
#!      \begin{tikzpicture}
#!           \coordinate (r) at (3,0);
#!           \coordinate (d) at (0,-2);
#!           \node (A) {$a$};
#!           \node (B) at ($(A)+(r)$) {$b$};
#!           \node (C) at ($(B) + (r)$) {$c$};
#!           \node (A2) at ($(A)+(d)$) {$a'$};
#!           \node (B2) at ($(B)+(d)$) {$b'$};
#!           \node (C2) at ($(C)+(d)$) {$c'$};
#!           \draw[->,thick] (A) to node[above]{$\rho$} (B);
#!           \draw[->,thick] (B) to node[above]{$\gamma$}(C);
#!           \draw[->,thick] (A2) to node[above]{$\rho'$} (B2);
#!           \draw[->,thick] (B2) to node[above]{$\gamma'$}(C2);
#!           \draw[->,thick] (B) to node[left]{$\beta$}(B2);
#!           \draw[->,thick] (A) to node[left]{$\omega$}(A2);
#!           \draw[->,thick] (C) to node[right]{$\psi$}(C2);
#!     \end{tikzpicture}
#!   \end{center}
#! @EndLatexOnly

#! Any such morphism $\omega$ is called a <Emph>relation witness</Emph>,
#! any such morphism $\psi$ is called a <Emph>corelation witness</Emph>.

#! Two morphisms between $x$ and $y$ with morphism data $\beta$ and $\beta'$
#! are congruent iff there exists
#! $\sigma_1: b \rightarrow a'$ and $\sigma_2: c \rightarrow b'$ such that
#! $\beta - \beta' = \sigma_1 \cdot \rho' + \gamma \cdot \sigma_2$.
#! We call any such pair $(\sigma_1, \sigma_2)$ a <Emph>witness pair</Emph> for $\beta, \beta'$ being congruent.

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The &GAP; category of objects of an Adelman category.
#! Every object of an Adelman category
#! lies in this &GAP; category.
#! @Arguments a
DeclareCategory( "IsAdelmanCategoryObject",
                 IsCapCategoryObject );

#! @Description
#! The &GAP; category of morphisms of an Adelman category.
#! Every morphism of an Adelman category
#! lies in this &GAP; category.
#! @Arguments alpha
DeclareCategory( "IsAdelmanCategoryMorphism",
                 IsCapCategoryMorphism );

#! @Description
#! The &GAP; category of Adelman categories.
#! Every CAP category which was created as an Adelman category
#! lies in this &GAP; category.
#! @Arguments C
DeclareCategory( "IsAdelmanCategory",
                 IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_ADELMAN_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The argument is an additive CAP category $A$.
#! The output is the Adelman category of $A$.
#! @Returns a category
#! @Arguments A
DeclareAttribute( "AdelmanCategory",
                  IsCapCategory );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow b$, $\beta: b \rightarrow c$
#! of the same additive category $A$.
#! The output is an object in the Adelman category of $A$
#! whose relation morphism is $\alpha$ and whose corelation morphism is $\beta$.
#! @Returns an object
#! @Arguments alpha, beta
DeclareOperation( "AdelmanCategoryObject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! Let $A$ be an additive category.
#! The arguments are
#! an object $x$ in the Adelman category of $A$,
#! a morphism $\alpha: a \rightarrow b$ of $A$,
#! and an object $y$ in the Adelman category of $A$.
#! The output is a morphism in the Adelman category of $A$
#! whose morphism datum is given by $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}(x, y)$
#! @Arguments x, alpha, y
DeclareOperation( "AdelmanCategoryMorphism",
                  [ IsAdelmanCategoryObject, IsCapCategoryMorphism, IsAdelmanCategoryObject ] );

#! @Description
#! The argument is an object $a$ of an additive category $A$.
#! The output is an object in the Adelman category of $A$
#! whose relation morphism is $0 \rightarrow a$
#! and whose corelation morphism is $a \rightarrow 0$.
#! @Returns an object
#! @Arguments a
DeclareAttribute( "AsAdelmanCategoryObject",
                  IsCapCategoryObject );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$ of an additive category $A$.
#! The output is a morphism in the Adelman category of $A$
#! whose source $x$ is
#! <C>AsAdelmanCategoryObject( a )</C>,
#! whose range $y$ is
#! <C>AsAdelmanCategoryObject( b )</C>,
#! and whose morphism datum is $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}( x, y )$
#! @Arguments alpha
DeclareAttribute( "AsAdelmanCategoryMorphism",
                  IsCapCategoryMorphism );

#! @Description
#! This is a convenience method.
#! The first argument is an object $a$
#! which either lies in an additive category $A$ (which was not created as a Freyd category)
#! or in a Freyd category $F$ of an underlying additive category $A$.
#! The second argument is an Adelman category $C$ of $A$.
#! If $a$ lies in $A$
#! this method returns <C>AsAdelmanCategoryObject( a )</C>.
#! If $a$ lies in $F$,
#! this method return an object in $C$ whose relation morphism is the same as the relation
#! morphism of $a$, and whose corelation morphism is $0$.
#! @Returns an object
#! @Arguments a, C
DeclareOperation( "\/",
                  [ IsCapCategoryObject, IsAdelmanCategory ] );

#! @Description
#! This is a convenience method.
#! The first argument is a morphism $\alpha$
#! which lies in an additive category $A$.
#! The second argument is an Adelman category $C$ of $A$.
#! This method returns <C>AsAdelmanCategoryMorphism( alpha )</C>.
#! We set $x = \mathrm{ AsAdelmanCategoryObject( Source( \alpha ) ) }$
#! and $y = \mathrm{ AsAdelmanCategoryObject( Range( \alpha ) ) }$.
#! @Returns a morphism in $\mathrm{Hom}( x, y )$
#! @Arguments alpha, C
DeclareOperation( "\/",
                  [ IsCapCategoryMorphism, IsAdelmanCategory ] );

####################################
##
#! @Section Functors and natural transformations
##
####################################

DeclareAttribute( "AdelmanCategoryFunctorInducedByUniversalProperty",
                  IsCapFunctor );

DeclareAttribute( "EmbeddingFunctorOfFreydCategoryIntoAdelmanCategory",
                  IsCapCategory );

DeclareAttribute( "RightSatelliteAsEndofunctorOfAdelmanCategory",
                  IsCapCategory );

DeclareAttribute( "LeftSatelliteAsEndofunctorOfAdelmanCategory",
                  IsCapCategory );

DeclareAttribute( "UnitOfSatelliteAdjunctionOfAdelmanCategory",
                  IsCapCategory );

DeclareAttribute( "CounitOfSatelliteAdjunctionOfAdelmanCategory",
                  IsCapCategory );

DeclareAttribute( "ProjectionFunctorAdelmanCategoryToFreydCategory",
                  IsCapCategory );

####################################
##
#! @Section Attributes and Properties
##
####################################

#! @Description
#! The argument is an Adelman category $C$.
#! The output is its underlying category $A$ with which it was constructed.
#! @Returns a category
#! @Arguments C
DeclareAttribute( "UnderlyingCategory",
                  IsAdelmanCategory );

#! @Description
#! The argument is an object $x$ in an Adelman category.
#! The output is its relation morphism $\rho: a \rightarrow b$.
#! @Returns a morphism in $\mathrm{Hom}( a, b )$
#! @Arguments x
DeclareAttribute( "RelationMorphism",
                  IsAdelmanCategoryObject );

CapJitAddTypeSignature( "RelationMorphism", [ IsAdelmanCategoryObject ], function ( input_types )
    
    Assert( 0, IsAdelmanCategory( input_types[1].category ) );
    
    return rec( filter := UnderlyingCategory( input_types[1].category )!.morphism_representation, category := UnderlyingCategory( input_types[1].category ) );
    
end );

#! @Description
#! The argument is an object $x$ in an Adelman category.
#! The output is its corelation morphism $\gamma: b \rightarrow c$.
#! @Returns a morphism in $\mathrm{Hom}( b, c )$
#! @Arguments x
DeclareAttribute( "CorelationMorphism",
                  IsAdelmanCategoryObject );

CapJitAddTypeSignature( "CorelationMorphism", [ IsAdelmanCategoryObject ], function ( input_types )
    
    Assert( 0, IsAdelmanCategory( input_types[1].category ) );
    
    return rec( filter := UnderlyingCategory( input_types[1].category )!.morphism_representation, category := UnderlyingCategory( input_types[1].category ) );
    
end );

#! @Description
#! The argument is a morphism $\alpha$ in an Adelman category.
#! The output is its morphism datum $\beta: b \rightarrow b'$.
#! @Returns a morphism in $\mathrm{Hom}( b, b' )$
#! @Arguments alpha
DeclareAttribute( "MorphismDatum",
                  IsAdelmanCategoryMorphism );

CapJitAddTypeSignature( "MorphismDatum", [ IsAdelmanCategoryMorphism ], function ( input_types )
    
    Assert( 0, IsAdelmanCategory( input_types[1].category ) );
    
    return rec( filter := UnderlyingCategory( input_types[1].category )!.morphism_representation, category := UnderlyingCategory( input_types[1].category ) );
    
end );

#! @Description
#! The argument is a morphism $\alpha$ in an Adelman category.
#! The output is its relation witness $\omega: a \rightarrow a'$.
#! @Returns a morphism in $\mathrm{Hom}( a, a' )$
#! @Arguments alpha
DeclareAttribute( "RelationWitness",
                  IsAdelmanCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha$ in an Adelman category.
#! The output is its corelation witness $\psi: c \rightarrow c'$.
#! @Returns a morphism in $\mathrm{Hom}( c, c' )$
#! @Arguments alpha
DeclareAttribute( "CorelationWitness",
                  IsAdelmanCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha$ congruent to zero in an Adelman category.
#! The output is a witness pair.
#! @Returns a list of morphisms
#! @Arguments alpha
DeclareAttribute( "WitnessPairForBeingCongruentToZero",
                  IsAdelmanCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha$ in an Adelman category.
#! The output is `true` if $\alpha$ is congruent to zero, else `false`.
#! @Returns a boolean
#! @Arguments alpha
DeclareAttribute( "MereExistenceOfWitnessPairForBeingCongruentToZero",
                  IsAdelmanCategoryMorphism );

DeclareOperation( "HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding",
                  [ IsAdelmanCategoryObject, IsAdelmanCategoryObject ] );

#! @Description
#! The argument is an object $x$ in an Adelman category.
#! The output is <C>true</C> if the composition of its relation morphism and its corelation morphism yields zero.
#! Otherwise, the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments x
DeclareProperty( "IsSequenceAsAdelmanCategoryObject",
                  IsAdelmanCategoryObject );
