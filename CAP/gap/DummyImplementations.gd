# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#

#! @Chapter Dummy implementations
#! 
#! A dummy implementation of a concept seems to provide an interface for the concept, but calling any operation in this interface will simply signal an error.
#! Hence, when using a dummy implementation, we can be sure that we only rely on the abstract interface but not on any implementation details,
#! for the simple reason that there is no actual implementation.
#! This is useful for testing or compilation against a generic implementation of a concept.

####################################
#
#! @Section Dummy rings
#
####################################

####################################
#
# GAP filters
#
####################################

#= comment for Julia
# IsRingElement(WithOne) is a union of types, which we cannot subtype

#! @Description
#!  The &GAP; filter of dummy rings.
DeclareFilter( "IsDummyRing",
        IsRingWithOne );

#! @Description
#!  The &GAP; filter of elements of a dummy ring.
DeclareFilter( "IsDummyRingElement",
        IsRingElementWithOne );

#! @Description
#!  The &GAP; filter of dummy commutative rings.
DeclareFilter( "IsDummyCommutativeRing",
        IsDummyRing );

#! @Description
#!  The &GAP; filter of elements of a dummy commutative ring.
DeclareFilter( "IsDummyCommutativeRingElement",
        IsDummyRingElement );

#! @Description
#!  The &GAP; filter of dummy fields.
DeclareFilter( "IsDummyField",
        IsDummyCommutativeRing );

#! @Description
#!  The &GAP; filter of elements of a dummy field.
DeclareFilter( "IsDummyFieldElement",
        IsDummyCommutativeRingElement );
# =#

####################################
#
# Constructors
#
####################################

#! @Description
#! @Arguments
#! @Returns a dummy ring
DeclareGlobalFunction( "DummyRing" );

#! @Description
#! @Arguments
#! @Returns a dummy commutative ring
DeclareGlobalFunction( "DummyCommutativeRing" );

#! @Description
#! @Arguments
#! @Returns a dummy field
DeclareGlobalFunction( "DummyField" );

####################################
#
#! @Section Dummy categories
#
####################################

####################################
#
# GAP categories
#
####################################

#! @Description
#!  The &GAP; category of a dummy CAP category.
DeclareCategory( "IsDummyCategory",
        IsCapCategory );

#! @Description
#!  The &GAP; category of objects in a dummy CAP category.
DeclareCategory( "IsDummyCategoryObject",
        IsCapCategoryObject );

#! @Description
#!  The &GAP; category of morphisms in a dummy CAP category.
DeclareCategory( "IsDummyCategoryMorphism",
        IsCapCategoryMorphism );

####################################
#
# Constructors
#
####################################

#! @Description
#!  Creates a dummy category subject to the options given via <A>options</A>, which is a record passed on to <Ref Oper="CategoryConstructor" Label="for IsRecord" />.
#!  Note that the options `{category,object,morphism}_filter` will be set to `IsDummyCategory{,Object,Morphism}` and the options `{object,morphism}_{constructor,datum}` and
#!  `create_func_*` will be set to dummy implementations (throwing errors when actually called).
#!  The dummy category will pretend to support empty limits by default.
#! @Arguments options
#! @Returns a category
DeclareOperation( "DummyCategory",
                  [ IsRecord ] );
