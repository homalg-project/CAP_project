# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Finite skeletal discrete categories

########################################
#
#! @Section &GAP; Categories
#
########################################

#! @Description
#!  The &GAP; type of a finite skeletal discrete category.
#! @Arguments C
DeclareCategory( "IsFiniteSkeletalDiscreteCategory", IsCapCategory );

#! @Description
#!  The &GAP; type of an object in a finite skeletal discrete category.
#! @Arguments O
DeclareCategory( "IsObjectInFiniteSkeletalDiscreteCategory", IsCapCategoryObject );

#! @Description
#!  The &GAP; type of a morphism in a finite skeletal discrete category.
#! @Arguments M
DeclareCategory( "IsMorphismInFiniteSkeletalDiscreteCategory", IsCapCategoryMorphism );

########################################
#
#! @Section Constructors
#
########################################

#! @Description
#!  Construct a finite skeletal discrete category.
#! @Returns a &CAP; category
DeclareGlobalFunction( "FiniteSkeletalDiscreteCategory" );

########################################
#
#! @Section Attributes
#
########################################

#! @Description
#!  The number of objects of a finite skeletal discrete category.
#! @Returns a list of &CAP; objects
DeclareAttribute( "NumberOfObjects", IsFiniteSkeletalDiscreteCategory );

CapJitAddTypeSignature( "NumberOfObjects", [ IsFiniteSkeletalDiscreteCategory ], IsBigInt );

#! @Description
#!  The index of an object in a finite skeletal discrete category.
#! @Returns an integer
DeclareAttribute( "IndexOfObject", IsObjectInFiniteSkeletalDiscreteCategory );

CapJitAddTypeSignature( "IndexOfObject", [ IsObjectInFiniteSkeletalDiscreteCategory ], IsBigInt );

####################################
#
#! @Section Properties
#
####################################

#! @Description
#!  The property of <A>C</A> being a discrete &CAP; category,
#!  i.e., equivalent to a category in which any morphism is an identity.
#! @Arguments C
DeclareProperty( "IsDiscreteCategory", IsCapCategory );

AddCategoricalProperty( [ "IsDiscreteCategory", "IsDiscreteCategory" ] );
