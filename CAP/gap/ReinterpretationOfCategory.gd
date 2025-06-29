# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#

#! @Chapter Reinterpretations of categories
#!
#! @Section Introduction
#!
#! The support for building towers of category constructors is one
#! of the main design features of CAP. Many categories that
#! appear in the various applications can be modeled by towers
#! of multiple category constructors.
#! The category constructor <Ref Oper="ReinterpretationOfCategory" Label="for IsCapCategory, IsRecord" />
#! allows adding one last layer on top which allows expressing
#! the desired (re)interpretation of such a modeling tower.
#! In particular, this category constructor allows specifying
#! the name of the category together with customized methods for the operations
#! * ObjectConstructor
#! * MorphismConstructor
#! * ObjectDatum
#! * MorphismDatum
#! in order to reflect the desired (re)interpretation with
#! a user-interface that is independent of the modeling tower (see below for details).
#! Note that the same tower might have multiple interpretations.
#! 
#! <Table Align="|c|">
#! <Caption>A tower of categories modeling the category `R`</Caption>
#! <HorLine/>
#! <Row>
#!   <Item>`R := ReinterpretationOfCategory( cat_n )`</Item>
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
#! The reinterpretation `R` is isomorphic to the top category `cat_n` in the tower.
#! In practice, the word <Q>tower</Q> stands more generally for a finite poset
#! with a greatest element.
#!
#! @Section Tutorial
#!
#! We will show how one can reinterpret a category with the following guiding example:
#! We reinterpret `Opposite( CategoryOfRows( R ) )` as `CategoryOfColumns( R )` using
#! <Ref Oper="ReinterpretationOfCategory" Label="for IsCapCategory, IsRecord" />
#! with the options described in the following (see `CategoryOfColumns_as_Opposite_CategoryOfRows.gi` in
#! `AdditiveClosuresForCAP` for a full implementation).
#! <Enum>
#! <Item>
#!     Set the options `category_filter`, `category_object_filter`, and `category_morphism_filter`
#!     to the filters corresponding to the data structure of the desired reinterpretation,
#!     e.g. `IsCategoryOfColumns`, `IsCategoryOfColumsObject`, and `IsCategoryOfColumsMorphism`.
#! </Item>
#! <Item>
#!     Set `object_constructor`, `object_datum`, `morphism_constructor`, and `morphism_datum`
#!     to the functions one would write for `ObjectConstructor` and so on for a primitive implementation
#!     of the desired reinterpretation.
#!     In our example, `object_constructor` takes the reinterpretation `R` (which lies in `IsCategoryOfColumns` due
#!     to the filter set in the first step) and an integer, and returns a CAP object
#!     in the category with attribute `RankOfObject` set to the integer, just like a primitive
#!     implementation of `CategoryOfColumns` would do.
#! </Item>
#! <Item>
#!    Set `modeling_tower_object_constructor`, `modeling_tower_object_datum`,
#!    `modeling_tower_morphism_constructor`, and `modeling_tower_morphism_datum`:
#!    `modeling_tower_object_constructor` gets the same input as `object_constructor` but must return
#!    the corresponding object in the tower `cat_n`. `modeling_tower_object_datum` has the same output as `object_datum`
#!    but gets the reinterpretation `R` and an object in the tower `cat_n` as an input.
#!    In our example, `modeling_tower_object_constructor` gets the reinterpretation `R` and an integer
#!    as in step 2 and wraps the integer as a `CategoryOfRowsObject` and the result as an object in the opposite
#!    category. `modeling_tower_object_datum` gets the reinterpretation `R` and an object in
#!    `Opposite( CategoryOfRows( R ) )` (that is, an integer boxed as a category of rows object
#!    boxed as an object in the opposite category) and returns the underlying integer.
#!    `modeling_tower_morphism_constructor` and `modeling_tower_morphism_datum` are given analogously.
#! </Item>
#! </Enum>
#! By composing `modeling_tower_object_datum` with `object_constructor` and `modeling_tower_morphism_datum` with `morphism_constructor`
#! (with suitable source and range), `ReinterpretationOfCategory` defines a functor "Reinterpretation" from `cat_n` to `R`.
#! Similarly, it defines a functor "Model" from `R` to `cat_n` by composing `object_datum` with
#! `modeling_tower_object_constructor` and `morphism_datum` with `modeling_tower_morphism_constructor` (with suitable source and range).
#! "Reinterpretation" should be an isomorphism of categories with inverse "Model".
#! More precisely, one has to take care of the following things:
#!   * Since `R` should just be a reinterpretation of `cat_n` with a nicer data structure, we certainly
#!     want "Reinterpretation" to be an equivalence of categories with pseudo-inverse "Model".
#!   * `ReinterpretationOfCategory` copies all properties from `cat_n` to `R`,
#!     including properties like `IsSkeletalCategory` which are not necessarily preserved by mere equivalences.
#!   * To fulfill the specification of WithGiven operations, reinterpreting a WithGiven object `A` in `cat_n`
#!     as an object in `R` and taking its model again must give an object equal to `A`. So we require applying
#!     "Reinterpretation" and then "Model" to give the identity. Conversely, let `B_1` be an object in `R`.
#!     We take its model and reinterpret this again to form an object `B_2`. By construction of `R`, `B_1` and `B_2` are equal
#!     if and only if their models are equal. But since applying "Reinterpretation" and then "Model" gives the identity,
#!     taking the model of `B_2` simply gives an object equal to the model of `B_1`. Thus, also `B_1` and `B_2` are equal.
#!     Hence, "Reinterpretation" has to be an equivalence which is a bijection on objects, and hence an isomorphism (although
#!     "Model" is not necessarily its inverse).
#!     Note: Alternatively, one can make sure that WithGiven operations in `cat_n` are only called
#!     via the corresponding non-WithGiven operation in `cat_n`. This can be achieved by reinterpreting
#!     all operations of `cat_n` (i.e. creating `R` with `only_primitive_operations := false`), disabling redirect functions
#!     (i.e. creating `R` with the option `overhead := false`) and not calling WithGiven operations
#!     of `R` manually.
#!
#! @Section Implementation details
#!
#! Operations in `ReinterpretationOfCategory` are implemented as follows:
#! <Enum>
#! <Item>
#!     Apply `object_datum` and `morphism_datum` to the input to get the underlying data.
#! </Item>
#! <Item>
#!     Apply `modeling_tower_object_constructor` and `modeling_tower_morphism_constructor`
#!     to the underlying data to get objects and morphisms in the tower `cat_n`.
#! </Item>
#! <Item>
#!     Apply the operation of the tower `cat_n`.
#! </Item>
#! <Item>
#!     Apply `modeling_tower_object_datum` or `modeling_tower_morphism_datum` to the result
#!     to get the underlying data.
#! </Item>
#! <Item>
#!     Apply `object_constructor` or `morphism_constructor` to the underlying data to get an
#!     object or a morphism in the reinterpretation `R`.
#! </Item>
#! </Enum>
#! The first two steps define the functor "Model" and the last two steps define the functor "Reinterpretation".
#! "Reinterpretation" on objects and morphisms is called `ReinterpretationOfObject` and `ReinterpretationOfMorphism` in the code.
#! "Model" on objects and morphisms is called `ModelingObject` and `ModelingMorphism` in the code.
#!
#! @Section Relation to <C>CompilerForCAP</C>
#!
#! The operation of the tower `cat_n` (step 3 above) usually unboxes objects and morphisms,
#! operates on the underlying data, and boxes the result. The unboxing usually
#! cancels with step 2 above, and boxing the result usually cancels with step 4 above.
#! If one now compiles the operations of the reinterpretation `R`, only the following steps remain:
#! <Enum>
#! <Item>
#!     Apply `object_datum` and `morphism_datum` to the input to get the underlying data.
#! </Item>
#! <Item>
#!     Operate on the underlying data. (previously part of step 3)
#! </Item>
#! <Item>
#!     Apply `object_constructor` or `morphism_constructor` to the underlying data to get an
#!     object or a morphism in the reinterpretation `R`. (previously step 5)
#! </Item>
#! </Enum>
#! This is exactly what a primitive implementation would look like. Thus, in many cases
#! compiling a reinterpretation immediately gives a primitive implementation with no remaining
#! references to the tower `cat_n`.

####################################
#
#! @Section Attributes
#
####################################

#! @Description
#!  The tower `cat_n` modeling the reinterpretation <A>R</A>.
#! @Arguments R
#! @Returns a category
DeclareAttribute( "ModelingCategory",
        IsCapCategory );

##
CapJitAddTypeSignature( "ModelingCategory",
        [ IsCapCategory ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( ModelingCategory( input_types[1].category ) );
    
end );

####################################
#
#! @Section Constructors
#
####################################

#! @Description
#!  Reinterprets a category <A>category</A> (the "modeling category") to form a new category `R` (the "reinterpretation") subject to the options given via <A>options</A>,
#!  which is a record with the following keys:
#!  * `name`: the name of the reinterpretation `R`,
#!  * `category_filter`, `category_object_filter`, `category_morphism_filter`, `object_datum_type`, `morphism_datum_type`, `object_constructor`, `object_datum`, `morphism_constructor`, `morphism_datum`: same meaning as for <Ref Oper="CategoryConstructor" Label="for IsRecord" />, which is used to create the reinterpretation `R`,
#!  * `modeling_tower_object_constructor`: a function which gets the reinterpretation `R` and an object datum (in the sense of `object_datum`) and returns the corresponding modeling object in the modeling category,
#!  * `modeling_tower_object_datum`: a function which gets the reinterpretation `R` and an object in the modeling category and returns the corresponding object datum (in the sense of `object_datum`),
#!  * `modeling_tower_morphism_constructor`: a function which gets the reinterpretation `R`, a source in the modeling category, a morphism datum (in the sense of `morphism_datum`), and a range in the modeling category and returns the corresponding modeling morphism in the modeling category,
#!  * `modeling_tower_morphism_datum`: a function which gets the reinterpretation `R` and a morphism in the modeling category and returns the corresponding morphism datum (in the sense of `morphism_datum`),
#!  * `only_primitive_operations` (optional, default `false`): whether to only reinterpret primitive operations or all operations.
#! @Arguments category, options
#! @Returns a category
DeclareOperation( "ReinterpretationOfCategory",
                  [ IsCapCategory, IsRecord ] );


#! @Description
#!  Returns the functor from the modeling category `ModelingCategory`(<A>R</A>) to the reinterpretation <A>R</A>
#!  which maps each object/morphism to its reinterpretation.
#! @Arguments R
#! @Returns a functor
DeclareAttribute( "ReinterpretationFunctor",
                  IsCapCategory );

#! @Description
#!  Returns the object in `ModelingCategory`(<A>R</A>) modeling the object <A>obj</A> in the reinterpretation <A>R</A>.
#! @Arguments R, obj
#! @Returns a CAP category object
DeclareOperation( "ModelingObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

CapJitAddTypeSignature( "ModelingObject", [ IsCapCategory, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( ModelingCategory( input_types[1].category ) );
    
end );

#! @Description
#!  Returns the reinterpretation in `R` of an object <A>obj</A> in `ModelingCategory`(<A>R</A>).
#! @Arguments R, obj
#! @Returns a CAP category object
DeclareOperation( "ReinterpretationOfObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

CapJitAddTypeSignature( "ReinterpretationOfObject", [ IsCapCategory, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

#! @Description
#!  Returns the morphism in `ModelingCategory`(<A>R</A>) modeling the morphism <A>mor</A> in the reinterpretation <A>R</A>.
#! @Arguments R, mor
#! @Returns a CAP category morphism
DeclareOperation( "ModelingMorphism", [ IsCapCategory, IsCapCategoryMorphism ] );

CapJitAddTypeSignature( "ModelingMorphism", [ IsCapCategory, IsCapCategoryMorphism ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( ModelingCategory( input_types[1].category ) );
    
end );

#! @Description
#!  Returns the reinterpretation in `R` with given source and range in `R` of a morphism <A>mor</A> in `ModelingCategory`(<A>R</A>).
#! @Arguments R, source, mor, range
#! @Returns a CAP category morphism
DeclareOperation( "ReinterpretationOfMorphism", [ IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

CapJitAddTypeSignature( "ReinterpretationOfMorphism", [ IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

# helper operations
# Those should never be used outside of ReinterpretationOfCategory, but allow to register methods for CompilerForCAP.
DeclareOperation( "ModelingTowerObjectConstructor", [ IsCapCategory, IsObject ] );
DeclareOperation( "ModelingTowerObjectDatum", [ IsCapCategory, IsCapCategoryObject ] );
DeclareOperation( "ModelingTowerMorphismConstructor", [ IsCapCategory, IsCapCategoryObject, IsObject, IsCapCategoryObject ] );
DeclareOperation( "ModelingTowerMorphismDatum", [ IsCapCategory, IsCapCategoryMorphism ] );
