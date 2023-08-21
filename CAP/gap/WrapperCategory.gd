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
#!  The &GAP; category of objects in a wrapper CAP category.
DeclareCategory( "IsWrapperCapCategoryObject",
        IsCapCategoryObject );

#! @Description
#!  The &GAP; category of morphisms in a wrapper CAP category.
DeclareCategory( "IsWrapperCapCategoryMorphism",
        IsCapCategoryMorphism );

####################################
#
#! @Section Attributes
#
####################################

#! @Description
#!  The cell underlying the wrapper category object <A>object</A>.
#! @Arguments object
#! @Returns a category object
DeclareAttribute( "UnderlyingCell",
        IsWrapperCapCategoryObject );

##
CapJitAddTypeSignature( "UnderlyingCell",
        [ IsWrapperCapCategoryObject ],
  function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( ModelingCategory( input_types[1].category ) );
    
end );

#! @Description
#!  The cell underlying the wrapper category morphism <A>morphism</A>.
#! @Arguments morphism
#! @Returns a category morphism
DeclareAttribute( "UnderlyingCell",
        IsWrapperCapCategoryMorphism );

##
CapJitAddTypeSignature( "UnderlyingCell",
        [ IsWrapperCapCategoryMorphism ],
  function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( ModelingCategory( input_types[1].category ) );
    
end );

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

##
CapJitAddTypeSignature( "AsObjectInWrapperCategory",
        [ IsWrapperCapCategory, IsCapCategoryObject ],
  function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

#! @Description
#!  Wrap a morphism <A>morphism</A> (in the category underlying the wrapper category `CapCategory(`<A>source</A>`)`) to form a morphism in `CapCategory(`<A>source</A>`)`
#!  with given source and range.
#! @Arguments source, morphism, range
#! @Returns a morphism
DeclareOperation( "AsMorphismInWrapperCategory",
                  [ IsWrapperCapCategoryObject, IsCapCategoryMorphism, IsWrapperCapCategoryObject ] );

##
CapJitAddTypeSignature( "AsMorphismInWrapperCategory",
        [ IsWrapperCapCategory, IsWrapperCapCategoryObject, IsCapCategoryMorphism, IsWrapperCapCategoryObject ],
  function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

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
DeclareOperation( "/",
                [ IsCapCategoryCell, IsWrapperCapCategory ] );

#! @Description
#!  Wraps a category <A>category</A> to form a new category subject to the options given via <A>options</A>,
#!  which is a record with the following keys:
#!  * `name` (optional): the name of the wrapper category
#!  * `only_primitive_operations` (optional, default `false`): whether to only wrap primitive operations or all operations
#!
#!  Additionally, the following options of <Ref Oper="CategoryConstructor" Label="for IsRecord" /> are supported:
#!  `category_filter`, `category_object_filter`, `category_morphism_filter`.
#!  The filters must imply `IsWrapperCapCategory`, `IsWrapperCapCategoryObject`, and `IsWrapperCapCategoryMorphism`, respectively.
#! @Arguments category, options
#! @Returns a category
DeclareOperation( "WrapperCategory",
                  [ IsCapCategory, IsRecord ] );

#! @Description
#!  Return the functor from the wrapped category `ModelingCategory`(<A>W</A>) to the wrapper category <A>W</A>
#!  which simply wraps objects/morphisms.
#! @Arguments W
#! @Returns a functor
DeclareAttribute( "WrappingFunctor",
                  IsWrapperCapCategory );
