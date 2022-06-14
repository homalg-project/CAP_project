# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#

#! @Chapter Create wrapper hulls of a category

#! The support for building towers of category constructors is one
#! of the main design features of CAP. Many categories that
#! appear in the various applications can be modeled by towers
#! of multiple category constructors.
#! The wrapper category constructor allows adding
#! one last layer on top which allows expressing
#! the desired (re)interpretation of such a modeling tower.
#! In particular, the wrapper category constructor allows specifying
#! the name of the category together with customized methods for the operations
#! * ObjectConstructor
#! * MorphismConstructor
#! * ObjectDatum
#! * MorphismDatum
#! in order to reflect the desired interpretation with
#! a user-interface that is independent of the modeling tower.
#! Note that the same tower might have multiple interpretations.
#! 
#! <Table Align="|c|">
#! <Caption>A tower of categories modeling the category <C>W</C></Caption>
#! <HorLine/>
#! <Row>
#!   <Item><C>W := WrapperCategory( cat_n )</C></Item>
#! </Row>
#! <HorLine/>
#! <Row>
#!   <Item><C>cat_n := CategoryConstructor_n( cat_{n-1} )</C></Item>
#! </Row>
#! <HorLine/>
#! <Row>
#!   <Item>...</Item>
#! </Row>
#! <HorLine/>
#! <Row>
#!   <Item><C>cat_1 := CategoryConstructor_1( non_categorical_input )</C></Item>
#! </Row>
#! <HorLine/>
#! </Table>
#! The wrapper category <C>W</C> is by construction equivalent
#! to the top category <C>cat_n</C> in the tower.
#! In practice, the word <Q>tower</Q> stands more generally for a finite poset
#! with a greatest element.

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
#!  The category used to model the wrapper category <A>category</A>.
#! @Arguments category
#! @Returns a category
DeclareAttribute( "ModelingCategory",
        IsWrapperCapCategory );

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
#!  Return the functor from the wrapped category <C>ModelingCategory</C>(<A>W</A>) to the wrapper category <A>W</A>.
#!  The functor maps each wrapped object/morphism to its wrapping object/morphism.
#! @Arguments W
#! @Returns a functor
DeclareAttribute( "WrappingFunctor",
                  IsWrapperCapCategory );
