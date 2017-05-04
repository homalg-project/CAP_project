#############################################################################
##
##                                GroupRepresentationsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
#! @Chapter Irreducible Objects
##
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

DeclareCategory( "IsGZGradedIrreducibleObject",
                 IsObject );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The argument is 
#! an integer $n$
#! and a character $c$ of a group.
#! The output is their associated $G-\mathbb{Z}$-irreducible object.
#! @Returns a $G-\mathbb{Z}$-irreducible object
#! @Arguments n, c
DeclareOperationWithCache( "GZGradedIrreducibleObject", [ IsInt, IsCharacter ] );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is a $G-\mathbb{Z}$-irreducible object $i$.
#! The output is its underlying character.
#! @Returns an irreducible character
#! @Arguments i
DeclareAttribute( "UnderlyingCharacter", IsGZGradedIrreducibleObject );

#! @Description
#! The argument is a $G-\mathbb{Z}$-irreducible object $i$.
#! The output is its underlying degree.
#! @Returns an integer
#! @Arguments i
DeclareAttribute( "UnderlyingDegree", IsGZGradedIrreducibleObject );

#! @Description
#! The argument is a $G-\mathbb{Z}$-irreducible object $i$.
#! The output is its underlying group.
#! @Returns a group
#! @Arguments i
DeclareAttribute( "UnderlyingGroup", IsGZGradedIrreducibleObject );

#! @Description
#! The argument is a $G-\mathbb{Z}$-irreducible object $i$.
#! The output is the character table of its underlying group.
#! @Returns a character table
#! @Arguments i
DeclareAttribute( "UnderlyingCharacterTable", IsGZGradedIrreducibleObject );

#! @Description
#! The argument is a $G-\mathbb{Z}$-irreducible object $i$.
#! The output is a list consisting of the irreducible characters
#! of its underlying group.
#! @Returns a list
#! @Arguments i
DeclareAttribute( "UnderlyingIrreducibleCharacters", IsGZGradedIrreducibleObject );

#! @Description
#! The argument is a $G-\mathbb{Z}$-irreducible object $i$.
#! The output is the integer $n$ such that
#! the $n$-th entry of the list of the underlying irreducible characters
#! is the underlying irreducible character of $i$.
#! @Returns an integer
#! @Arguments i
DeclareAttribute( "UnderlyingCharacterNumber", IsGZGradedIrreducibleObject );

#! @Description
#! The argument is a $G-\mathbb{Z}$-irreducible object $i$.
#! The output is the dimension of its underlying irreducible character.
#! @Returns an integer
#! @Arguments i
DeclareAttribute( "Dimension", IsGZGradedIrreducibleObject );

#! @Description
#! The argument is a $G-\mathbb{Z}$-irreducible object $i$.
#! The output is the $G-\mathbb{Z}$-irreducible object associated
#! to the degree $-n$ and the dual character of $c$, 
#! where $n$ is the underlying degree
#! and $c$ is the underlying character of $i$.
#! @Returns a $G-\mathbb{Z}$-irreducible object
#! @Arguments i
DeclareAttribute( "Dual", IsGZGradedIrreducibleObject );

####################################
##
#! @Section Properties
##
####################################

#! @Description
#! The argument is a $G-\mathbb{Z}$-irreducible object $i$.
#! The output is true if the underlying character of $i$
#! is the trivial one, false otherwise.
#! @Returns a boolean
#! @Arguments i
DeclareProperty( "IsYieldingIdentities", IsGZGradedIrreducibleObject );

####################################
##
#! @Section Operations
##
####################################

#! @Description
#! The arguments are 3 $G-\mathbb{Z}$-irreducible objects $i,j,k$.
#! Let their underlying characters be denoted by $a,b,c$, respectively,
#! and their underlying degrees by $n_i, n_j, n_k$, respectively.
#! The output is $0$ if $n_i$ is not equal to $n_j + n_k$.
#! Otherwise, the output is the number $\langle a, b\cdot c \rangle$,
#! i.e., the multiplicity of $a$ in the product of characters $b \cdot c$.
#! @Returns an integer
#! @Arguments i, j, k
DeclareOperation( "Multiplicity", [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ] );

##
DeclareOperation( "Multiplicity", 
  [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ] );

# @Description
# The arguments are 2 $G-\mathbb{Z}$-irreducible objects $i,j$.
#! Let their underlying characters be denoted by $a,b$, respectively,
#! and their underlying degrees by $n_i, n_j$, respectively.
# The output is true if $n_i < n_j$ or
#! if $n_i = n_j$ and 
#! the underlying character number of $j$
# is greater than the underlying character number of $i$.
# Otherwise, the output is false.
# @Returns a boolean
# @Arguments i, j
DeclareOperation( "\<", [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ] );

#! @Description
#! The arguments are 2 $G-\mathbb{Z}$-irreducible objects $i,j$
#! with underlying irreducible characters $a,b$, respectively.
#! The output is a list
#! L = $[ [ n_1, k_1 ], \dots, [ n_l, k_l ] ]$
#! consisting of positive integers $n_c$ and $G$-irreducible objects $k_c$
#! representing the character decomposition into irreducibles
#! of the product $a\cdot b$.
#! The underlying degrees of $k_c$ are given by the sum of
#! the underlying degrees of $i$ and $j$.
#! @Returns a list
#! @Arguments i, j
DeclareOperation( "\*", [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ] );

##
DeclareOperation( "TensorProductOfIrreduciblesOp", [ IsList, IsGZGradedIrreducibleObject ] );

#! @Description
#! The arguments are
#! - three $G-\mathbb{Z}$-irreducible objects $i,j,k$,
#! - a list $A$ containing the associator on all irreducibles (of $G$-irreducible objects) as strings,
#!   e.g., the list constructed by the methods provided in this package,
#! - a homalg field $F$,
#! - a list L = $[ [ n_1, h_1 ], \dots, [ n_l, h_l ] ]$
#!   consisting of positive integers $n_c$ and $G-\mathbb{Z}$-irreducible objects $h_c$
#!   representing the character decomposition into irreducibles of the product of $i,j,k$.
#! The output is the list
#! $[ [ \alpha_{h_1}, h_1 ], \dots, [ \alpha_{h_l}, h_l ] ]$,
#! where $\alpha_{h_c}$ is the $F$-vector space homomorphism
#! representing the $h_c$-th component of the associator of $i,j,k$.
#! @Returns a list
#! @Arguments i, j, k, A, F, L
DeclareOperation( "AssociatorFromData", 
                  [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsList, IsFieldForHomalg, IsList ] );

##
DeclareOperation( "AssociatorStringListFromData", 
                  [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsList ] );


#! @Description
#! The arguments are two $G-\mathbb{Z}$-irreducible objects $i, j$.
#! The output is the empty list if the underlying characters of $i$
#! and $j$ are unequal.
#! Otherwise, the output is 
#! a list $L = [ [ n_1, k_1 ], \dots, [ n_1, k_l ] ]$
#! consisting of positive integers $n_j$
#! and $G-\mathbb{Z}$-irreducible objects $k_a$,
#! corresponding
#! to the 
#! decomposition of the 
#! second exterior power character $\wedge^2 c$
#! into irreducibles.
#! Here, $c$ is the associated character of
#! $i$ and $j$.
#! The underlying degree of $k_a$ is the sum of 
#! the underlying degrees of $i$ and $j$.
#! @Returns a list
#! @Arguments i, j
DeclareOperation( "ExteriorPower", [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ] );
