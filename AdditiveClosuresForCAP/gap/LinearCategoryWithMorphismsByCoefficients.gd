# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#

#! @Chapter Reinterpret a linear category over a commutative semiring with free f.g. external Homs

####################################
#
#! @Section GAP categories
#
####################################

#! @Description
#!  The &GAP; category of a reinterpreted linear category over a commutative semiring with free f.g. external Homs.
DeclareCategory( "IsLinearCategoryWithMorphismsByCoefficients",
        IsCapCategory );

#! @Description
#!  The &GAP; category of objects in a reinterpreted linear category over a commutative semiring with free f.g. external Homs.
DeclareCategory( "IsObjectInLinearCategoryWithMorphismsByCoefficients",
        IsCapCategoryObject );

#! @Description
#!  The &GAP; category of morphisms in a reinterpreted linear category over a commutative semiring with free f.g. external Homs.
DeclareCategory( "IsMorphismInLinearCategoryWithMorphismsByCoefficients",
        IsCapCategoryMorphism );

####################################
#
#! @Section Attributes
#
####################################

#! @Description
#!  The datum underlying the object <A>obj</A>.
#! @Arguments obj
#! @Returns a GAP object
DeclareAttribute( "UnderlyingDatum",
        IsObjectInLinearCategoryWithMorphismsByCoefficients );

##
CapJitAddTypeSignature( "UnderlyingDatum",
        [ IsObjectInLinearCategoryWithMorphismsByCoefficients ],
  function ( input_types )
    
    return ObjectDatumType( input_types[1].category );
    
end );

#! @Description
#!  The pair consisting of an integer $n$ and a list of length $n$ of coefficients with respect to a basis.
#! @Arguments mor
#! @Returns a pair
DeclareAttribute( "PairOfIntAndListOfCoefficients",
        IsMorphismInLinearCategoryWithMorphismsByCoefficients );

##
CapJitAddTypeSignature( "PairOfIntAndListOfCoefficients",
        [ IsMorphismInLinearCategoryWithMorphismsByCoefficients ],
  function ( input_types )
    
    return MorphismDatumType( input_types[1].category );
    
end );

####################################
#
#! @Section Constructors
#
####################################

#! @Description
#!  Reinterprets the category <A>cat</A> to form a new category subject to the options given via <A>options</A>,
#!  which is a record with the following keys:
#!  * `name` (optional): the name of the wrapper category
#!
#!  Additionally, the following options of <Ref Oper="CategoryConstructor" Label="for IsRecord" BookName="CAP" /> are supported:
#!  `category_filter`, `category_object_filter`, `category_morphism_filter`.
#! @Arguments cat, options
#! @Returns a category
DeclareOperation( "LinearCategoryWithMorphismsByCoefficients",
        [ IsCapCategory, IsRecord ] );
