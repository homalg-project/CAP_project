# SPDX-License-Identifier: GPL-2.0-or-later
# GroupRepresentationsForCAP: Skeletal category of group representations for CAP
#
# Declarations
#
#! @Chapter Irreducible Objects

#! @Section Introduction
#! For a semisimple category $C$ of the form
#! $\bigoplus_{i \in I} k\mathrm{-vec}$
#! to become a rigid symmetric closed monoidal skeletal category,
#! the set $I$ has to be equipped with extra strucutre.
#! To become a skeletal category, we need:
#! - a total ordering on $I$.
#! To become a monoidal category, we need:
#! - a function $\texttt{IsYieldingIdentities}$, deciding whether an object
#!   yields the identity whenever it is part of an associator triple or a braiding pair,
#! - functions  $\texttt{Multiplicity}$ and $\texttt{*}$, defining the tensor product on objects,
#! - a function $\texttt{AssociatorFromData}$, defining the tensor product on morphisms.
#! To become a symmetric monoidal category, we need:
#! - a function $\texttt{ExteriorPower}$.
#! To become a rigid symmetric monoidal category, we need:
#! - a function $\texttt{Dual}$, defining duals on objects.
#! In the following, two families
#! of such sets $I$ are introduced:
#! - $\texttt{GIrreducibleObject}$: For a group $G$, the set $I$ consists of the irreducible characters of $G$.
#!  We call the elements in $I$ the $G$-irreducible objects.
#! - $\texttt{GZGradedIrreducibleObject}$: For a group $G$, the set $I$ consists of 
#!  the irreducible characters of $G$ together with a degree $n \in \mathbb{Z}$.
#!  We call the elements in $I$ the $G-\mathbb{Z}$-irreducible objects.

####################################
##
#! @Section GAP Categories
##
####################################

DeclareCategory( "IsGIrreducibleObject",
                 IsObject );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The argument is a character $c$ of a group.
#! The output is its associated $G$-irreducible object.
#! @Returns a $G$-irreducible object
#! @Arguments c
DeclareAttribute( "GIrreducibleObject", IsCharacter );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is a $G$-irreducible object $i$.
#! The output is its underlying character.
#! @Returns an irreducible character
#! @Arguments i
DeclareAttribute( "UnderlyingCharacter", IsGIrreducibleObject );

#! @Description
#! The argument is a $G$-irreducible object $i$.
#! The output is its underlying group.
#! @Returns a group
#! @Arguments i
DeclareAttribute( "UnderlyingGroup", IsGIrreducibleObject );

#! @Description
#! The argument is a $G$-irreducible object $i$.
#! The output is the character table of its underlying group.
#! @Returns a character table
#! @Arguments i
DeclareAttribute( "UnderlyingCharacterTable", IsGIrreducibleObject );

#! @Description
#! The argument is a $G$-irreducible object $i$.
#! The output is a list consisting of the irreducible characters
#! of its underlying group.
#! @Returns a list
#! @Arguments i
DeclareAttribute( "UnderlyingIrreducibleCharacters", IsGIrreducibleObject );

#! @Description
#! The argument is a $G$-irreducible object $i$.
#! The output is the integer $n$ such that
#! the $n$-th entry of the list of the underlying irreducible characters
#! is the underlying irreducible character of $i$.
#! @Returns an integer
#! @Arguments i
DeclareAttribute( "UnderlyingCharacterNumber", IsGIrreducibleObject );

#! @Description
#! The argument is a $G$-irreducible object $i$.
#! The output is the dimension of its underlying irreducible character.
#! @Returns an integer
#! @Arguments i
DeclareAttribute( "Dimension", IsGIrreducibleObject );

#! @Description
#! The argument is a $G$-irreducible object $i$.
#! The output is the $G$-irreducible object associated
#! to the dual character of $c$, where $c$ is the associated character of
#! $i$.
#! @Returns a $G$-irreducible object
#! @Arguments i
DeclareAttribute( "Dual", IsGIrreducibleObject );

####################################
##
#! @Section Properties
##
####################################

#! @Description
#! The argument is a $G$-irreducible object $i$.
#! The output is true if the underlying character of $i$
#! is the trivial one, false otherwise.
#! @Returns a boolean
#! @Arguments i
DeclareProperty( "IsYieldingIdentities", IsGIrreducibleObject );

####################################
##
#! @Section Operations
##
####################################

#! @Description
#! The arguments are 3 $G$-irreducible objects $i,j,k$.
#! Let their underlying characters be denoted by $a,b,c$, respectively.
#! Then the output is the number $\langle a, b\cdot c \rangle$,
#! i.e., the multiplicity of $a$ in the product of characters $b \cdot c$.
#! @Returns an integer
#! @Arguments i, j, k
DeclareOperation( "Multiplicity", [ IsGIrreducibleObject, IsGIrreducibleObject, IsGIrreducibleObject ] );

# @Description
# The arguments are 2 $G$-irreducible objects $i,j$.
# The output is true if the underlying character number of $j$
# is greater than the underlying character number of $i$,
# false otherwise.
# @Returns a boolean
# @Arguments i, j
DeclareOperation( "\<", [ IsGIrreducibleObject, IsGIrreducibleObject ] );

#! @Description
#! The arguments are 2 $G$-irreducible objects $i,j$
#! with underlying irreducible characters $a,b$, respectively.
#! The output is a list
#! L = $[ [ n_1, k_1 ], \dots, [ n_l, k_l ] ]$
#! consisting of positive integers $n_c$ and $G$-irreducible objects $k_c$
#! representing the character decomposition into irreducibles
#! of the product $a\cdot b$.
#! @Returns a list
#! @Arguments i, j
DeclareOperation( "\*", [ IsGIrreducibleObject, IsGIrreducibleObject ] );

#! @Description
#! The arguments are
#! - three $G$-irreducible objects $i,j,k$,
#! - a list $A$ containing the associator on all irreducibles as strings,
#!   e.g., the list constructed by the methods provided in this package,
#! - a matrix category `vec` of a homalg field $F$,
#! - a list L = $[ [ n_1, h_1 ], \dots, [ n_l, h_l ] ]$
#!   consisting of positive integers $n_c$ and $G$-irreducible objects $h_c$
#!   representing the character decomposition into irreducibles of the product of $i,j,k$.
#! The output is the list
#! $[ [ \alpha_{h_1}, h_1 ], \dots, [ \alpha_{h_l}, h_l ] ]$,
#! where $\alpha_{h_c}$ is the $F$-vector space homomorphism
#! representing the $h_c$-th component of the associator of $i,j,k$.
#! @Returns a list
#! @Arguments i, j, k, A, vec, L
DeclareOperation( "AssociatorFromData", 
                  [ IsGIrreducibleObject, IsGIrreducibleObject, IsGIrreducibleObject, IsList, IsMatrixCategory, IsList ] );

#! @Description
#! The arguments are two $G$-irreducible objects $i, j$.
#! The output is the empty list if $i$ is not equal to $j$.
#! Otherwise, the output is 
#! a list $L = [ [ n_1, k_1 ], \dots, [ n_1, k_l ] ]$
#! consisting of positive integers $n_j$
#! and $G$-irreducible objects $k_j$,
#! corresponding
#! to the 
#! decomposition of the 
#! second exterior power character $\wedge^2 c$
#! into irreducibles.
#! Here, $c$ is the associated character of
#! $i$.
#! @Returns a list
#! @Arguments i, j
DeclareOperation( "ExteriorPower", [ IsGIrreducibleObject, IsGIrreducibleObject ] );

