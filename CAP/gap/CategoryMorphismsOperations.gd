# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Morphisms

###################################
##
#! @Section Morphism constructors
##
###################################

#! @Description
#! The arguments are two objects $S$ and $T$ in a category,
#! and a morphism datum $a$ (type and semantics of the morphism datum depend on the category).
#! The output is a morphism in $\mathrm{Hom}(S,T)$ defined by $a$.
#! Note that by default this CAP operation is not cached. You can change this behaviour
#! by calling `SetCachingToWeak( C, "MorphismConstructor" )` resp. `SetCachingToCrisp( C, "MorphismConstructor" )`.
#! @Returns a morphism in $\mathrm{Hom}(S,T)$
#! @Arguments S, a, T
DeclareOperation( "MorphismConstructor",
                  [ IsCapCategoryObject, IsObject, IsCapCategoryObject ] );

#! @Description
#! The argument is a CAP category morphism <A>mor</A>.
#! The output is a datum which can be used to construct <A>mor</A>, that is,
#! `IsEqualForMorphisms( `<A>mor</A>`, MorphismConstructor( Source( `<A>mor</A>` ), MorphismDatum( `<A>mor</A>` ), Range( `<A>mor</A>` ) ) )`.
#! Note that by default this CAP operation is not cached. You can change this behaviour
#! by calling `SetCachingToWeak( C, "MorphismDatum" )` resp. `SetCachingToCrisp( C, "MorphismDatum" )`.
#! @Returns depends on the category
#! @Arguments mor
DeclareAttribute( "MorphismDatum",
                  IsCapCategoryMorphism );

###################################
##
#! @Section Categorical Properties of Morphisms
##
###################################

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is <C>true</C> if $\alpha$ is a monomorphism,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsMonomorphism",
                 IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is <C>true</C> if $\alpha$ is an epimorphism,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsEpimorphism",
                 IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is <C>true</C> if $\alpha$ is an isomorphism,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsIsomorphism",
                 IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is <C>true</C> if $\alpha$ is a split monomorphism,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsSplitMonomorphism",
                 IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is <C>true</C> if $\alpha$ is a split epimorphism,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsSplitEpimorphism",
                 IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow a$.
#! The output is <C>true</C> if $\alpha$ is congruent to the identity of $a$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsOne",
                 IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow a$.
#! The output is <C>true</C> if $\alpha^2 \sim_{a,a} \alpha$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsIdempotent",
                 IsCapCategoryMorphism );

###################################
##
#! @Section Random Morphisms
##
###################################

#! CAP provides two principal methods to generate random morphisms with or without fixed source and range:
#!  * <E>By integers</E>: The integer is simply a parameter that can be used to create a random morphism.
#!  * <E>By lists</E>: The list is used when creating a random morphism would need more than one parameter. Lists offer more
#!    flexibility at the expense of the genericity of the methods. This happens because lists that are valid as input in
#!    some category may be not valid for other categories. Hence, these operations are not thought to be used in
#!    generic categorical algorithms.

#! @Description
#! The arguments are an object $a$ in a category $C$ and an integer $n$.
#! The output is a random morphism $\alpha: a \rightarrow b$ for some object $b$ in $C$.
#! If $C$ is equipped with the methods <C>RandomObjectByInteger</C> and <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>
#! and $C$ is an Ab-category, then <C>RandomMorphismWithFixedSourceByInteger</C>$(C,a,n)$ can be derived as
#! <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>($C$,$a$,$b$,$1$+<C>Log2Int</C>($n$)) where
#! $b$ is computed via <C>RandomObjectByInteger</C>($C$,$n$).
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments a, n
DeclareOperation( "RandomMorphismWithFixedSourceByInteger",
                  [ IsCapCategoryObject, IsInt ] );

#! @Description
#! The arguments are an object $a$ in a category $C$ and a list $L$.
#! The output is a random morphism $\alpha: a \rightarrow b$ for some object $b$ in $C$.
#! If $C$ is equipped with the methods <C>RandomObjectByList</C> and <C>RandomMorphismWithFixedSourceAndRangeByList</C>
#! and $C$ is an Ab-category, then <C>RandomMorphismWithFixedSourceByList</C>$(C,a,L)$ can be derived as
#! <C>RandomMorphismWithFixedSourceAndRangeByList</C>($C,a,b,L[2]$) where
#! $b$ is computed via <C>RandomObjectByList</C>($C,L[1]$).
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments a, L
DeclareOperation( "RandomMorphismWithFixedSourceByList",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $b$ in a category $C$ and an integer $n$.
#! The output is a random morphism $\alpha: a \rightarrow b$ for some object $a$ in $C$.
#! If $C$ is equipped with the methods <C>RandomObjectByInteger</C> and <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>
#! and $C$ is an Ab-category, then <C>RandomMorphismWithFixedRangeByInteger</C>$(C,b,n)$ can be derived as
#! <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>($C$,$a$,$b$,$1$+<C>Log2Int</C>($n$)) where
#! $a$ is computed via <C>RandomObjectByInteger</C>($C$,$n$).
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments b, n
DeclareOperation( "RandomMorphismWithFixedRangeByInteger",
                  [ IsCapCategoryObject, IsInt ] );

#! @Description
#! The arguments are an object $b$ in a category $C$ and a list $L$.
#! The output is a random morphism $\alpha: a \rightarrow b$ for some object $a$ in $C$.
#! If $C$ is equipped with the methods <C>RandomObjectByList</C> and <C>RandomMorphismWithFixedSourceAndRangeByList</C>
#! and $C$ is an Ab-category, then <C>RandomMorphismWithFixedRangeByList</C>$(C,b,L)$ can be derived as
#! <C>RandomMorphismWithFixedSourceAndRangeByList</C>($C,a,b,L[2]$) where
#! $a$ is computed via <C>RandomObjectByList</C>($C,L[1]$).
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments b, L
DeclareOperation( "RandomMorphismWithFixedRangeByList",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are two objects $a$ and $b$ in a category $C$ and an integer $n$.
#! The output is a random morphism $\alpha: a \rightarrow b$ in $C$.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments a, b, n
DeclareOperation( "RandomMorphismWithFixedSourceAndRangeByInteger",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsInt ] );

#! @Description
#! This operation is not a CAP basic operation
#! The arguments are two objects $a$ and $b$ in a category $C$ and a list $L$.
#! The output is a random morphism $\alpha: a \rightarrow b$ in $C$.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments a, b, L
DeclareOperation( "RandomMorphismWithFixedSourceAndRangeByList",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a category $C$ and an integer $n$.
#! The output is a random morphism in $C$.
#! The operation can be derived in three different ways:
#! - If $C$ is equipped with the methods <C>RandomObjectByInteger</C> and <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>
#!   and $C$ is an Ab-category, then <C>RandomMorphism</C>$(C,n)$ can be derived as
#!   <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>($C,a,b$,$1$+<C>Log2Int</C>($n$)) where
#!   $a$ and $b$ are computed via <C>RandomObjectByInteger</C>($C,n$).
#! - If $C$ is equipped with the methods <C>RandomObjectByInteger</C> and <C>RandomMorphismWithFixedSourceByInteger</C>,
#!   then <C>RandomMorphism</C>$(C,n)$ can be derived as
#!   <C>RandomMorphismWithFixedSourceByInteger</C>($C,a,1$+<C>Log2Int</C>($n$)) where
#!   $a$ is computed via <C>RandomObjectByInteger</C>($C,n$).
#! - If $C$ is equipped with the methods <C>RandomObjectByInteger</C> and <C>RandomMorphismWithFixedRangeByInteger</C>,
#!   then <C>RandomMorphism</C>$(C,n)$ can be derived as
#!   <C>RandomMorphismWithFixedRangeByInteger</C>($C,b,1$+<C>Log2Int</C>($n$)) where
#!   $b$ is computed via <C>RandomObjectByInteger</C>($C,n$).
#! @Returns a morphism in $C$
#! @Arguments C, n
DeclareOperation( "RandomMorphismByInteger",
                  [ IsCapCategory, IsInt ] );

#! @Description
#! The arguments are a category $C$ and a list $L$.
#! The output is a random morphism in $C$.
#! The operation can be derived in three different ways:
#! - If $C$ is equipped with the methods <C>RandomObjectByList</C> and <C>RandomMorphismWithFixedSourceAndRangeByList</C>
#!   and $C$ is an Ab-category, then <C>RandomMorphism</C>$(C,L)$ can be derived as
#!   <C>RandomMorphismWithFixedSourceAndRangeByList</C>($C,a,b,L[3]$)) where
#!   $a$ and $b$ are computed via <C>RandomObjectByList</C>($C,L[i]$) for $i=1,2$ respectively.
#! - If $C$ is equipped with the methods <C>RandomObjectByList</C> and <C>RandomMorphismWithFixedSourceByList</C>,
#!   then <C>RandomMorphism</C>$(C,L)$ can be derived as
#!   <C>RandomMorphismWithFixedSourceByList</C>($C,a,L[2]$) where
#!   $a$ is computed via <C>RandomObjectByList</C>($C,L[1]$).
#! - If $C$ is equipped with the methods <C>RandomObjectByList</C> and <C>RandomMorphismWithFixedRangeByList</C>,
#!   then <C>RandomMorphism</C>$(C,L)$ can be derived as
#!   <C>RandomMorphismWithFixedRangeByList</C>($C,b,L[2]$) where
#!   $b$ is computed via <C>RandomObjectByList</C>($C,L[1]$).
#! @Returns a morphism in $C$
#! @Arguments C, L
DeclareOperation( "RandomMorphismByList",
                  [ IsCapCategory, IsList ] );

#! @BeginGroup
#! @Description
#! These are convenient methods and they, depending on the input, delegate to one of the above methods.
# @Returns an object, morphism in $C$
#! @Arguments a, n
DeclareOperation( "RandomMorphismWithFixedSource", [ IsCapCategoryObject, IsInt ] );
#! @Arguments a, L
DeclareOperation( "RandomMorphismWithFixedSource", [ IsCapCategoryObject, IsList ] );
#! @Arguments b, n
DeclareOperation( "RandomMorphismWithFixedRange", [ IsCapCategoryObject, IsInt ] );
#! @Arguments b, L
DeclareOperation( "RandomMorphismWithFixedRange", [ IsCapCategoryObject, IsList ] );
#! @Arguments a, b, n
DeclareOperation( "RandomMorphismWithFixedSourceAndRange", [ IsCapCategoryObject, IsCapCategoryObject, IsInt ] );
#! @Arguments a, b, L
DeclareOperation( "RandomMorphismWithFixedSourceAndRange", [ IsCapCategoryObject, IsCapCategoryObject, IsList ] );
#! @Arguments a, b, n
DeclareOperation( "RandomMorphism", [ IsCapCategoryObject, IsCapCategoryObject, IsInt ] );
#! @Arguments a, b, L
DeclareOperation( "RandomMorphism", [ IsCapCategoryObject, IsCapCategoryObject, IsList ] );
#! @Arguments C, n
DeclareOperation( "RandomMorphism", [ IsCapCategory, IsInt ] );
#! @Arguments C, L
DeclareOperation( "RandomMorphism", [ IsCapCategory, IsList ] );
#! @EndGroup

###################################
##
#! @Section Non-Categorical Properties of Morphisms
##
###################################

#! Non-categorical properties are not stable under equivalences of categories.

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is <C>true</C> if $\alpha = \mathrm{id}_a$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsEqualToIdentityMorphism",
                 IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is <C>true</C> if $\alpha = 0$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsEqualToZeroMorphism",
                 IsCapCategoryMorphism );

## This is not a categorical property because non-endomorphisms 
## can be mapped to endomorphisms under equivalences of categories.
#! @Description
#! The argument is a morphism $\alpha$.
#! The output is <C>true</C> if $\alpha$ is an endomorphism,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsEndomorphism",
                 IsCapCategoryMorphism );

## This is not a categorical property because non-endomorphisms 
## can be mapped to endomorphisms under equivalences of categories.
#! @Description
#! The argument is a morphism $\alpha$.
#! The output is <C>true</C> if $\alpha$ is an automorphism,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsAutomorphism",
                 IsCapCategoryMorphism );

###################################
##
#! @Section Equality and Congruence for Morphisms
##
###################################


#! @Description
#! The arguments are two morphisms $\alpha, \beta: a \rightarrow b$.
#! The output is <C>true</C> if $\alpha \sim_{a,b} \beta$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsCongruentForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );


#! @Description
#! The arguments are two morphisms $\alpha, \beta: a \rightarrow b$.
#! The output is <C>true</C> if $\alpha = \beta$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsEqualForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );


#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow b, \beta: c \rightarrow d$.
#! The output is <C>true</C> if $\alpha = \beta$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsEqualForMorphismsOnMor",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );


###################################
##
#! @Section Basic Operations for Morphisms in Ab-Categories
##
###################################

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is <C>true</C> if $\alpha \sim_{a,b} 0$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsZeroForMorphisms",
                 IsCapCategoryMorphism );

DeclareProperty( "IsZero", IsCapCategoryMorphism );

DeclareOperation( "+", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "-", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha, \beta: a \rightarrow b$.
#! The output is the addition $\alpha + \beta$.
#! Note: The addition has to be compatible with the congruence of morphisms.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments alpha, beta
DeclareOperation( "AdditionForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha, \beta: a \rightarrow b$.
#! The output is the addition $\alpha - \beta$.
#! Note: The addition has to be compatible with the congruence of morphisms.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments alpha, beta
DeclareOperation( "SubtractionForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its additive inverse $-\alpha$.
#! Note: The addition has to be compatible with the congruence of morphisms.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments alpha
DeclareAttribute( "AdditiveInverseForMorphisms",
                  IsCapCategoryMorphism );

DeclareAttribute( "AdditiveInverse",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are an element $r$ of a commutative ring
#! and a morphism $\alpha: a \rightarrow b$.
#! The output is the multiplication with the ring element $r \cdot \alpha$.
#! Note: The multiplication has to be compatible with the congruence of morphisms.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments r, alpha
DeclareOperation( "MultiplyWithElementOfCommutativeRingForMorphisms",
                  [ IsRingElement, IsCapCategoryMorphism ] );

#! @Description
#! This is a convenience method. It has two arguments.
#! The first argument is either a rational number $q$
#! or an element $r$ of a commutative ring $R$.
#! The second argument is a morphism $\alpha: a \rightarrow b$ in a linear category
#! over the commutative ring $R$.
#! In the case where the first element is a rational number, this method tries to interpret $q$ as an element $r$ of $R$ via
#! <C>R!.interpret_rationals_func</C>. If no such interpretation
#! exists, this method throws an error.
#! The output is the multiplication with the ring element $r \cdot \alpha$.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments r, alpha
DeclareOperation( "*",
                  [ IsRingElement, IsCapCategoryMorphism ] );

DeclareOperation( "*",
                  [ IsCapCategoryMorphism, IsRingElement ] );


###################################
##
## Zero Morphism
##
###################################

#! @Description
#! The arguments are two objects $a$ and $b$.
#! The output is the zero morphism $0: a \rightarrow b$.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments a, b
DeclareOperation( "ZeroMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );


###################################
##
#! @Section Subobject and Factorobject Operations
##
###################################

#! Subobjects of an object $c$ are monomorphisms
#! with range $c$ and a special function for comparision.
#! Similarly, factorobjects of an object $c$ are epimorphisms
#! with source $c$ and a special function for comparision.

## TODO
# @Description
# This is a synonym for <C>IsMonomorphism</C>.
DeclareSynonymAttr( "IsSubobject",
                    IsMonomorphism );

## TODO
# @Description
# This is a synonym for <C>IsEpimorphism</C>.
DeclareSynonymAttr( "IsFactorobject",
                    IsEpimorphism );

#! @Description
#! The arguments are two subobjects $\alpha: a \rightarrow c$, $\beta: b \rightarrow c$.
#! The output is <C>true</C> if there exists an isomorphism $\iota: a \rightarrow b$
#! such that $\beta \circ \iota \sim_{a,c} \alpha$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsEqualAsSubobjects",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two factorobjects $\alpha: c \rightarrow a$, $\beta: c \rightarrow b$.
#! The output is <C>true</C> if there exists an isomorphism $\iota: b \rightarrow a$
#! such that $\iota \circ \beta \sim_{c,a} \alpha$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsEqualAsFactorobjects",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );


#! @Description
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \def\h{1}
#! \node (a) at (0,\h) {$a$};
#! \node (b) at (0,-\h) {$b$};
#! \node (c) at (\w,0) {$c$};
#! \draw[right hook-latex] (a) to node[pos=0.45, above] {$\alpha$} (c);
#! \draw[right hook-latex] (b) to node[pos=0.45, below] {$\beta$} (c);
#! \draw[-latex, dashed] (a) to node[pos=0.45, left] {$\exists \iota$} (b);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly
#! In short: Returns <C>true</C> iff $\alpha$ is smaller than $\beta$.
#! Full description: The arguments are two subobjects $\alpha: a \rightarrow c$, $\beta: b \rightarrow c$.
#! The output is <C>true</C> if there exists a morphism $\iota: a \rightarrow b$
#! such that $\beta \circ \iota \sim_{a,c} \alpha$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsDominating",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );


#! @Description
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \def\h{1}
#! \node (c) at (0,0) {$c$};
#! \node (a) at (\w,\h) {$a$};
#! \node (b) at (\w,-\h) {$b$};
#! \draw[-twohead] (c) to node[pos=0.45, above] {$\alpha$} (a);
#! \draw[-twohead] (c) to node[pos=0.45, below] {$\beta$} (b);
#! \draw[-latex, dashed] (b) to node[pos=0.45, right] {$\exists \iota$} (a);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly
#! In short: Returns <C>true</C> iff $\alpha$ is smaller than $\beta$.
#! Full description: 
#! The arguments are two factorobjects $\alpha: c \rightarrow a$, $\beta: c \rightarrow b$.
#! The output is <C>true</C> if there exists a morphism $\iota: b \rightarrow a$
#! such that $\iota \circ \beta \sim_{c,a} \alpha$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsCodominating",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );


###################################
##
#! @Section Identity Morphism and Composition of Morphisms
##
###################################

#! @Description
#! The argument is an object $a$.
#! The output is its identity morphism $\mathrm{id}_a$.
#! @Returns a morphism in $\mathrm{Hom}(a,a)$
#! @Arguments a
DeclareAttribute( "IdentityMorphism",
                                          IsCapCategoryObject );


#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow b$, $\beta: b \rightarrow c$.
#! The output is the composition $\beta \circ \alpha: a \rightarrow c$.
#! @Returns a morphism in $\mathrm{Hom}( a, c )$
#! @Arguments alpha, beta
DeclareOperation( "PreCompose",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! This is a convenience method.
#! The argument is a list of morphisms
#! $L = ( \alpha_1: a_1 \rightarrow a_2, \alpha_2: a_2 \rightarrow a_3, \dots, \alpha_n: a_n \rightarrow a_{n+1} )$.
#! The output is the composition
#! $\alpha_{n} \circ ( \alpha_{n-1} \circ ( \dots ( \alpha_2 \circ \alpha_1 ) ) )$.
#! @Returns a morphism in $\mathrm{Hom}(a_1, a_{n+1})$
#! @Arguments L
DeclareOperation( "PreCompose",
                  [ IsList ] );

#! @Description
#! The arguments are two objects <A>s</A> = $a_1$, <A>r</A> = $a_{n+1}$, and a list of morphisms
#! $L = ( \alpha_1: a_1 \rightarrow a_2, \alpha_2: a_2 \rightarrow a_3, \dots, \alpha_n: a_n \rightarrow a_{n+1} )$ in $C$.
#! The output is the composition
#! $\alpha_{n} \circ ( \alpha_{n-1} \circ ( \dots ( \alpha_2 \circ \alpha_1 ) ) )$.
#! If $L$ is empty, then $s$ must be equal to $r$ and the output is congruent to the identity morphism of $s$.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, L, r
DeclareOperation( "PreComposeList",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );


#! @Description
#! The arguments are two morphisms $\beta: b \rightarrow c$, $\alpha: a \rightarrow b$.
#! The output is the composition $\beta \circ \alpha: a \rightarrow c$.
#! @Returns a morphism in $\mathrm{Hom}( a, c )$
#! @Arguments beta, alpha
DeclareOperation( "PostCompose",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! This is a convenience method.
#! The argument is a list of morphisms
#! $L = ( \alpha_n: a_n \rightarrow a_{n+1}, \alpha_{n-1}: a_{n-1} \rightarrow a_n, \dots, \alpha_1: a_1 \rightarrow a_2 )$.
#! The output is the composition
#! $((\alpha_{n} \circ  \alpha_{n-1}) \circ \dots  \alpha_2) \circ \alpha_1$.
#! @Returns a morphism in $\mathrm{Hom}(a_1, a_{n+1})$
#! @Arguments L
DeclareOperation( "PostCompose",
                  [ IsList ] );

#! @Description
#! The arguments are two objects <A>s</A> = $a_1$, <A>r</A> = $a_{n+1}$, and a list of morphisms
#! $L = ( \alpha_n: a_n \rightarrow a_{n+1}, \alpha_{n-1}: a_{n-1} \rightarrow a_n, \dots, \alpha_1: a_1 \rightarrow a_2 )$.
#! The output is the composition
#! $((\alpha_{n} \circ  \alpha_{n-1}) \circ \dots  \alpha_2) \circ \alpha_1$.
#! If $L$ is empty, then $s$ must be equal to $r$ and the output is congruent to the identity morphism of $s$.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, L, r
DeclareOperation( "PostComposeList",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects <A>s</A>, <A>r</A> and a list <A>morphisms</A> of morphisms from <A>s</A> to <A>r</A>.
#! The output is the sum of all elements in <A>morphisms</A>, or the zero-morphism from <A>s</A> to <A>r</A> 
#! if <A>morphisms</A> is empty.
#! @Returns a morphism in $\mathrm{Hom}(s,r)$
#! @Arguments s, morphisms, r
DeclareOperation( "SumOfMorphisms",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects <A>s</A>, <A>r</A> in some linear category over a ring $R$,
#! a list <A>coeffs</A> of ring elements in $R$ and a list <A>mors</A> of morphisms from <A>s</A> to <A>r</A>.
#! The output is the linear combination of the morphisms in <A>mors</A> with respect to the coefficients list <A>coeffs</A>,
#! or the zero morphism from <A>s</A> to <A>r</A> if <A>coeffs</A> and <A>mors</A> are the empty lists.
#! @Returns a morphism in $\mathrm{Hom}(s,r)$
#! @Arguments s, coeffs, mors, r
DeclareOperation( "LinearCombinationOfMorphisms",
                  [ IsCapCategoryObject, IsList, IsList, IsCapCategoryObject ] );

###################################
##
#! @Section Well-Definedness of Morphisms
##
###################################

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is <C>true</C> if $\alpha$ is well-defined,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareOperation( "IsWellDefinedForMorphisms",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two well-defined objects $S$ and $T$ and a morphism $\alpha$.
#! The output is <C>true</C> if $\alpha$ is a well-defined morphism from $S$ to $T$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments source, alpha, range
DeclareOperation( "IsWellDefinedForMorphismsWithGivenSourceAndRange",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

###################################
##
#! @Section Lift/Colift
##
###################################

#! * For any pair of morphisms $\alpha: a \rightarrow c$, $\beta: b \rightarrow c$,
#!  we call each morphism $\alpha / \beta: a \rightarrow b$ such that
#!  $\beta \circ (\alpha / \beta) \sim_{a,c} \alpha$ a <Emph>lift of $\alpha$ along $\beta$</Emph>.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \def\h{1}
#! \node (a) at (0,\h) {$a$};
#! \node (b) at (0,-\h) {$b$};
#! \node (c) at (\w,0) {$c$};
#! \draw[-latex] (a) to node[pos=0.45, above] {$\alpha$} (c);
#! \draw[-latex] (b) to node[pos=0.45, below] {$\beta$} (c);
#! \draw[-latex, dashed] (a) to node[pos=0.45, left] {$\alpha/\beta$} (b);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly
#! * For any pair of morphisms $\alpha: a \rightarrow c$, $\beta: a \rightarrow b$,
#!  we call each morphism $\alpha \backslash \beta: c \rightarrow b$ such that
#!  $(\alpha \backslash \beta) \circ \alpha \sim_{a,b} \beta$ a <Emph> colift of $\beta$ along $\alpha$</Emph>.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \def\h{1}
#! \node (a) at (0,0) {$a$};
#! \node (c) at (\w,\h) {$c$};
#! \node (b) at (\w,-\h) {$b$};
#! \draw[-latex] (a) to node[pos=0.45, above] {$\alpha$} (c);
#! \draw[-latex] (a) to node[pos=0.45, below] {$\beta$} (b);
#! \draw[-latex, dashed] (c) to node[pos=0.45, right] {$\alpha \backslash \beta$} (b);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

#! Note that such lifts (or colifts) do not have to be unique. So in general,
#! we do not expect that algorithms computing lifts (or colifts) do this in a functorial way.
#! Thus the operations $\mathtt{Lift}$ and $\mathtt{Colift}$ are not regarded as 
#! categorical operations, but only as set-theoretic operations.

#! @Description
#! The arguments are a monomorphism $\iota: k \hookrightarrow a$
#! and a morphism $\tau: t \rightarrow a$
#! such that there is a morphism $u: t \rightarrow k$ with
#! $\iota \circ u \sim_{t,a} \tau$.
#! The output is such a $u$.
#! @Returns a morphism in $\mathrm{Hom}(t,k)$
#! @Arguments iota, tau
DeclareOperation( "LiftAlongMonomorphism",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an epimorphism $\epsilon: a \rightarrow c$
#! and a morphism $\tau: a \rightarrow t$
#! such that there is a morphism $u: c \rightarrow t$ with
#! $u \circ \epsilon \sim_{a,t} \tau$.
#! The output is such a $u$.
#! @Returns a morphism in $\mathrm{Hom}(c,t)$
#! @Arguments epsilon, tau
DeclareOperation( "ColiftAlongEpimorphism",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a monomorphism $\iota: k \hookrightarrow a$
#! and a morphism $\tau: t \rightarrow a$.
#! The output is <C>true</C> if there exists
#! a morphism $u: t \rightarrow k$ with
#! $\iota \circ u \sim_{t,a} \tau$.
#! Otherwise, the output is  <C>false</C>.
#! @Returns a boolean
#! @Arguments iota, tau
DeclareOperation( "IsLiftableAlongMonomorphism",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an epimorphism $\epsilon: a \rightarrow c$
#! and a morphism $\tau: a \rightarrow t$.
#! The output is <C>true</C> if there exists
#! a morphism $u: c \rightarrow t$ with
#! $u \circ \epsilon \sim_{a,t} \tau$.
#! Otherwise, the output is  <C>false</C>.
#! @Returns a boolean
#! @Arguments epsilon, tau
DeclareOperation( "IsColiftableAlongEpimorphism",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow c$, $\beta: b \rightarrow c$
#! such that a lift $\alpha / \beta: a \rightarrow b$ of $\alpha$ along $\beta$ exists.
#! The output is such a lift $\alpha / \beta: a \rightarrow b$.
#! Recall that a lift $\alpha / \beta: a \rightarrow b$ of $\alpha$ along $\beta$ is
#! a morphism such that $\beta \circ (\alpha / \beta) \sim_{a,c} \alpha$.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments alpha, beta
DeclareOperation( "Lift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! This is a convenience operation.
#! The arguments are two morphisms $\alpha: a \rightarrow c$, $\beta: b \rightarrow c$.
#! The output is a lift $\alpha / \beta: a \rightarrow b$ of $\alpha$ along $\beta$
#! if such a lift exists or $\mathtt{fail}$ if it doesn't.
#! Recall that a lift $\alpha / \beta: a \rightarrow b$ of $\alpha$ along $\beta$ is
#! a morphism such that $\beta \circ (\alpha / \beta) \sim_{a,c} \alpha$.
#! @Returns a morphism in $\mathrm{Hom}(a,b) + \{ \mathtt{fail} \}$
#! @Arguments alpha, beta
DeclareOperation( "LiftOrFail",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow c$, $\beta: b \rightarrow c$.
#! The output is <C>true</C> if there exists
#!  a lift $\alpha / \beta: a \rightarrow b$ of $\alpha$ along $\beta$, i.e.,
#! a morphism such that $\beta \circ (\alpha / \beta) \sim_{a,c} \alpha$.
#! Otherwise, the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsLiftable",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow c$, $\beta: a \rightarrow b$
#! such that a colift $\alpha \backslash \beta: c \rightarrow b$ of $\beta$ along $\alpha$ exists.
#! The output is such a colift $\alpha \backslash \beta: c \rightarrow b$.
#! Recall that a colift $\alpha \backslash \beta: c \rightarrow b$ of $\beta$ along $\alpha$ is
#! a morphism such that $(\alpha \backslash \beta) \circ \alpha \sim_{a,b} \beta$.
#! @Returns a morphism in $\mathrm{Hom}(c,b)$
#! @Arguments alpha, beta
DeclareOperation( "Colift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );


#! @Description
#! This is a convenience operation.
#! The arguments are two morphisms $\alpha: a \rightarrow c$, $\beta: a \rightarrow b$.
#! The output is a colift $\alpha \backslash \beta: c \rightarrow b$ of $\beta$ along $\alpha$
#! if such a colift exists or $\mathtt{fail}$ if it doesn't.
#! Recall that a colift $\alpha \backslash \beta: c \rightarrow b$ of $\beta$ along $\alpha$ is
#! a morphism such that $(\alpha \backslash \beta) \circ \alpha \sim_{a,b} \beta$.
#! @Returns a morphism in $\mathrm{Hom}(c,b) + \{ \mathtt{fail} \}$
#! @Arguments alpha, beta
DeclareOperation( "ColiftOrFail",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );


#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow c$, $\beta: a \rightarrow b$.
#! The output is <C>true</C> if there exists
#! a colift $\alpha \backslash \beta: c \rightarrow b$ of $\beta$ along $\alpha$., i.e.,
#! a morphism such that $(\alpha \backslash \beta) \circ \alpha \sim_{a,b} \beta$.
#! Otherwise, the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsColiftable",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

####################################
##
#! @Section Inverses
##
####################################

#! Let $\alpha: a \rightarrow b$ be a morphism. An inverse of $\alpha$
#! is a morphism $\alpha^{-1}: b \rightarrow a$ such that
#! $\alpha \circ \alpha^{-1} \sim_{b,b} \mathrm{id}_b$
#! and $\alpha^{-1} \circ \alpha \sim_{a,a} \mathrm{id}_a$.

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \def\h{1}
#! \node (a) at (0,0) {$a$};
#! \node (b) at (\w,0) {$b$};
#! \draw[-latex] (a) to node[pos=0.45, above] {$\alpha$} (b);
#! \draw[-latex] (b) to [out = -135, in = -45] node[pos=0.45, below] {$\alpha^{-1}$} (a);
#! \draw [-latex] (a.135) arc (45:45+280:4mm) node[pos=0.5,left] {$\mathrm{id}_a$} (a);
#! \draw [-latex] (b.45) arc (-240:-240-280:4mm) node[pos=0.5,right] {$\mathrm{id}_b$} (b);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

#! @Description
#! The argument is an isomorphism $\alpha: a \rightarrow b$.
#! The output is its inverse $\alpha^{-1}: b \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(b,a)$
#! @Arguments alpha
DeclareOperation( "InverseForMorphisms",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The argument is a split-epimorphism $\alpha: a \rightarrow b$.
#! The output is a pre-inverse $\iota: b \rightarrow a$ of $\alpha$,
#! i.e., $\iota$ satisfies $\alpha \circ \iota \sim_{b,b} \mathrm{id}_b$.
#! The morphism $\iota$ is also known as a section or a right-inverse of $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}(b,a)$
#! @Arguments alpha
DeclareOperation( "PreInverseForMorphisms",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The argument is a split-monomorphism $\alpha: a \rightarrow b$.
#! The output is a post-inverse $\pi: b \rightarrow a$ of $\alpha$,
#! i.e., $\pi$ satisfies $\pi \circ \alpha \sim_{a,a} \mathrm{id}_a$.
#! The morphism $\pi$ is also known as a contraction or a left-inverse of $\alpha$.
#! @Returns a morphism in $\mathrm{Hom}(b,a)$
#! @Arguments alpha
DeclareOperation( "PostInverseForMorphisms",
                  [ IsCapCategoryMorphism ] );

###################################
##
#! @Section Tool functions for caches
##
###################################

#! @Description
#!  By default, CAP uses caches to store the values of Categorical operations.
#!  To get a value out of the cache, one needs to compare the input of a basic operation
#!  with its previous input. To compare morphisms in the category, IsEqualForCacheForMorphisms is
#!  used. By default, IsEqualForCacheForMorphisms falls back to IsEqualForCache (see ToolsForHomalg),
#!  which in turn defaults to recursive comparison for lists and `IsIdenticalObj` in all other cases.
#!  If you add a function via `AddIsEqualForCacheForMorphisms`, that function is used instead.
#!  A function $F: a,b \mapsto bool$ is expected there. The output has to be
#!  true or false. Fail is not allowed in this context.
#! @Arguments phi, psi
#! @Returns true or false
DeclareOperation( "IsEqualForCacheForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

###################################
##
#! @Section Transport Operations
##
###################################

## mor: x -> y
## equality_source: x -> x'
## equality_range: y -> y'
## TransportHom( mor, equality_source, equality_range ): x' -> y'
DeclareOperation( "TransportHom",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

###################################
##
#! @Section IsHomSetInhabited
##
###################################

#! @Description
#!  The arguments are two objects <A>A</A> and <A>B</A>.
#!  The output is <C>true</C> if there exists a morphism from <A>A</A> to <A>B</A>,
#!  otherwise the output is <C>false</C>.
#! @Arguments A, B
#! @Returns a boolean
DeclareOperation( "IsHomSetInhabited",
        [ IsCapCategoryObject, IsCapCategoryObject ] );

###################################
##
#! @Section SetOfMorphisms
##
###################################

#! @Description
#!  Return a duplicate free list of morphisms of the finite category <A>C</A>.
#! @Arguments C
#! @Returns a list of a &CAP; category morphisms
DeclareAttribute( "SetOfMorphismsOfFiniteCategory",
        IsCapCategory );

#! @Description
#!  Return a duplicate free list of morphisms of the finite category <A>C</A>.
#!  The corresponding &CAP; operation is <C>SetOfMorphismsOfFiniteCategory</C>.
#! @Arguments C
#! @Returns a list of &CAP; category objects
DeclareAttribute( "SetOfMorphisms", IsCapCategory );

###################################
##
#! @Section Homomorphism structures
##
###################################

#! Homomorphism structures are way to "oversee" the homomorphisms between two given objects.
#! Let $C$, $D$ be categories.
#! A $D$-homomorphism structure for $C$ consists of the following data:
#! * a functor $H: C^{\mathrm{op}} \times C \rightarrow D$ (when $C$ and $D$ are Ab-categories, $H$ is assumed to be bilinear).
#! * an object $1 \in D$, called the distinguished object,
#! * a bijection $\nu: \mathrm{Hom}_{C}(a,b) \simeq \mathrm{Hom}_{D}(1, H(a,b))$ natural in $a,b \in C$.

#! @Description
#! The arguments are two objects $a, b$ in $C$.
#! The output is the value of the homomorphism structure on objects $H(a,b)$.
#! @Returns an object in $D$
#! @Arguments a,b
DeclareOperation( "HomomorphismStructureOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$ in $C$.
#! The output is the value of the homomorphism structure on morphisms $H(\alpha, \beta )$.
#! @Returns a morphism in $\mathrm{Hom}_{D}(H(a',b), H(a,b'))$
#! @Arguments alpha, beta
DeclareOperation( "HomomorphismStructureOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = H(a',b)$ in $D$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$ in $C$,
#! and an object $r = H(a,b')$ in $D$.
#! The output is the value of the homomorphism structure on morphisms $H(\alpha, \beta )$.
#! @Returns a morphism in $\mathrm{Hom}_{D}(H(a',b), H(a,b'))$
#! @Arguments s, alpha, beta, r
DeclareOperation( "HomomorphismStructureOnMorphismsWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The argument is a category $C$.
#! The output is the distinguished object $1$ in $D$ of the homomorphism structure.
#! @Returns an object in $D$
#! @Arguments C
DeclareAttribute( "DistinguishedObjectOfHomomorphismStructure",
                  IsCapCategory );

#! @Description
#! The argument is a morphism  $\alpha: a \rightarrow a'$ in $C$.
#! The output is the corresponding morphism
#! $\nu( \alpha ): 1 \rightarrow H(a,a')$ in $D$ of the homomorphism structure.
#! @Returns a morphism in $\mathrm{Hom}_{D}(1, H(a,a'))$
#! @Arguments alpha
DeclareAttribute( "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are the distinguished object $1$, a morphism  $\alpha: a \rightarrow a'$, and the object $r = H(a,a')$.
#! The output is the corresponding morphism
#! $\nu( \alpha ): 1 \rightarrow r$ in $D$ of the homomorphism structure.
#! @Returns a morphism in $\mathrm{Hom}_{D}(1, r)$
#! @Arguments distinguished_object, alpha, r
DeclareOperation( "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! objects $a,a'$ in $C$
#! and a morphism $\iota: 1 \rightarrow H(a,a')$ in $D$.
#! The output is the corresponding morphism
#! $\nu^{-1}(\iota): a \rightarrow a'$ in $C$ of the homomorphism structure.
#! @Returns a morphism in $\mathrm{Hom}_{C}(a,a')$
#! @Arguments a,a',iota
DeclareOperation( "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are three lists $\alpha$, $\beta$, and $\gamma$.
#! The first list $\alpha$ (the left coefficients) is a list of list of morphisms $\alpha_{ij}: A_i \rightarrow B_j$,
#! where $i = 1 \dots m$ and $j = 1 \dots n$ for integers $m,n \geq 1$.
#! The second list $\beta$ (the right coefficients) is a list of list of morphisms $\beta_{ij}: C_j \rightarrow D_i$,
#! where $i = 1 \dots m$ and $j = 1 \dots n$.
#! The third list $\gamma$ (the right side) is a list of morphisms $\gamma_i: A_i \rightarrow D_i$,
#! where $i = 1, \dots, m$.
#! Assumes that a solution to the linear system defined by $\alpha$, $\beta$, $\gamma$ exists, i.e.,
#! there exist morphisms $X_j: B_j \rightarrow C_j$ for $j=1\dots n$ such that
#! $\sum_{j = 1}^n \alpha_{ij}\cdot X_j \cdot \beta_{ij} = \gamma_i$
#! for all $i = 1 \dots m$.
#! The output is list of such morphisms $X_j: B_j \rightarrow C_j$ for $j=1\dots n$.
#! @Returns a list of morphisms $[X_1, \dots, X_n]$
#! @Arguments alpha, beta, gamma
DeclareOperation( "SolveLinearSystemInAbCategory",
                   [ IsList, IsList, IsList ] );

#! @Description
#! This is a convenience operation.
#! Like <C>SolveLinearSystemInAbCategory</C>,
#! but without the assumption that a solution exists.
#! If no solution exists, `fail` is returned.
#! @Returns a list of morphisms $[X_1, \dots, X_n]$ or `fail`
#! @Arguments alpha, beta, gamma
DeclareOperation( "SolveLinearSystemInAbCategoryOrFail",
                   [ IsList, IsList, IsList ] );

#! @Description
#! Like <C>SolveLinearSystemInAbCategory</C>,
#! but the output is simply <C>true</C> if a solution exists,
#! <C>false</C> otherwise.
#! @Returns a boolean
#! @Arguments alpha, beta, gamma
DeclareOperation( "MereExistenceOfSolutionOfLinearSystemInAbCategory",
                   [ IsList, IsList, IsList ] );

#! @Description
#! Like <C>SolveLinearSystemInAbCategory</C>,
#! but the output is simply <C>true</C> if a unique solution exists,
#! and <C>false</C> otherwise.
#! @Returns a boolean
#! @Arguments alpha, beta, gamma
DeclareOperation( "MereExistenceOfUniqueSolutionOfLinearSystemInAbCategory",
                   [ IsList, IsList, IsList ] );

#! @Description
#! Like <C>SolveLinearSystemInAbCategory</C>
#! but the output is <C>true</C> if the homogeneous system has only the trivial zero solution,
#! and <C>false</C> otherwise.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "MereExistenceOfUniqueSolutionOfHomogeneousLinearSystemInAbCategory",
                   [ IsList, IsList ] );

#! @Description
#! The arguments are two lists of lists $\alpha$ and $\beta$ of morphisms in a linear category over a commutative ring $k$.
#! The first list $\alpha$ (the left coefficients) is a list of list of morphisms $\alpha_{ij}: A_i \rightarrow B_j$,
#! where $i = 1, \dots, m$ and $j = 1, \dots, n$ for integers $m,n \geq 1$.
#! The second list $\beta$ (the right coefficients) is a list of list of morphisms $\beta_{ij}: C_j \rightarrow D_i$,
#! where $i = 1, \dots, m$ and $j = 1, \dots, n$.
#! The output is a generating set $[X^1,\dots,X^t]$ for the solutions of the homogeneous linear system:
#! $\sum_{j = 1}^n \alpha_{ij}\cdot X_{j} \cdot \beta_{ij} = 0, ~i = 1, \dots, m$.
#! Particularly, each $X^k$ is a list (of length $n$) of morphisms $X^k_j:B_j \to C_j, j=1,\dots,n$.
#! @Returns a list of lists of morphisms $[X^1, \dots, X^t]$
#! @Arguments alpha, beta
DeclareOperation( "BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory",
                   [ IsList, IsList ] );

#! @Description
#! The arguments are four lists of lists $\alpha$, $\beta$, $\gamma$, $\delta$ of morphisms in some linear category over commutative ring.
#! Each of $\alpha$ and $\gamma$ is a list of list of morphisms $\alpha_{ij}, \gamma_{ij}: A_i \rightarrow B_j$,
#! where $i = 1, \dots, m$ and $j = 1, \dots, n$ for integers $m,n \geq 1$.
#! Each of $\beta$ and $\delta$ is also a list of list of morphisms $\beta_{ij}, \delta_{ij}: C_j \rightarrow D_i$,
#! where $i = 1, \dots, m$ and $j = 1, \dots, n$.
#! The output is a generating set $[X^1,\dots,X^t]$ for the solutions of the homogeneous linear system
#! defined by $\alpha$, $\beta$, $\gamma$ and $\delta$, i.e.,
#! $\sum_{j = 1}^n \alpha_{ij}\cdot X^{k}_{j} \cdot \beta_{ij} = \sum_{j = 1}^n \gamma_{ij}\cdot X^{k}_{j} \cdot \delta_{ij}$
#! for all $i = 1, \dots, m$ and all $k = 1, \dots, t$.
#! @Returns a list of lists of morphisms $[X^1, \dots, X^t]$
#! @Arguments alpha, beta, gamma, delta
DeclareOperation( "BasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory",
                   [ IsList, IsList, IsList, IsList ] );

#! @Description
#! The arguments are two lists of lists $\alpha$, $\delta$ morphisms in some linear category
#! over commutative ring.
#! $\alpha$ is a list of list of morphisms $\alpha_{ij}:A_i \rightarrow B_j$ and
#! $\delta$ is a list of list of morphisms $\delta_{ij}:C_j \rightarrow D_i$,
#! where $i = 1, \dots, m$ and $j = 1, \dots, n$ for integers $m,n \geq 1$.
#! The method delegates to <C>BasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory</C> applied on $\alpha$, $\beta$, $\gamma$, $\delta$ where
#! * $\beta_{ij}$ equals <C>IdentityMorphism</C>(<C>Source</C>($\delta_{ij}$)) if $\delta_{ij}$ is an endomorphism,
#!   and <C>ZeroMorphism</C>(<C>Source</C>($\delta_{ij}$), <C>Range</C>($\delta_{ij}$)) otherwise,
#! * $\gamma_{ij}$ equals <C>IdentityMorphism</C>(<C>Source</C>($\alpha_{ij}$)) if $\alpha_{ij}$ is an endomorphism,
#!    and <C>ZeroMorphism</C>(<C>Source</C>($\alpha_{ij}$), <C>Range</C>($\alpha_{ij}$)) otherwise;
#! for all $i = 1, \dots, m$ and $j = 1, \dots, n$.
#! @Returns a list of lists of morphisms $[X^1, \dots, X^t]$
#! @Arguments alpha, delta
DeclareOperation( "BasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory",
                   [ IsList, IsList ] );

#! @Description
#! This is a convenience method.
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$ in $C$.
#! The output is <C>HomomorphismStructureOnMorphisms</C> called on $\alpha$, $\beta$.
#! @Returns a morphism in $\mathrm{Hom}_{D}(H(a',b), H(a,b'))$
#! @Arguments alpha, beta
DeclareOperation( "HomStructure",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! This is a convenience method.
#! The arguments are a morphism $\alpha: a \rightarrow a'$ and an object $b$ in $C$.
#! The output is <C>HomomorphismStructureOnMorphisms</C> called on $\alpha$, $\mathrm{id}_b$.
#! @Returns a morphism in $\mathrm{Hom}_{D}(H(a',b), H(a,b))$
#! @Arguments alpha, b
DeclareOperation( "HomStructure",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! This is a convenience method.
#! The arguments are an object $a$ and a morphism $\beta: b \rightarrow b'$ in $C$.
#! The output is <C>HomomorphismStructureOnMorphisms</C> called on $\mathrm{id}_a$, $\beta$.
#! @Returns a morphism in $\mathrm{Hom}_{D}(H(a,b), H(a,b'))$
#! @Arguments a, beta
DeclareOperation( "HomStructure",
                  [ IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! This is a convenience method.
#! The arguments are two objects $a$ and $b$ in $C$.
#! The output is <C>HomomorphismStructureOnObjects</C> called on $a,b$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "HomStructure",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a convenience method for
#! <C>InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure</C>.
DeclareOperation( "HomStructure",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! This is a convenience method for
#! <C>InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism</C>.
DeclareOperation( "HomStructure",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! This is a convenience method for
#! <C>DistinguishedObjectOfHomomorphismStructure</C>.
DeclareOperation( "HomStructure",
                  [ IsCapCategory ] );

#! @BeginGroup
#! @Description
#! If $\iota\colon D \to E$ is a full embedding of categories, every $D$-homomorphism structure for a category $C$
#! extends to a $E$-homomorphism structure for $C$. This operations accepts four functions
#! and installs operations `DistinguishedObjectOfHomomorphismStructureExtendedByFullEmbedding`,
#! `HomomorphismStructureOnObjectsExtendedByFullEmbedding` etc. which correspond to the $E$-homomorphism structure for $C$.
#! Note: To distinguish embeddings in different categories, in addition to $C$ also $E$ is passed to the operations.
#! When using this with different embeddings with the range category $E$, only the last embedding will be used.
#! The arguments are:
#! * `object_function` gets the categories $C$ and $E$ and an object in $D$.
#! * `morphism_function` gets the categories $C$ and $E$, an object in $E$, a morphism in $D$ and another object in $E$.
#!   The objects are the results of `object_function` applied to the source and range of the morphism.
#! * `object_function_inverse` gets the categories $C$ and $E$ and an object in $E$.
#! * `morphism_function_inverse` gets the categories $C$ and $E$, an object in $D$, a morphism in $E$ and another object in $D$.
#!   The objects are the results of `object_function_inverse` applied to the source and range of the morphism.
#! `object_function` and `morphism_function` define the embedding. `object_function_inverse` and `morphism_function_inverse` define
#! the inverse of the embedding on its image.
#! @Returns nothing
#! @Arguments C, E, object_function, morphism_function, object_function_inverse, morphism_function_inverse
DeclareOperation( "ExtendRangeOfHomomorphismStructureByFullEmbedding",
                  [ IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsFunction, IsFunction ] );

#! @Arguments C, E, a, b
DeclareOperation( "HomomorphismStructureOnObjectsExtendedByFullEmbedding",
                  [ IsCapCategory, IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Arguments C, E, alpha, beta
DeclareOperation( "HomomorphismStructureOnMorphismsExtendedByFullEmbedding",
                  [ IsCapCategory, IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Arguments C, E, s, alpha, beta, r
DeclareOperation( "HomomorphismStructureOnMorphismsWithGivenObjectsExtendedByFullEmbedding",
                  [ IsCapCategory, IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Arguments C, E
DeclareOperation( "DistinguishedObjectOfHomomorphismStructureExtendedByFullEmbedding",
                  [ IsCapCategory, IsCapCategory ] );

#! @Arguments C, E, alpha
DeclareOperation( "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureExtendedByFullEmbedding",
                  [ IsCapCategory, IsCapCategory, IsCapCategoryMorphism ] );

#! @Arguments C, E, distinguished_object, alpha, r
DeclareOperation( "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjectsExtendedByFullEmbedding",
                  [ IsCapCategory, IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Arguments C, E, a, a', iota
DeclareOperation( "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphismExtendedByFullEmbedding",
                  [ IsCapCategory, IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );
#! @EndGroup

CapJitAddTypeSignature( "HomomorphismStructureOnObjectsExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[2].category );
    
end );

CapJitAddTypeSignature( "HomomorphismStructureOnMorphismsExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[2].category );
    
end );

CapJitAddTypeSignature( "HomomorphismStructureOnMorphismsWithGivenObjectsExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[2].category );
    
end );

CapJitAddTypeSignature( "DistinguishedObjectOfHomomorphismStructureExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[2].category );
    
end );

CapJitAddTypeSignature( "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory, IsCapCategoryMorphism ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[2].category );
    
end );

CapJitAddTypeSignature( "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjectsExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[2].category );
    
end );

CapJitAddTypeSignature( "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphismExtendedByFullEmbedding", [ IsCapCategory, IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

#! @Description
#! Chooses the identity on $D$ as the full embedding in
#! <Ref Oper="ExtendRangeOfHomomorphismStructureByFullEmbedding" Label="for IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsFunction, IsFunction" />.
#! This is useful to handle this case as a degenerate case of
#! <Ref Oper="ExtendRangeOfHomomorphismStructureByFullEmbedding" Label="for IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsFunction, IsFunction" />.
#! @Returns nothing
#! @Arguments C
DeclareOperation( "ExtendRangeOfHomomorphismStructureByIdentityAsFullEmbedding",
                  [ IsCapCategory ] );

#! @Description
#! The argument are two objects <A>a</A>, <A>b</A>.
#! The output is a list of all morphisms from <A>a</A> to <A>b</A>.
#! @Returns a list of morphisms in $\mathrm{Hom}( a, b )$
#! @Arguments a, b
DeclareOperation( "MorphismsOfExternalHom",
        [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are objects $a,b$ in a $k$-linear category $C$.
#! The output is a list $L$ of morphisms which is a basis of $\mathrm{Hom}_{C}(a,b)$ in
#! the sense that any given morphism $\alpha: a \to b$ can uniquely be written as a
#! linear combination of $L$ with the coefficients in
#! <C>CoefficientsOfMorphism</C>($\alpha$).
#! @Returns a list of morphisms in $\mathrm{Hom}_{C}(a,b)$
#! @Arguments a, b
DeclareOperation( "BasisOfExternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a convenience method.
#! The argument is a morphism  $\alpha: a \to b$ in a $k$-linear category $C$.
#! The output is a list of coefficients of $\alpha$ with respect to the list
#! <C>BasisOfExternalHom</C>(<A>a</A>,<A>b</A>).
#! @Returns a list of elements in $k$
#! @Arguments alpha
DeclareAttribute( "CoefficientsOfMorphism",
                  IsCapCategoryMorphism );

###################################
##
#! @Section Simplified Morphisms
##
###################################

#! Let $\phi: A \rightarrow B$ be a morphism.
#! There are several different natural ways to look at $\phi$ as an object in an ambient category:

#! - $\mathrm{Hom}( A, B )$, the set of homomorphisms with the equivalence relation $\mathtt{IsCongruentForMorphisms}$ regarded as a category,
#! - $\sum_{A}\mathrm{Hom}( A, B )$, the category of morphisms where the range is fixed,
#! - $\sum_{B}\mathrm{Hom}( A, B )$, the category of morphisms where the source is fixed,
#! - $\sum_{A,B}\mathrm{Hom}( A, B )$, the category of morphisms where neither source nor range is fixed,

#! and furthermore, if $\phi$ happens to be an endomorphism $A \rightarrow A$,
#! we also have

#! - $\sum_{A}\mathrm{Hom}(A,A)$, the category of endomorphisms.

#! Let $\mathbf{C}$ be one of the categories above in which $\phi$ may reside as an object,
#! and let $i$ be a non-negative integer or $\infty$.
#! CAP provides commands for passing from $\phi$ to $\phi_i$, where $\phi_i$ is isomorphic to $\phi$
#! in $\mathbf{C}$, but "simpler".
#! The idea is that the greater the $i$, the "simpler" the $\phi_i$ (but this could mean the harder the computation),
#! with $\infty$ as a possible value.
#! The case $i = 0$ defaults to the identity operator for all simplifications.
#! For the Add-operatations, only the cases $i \geq 1$ have to be given as functions.
#! 
#! 
#! $\ $
#!
#!
#! If we regard $\phi$ as an object in the category $\mathrm{Hom}( A, B )$,
#! $\phi_i$ is again in $\mathrm{Hom}( A, B )$ such that $\phi \sim_{A,B} \phi_i$.
#! This case is handled by the following commands:

#! @Description
#! The arguments are a morphism $\phi: A \rightarrow B$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is a simplified morphism $\phi_i$.
#! @Returns a morphism in $\mathrm{Hom}(A,B)$
#! @Arguments phi, i
DeclareOperation( "SimplifyMorphism",
                  [ IsCapCategoryMorphism, IsObject ] );

#! $\ $
#!
#! If we regard $\phi$ as an object in the category $\sum_{A}\mathrm{Hom}( A, B )$,
#! then $\phi_i$ is a morphism of type $A_i \rightarrow B$ and there is an isomorphism
#! $\sigma_i: A \rightarrow A_i$ such that
#! $\phi_i \circ \sigma_i \sim_{A,B} \phi$.
#! This case is handled by the following commands:

## SimplifySource
#! @Description
#! The arguments are a morphism $\phi: A \rightarrow B$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is a simplified morphism with simplified source $\phi_i: A_i \rightarrow B$.
#! @Returns a morphism in $\mathrm{Hom}(A_i,B)$
#! @Arguments phi, i
DeclareOperation( "SimplifySource",
                  [ IsCapCategoryMorphism, IsObject ] );

#! @Description
#! The arguments are a morphism $\phi: A \rightarrow B$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is the isomorphism $(\sigma_i)^{-1}: A_i \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(A_i,A)$
#! @Arguments phi, i
DeclareOperation( "SimplifySource_IsoToInputObject",
                  [ IsCapCategoryMorphism, IsObject ] );

#! @Description
#! The arguments are a morphism $\phi: A \rightarrow B$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is the isomorphism $\sigma_i: A \rightarrow A_i$.
#! @Returns a morphism in $\mathrm{Hom}(A,A_i)$
#! @Arguments phi, i
DeclareOperation( "SimplifySource_IsoFromInputObject",
                  [ IsCapCategoryMorphism, IsObject ] );

## SimplifyRange
#! $\ $
#!
#! If we regard $\phi$ as an object in the category $\sum_{B}\mathrm{Hom}( A, B )$,
#! then $\phi_i$ is a morphism of type $A \rightarrow B_i$ and there is an isomorphism
#! $\rho_i: B \rightarrow B_i$ such that
#! $ \rho_i^{-1} \circ \phi_i\sim_{A,B} \phi$.
#! This case is handled by the following commands:

#! @Description
#! The arguments are a morphism $\phi: A \rightarrow B$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is a simplified morphism with simplified range $\phi_i: A \rightarrow B_i$.
#! @Returns a morphism in $\mathrm{Hom}(A,B_i)$
#! @Arguments phi, i
DeclareOperation( "SimplifyRange",
                  [ IsCapCategoryMorphism, IsObject ] );

#! @Description
#! The arguments are a morphism $\phi: A \rightarrow B$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is the isomorphism $(\rho_i)^{-1}: B_i \rightarrow B$.
#! @Returns a morphism in $\mathrm{Hom}(B_i,B)$
#! @Arguments phi, i
DeclareOperation( "SimplifyRange_IsoToInputObject",
                  [ IsCapCategoryMorphism, IsObject ] );

#! @Description
#! The arguments are a morphism $\phi: A \rightarrow B$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is the isomorphism $\rho_i: B \rightarrow B_i$.
#! @Returns a morphism in $\mathrm{Hom}(B,B_i)$
#! @Arguments phi, i
DeclareOperation( "SimplifyRange_IsoFromInputObject",
                  [ IsCapCategoryMorphism, IsObject ] );

## SimplifySourceAndRange*
#! $\ $
#!
#! If we regard $\phi$ as an object in the category $\sum_{A, B}\mathrm{Hom}( A, B )$,
#! then $\phi_i$ is a morphism of type $A_i \rightarrow B_i$ and there is are isomorphisms
#! $\sigma_i: A \rightarrow A_i$ and
#! $\rho_i: B \rightarrow B_i$ such that
#! $ \rho_i^{-1} \circ \phi_i \circ \sigma_i \sim_{A,B} \phi$.
#! This case is handled by the following commands:

#! @Description
#! The arguments are a morphism $\phi: A \rightarrow B$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is a simplified morphism with simplified source and range $\phi_i: A_i \rightarrow B_i$.
#! @Returns a morphism in $\mathrm{Hom}(A_i,B_i)$
#! @Arguments phi, i
DeclareOperation( "SimplifySourceAndRange",
                  [ IsCapCategoryMorphism, IsObject ] );

#! @Description
#! The arguments are a morphism $\phi: A \rightarrow B$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is the isomorphism $(\rho_i)^{-1}: B_i \rightarrow B$.
#! @Returns a morphism in $\mathrm{Hom}(B_i,B)$
#! @Arguments phi, i
DeclareOperation( "SimplifySourceAndRange_IsoToInputRange",
                  [ IsCapCategoryMorphism, IsObject ] );

#! @Description
#! The arguments are a morphism $\phi: A \rightarrow B$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is the isomorphism $\rho_i: B \rightarrow B_i$.
#! @Returns a morphism in $\mathrm{Hom}(B,B_i)$
#! @Arguments phi, i
DeclareOperation( "SimplifySourceAndRange_IsoFromInputRange",
                  [ IsCapCategoryMorphism, IsObject ] );

#! @Description
#! The arguments are a morphism $\phi: A \rightarrow B$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is the isomorphism $(\sigma_i)^{-1}: A_i \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(A_i,A)$
#! @Arguments phi, i
DeclareOperation( "SimplifySourceAndRange_IsoToInputSource",
                  [ IsCapCategoryMorphism, IsObject ] );

#! @Description
#! The arguments are a morphism $\phi: A \rightarrow B$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is the isomorphism $\sigma_i: A \rightarrow A_i$.
#! @Returns a morphism in $\mathrm{Hom}(A,A_i)$
#! @Arguments phi, i
DeclareOperation( "SimplifySourceAndRange_IsoFromInputSource",
                  [ IsCapCategoryMorphism, IsObject ] );

## SimplifyEndo*
#! $\ $
#!
#! If $\phi:A \rightarrow A$ is an endomorphism, we may regard it as an object in the category $\sum_{A}\mathrm{Hom}( A, A )$.
#! In this case
#! $\phi_i$ is a morphism of type $A_i \rightarrow A_i$ and there is an isomorphism
#! $\sigma_i: A \rightarrow A_i$ such that
#! $ \sigma_i^{-1} \circ \phi_i \circ \sigma_i \sim_{A,A} \phi$.
#! This case is handled by the following commands:

#! @Description
#! The arguments are an endomorphism $\phi: A \rightarrow A$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is a simplified endomorphism $\phi_i: A_i \rightarrow A_i$.
#! @Returns a morphism in $\mathrm{Hom}(A_i,A_i)$
#! @Arguments phi, i
DeclareOperation( "SimplifyEndo",
                  [ IsCapCategoryMorphism, IsObject ] );

#! @Description
#! The arguments are an endomorphism $\phi: A \rightarrow A$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is the isomorphism $(\sigma_i)^{-1}: A_i \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(A_i,A)$
#! @Arguments phi, i
DeclareOperation( "SimplifyEndo_IsoToInputObject",
                  [ IsCapCategoryMorphism, IsObject ] );

#! @Description
#! The arguments are an endomorphism $\phi: A \rightarrow A$ and a non-negative integer $i$ or <C>infinity</C>.
#! The output is the isomorphism $\sigma_i: A \rightarrow A_i$.
#! @Returns a morphism in $\mathrm{Hom}(A,A_i)$
#! @Arguments phi, i
DeclareOperation( "SimplifyEndo_IsoFromInputObject",
                  [ IsCapCategoryMorphism, IsObject ] );


#! @Description
#! This is a convenient method.
#! The argument is a morphism $\phi: A \rightarrow B$.
#! The output is a "simplified" version of $\phi$ that may change the
#! source and range of $\phi$ (up to isomorphism).
#! To be precise, the output is an $\infty$-th simplified morphism
#! of $(\iota_A^{\infty})^{-1}\circ \phi \circ \iota_A^{\infty}$.
#! @Returns a morphism in $\mathrm{Hom}(A_{\infty},B_{\infty})$
#! @Arguments phi
DeclareAttribute( "Simplify",
                  IsCapCategoryMorphism );

###################################
##
#! @Section Reduction by split epi summands
##
###################################

#! Let $\alpha: A \rightarrow B$ be a morphism in an additive category.
#! Suppose we are given direct sum decompositions
#! of $A \simeq A' \oplus A''$ and $B \simeq B' \oplus B''$
#! such that

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{4}
#! \def\h{2}
#! \node (A) at (0,0) {$A$};
#! \node (B) at (\w,0) {$B$};
#! \node (Ap) at (0,\h) {$A' \oplus A''$};
#! \node (Bp) at (\w,\h) {$B' \oplus B''$};
#! \draw[-latex] (A) to node[pos=0.45, above] {$\alpha$} (B);
#! \draw[-latex] (Ap) to node[pos=0.45, above] {$\alpha' \oplus \alpha''$} (Bp);
#! \draw[-latex] (A) to (Ap);
#! \draw[-latex] (B) to (Bp);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

#! If $\alpha''$ is a split epimorphism, then we call $\alpha': A' \rightarrow B'$
#! <Emph>some reduction of $\alpha$ by split epi summands</Emph>.

#! The inclusions/projections of the decompositions into direct sums
#! induce commutative diagrams

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{4}
#! \def\h{2}
#! \node (A) at (0,0) {$A$};
#! \node (B) at (\w,0) {$B$};
#! \node (Ap) at (0,\h) {$A'$};
#! \node (Bp) at (\w,\h) {$B'$};
#! \draw[-latex] (A) to node[pos=0.45, above] {$\alpha$} (B);
#! \draw[-latex] (Ap) to node[pos=0.45, above] {$\alpha'$} (Bp);
#! \draw[-latex] (A) to (Ap);
#! \draw[-latex] (B) to node[pos=0.45, right] {$\beta$} (Bp);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

#! and

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{4}
#! \def\h{2}
#! \node (A) at (0,0) {$A$};
#! \node (B) at (\w,0) {$B$};
#! \node (Ap) at (0,\h) {$A'$};
#! \node (Bp) at (\w,\h) {$B'$};
#! \draw[-latex] (A) to node[pos=0.45, above] {$\alpha$} (B);
#! \draw[-latex] (Ap) to node[pos=0.45, above] {$\alpha'$} (Bp);
#! \draw[-latex] (Ap) to (A);
#! \draw[-latex] (Bp) to node[pos=0.45, right] {$\beta'$} (B);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is some reduction of $\alpha$ by split epi summands $\alpha': A' \rightarrow B'$.
#! @Returns a morphism in $\mathrm{Hom}(A',B')$
#! @Arguments alpha
DeclareAttribute( "SomeReductionBySplitEpiSummand",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the morphism $\beta': B' \rightarrow B$
#! linking $\alpha$ with some reduction by split epi summands.
#! @Returns a morphism in $\mathrm{Hom}(B',B)$
#! @Arguments alpha
DeclareAttribute( "SomeReductionBySplitEpiSummand_MorphismToInputRange",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the morphism $\beta: B \rightarrow B'$
#! linking $\alpha$ with some reduction by split epi summands.
#! @Returns a morphism in $\mathrm{Hom}(B,B')$
#! @Arguments alpha
DeclareAttribute( "SomeReductionBySplitEpiSummand_MorphismFromInputRange",
                  IsCapCategoryMorphism );
