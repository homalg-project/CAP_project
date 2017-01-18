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

DeclareProperty( "IsOne", IsGZGradedIrreducibleObject );

####################################
##
#! @Section Operations
##
####################################

DeclareOperation( "Multiplicity", [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ] );

DeclareOperation( "\<", [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ] );

DeclareOperation( "\*", [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ] );

DeclareOperation( "AssociatorFromData", 
                  [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsList, IsFieldForHomalg, IsList ] );

#! @Description
#! The argument is a $G-\mathbb{Z}$-irreducible object $i$.
#! The output is 
#! a list $L = [ [ n_1, k_1 ], \dots, [ n_1, k_l ] ]$
#! consisting of positive integers $n_j$
#! and $G-\mathbb{Z}$-irreducible objects $k_j$,
#! corresponding
#! to the 
#! decomposition of the 
#! second exterior power character $\wedge^2 c$
#! into irreducibles.
#! Here, $c$ is the associated character of
#! $i$.
#! The underlying degree of the $k_j$ is
#! given by 2 times the underlying degree of $i$.
#! @Returns a list
#! @Arguments i
DeclareOperation( "ExteriorPower", [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ] );
