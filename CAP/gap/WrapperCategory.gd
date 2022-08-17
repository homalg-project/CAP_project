# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#

#! @Chapter Create wrapper hulls of a category
#!
#! @Section Introduction
#!
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
#! a user-interface that is independent of the modeling tower (see below for details).
#! Note that the same tower might have multiple interpretations.
#! 
#! <Table Align="|c|">
#! <Caption>A tower of categories modeling the category `W`</Caption>
#! <HorLine/>
#! <Row>
#!   <Item>`W := WrapperCategory( cat_n )`</Item>
#! </Row>
#! <HorLine/>
#! <Row>
#!   <Item>`cat_n := CategoryConstructor_n( cat_{n-1} )`</Item>
#! </Row>
#! <HorLine/>
#! <Row>
#!   <Item>...</Item>
#! </Row>
#! <HorLine/>
#! <Row>
#!   <Item>`cat_1 := CategoryConstructor_1( non_categorical_input )`</Item>
#! </Row>
#! <HorLine/>
#! </Table>
#! The wrapper category `W` is isomorphic
#! to the top category `cat_n` in the tower.
#! In practice, the word <Q>tower</Q> stands more generally for a finite poset
#! with a greatest element.
#!
#! @Section How to equip a tower with a custom data structure?
#!
#! To equip a tower with a custom data structure, wrap it using
#! <Ref Oper="WrapperCategory" Label="for IsCapCategory, IsRecord" /> with the options described
#! in the following.
#! Modeling `CategoryOfColumns( R )` as `Opposite( CategoryOfRows( R ) )` will be
#! our guiding example (see `CategoryOfColumnsAsOppositeOfCategoryOfRows.gi` in
#! `FreydCategoriesForCAP` for a full implementation).
#! <Enum>
#! <Item>
#!     Set the options `category_filter`, `category_object_filter`, and `category_morphism_filter`
#!     to the filters corresponding to the custom data structure, e.g. `IsCategoryOfColumns`,
#!     `IsCategoryOfColumsObject`, and `IsCategoryOfColumsMorphism`.
#! </Item>
#! <Item>
#!     Set `object_constructor`, `object_datum`, `morphism_constructor`, and `morphism_datum`
#!     to the functions one would write for `ObjectConstructor` and so on for a primitive implementation.
#!     In our example, `object_constructor` takes the wrapper category (which `IsCategoryOfColumns` due
#!     to the filter set in the first step) and an integer, and returns a CAP object
#!     in the category with attribute `Dimension` set to the integer, just like a primitive
#!     implementation of `CategoryOfColumns` would do.
#! </Item>
#! <Item>
#!     Set `modeling_tower_object_constructor`, `modeling_tower_object_datum`,
#!    `modeling_tower_morphism_constructor`, and `modeling_tower_morphism_datum`:
#!    `modeling_tower_object_constructor` gets the same input as `object_constructor` but must return
#!    the corresponding object in the tower. `modeling_tower_object_datum` has the same output as `object_datum`
#!    but gets the wrapper category and an object in the tower as an input.
#!    In our example, `modeling_tower_object_constructor` gets the wrapper category and an integer
#!    as in step 2 and wraps the integer as a `CategoryOfRowsObject` and the result as an opposite
#!    object. `modeling_tower_object_datum` gets the wrapper category and an object in
#!    `Opposite( CategoryOfRows( R ) )` (that is, an integer wrapped in a category of rows object
#!    wrapped in an opposite object) and returns the underlying integer.
#!    `modeling_tower_morphism_constructor` and `modeling_tower_morphism_datum` are given analogously.
#! </Item>
#! </Enum>
#! By composing `modeling_tower_object_datum` with `object_constructor` and `modeling_tower_morphism_datum` with `morphism_constructor`
#! (with suitable source and range), `WrapperCategory` defines a functor "Wrapping" from `cat_n` to `W`.
#! Similarly, it defines a functor "Unwrapping" from `W` to `cat_n` by composing `object_datum` with
#! `modeling_tower_object_constructor` and `morphism_datum` with `modeling_tower_morphism_constructor` (with suitable source and range).
#! "Wrapping" should be an isomorphism of categories with inverse "Unwrapping".
#! More precisely, one has to take care of the following things:
#!   * `W` should just be a reinterpretation of `cat_n` (with a nicer data structure), so we certainly
#!     want "Wrapping" to be an equivalence of categories with pseudo-inverse "Unwrapping".
#!   * `WrapperCategory` copies all properties from `cat_n` to `W`,
#!     including properties like `IsSkeletalCategory` which are not necessarily preserved by mere equivalences.
#!   * To fulfill the specification of WithGiven operations, wrapping a WithGiven object `A` in `cat_n`
#!     as an object in `W` and unwrapping it again must give an object equal to `A`. So we require
#!     "Wrapping" and then "Unwrapping" to be the identity. Conversely, let let `B_1` be an object in `W`
#!     which we unwrap and wrap again to form an object `B_2`. By construction of `W`, `B_1` and `B_2` are equal
#!     if and only if they are equal when unwrapped. But due to "Wrapping" and then "Unwrapping" being the identity,
#!     unwrapping `B_2` simply gives an object equal to `B_1` unwrapped. Thus, also `B_1` and `B_2` are equal.
#!     Thus, "Wrapping" has to be an equivalence which is a bijection on objects, and hence an isomorphism (although
#!     "Unwrapping" is not necessarily its inverse).
#!     Note: Alternatively, one can make sure that WithGiven operations in `cat_n` are only called
#!     via the corresponding non-WithGiven operation in `cat_n`. This can be achieved by wrapping
#!     all operations of `cat_n` (i.e. creating `W` with `only_primitive_operations := false`), disabling redirect functions
#!     (i.e. creating `W` with the option `overhead := false`) and not calling WithGiven operations
#!     of `W` manually.
#!
#! @Section How does it work?
#!
#! Operations in `WrapperCategory` are implemented as follows:
#! <Enum>
#! <Item>
#!     Apply `object_datum` and `morphism_datum` to the input to get the underlying data.
#! </Item>
#! <Item>
#!     Apply `modeling_tower_object_constructor` and `modeling_tower_morphism_constructor`
#!     to the underlying data to get objects and morphisms in the tower.
#! </Item>
#! <Item>
#!     Apply the operation of the tower.
#! </Item>
#! <Item>
#!     Apply `modeling_tower_object_datum` or `modeling_tower_morphism_datum` to the result
#!     to get the underlying data.
#! </Item>
#! <Item>
#!     Apply `object_constructor` or `morphism_constructor` to the underlying data to get an
#!     object or a morphism in the wrapper category.
#! </Item>
#! </Enum>
#! The first two steps define the functor "Unwrapping" and the last two steps define the functor "Wrapping".
#! "Wrapping" on objects and morphisms is called `ModeledObject` and `ModeledMorphism` in the code.
#! "Unwrapping" on objects and morphisms is called `ModelingObject` and `ModelingMorphism` in the code.
#!
#! @Section Relation to `CompilerForCAP`
#!
#! The operation of the tower (step 3 above) usually unwraps objects and morphisms,
#! operates on the underlying data, and wraps the result. The unwrapping usually
#! cancels with step 2 above, and wrapping the result usually cancels with step 4 above.
#! If one now compiles the operations of the wrapper category, only the following steps remain:
#! <Enum>
#! <Item>
#!     Apply `object_datum` and `morphism_datum` to the input to get the underlying data.
#! </Item>
#! <Item>
#!     Operate on the underlying data. (previously part of step 3)
#! </Item>
#! <Item>
#!     Apply `object_constructor` or `morphism_constructor` to the underlying data to get an
#!     object or a morphism in the wrapper category. (previously step 5)
#! </Item>
#! </Enum>
#! This is exactly what a primitive implementation would look like. Thus, in many cases
#! compiling a wrapper category immediately gives a primitive implementation with no remaining
#! references to the tower.

####################################
#
#! @Section GAP categories
#
####################################

#! @Description
#!  The &GAP; category of a wrapper CAP category (using the default data structure).
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
#!  The category used to model the wrapper category <A>category</A>.
#! @Arguments category
#! @Returns a category
DeclareAttribute( "ModelingCategory",
        IsCapCategory );

##
CapJitAddTypeSignature( "ModelingCategory",
        [ IsCapCategory ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( ModelingCategory( input_types[1].category ) );
    
end );


DeclareAttribute( "UnderlyingCategory",
        IsWrapperCapCategory );

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
#!  * `wrap_range_of_hom_structure` (optional, default `false`): whether to wrap the range category of the homomorphism structure
#!
#!  Additionally, the following options of <Ref Oper="CategoryConstructor" Label="for IsRecord" /> are supported:
#!  `category_filter`, `category_object_filter`, `category_morphism_filter`, `object_constructor`, `object_datum`, `morphism_constructor`, `morphism_datum`.
#!  To avoid inconsistencies, either all or none of those options should be set. If they are set, also the following options should be set:
#!  * `modeling_tower_object_constructor`: a function which gets the wrapper category and an object datum (in the sense of `object_datum`) and returns the corresponding modeling object in the modeling category,
#!  * `modeling_tower_object_datum`: a function which gets the wrapper category and an object in the modeling category and returns the corresponding object datum (in the sense of `object_datum`),
#!  * `modeling_tower_morphism_constructor`: a function which gets the wrapper category, a source in the modeling category, a morphism datum (in the sense of `morphism_datum`), and a range in the modeling category and returns the corresponding modeling morphism in the modeling category,
#!  * `modeling_tower_morphism_datum`: a function which gets the wrapper category and a morphism in the modeling category and returns the corresponding morphism datum (in the sense of `morphism_datum`),
#! @Arguments category, options
#! @Returns a category
DeclareOperation( "WrapperCategory",
                  [ IsCapCategory, IsRecord ] );


#! @Description
#!  Return the functor from the wrapped category `ModelingCategory`(<A>W</A>) to the wrapper category <A>W</A>.
#!  The functor maps each wrapped object/morphism to its wrapping object/morphism.
#! @Arguments W
#! @Returns a functor
DeclareAttribute( "WrappingFunctor",
                  IsWrapperCapCategory );

#! @Description
#!  Returns the object modeling the object <A>obj</A> in <A>cat</A>.
#!  <A>cat</A> must be a CAP category which has been created as a wrapper CAP category (but not necessarily uses the default data structure).
#! @Arguments cat, obj
#! @Returns a CAP category object
DeclareOperation( "ModelingObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

CapJitAddTypeSignature( "ModelingObject", [ IsCapCategory, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( ModelingCategory( input_types[1].category ) );
    
end );

#! @Description
#!  Returns the object modeled by the object <A>obj</A> in the modeling category of <A>cat</A>.
#!  <A>cat</A> must be a CAP category which has been created as a wrapper CAP category (but not necessarily uses the default data structure).
#! @Arguments cat, obj
#! @Returns a CAP category object
DeclareOperation( "ModeledObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

CapJitAddTypeSignature( "ModeledObject", [ IsCapCategory, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

#! @Description
#!  Returns the morphism modeling the morphism <A>mor</A> in <A>cat</A>.
#!  <A>cat</A> must be a CAP category which has been created as a wrapper CAP category (but not necessarily uses the default data structure).
#! @Arguments cat, mor
#! @Returns a CAP category morphism
DeclareOperation( "ModelingMorphism", [ IsCapCategory, IsCapCategoryMorphism ] );

CapJitAddTypeSignature( "ModelingMorphism", [ IsCapCategory, IsCapCategoryMorphism ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( ModelingCategory( input_types[1].category ) );
    
end );

#! @Description
#!  Returns the morphism modeled by the morphism <A>mor</A> in the modeling category of <A>cat</A> with given source and range.
#!  <A>cat</A> must be a CAP category which has been created as a wrapper CAP category (but not necessarily uses the default data structure).
#! @Arguments cat, source, obj, range
#! @Returns a CAP category morphism
DeclareOperation( "ModeledMorphism", [ IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

CapJitAddTypeSignature( "ModeledMorphism", [ IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

# helper operations
# Those should never be used outside of WrapperCategory, but allow to register methods for CompilerForCAP.
DeclareOperation( "ModelingTowerObjectConstructor", [ IsCapCategory, IsObject ] );
DeclareOperation( "ModelingTowerObjectDatum", [ IsCapCategory, IsCapCategoryObject ] );
DeclareOperation( "ModelingTowerMorphismConstructor", [ IsCapCategory, IsCapCategoryObject, IsObject, IsCapCategoryObject ] );
DeclareOperation( "ModelingTowerMorphismDatum", [ IsCapCategory, IsCapCategoryMorphism ] );
