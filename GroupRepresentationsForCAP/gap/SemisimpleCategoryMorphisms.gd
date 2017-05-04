#############################################################################
##
##                                GroupRepresentationsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
#! @Chapter Semisimple Categories
##
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of morphisms in a semisimple category.
#! @Arguments object
DeclareCategory( "IsSemisimpleCategoryMorphism",
                 IsCapCategoryMorphism and IsCellOfSkeletalCategory);

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The arguments are
#! an object $s$
#! in a semisimple category $\bigoplus_{i \in I} k\mathrm{-vec}$,
#! a list of pairs $L = [ [ \phi_1, i_1 ], \dots [ \phi_l, i_l ] ]$
#! where $\phi_j$ are morphisms in the Matrix Category $k\mathrm{-vec}$
#! and $i_j \in I$,
#! and another object $r$
#! in the same semisimple category.
#! The output is a morphism
#! in $\bigoplus_{i \in I} k\mathrm{-vec}$
#! from $s$ to $r$
#! whose $i$-th component is given
#! by $\phi_i$.
#! For this morphism to be well defined,
#! there has to be an $\phi_i$ for every $i$
#! in the support of $s$ and $r$.
#! @Returns a morphism
#! @Arguments s, L, r
DeclareOperation( "SemisimpleCategoryMorphism",
                  [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s$
#! in a semisimple category $\bigoplus_{i \in I} k\mathrm{-vec}$,
#! a list of pairs $L = [ [ \phi_1, i_1 ], \dots [ \phi_l, i_l ] ]$
#! where $\phi_j$ are morphisms in the Matrix Category $k\mathrm{-vec}$
#! and $i_j \in I$,
#! and another object $r$
#! in the same semisimple category.
#! The output is a morphism
#! in $\bigoplus_{i \in I} k\mathrm{-vec}$
#! from $s$ to $r$
#! whose $i_j$-th component is given
#! by $\phi_{i_j}$ for $j = 1, \dots l$,
#! and by the zero morphism otherwise.
#! @Returns a morphism
#! @Arguments s, L, r
DeclareOperation( "SemisimpleCategoryMorphismSparse",
                  [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ] );

#! @Description
#! The arguments are
#! an object $v = \oplus_{i \in I} a_i \chi^{i}$
#! in a semisimple category $\bigoplus_{i \in I} k\mathrm{-vec}$,
#! and an object $j \in I$.
#! The output is the canonical inclusion
#! $a_j \chi^j \hookrightarrow \oplus_{i \in I} a_i \chi^{i}$
#! in $\bigoplus_{i \in I} k\mathrm{-vec}$.
#! @Returns a morphism
#! @Arguments v, j
DeclareOperation( "ComponentInclusionMorphism",
                  [ IsSemisimpleCategoryObject, IsObject ] );

#! @Description
#! The arguments are
#! an object $v = \oplus_{i \in I} a_i \chi^{i}$
#! in a semisimple category $\bigoplus_{i \in I} k\mathrm{-vec}$,
#! and an object $j \in I$.
#! The output is the canonical projection
#! $\oplus_{i \in I} a_i \chi^{i} \twoheadrightarrow a_j \chi^j$
#! in $\bigoplus_{i \in I} k\mathrm{-vec}$.
#! @Returns a morphism
#! @Arguments v, j
DeclareOperation( "ComponentProjectionMorphism",
                  [ IsSemisimpleCategoryObject, IsObject ] );

##
DeclareOperation( "CAP_INTERNAL_Create_Semisimple_Endomorphism_From_Sparse_String_List",
                  [ IsSemisimpleCategoryObject, IsList ] );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is a morphism
#! $\alpha = ( \alpha_i )_{i \in I}$
#! in a semisimple category $\bigoplus_{i \in I} k\mathrm{-vec}$.
#! The output is the list of pairs
#! $[ [ \alpha_{i_1}, i_1 ], \dots, [ \alpha_{i_l}, i_l ] ]$
#! where $i_j$ ranges through the support of the
#! source and range of $\alpha$.
#! @Returns a list
#! @Arguments alpha
DeclareAttribute( "SemisimpleCategoryMorphismList",
                  IsSemisimpleCategoryMorphism );

#! @Description
#! The argument is a morphism
#! $\alpha = ( \alpha_i )_{i \in I}$
#! in a semisimple category $\bigoplus_{i \in I} k\mathrm{-vec}$.
#! The output is the homalg field $k$.
#! @Returns a homalg field
#! @Arguments alpha
DeclareAttribute( "UnderlyingFieldForHomalg",
                  IsSemisimpleCategoryMorphism );

####################################
##
#! @Section Operations
##
####################################

#! @Description
#! The argument is a morphism
#! $\alpha = ( \alpha_i )_{i \in I}$
#! in a semisimple category $\bigoplus_{i \in I} k\mathrm{-vec}$
#! and an object $i \in I$.
#! The output is $\alpha_i$.
#! @Returns a vector space morphism 
#! @Arguments alpha, i
DeclareOperation( "Component", [ IsSemisimpleCategoryMorphism, IsObject ] );

