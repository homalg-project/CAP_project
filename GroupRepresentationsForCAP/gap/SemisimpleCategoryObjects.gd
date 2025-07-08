# SPDX-License-Identifier: GPL-2.0-or-later
# GroupRepresentationsForCAP: Skeletal category of group representations for CAP
#
# Declarations
#
#! @Chapter Semisimple Categories

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of objects in a semisimple category.
#! @Arguments object
DeclareCategory( "IsSemisimpleCategoryObject",
                 IsCapCategoryObject );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The arguments are 
#! a list $L$
#! and a semisimple category $C = \bigoplus_{i \in I} k\mathrm{-vec}$.
#! The list $L$ contains pairs $L = [ [ a_1, i_1 ], \dots, [ a_l, i_l ] ]$
#! of non-negative integers $a_j$ and
#! objects $i_j \in I$.
#! The output is the object in $C$
#! given by $\oplus_{j=1}^l a_j \chi^{i_j}$.
#! @Returns an object
#! @Arguments L, C
DeclareOperation( "SemisimpleCategoryObject", [ IsList, IsCapCategory ] );

#! @Description
#! The arguments are 
#! a list $L$
#! and a semisimple category $C = \bigoplus_{i \in I} k\mathrm{-vec}$.
#! The list $L$ contains an even number of
#! elements $L = [ a_1, i_1, \dots, a_l, i_l ]$
#! of non-negative integers $a_j$ and
#! objects $i_j \in I$.
#! The output is the object in $C$
#! given by $\oplus_{j=1}^l a_j \chi^{i_j}$.
#! @Returns an object
#! @Arguments L, C
DeclareOperationWithCache( "SemisimpleCategoryObjectConstructorWithFlatList", [ IsList, IsCapCategory ] );


####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is an object $v = \oplus_{j=1}^l a_j \chi^{i_j}$
#! in a semisimple category.
#! The output is the list $[ [ a_1, i_1 ], \dots [ a_l, i_l ] ]$.
#! @Returns a list
#! @Arguments v
DeclareAttribute( "SemisimpleCategoryObjectList",
                  IsSemisimpleCategoryObject );

#! @Description
#! The argument is an object $v = \oplus_{j=1}^l a_j \chi^{i_j}$
#! in a semisimple category.
#! The output is the list $[ [ a_1, \chi^{i_1} ], \dots [ a_l, \chi^{i_l} ] ]$.
#! @Returns a list
#! @Arguments v
DeclareAttribute( "SemisimpleCategoryObjectListWithActualObjects",
                  IsSemisimpleCategoryObject );

#! @Description
#! The argument is an object $v = \oplus_{j=1}^l a_j \chi^{i_j}$
#! in a semisimple category.
#! The output is the list $[ i_1, \dots, i_l ]$.
#! @Returns a list
#! @Arguments v
DeclareAttribute( "Support",
                  IsSemisimpleCategoryObject );

#! @Description
#! The argument is an object $v = \oplus_{j=1}^l a_j \chi^{i_j}$
#! in a semisimple category $\bigoplus_{i \in I} k\mathrm{-vec}$.
#! The output is the homalg field $k$.
#! @Returns a homalg field
#! @Arguments v
DeclareAttribute( "UnderlyingFieldForHomalg",
                  IsSemisimpleCategoryObject );

#! @Description
#! The argument is an object $v = \oplus_{j=1}^l a_j \chi^{i_j}$
#! in a semisimple category $\bigoplus_{i \in I} k\mathrm{-vec}$.
#! The output is the integer $\sum_{j=1}^l a_j \cdot \mathrm{dim}( i_j )$.
#! This functions works under the assumption that there is
#! a notion of dimension on the objects in $I$.
#! @Returns an integer
#! @Arguments v
DeclareAttribute( "Dimension",
                  IsSemisimpleCategoryObject );


####################################
##
#! @Section Operations
##
####################################

#! @Description
#! The argument is a list $L = [ [ a_1, i_1 ], \dots, [ a_l, i_l ] ]$
#! of non-negative integers $a_j$ and
#! objects $i_j \in I$,
#! where $I$ correspond to irreducible objects
#! in a semisimple category $\bigoplus_{i \in I} k\mathrm{-vec}$.
#! The output is again a list of pairs
#! consisting of integers an elements in $I$,
#! but with the following normalization:
#! - Each $a_j$ is positive,
#! - $i_j$ is strictly less than $i_{j+1}$.
#! @Returns a list
#! @Arguments L
DeclareOperation( "NormalizeSemisimpleCategoryObjectList", [ IsList ] );

#! @Description
#! The arguments are an object
#! $v = \oplus_{j=1}^l a_j \chi^{i_j}$
#! in a semisimple category $\bigoplus_{i \in I} k\mathrm{-vec}$,
#! and an element $i \in I$.
#! The output is the integer $a_i$.
#! @Returns an integer
#! @Arguments v, i
DeclareOperation( "Multiplicity", [ IsSemisimpleCategoryObject, IsObject ] );

#! @Description
#! The arguments are an object
#! $v = \oplus_{j=1}^l a_j \chi^{i_j}$
#! in a semisimple category $\bigoplus_{i \in I} k\mathrm{-vec}$,
#! and an element $i \in I$.
#! The output is the $k$-vector space object $k^{a_i}$
#! in Cap's Matrix Category.
#! @Returns a vector space object
#! @Arguments v, i
DeclareOperation( "Component", [ IsSemisimpleCategoryObject, IsObject ] );
