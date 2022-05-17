# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#

#! @Chapter Dummy categories
#! 
#! A dummy category pretends to support certain CAP operations but has not actual implementation.
#! This is useful for testing or compiling against a certain set of CAP operations.

####################################
#
#! @Section GAP categories
#
####################################

#! @Description
#!  The &GAP; category of a dummy CAP category.
DeclareCategory( "IsDummyCategory",
        IsCapCategory );

#! @Description
#!  The &GAP; category of cells in a dummy CAP category.
DeclareCategory( "IsDummyCategoryCell",
        IsCapCategoryCell );

#! @Description
#!  The &GAP; category of objects in a dummy CAP category.
DeclareCategory( "IsDummyCategoryObject",
        IsDummyCategoryCell and IsCapCategoryObject );

#! @Description
#!  The &GAP; category of morphisms in a dummy CAP category.
DeclareCategory( "IsDummyCategoryMorphism",
        IsDummyCategoryCell and IsCapCategoryMorphism );

####################################
#
#! @Section Constructors
#
####################################

#! @Description
#!  Creates a dummy category subject to the options given via <A>options</A>, which is a record passed on to <Ref Oper="CategoryConstructor" Label="for IsRecord" />.
#!  Note that the options `{category,object,morphism}_filter` will be set to `IsDummyCategory{,Object,Morphism}` and
#!  `create_func_*` will be set to dummy implementations (throwing errors when actually called).
#!  The dummy category will pretend to support empty limits by default.
#! @Arguments options
#! @Returns a category
DeclareOperation( "DummyCategory",
                  [ IsRecord ] );
