# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Category of rows

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of objects in the category
#! of rows over a ring $R$.
#! @Arguments object
DeclareCategory( "IsCategoryOfRowsObject",
                 IsCapCategoryObject );

DeclareCategory( "IsCategoryOfRowsMorphism",
                 IsCapCategoryMorphism );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_CATEGORY_OF_ROWS" );

DeclareCategory( "IsCategoryOfRows",
                 IsCapCategory );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "CategoryOfRows",
                  [ IsHomalgRing ] );

DeclareOperation( "CategoryOfRowsObject",
                  [ IsInt, IsCategoryOfRows ] );

KeyDependentOperation( "CategoryOfRowsObject",
                       IsCategoryOfRows, IsInt, ReturnTrue );

DeclareOperation( "AsCategoryOfRowsMorphism",
                  [ IsHomalgMatrix, IsCategoryOfRows ] );

DeclareOperation( "CategoryOfRowsMorphism",
                  [ IsCategoryOfRowsObject, IsHomalgMatrix, IsCategoryOfRowsObject ] );

DeclareOperation( "\/",
                  [ IsHomalgMatrix, IsCategoryOfRows ] );

KeyDependentOperation( "StandardRowMorphism",
                       IsCategoryOfRowsObject, IsInt, ReturnTrue );

####################################
##
#! @Section Random Methods in Category of Rows
##
####################################

if false then

#! @Description
#! The arguments are a category <A>C</A> and a non-empty list <A>L</A> of non-negative integers.
#! The output is an object whose rank is a random element in <A>L</A>.
#! @Returns an object in a category of rows
#! @Arguments C, L
DeclareOperation( RandomObjectByList, [ IsCategoryOfRows, IsList ] );

#! @Description
#! The arguments are a category of rows <A>C</A> and a non-negative integer <A>n</A>.
#! The output is an object whose rank is at most <A>n</A>.
#! @Returns an object in a category of rows
#! @Arguments C, n
DeclareOperation( RandomObjectByInteger, [ IsCategoryOfRows, IsInt ] );

#! @Description
#! The arguments are two objects <A>S</A>, <A>R</A> and a list <A>L</A> of integers or elements in the underlying ring.
#! The output is a morphism from <A>S</A> to <A>R</A> whose matrix is an <A>L</A>-linear combination of random
#! matrices over the underlying ring.
#! @Returns  a morphism in a category of rows
#! @Arguments S, R, L
DeclareOperation( RandomMorphismWithFixedSourceAndRangeByList, [ IsCategoryOfRowsObject, IsCategoryOfRowsObject, IsList ] );

#! @Description
#! The arguments are two objects <A>S</A>, <A>R</A> and an integer <A>n</A>.
#! The output is a morphism from <A>S</A> to <A>R</A> defined by a random matrix over the underlying ring.
#! Particularly, the argument <A>n</A> will be disregarded.
#! @Returns  a morphism in a category of rows
#! @Arguments S, R, n
DeclareOperation( RandomMorphismWithFixedSourceAndRangeByInteger, [ IsCategoryOfRowsObject, IsCategoryOfRowsObject, IsInt ] );

#! @Description
#! The arguments are an object <A>S</A> and a list <A>L</A> consisting of two lists: a non-empty list of non-negative integers and a list of integers or elements in the underlying ring.
#! The output is a morphism from <A>S</A> to an object <A>R</A> whose rank is a random element in <A>L</A>[1].
#! The matrix of the morphism is an <A>L</A>[2]-linear combination of random matrices over the underlying ring.
#! @Returns a morphism in a category of rows
#! @Arguments S, L
DeclareOperation( RandomMorphismWithFixedSourceByList, [ IsCategoryOfRowsObject, IsList ] );

#! @Description
#! The arguments are an object <A>S</A> and a non-negative integer <A>n</A>.
#! The output is a morphism from <A>S</A> to an object <A>R</A> whose rank is at most <A>n</A>.
#! @Returns  a morphism in a category of rows
#! @Arguments S, n
DeclareOperation( RandomMorphismWithFixedSourceByInteger, [ IsCategoryOfRowsObject, IsInt ] );

#! @Description
#! The arguments are an object <A>R</A> and a list <A>L</A> consisting of two lists: a non-empty list of non-negative integers and a list of integers or elements in the underlying ring.
#! The output is a morphism to <A>R</A> from an object <A>S</A> whose rank is a random element in <A>L</A>[1].
#! The matrix of the morphism is an <A>L</A>[2]-linear combination of random matrices over the underlying ring.
#! @Returns a morphism in a category of rows
#! @Arguments R, L
DeclareOperation( RandomMorphismWithFixedRangeByList, [ IsCategoryOfRowsObject, IsList ] );

#! @Description
#! The arguments are an object <A>R</A> and a non-negative integer <A>n</A>.
#! The output is a morphism to <A>R</A> from an object <A>S</A> whose rank is at most <A>n</A>.
#! @Returns a morphism in a category of rows
#! @Arguments R, n
DeclareOperation( RandomMorphismWithFixedRangeByInteger, [ IsCategoryOfRowsObject, IsInt ] );

#! @Description
#! The arguments are a category of rows <A>C</A> and a list <A>L</A> consisting of 3 lists: two non-empty lists of non-negative integers and a list of integers or elements in the underlying ring.
#! The output is a morphism from an object <A>S</A> to an object <A>R</A> whose ranks are random elements in <A>L</A>[1] resp. <A>L</A>[2].
#! Its matrix is an <A>L</A>[3]-linear combination of random matrices over the underlying ring.
#! @Returns  a morphism in a category of rows
#! @Arguments C, L
DeclareOperation( RandomMorphismByList, [ IsCategoryOfRows, IsList ] );

#! @Description
#! The arguments are a category of rows <A>C</A> and a non-negative integer <A>n</A>.
#! The output is a morphism whose source and range ranks are at most <A>n</A>.
#! @Returns  a morphism in a category of rows
#! @Arguments C, n
DeclareOperation( RandomMorphismByInteger, [ IsCategoryOfRows, IsInt ] );

fi;


####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingRing",
                  IsCategoryOfRows );
CapJitAddTypeSignature( "UnderlyingRing", [ IsCategoryOfRows ], IsHomalgRing );

DeclareAttribute( "BasisOfRingOverBaseFieldAsColumnVector",
                  IsCategoryOfRows );

CapJitAddTypeSignature( "BasisOfRingOverBaseFieldAsColumnVector", [ IsCategoryOfRows ], function ( input_types )
    
    Assert( 0, IsHomalgRing( UnderlyingRing( input_types[1].category ) ) );
    
    return rec( filter := IsHomalgMatrix );
    
end );

DeclareAttribute( "RankOfObject",
                  IsCategoryOfRowsObject );
CapJitAddTypeSignature( "RankOfObject", [ IsCategoryOfRowsObject ], IsInt );

DeclareAttribute( "UnderlyingMatrix",
                  IsCategoryOfRowsMorphism );
CapJitAddTypeSignature( "UnderlyingMatrix", [ IsCategoryOfRowsMorphism ], IsHomalgMatrix );

DeclareAttribute( "CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple",
                  IsCategoryOfRowsMorphism );

CapJitAddTypeSignature( "CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple", [ IsCategoryOfRowsMorphism ], rec(
    filter := IsNTuple,
    element_types := [
        rec( filter := IsHomalgMatrix ),
        rec( filter := IsHomalgMatrix ),
        rec( filter := IsHomalgMatrix ),
    ],
) );

####################################
##
#! @Section Global functions
##
####################################

DeclareGlobalFunction( "CATEGORY_OF_ROWS_SimplificationSourceAndRangeTuple" );

DeclareGlobalFunction( "CATEGORY_OF_ROWS_SimplificationSourceTuple" );

DeclareGlobalFunction( "CATEGORY_OF_ROWS_SimplificationRangeTuple" );
