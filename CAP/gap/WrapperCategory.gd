# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#

#! @Chapter Create wrapper hulls of a category

####################################
#
#! @Section GAP categories
#
####################################

#! @Description
#!  The &GAP; category of a wrapper CAP category.
DeclareCategory( "IsWrapperCapCategory",
        IsCapCategory );

#! @Description
#!  The &GAP; category of cells in a wrapper CAP category.
DeclareCategory( "IsWrapperCapCategoryCell",
        IsCapCategoryCell );

#! @Description
#!  The &GAP; category of objects in a wrapper CAP category.
DeclareCategory( "IsWrapperCapCategoryObject",
        IsWrapperCapCategoryCell and IsCapCategoryObject );

#! @Description
#!  The &GAP; category of morphisms in a wrapper CAP category.
DeclareCategory( "IsWrapperCapCategoryMorphism",
        IsWrapperCapCategoryCell and IsCapCategoryMorphism );

####################################
#
#! @Section Attributes
#
####################################

#! @Description
#!  The category underlying the wrapper category <A>category</A>.
#! @Arguments category
#! @Returns a category
DeclareAttribute( "UnderlyingCategory",
        IsWrapperCapCategory );

#! @Description
#!  The cell underlying the wrapper category cell <A>cell</A>.
#! @Arguments cell
#! @Returns a category cell
DeclareAttribute( "UnderlyingCell",
        IsWrapperCapCategoryCell );

####################################
#
#! @Section Constructors
#
####################################

#! @Description
#!  Wrap an object <A>object</A> (in the category underlying the wrapper category <A>category</A>) to form an object in <A>category</A>.
#! @Arguments category, object
#! @Returns an object
DeclareOperation( "AsObjectInWrapperCategory",
                  [ IsWrapperCapCategory, IsCapCategoryObject ] );

#! @Description
#!  Wrap a morphism <A>morphism</A> (in the category underlying the wrapper category `CapCategory(`<A>source</A>`)`) to form a morphism in `CapCategory(`<A>source</A>`)`
#!  with given source and range.
#! @Arguments source, morphism, range
#! @Returns a morphism
DeclareOperation( "AsMorphismInWrapperCategory",
                  [ IsWrapperCapCategoryObject, IsCapCategoryMorphism, IsWrapperCapCategoryObject ] );

#! @Description
#!  Wrap a morphism <A>morphism</A> (in the category underlying the wrapper category <A>category</A>) to form a morphism in <A>category</A>.
#! @Arguments category, morphism
#! @Returns a morphism
DeclareOperation( "AsMorphismInWrapperCategory",
                  [ IsWrapperCapCategory, IsCapCategoryMorphism ] );

#! @Description
#!  Convenience method for <Ref Oper="AsObjectInWrapperCategory" Label="for IsWrapperCapCategory, IsCapCategoryObject" />
#!  and <Ref Oper="AsMorphismInWrapperCategory" Label="for IsWrapperCapCategory, IsCapCategoryMorphism" />.
#! @Arguments cell, category
DeclareOperation( "\/",
                [ IsCapCategoryCell, IsWrapperCapCategory ] );

#! @Description
#!  Wraps a category <A>category</A> to form a new category subject to the options given via <A>options</A>,
#!  which is a record with the following keys:
#!  * `name` (optional): the name of the wrapper category
#!  * `only_primitive_operations` (optional, default `false`): whether to only wrap primitive operations or all operations
#!  * `wrap_range_of_hom_structure` (optional, default `false`): whether to wrap the range category of the homomorphism structure
#!
#!  Additionally, the following options of <Ref Oper="CategoryConstructor" Label="for IsRecord" /> are supported:
#!  `category_filter`, `category_object_filter`, `category_morphism_filter`, `object_constructor`, `object_datum`, `morphism_constructor`, `morphism_datum`.
#! @Arguments category, options
#! @Returns a category
DeclareOperation( "WrapperCategory",
                  [ IsCapCategory, IsRecord ] );


#! @Description
#!  Return the functor from the wrapped category <C>UnderlyingCategory</C>(<A>W</A>) to the wrapper category <A>W</A>.
#!  The functor maps each wrapped object/morphism to its wrapping object/morphism.
#! @Arguments W
#! @Returns a functor
DeclareAttribute( "WrappingFunctor",
                  IsWrapperCapCategory );
