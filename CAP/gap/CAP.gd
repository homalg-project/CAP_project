# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter CAP Categories
#!  Categories are the main GAP objects in CAP.
#!  They are used to associate GAP objects which represent objects and
#!  morphisms with their category. By associating a GAP object to the
#!  category, one of two filters belonging to the category (ObjectFilter/MorphismFilter)
#!  are set to true.
#!  Via Add methods, functions for specific existential quantifiers can be
#!  associated to the category and after that can be applied to GAP objects in the category.
#!  A GAP category object also knows which constructions
#!  are currently possible in this category.
#!
#! Classically, a category consists of a class of objects, a set of morphisms, identity morphisms, and a composition function
#! satisfying some simple axioms. In CAP, we use a slightly different notion of a category.
#!
#! A CAP category $\mathbf{C}$ consists of the following data:
#! * A set $\mathrm{Obj}_{\mathbf{C}}$ of **objects**.
#! * For every pair $a,b \in \mathrm{Obj}_{\mathbf{C}}$, a set $\mathrm{Hom}_{\mathbf{C}}( a, b )$ of **morphisms**.
#! * For every pair $a,b \in \mathrm{Obj}_{\mathbf{C}}$, an equivalence relation $\sim_{a,b}$ on $\mathrm{Hom}_{\mathbf{C}}( a, b )$
#!   called **congruence for morphisms**.
#! * For every $a \in \mathrm{Obj}_{\mathbf{C}}$, an **identity morphism** $\mathrm{id}_a \in \mathrm{Hom}_{\mathbf{C}}( a, a )$.
#! * For every triple $a, b, c \in \mathrm{Obj}_{\mathbf{C}}$, a **composition function**
#!   $$\circ: \mathrm{Hom}_{\mathbf{C}}( b, c ) \times \mathrm{Hom}_{\mathbf{C}}( a, b ) \rightarrow \mathrm{Hom}_{\mathbf{C}}( a, c )$$
#!   compatible with the congruence, i.e.,
#!   if $\alpha, \alpha' \in \mathrm{Hom}_{\mathbf{C}}( a, b )$,
#!   $\beta, \beta' \in \mathrm{Hom}_{\mathbf{C}}( b, c )$,
#!   $\alpha \sim_{a,b} \alpha'$
#!   and $\beta \sim_{b,c} \beta'$,
#!   then $\beta \circ \alpha \sim_{a,c} \beta' \circ \alpha'$.
#! * For all $a, b \in \mathrm{Obj}_{\mathbf{C}}$,
#!   $\alpha \in \mathrm{Hom}_{\mathbf{C}}( a, b )$,
#!   we have $$\left( \mathrm{id}_{b} \circ \alpha \right) \sim_{a,b} \alpha$$
#!   and
#!   $$\alpha \sim_{a,b} \left( \alpha \circ \mathrm{id}_{a} \right).$$
#! * For all $a,b,c,d \in \mathrm{Obj}_{\mathbf{C}}$,
#!   $\alpha \in \mathrm{Hom}_{\mathbf{C}}( a, b )$,
#!   $\beta \in \mathrm{Hom}_{\mathbf{C}}( b, c )$,
#!   $\gamma \in \mathrm{Hom}_{\mathbf{C}}( c, d )$,
#!   we have $$\left(( \gamma \circ \beta ) \circ \alpha \right) \sim_{a,d} \left( \gamma \circ ( \beta \circ \alpha ) \right)$$


###################################
##
#! @Section Internal stuff
##
###################################

DeclareGlobalVariable( "CAP_INTERNAL" );

DeclareGlobalFunction( "CAP_INTERNAL_NAME_COUNTER" );

DeclareGlobalFunction( "CATEGORIES_CACHE_GETTER" );

DeclareGlobalFunction( "GET_METHOD_CACHE" );

DeclareGlobalFunction( "SET_VALUE_OF_CATEGORY_CACHE" );

DeclareGlobalFunction( "HAS_VALUE_OF_CATEGORY_CACHE" );

DeclareGlobalFunction( "CAP_INTERNAL_INSTALL_PRINT_FUNCTION" );

DeclareGlobalVariable( "CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST" );

InstallValue( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST, [ ] );

###################################
##
#! @Section Categories
##
###################################


#! @Description
#!  The GAP category of CAP categories. Objects of this type handle
#!  the CAP category information, the caching, and filters for objects in the CAP category.
#!  Please note that the object itself is not related to methods, you only need it
#!  as a handler and a presentation of the CAP category.
#! @Arguments object
DeclareCategory( "IsCapCategory",
                 IsAttributeStoringRep );

#! @Description
#! The GAP category of CAP category cells.
#! Every object, morphism, and $2$-cell
#! of a CAP category lies in this GAP category.
#! @Arguments object
DeclareCategory( "IsCapCategoryCell",
                 IsAttributeStoringRep );

#! @Description
#! The GAP category of CAP category objects.
#! Every object of a CAP category lies in
#! this GAP category.
#! @Arguments object
DeclareCategory( "IsCapCategoryObject",
                 IsCapCategoryCell );

#! @Description
#! The GAP category of CAP category morphisms.
#! Every morphism of a CAP category lies in
#! this GAP category.
#! @Arguments object
DeclareCategory( "IsCapCategoryMorphism",
                 IsCapCategoryCell  );

#! @Description
#! The GAP category of CAP category $2$-cells.
#! Every $2$-cell of a CAP category lies in
#! this GAP category.
#! @Arguments object
DeclareCategory( "IsCapCategoryTwoCell",
                 IsCapCategoryCell );

###################################
##
#! @Section Categorical properties
##
###################################

#! @Description
#!  Adds a categorical property to the list of CAP
#!  categorical properties. <A>list</A> must be a list
#!  containing one entry, if the property is self dual,
#!  or two, if the dual property has a different name.
#!  If the first entry of the list is empty and the second
#!  is a property name, the property is assumed to have no
#!  dual.
#! @Arguments list
DeclareGlobalFunction( "AddCategoricalProperty" );

InstallGlobalFunction( AddCategoricalProperty,
  function( property_pair )
    local property;
    
    if not IsList( property_pair ) or Length( property_pair ) <> 2 or not IsString( property_pair[1] ) or not ( IsString( property_pair[2] ) or property_pair[2] = fail ) then
        Error(
            "You must pass a pair (i.e. a list of length 2) of strings to `AddCategoricalProperty`. ",
            "The second entry is the property of the opposite category. ",
            "If the opposite property is not implemented, you may pass `fail` instead."
        );
        return;
    fi;
    
    Add( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST, property_pair );
    
    if not IsBoundGlobal( property_pair[1] ) then
        
        Print( "WARNING: please declare ", property_pair[1], " as a property of IsCapCategory with corresponding documentation before adding it as a categorical property.\n" );
        
        DeclareProperty( property_pair[1], IsCapCategory );
        
        # all property pairs must also be added with the entries swapped
        # this will declare the opposite property
        
    fi;
    
end );

#! @Description
#!  The (evil) property of <A>C</A> being a category with finitely many objects.
#! @Arguments C
DeclareProperty( "IsObjectFiniteCategory",
        IsCapCategory );

AddCategoricalProperty( [ "IsObjectFiniteCategory", "IsObjectFiniteCategory" ] );

#! @Description
#!  The (evil) property of <A>C</A> being a finite category.
#! @Arguments C
DeclareProperty( "IsFiniteCategory",
        IsCapCategory );

#! @Description
#!  Synonym for <C>IsFiniteCategory</C>.
#! @Arguments C
DeclareProperty( "IsFinite",
        IsCapCategory );

AddCategoricalProperty( [ "IsFiniteCategory", "IsFiniteCategory" ] );

#! @Description
#!  The property of <A>C</A> being equivalent to a finite category.
#! @Arguments C
DeclareProperty( "IsEquivalentToFiniteCategory",
        IsCapCategory );

AddCategoricalProperty( [ "IsEquivalentToFiniteCategory", "IsEquivalentToFiniteCategory" ] );

#! @Description
#!  The property of the category <A>C</A> being equipped with a homomorphism structure.
#! @Arguments C
DeclareProperty( "IsEquippedWithHomomorphismStructure", IsCapCategory );

AddCategoricalProperty( [ "IsEquippedWithHomomorphismStructure", "IsEquippedWithHomomorphismStructure" ] );

#! @Description
#!  The property of the category <A>C</A> having decidable lifts.
#! @Arguments C
DeclareProperty( "IsCategoryWithDecidableLifts", IsCapCategory );

AddCategoricalProperty( [ "IsCategoryWithDecidableLifts", "IsCategoryWithDecidableColifts" ] );

#! @Description
#!  The property of the category <A>C</A> having decidable colifts.
#! @Arguments C
DeclareProperty( "IsCategoryWithDecidableColifts", IsCapCategory );

AddCategoricalProperty( [ "IsCategoryWithDecidableColifts", "IsCategoryWithDecidableLifts" ] );

#! @Description
#!  The property of the category <A>C</A> having an initial object.
#! @Arguments C
DeclareProperty( "IsCategoryWithInitialObject", IsCapCategory );

AddCategoricalProperty( [ "IsCategoryWithInitialObject", "IsCategoryWithTerminalObject" ] );

#! @Description
#!  The property of the category <A>C</A> having a terminal object.
#! @Arguments C
DeclareProperty( "IsCategoryWithTerminalObject", IsCapCategory );

AddCategoricalProperty( [ "IsCategoryWithTerminalObject", "IsCategoryWithInitialObject" ] );

#! @Description
#!  The property of the category <A>C</A> having a zero object.
#! @Arguments C
DeclareProperty( "IsCategoryWithZeroObject", IsCapCategory );

AddCategoricalProperty( [ "IsCategoryWithZeroObject", "IsCategoryWithZeroObject" ] );

#! @Description
#!  The property of the category <A>C</A> having all equalizers.
#! @Arguments C
DeclareProperty( "IsCategoryWithEqualizers", IsCapCategory );

AddCategoricalProperty( [ "IsCategoryWithEqualizers", "IsCategoryWithCoequalizers" ] );

#! @Description
#!  The property of the category <A>C</A> having all coequalizers.
#! @Arguments C
DeclareProperty( "IsCategoryWithCoequalizers", IsCapCategory );

AddCategoricalProperty( [ "IsCategoryWithCoequalizers", "IsCategoryWithEqualizers" ] );

#! @Description
#!  The property of the category <A>C</A> being enriched over a commutative regular semigroup.
#! @Arguments C
DeclareProperty( "IsEnrichedOverCommutativeRegularSemigroup", IsCapCategory );

AddCategoricalProperty( [ "IsEnrichedOverCommutativeRegularSemigroup", "IsEnrichedOverCommutativeRegularSemigroup" ] );

#! @Description
#!  The property of the category <A>C</A> being skeletal, that is, whether `IsEqualForObjects` and `IsIsomorphicForObjects` coincide.
#! @Arguments C
DeclareProperty( "IsSkeletalCategory", IsCapCategory );

AddCategoricalProperty( [ "IsSkeletalCategory", "IsSkeletalCategory" ] );

#! @Description
#!  The property of the category <A>C</A> being preadditive.
#! @Arguments C
DeclareProperty( "IsAbCategory", IsCapCategory );

AddCategoricalProperty( [ "IsAbCategory", "IsAbCategory" ] );

#! @Description
#!  The property of the category <A>C</A> being linear over a commutative ring.
#! @Arguments C
DeclareProperty( "IsLinearCategoryOverCommutativeRing", IsCapCategory );

AddCategoricalProperty( [ "IsLinearCategoryOverCommutativeRing", "IsLinearCategoryOverCommutativeRing" ] );

#! @Description
#!  The property of the category <A>C</A> being linear over a commutative ring $k$
#!  such that all external homs are finitely generated free $k$-modules.
#! @Arguments C
DeclareProperty( "IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms", IsCapCategory );

AddCategoricalProperty( [ "IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms", "IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms" ] );

#! @Description
#!  The property of the category <A>C</A> having all kernels.
#! @Arguments C
DeclareProperty( "IsCategoryWithKernels", IsCapCategory );

AddCategoricalProperty( [ "IsCategoryWithKernels", "IsCategoryWithCokernels" ] );

#! @Description
#!  The property of the category <A>C</A> having all cokernels.
#! @Arguments C
DeclareProperty( "IsCategoryWithCokernels", IsCapCategory );

AddCategoricalProperty( [ "IsCategoryWithCokernels", "IsCategoryWithKernels" ] );

#! @Description
#!  The property of the category <A>C</A> being additive.
#! @Arguments C
DeclareProperty( "IsAdditiveCategory", IsCapCategory );

AddCategoricalProperty( [ "IsAdditiveCategory", "IsAdditiveCategory" ] );

#! @Description
#!  The property of the category <A>C</A> being preabelian.
#! @Arguments C
DeclareProperty( "IsPreAbelianCategory", IsCapCategory );

AddCategoricalProperty( [ "IsPreAbelianCategory", "IsPreAbelianCategory" ] );

#! @Description
#!  The property of the category <A>C</A> being abelian.
#! @Arguments C
DeclareProperty( "IsAbelianCategory", IsCapCategory );

AddCategoricalProperty( [ "IsAbelianCategory", "IsAbelianCategory" ] );

#! @Description
#!  The property of the category <A>C</A> being abelian with enough projectives.
#! @Arguments C
DeclareProperty( "IsAbelianCategoryWithEnoughProjectives", IsCapCategory );

AddCategoricalProperty( [ "IsAbelianCategoryWithEnoughProjectives", "IsAbelianCategoryWithEnoughInjectives" ] );

#! @Description
#!  The property of the category <A>C</A> being abelian with enough injectives.
#! @Arguments C
DeclareProperty( "IsAbelianCategoryWithEnoughInjectives", IsCapCategory );

AddCategoricalProperty( [ "IsAbelianCategoryWithEnoughInjectives", "IsAbelianCategoryWithEnoughProjectives" ] );

#! @Description
#!  The property of the category <A>C</A> being locally of finite projective dimension.
#! @Arguments C
DeclareProperty( "IsLocallyOfFiniteProjectiveDimension", IsCapCategory );

AddCategoricalProperty( [ "IsLocallyOfFiniteProjectiveDimension", "IsLocallyOfFiniteInjectiveDimension" ] );

#! @Description
#!  The property of the category <A>C</A> being locally of finite injective dimension.
#! @Arguments C
DeclareProperty( "IsLocallyOfFiniteInjectiveDimension", IsCapCategory );

AddCategoricalProperty( [ "IsLocallyOfFiniteInjectiveDimension", "IsLocallyOfFiniteProjectiveDimension" ] );

DeclareAttribute( "TheoremRecord",
                  IsCapCategory, "mutable" );

#! @Description
#! The input <A>categorical_property</A> is the name of a valid categorical property.
#! The output is the list of names of the CAP operations needed to make this categorical property constructive.
#! @Returns a list
#! @Arguments categorical_property
DeclareGlobalFunction( "ListOfDefiningOperations" );

###################################
##
#! @Section Constructor
##
###################################

#! @Description
#! Creates a new CAP category from scratch.
#! It gets a generic name.
#! @Arguments
#! @Returns a category
#! @Label
DeclareOperation( "CreateCapCategory",
                  [ ] );

#! @Description
#! The argument is a string $s$.
#! This operation creates a new CAP category from scratch.
#! Its name is set to $s$.
#! @Arguments s
#! @Returns a category
DeclareOperation( "CreateCapCategory",
                           [ IsString ] );

#! @Description
#! The argument is a string $s$.
#! This operation creates a new CAP category from scratch.
#! Its name is set to $s$.
#! The category, its objects, its morphisms, and its two cells will lie in the corresponding given filters.
#! @Arguments s, category_filter, object_filter, morphism_filter, two_cell_filter
#! @Returns a category
DeclareOperation( "CreateCapCategory",
                           [ IsString, IsFunction, IsFunction, IsFunction, IsFunction ] );

#! @Description
#! The argument is a string $s$.
#! This operation creates a new CAP category from scratch.
#! Its name is set to $s$.
#! The category, its objects, its morphisms, and its two cells will lie in the corresponding given filters.
#! The data types of the object/morphism/two cell datum can be given as described in <Ref BookName="CompilerForCAP" Func="CapJitInferredDataTypes" />.
#! As a convenience, simply a filter can be given if this suffices to fully determine the data type.
#! If a data type is not specified, pass `fail` instead.
#! @Arguments s, category_filter, object_filter, morphism_filter, two_cell_filter, object_datum_type, morphism_datum_type, two_cell_datum_type
#! @Returns a category
DeclareGlobalFunction( "CreateCapCategoryWithDataTypes" );

###################################
##
#! @Section Internal Attributes
##
###################################

#! @Description
#! The argument is a category $C$.
#! The output is its name.
#! @Arguments C
#! @Returns a string
DeclareAttribute( "Name", IsCapCategory );

#! Each category $C$ stores various filters.
#! They are used to apply the right functions in the method selection.

## This filter is used by the installation
## of the Add methods for the terminal object.
#! @Description
#! The argument is a category $C$.
#! The output is a filter in which $C$ lies.
#! @Arguments C
#! @Returns a filter
DeclareAttribute( "CategoryFilter",
                  IsCapCategory );

DeclareAttribute( "CellFilter",
                  IsCapCategory );

#! @Description
#! The argument is a category $C$.
#! The output is a filter in which all objects
#! of $C$ shall lie.
#! @Arguments C
#! @Returns a filter
DeclareAttribute( "ObjectFilter",
                  IsCapCategory );

#! @Description
#! The argument is a category $C$.
#! The output is a filter in which all morphisms
#! of $C$ shall lie.
#! @Arguments C
#! @Returns a filter
DeclareAttribute( "MorphismFilter",
                  IsCapCategory );

#! @Description
#! The argument is a category $C$.
#! The output is a filter in which all $2$-cells
#! of $C$ shall lie.
#! @Arguments C
#! @Returns a filter
DeclareAttribute( "TwoCellFilter",
                  IsCapCategory );

#! @Description
#! The argument is a category $C$.
#! The output is the data type (see <Ref BookName="CompilerForCAP" Func="CapJitInferredDataTypes" />)
#! of object data of $C$ (or `fail` if this data type is not specified).
#! @Arguments C
#! @Returns a data type or `fail`
DeclareAttribute( "ObjectDatumType",
                  IsCapCategory );

#! @Description
#! The argument is a category $C$.
#! The output is the data type (see <Ref BookName="CompilerForCAP" Func="CapJitInferredDataTypes" />)
#! of morphism data of $C$ (or `fail` if this data type is not specified).
#! @Arguments C
#! @Returns a data type or `fail`
DeclareAttribute( "MorphismDatumType",
                  IsCapCategory );

#! @Description
#! The argument is a category $C$.
#! The output is the data type (see <Ref BookName="CompilerForCAP" Func="CapJitInferredDataTypes" />)
#! of two cell data of $C$ (or `fail` if this data type is not specified).
#! @Arguments C
#! @Returns a data type or `fail`
DeclareAttribute( "TwoCellDatumType",
                  IsCapCategory );

#! @Description
#! The argument is a category $C$ which is expected to lie in the
#! filter <C>IsLinearCategoryOverCommutativeRing</C>.
#! The output is a commutative ring over which the category is linear.
#! @Arguments C
#! @Returns a ring
DeclareAttribute( "CommutativeRingOfLinearCategory",
                  IsCapCategory );

# display a warning when trying to overwrite an existing CommutativeRingOfLinearCategory with a different one
#= comment for Julia, which does not have "TryNextMethod"
InstallMethod( SetCommutativeRingOfLinearCategory,
               [ IsCapCategory, IsObject ],
               
  function( category, ring )
    
    if not (IsRing( ring ) and HasIsCommutative( ring ) and IsCommutative( ring )) then
        
        Error( "CommutativeRingOfLinearCategory must be a commutative ring" );
        
    fi;
    
    if HasCommutativeRingOfLinearCategory( category ) and not IsIdenticalObj( ring, CommutativeRingOfLinearCategory( category ) ) then
        
        Print( "WARNING: Trying to set CommutativeRingOfLinearCategory to a ring with name \"", String( ring ), "\" but a different ring with name \"", String( CommutativeRingOfLinearCategory( category ) ), "\" is already set.\n" );
        
    fi;
    
    # delegate to system setter
    TryNextMethod( );
    
end );
# =#

#! @Description
#! The argument is a category $C$ which is expected to lie in the
#! filter <C>IsEquippedWithHomomorphismStructure</C>.
#! The output is the range category $D$ of the defining functor
#! $H: C^{\mathrm{op}} \times C \rightarrow D$ of the homomorphism structure.
#! @Arguments C
#! @Returns a category
DeclareAttribute( "RangeCategoryOfHomomorphismStructure",
                  IsCapCategory );

# display a warning when trying to overwrite an existing RangeCategoryOfHomomorphismStructure with a different one
#= comment for Julia, which does not have "TryNextMethod"
InstallMethod( SetRangeCategoryOfHomomorphismStructure,
               [ IsCapCategory, IsObject ],
               
  function( category, range_category )
    
    if not IsCapCategory( range_category ) then
        
        Error( "RangeCategoryOfHomomorphismStructure must be a CAP category" );
        
    fi;
    
    if HasRangeCategoryOfHomomorphismStructure( category ) and not IsIdenticalObj( range_category, RangeCategoryOfHomomorphismStructure( category ) ) then
        
        Print( "WARNING: Trying to set RangeCategoryOfHomomorphismStructure to a category with name \"", Name( range_category ), "\" but a different range category with name \"", Name( RangeCategoryOfHomomorphismStructure( category ) ), "\" is already set.\n" );
        
    fi;
    
    # delegate to system setter
    TryNextMethod( );
    
end );
# =#

#! @Description
#! The argument is an additive category $C$.
#! The output is a list $L$ of objects in $C$ such that every object in $C$ is a finite direct sum of objects in $L$.
#! @Arguments C
#! @Returns a list of objects
DeclareAttribute( "AdditiveGenerators",
                  IsCapCategory );

#! @Description
#!  The argument is an Abelian category $C$ with enough projectives.
#!  The output is the set of indecomposable projective objects in $C$ up to isomorphism.
#!  That is every projective object in $C$ is isomorphic to a finite direct sum over these objects.
#! @Arguments C
#! @Returns a list of objects
DeclareAttribute( "IndecomposableProjectiveObjects",
                  IsCapCategory );

#! @Description
#!  The argument is an Abelian category $C$ with enough injectives.
#!  The output is the set of indecomposable injective objects in $C$ up to isomorphism.
#!  That is every injective object in $C$ is isomorphic to a finite direct sum over these objects.
#! @Arguments C
#! @Returns a list of objects
DeclareAttribute( "IndecomposableInjectiveObjects",
                  IsCapCategory );

#############################################
##
#! @Section Logic switcher
#! @SectionLabel Logic_switcher
##
#############################################

#! @Description
#!  Activates the predicate logic propagation between equal objects for the category <A>C</A>.
#! @Arguments C
DeclareGlobalFunction( "CapCategorySwitchLogicPropagationForObjectsOn" );

#! @Description
#!  Deactivates the predicate logic propagation between equal objects for the category <A>C</A>.
#! @Arguments C
DeclareGlobalFunction( "CapCategorySwitchLogicPropagationForObjectsOff" );

#! @Description
#!  Activates the predicate logic propagation between equal morphisms for the category <A>C</A>.
#! @Arguments C
DeclareGlobalFunction( "CapCategorySwitchLogicPropagationForMorphismsOn" );

#! @Description
#!  Deactivates the predicate logic propagation between equal morphisms for the category <A>C</A>.
#! @Arguments C
DeclareGlobalFunction( "CapCategorySwitchLogicPropagationForMorphismsOff" );

#! @Description
#!  Activates the predicate logic propagation between equal cells for the category <A>C</A>.
#! @Arguments C
DeclareGlobalFunction( "CapCategorySwitchLogicPropagationOn" );

#! @Description
#!  Deactivates the predicate logic propagation between equal cells for the category <A>C</A>.
#! @Arguments C
DeclareGlobalFunction( "CapCategorySwitchLogicPropagationOff" );

#! @Description
#!  Activates the predicate implication logic for the category <A>C</A>.
#! @Arguments C
DeclareGlobalFunction( "CapCategorySwitchLogicOn" );

#! @Description
#!  Deactivates the predicate implication logic for the category <A>C</A>.
#! @Arguments C
DeclareGlobalFunction( "CapCategorySwitchLogicOff" );

#############################################
##
#! @Section Tool functions
##
#############################################

#! @BeginGroup
#! @Description
#! The argument is a category <A>C</A> and a string <A>string</A>,
#! which should be the name of a CAP operation, e.g., PreCompose.
#! If applying this method is possible in $C$, the method returns <C>true</C>, <C>false</C> otherwise.
#! If the string is not the name of a CAP operation, an error is raised.
#! For debugging purposes one can also pass the CAP operation instead of its name.
#! @Returns <C>true</C> or <C>false</C>
#! @Arguments C, string
DeclareOperation( "CanCompute",
                  [ IsCapCategory, IsString ] );
#! @Arguments C, operation
DeclareOperation( "CanCompute",
                  [ IsCapCategory, IsFunction ] );
#! @EndGroup

#! @Description
#!  Returns the weight of the operation currently installed as <A>op_name</A> in <A>cat</A>.
#! @Returns an integer
#! @Arguments cat, op_name
DeclareOperation( "OperationWeight",
                  [ IsCapCategory, IsString ] );

DeclareGlobalFunction( "ListInstalledOperationsOfCategory" );
DeclareGlobalFunction( "ListPrimitivelyInstalledOperationsOfCategory" );

#! @Description
#! The arguments are a category $C$ and a string $s$.
#! If $s$ is a categorical property (e.g. <C>"IsAbelianCategory"</C>),
#! the output is a list of strings with CAP operations
#! which are missing in $C$ to have the categorical property
#! constructively.
#! If $s$ is not a categorical property, an error is raised.
#! @Returns a list
#! @Arguments C,s
DeclareOperation( "MissingOperationsForConstructivenessOfCategory",
                  [ IsCapCategory, IsStringRep ] );

#############################################
##
#! @Section Well-Definedness of Cells
##
#############################################

#! @Description
#! The argument is a cell $c$.
#! The output is <C>true</C> if $c$ is well-defined,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments c
DeclareProperty( "IsWellDefined",
                 IsCapCategoryCell );

#############################################
##
#! @Section Unpacking data structures
##
#############################################


#! @Description
#! The argument is a GAP object $x$.
#! If $x$ is an object in a CAP category, the output consists of data which are needed to reconstruct $x$
#! (e.g., by passing them to an appropriate constructor).
#! If $x$ is a morphism in a CAP category, the output consists of a triple whose first entry is the source of $x$,
#! the third entry is the range of $x$, and the second entry consists of data which are needed to reconstruct $x$
#! (e.g., by passing them to an appropriate constructor, possibly together with the source and range of $x$).
#! @Returns a GAP object
#! @Arguments x
DeclareAttribute( "Down",
                  IsObject );

#! @Description
#! The argument is a morphism in a CAP category, the output consists of data which are needed to reconstruct $x$
#! (e.g., by passing it to an appropriate constructor, possibly together with its source and range).
#! @Returns a GAP object
#! @Arguments x
DeclareAttribute( "DownOnlyMorphismData",
                  IsCapCategoryMorphism );

##
DeclareAttribute( "Down2",
                  IsObject );

##
DeclareAttribute( "Down3",
                  IsObject );

#! @Description
#! The argument is a GAP object $x$.
#! This function iteratively calls <C>Down</C> until it becomes stable.
#! @Returns a GAP object
#! @Arguments x
DeclareAttribute( "DownToBottom",
                  IsObject );

####################################
##
#! @Section Caching
#! @SectionLabel Caching
##
####################################

DeclareOperation( "SetCaching",
                  [ IsCapCategory, IsString, IsString ] );

DeclareOperation( "SetCachingToWeak",
                  [ IsCapCategory, IsString ] );

DeclareOperation( "SetCachingToCrisp",
                  [ IsCapCategory, IsString ] );

DeclareOperation( "DeactivateCaching",
                  [ IsCapCategory, IsString ] );

#! @Description
#!  Sets the caching of <A>category</A> to <A>type</A>.
#! @Arguments category, type
DeclareGlobalFunction( "SetCachingOfCategory" );

#! @BeginGroup
#! @Description
#!  Sets the caching of <A>category</A> to <C>weak</C>, <C>crisp</C> or <C>none</C>, respectively.
#! @Arguments category
DeclareGlobalFunction( "SetCachingOfCategoryWeak" );
#! @Arguments category
DeclareGlobalFunction( "SetCachingOfCategoryCrisp" );
#! @Arguments category
DeclareGlobalFunction( "DeactivateCachingOfCategory" );
#! @EndGroup

#! @BeginGroup
#! @Description
#!  Sets the default caching behaviour, all new categories will have their caching set to either
#!  <C>weak</C>, <C>crisp</C>, or <C>none</C>. The default at startup is <C>weak</C>.
#! @Arguments type
DeclareGlobalFunction( "SetDefaultCaching" );
#! @Arguments
DeclareGlobalFunction( "SetDefaultCachingWeak" );
#! @Arguments
DeclareGlobalFunction( "SetDefaultCachingCrisp" );
#! @Arguments
DeclareGlobalFunction( "DeactivateDefaultCaching" );
#! @EndGroup

####################################
##
#! @Section Sanity checks
#! @SectionLabel Sanity_checks
##
####################################

#! @BeginGroup
#! @Description
#!  Most operations can perform optional sanity checks on their arguments and results.
#!  The checks can either be partial (set by default), full, or disabled.
#!  With the following commands you can either enable the full checks, the partial checks or, for performance, disable the checks altogether.
#!  You can do this for input checks, output checks or for both at once.
#! @Arguments category
DeclareGlobalFunction( "DisableInputSanityChecks" );
#! @Arguments category
DeclareGlobalFunction( "DisableOutputSanityChecks" );
#! @Arguments category
DeclareGlobalFunction( "EnablePartialInputSanityChecks" );
#! @Arguments category
DeclareGlobalFunction( "EnablePartialOutputSanityChecks" );
#! @Arguments category
DeclareGlobalFunction( "EnableFullInputSanityChecks" );
#! @Arguments category
DeclareGlobalFunction( "EnableFullOutputSanityChecks" );
#! @Arguments category
DeclareGlobalFunction( "DisableSanityChecks" );
#! @Arguments category
DeclareGlobalFunction( "EnablePartialSanityChecks" );
#! @Arguments category
DeclareGlobalFunction( "EnableFullSanityChecks" );
#! @EndGroup

####################################
##
#! @Section Timing statistics
#! @SectionLabel Timing_statistics
##
####################################

#! @BeginGroup
#! @Description
#!   Enable, disable, reset, display, or browse timing statistics of the primitive operations of <A>category</A>.
#!   Caution: If a primitive operation calls another primitive operation, the runtime
#!   of the later (including sanity checks etc.) is also included in the runtime of the former.
#! @Arguments category
DeclareGlobalFunction( "EnableTimingStatistics" );
#! @Arguments category
DeclareGlobalFunction( "DisableTimingStatistics" );
#! @Arguments category
DeclareGlobalFunction( "ResetTimingStatistics" );
#! @Arguments category
DeclareGlobalFunction( "DisplayTimingStatistics" );
#! @Arguments category
DeclareGlobalFunction( "BrowseTimingStatistics" );
#! @Arguments category
#! @EndGroup

#############################################
##
#! @Section Enable automatic calls of <C>Add</C>
#! @SectionLabel Automatic_adds
##
#############################################

#! @BeginGroup
#! @Description
#!  Enables/disables the automatic call of <C>Add</C> for the output
#!  of primitively added functions for the category <A>C</A>.
#!  If the automatic call of <C>Add</C> is disabled (default),
#!  the output of primitively added functions must belong to the correct category.
#!  If the automatic call of <C>Add</C> is enabled,
#!  the output of primitively added functions only has to be a GAP object
#!  lying in <C>IsAttributeStoringRep</C> (with suitable attributes <C>Source</C> and <C>Range</C>
#!  if the output should be a morphism or a twocell).
#! @Arguments C
DeclareGlobalFunction( "EnableAddForCategoricalOperations" );
#! @Arguments C
DeclareGlobalFunction( "DisableAddForCategoricalOperations" );
#! @EndGroup


#############################################
##
#! @Section Performance tweaks
##
#############################################

#!  For finding performance issues in primitive operations, you can collect timing statistics, see <Ref Sect="Section_Timing_statistics" />.
#!  You can use the package `CompilerForCAP` to compile your code.
#!  Additionally, CAP has several settings which can improve the performance.
#!  In the following some of these are listed.
#!    * <C>DeactivateCachingOfCategory</C> or <C>DeactivateDefaultCaching</C>: see <Ref Sect="Section_Caching" />.
#!        This can either improve or degrade the performance depending on the concrete example.
#!    * <C>CapCategorySwitchLogicOff</C> (on by default) or <C>CapCategorySwitchLogicPropagationOff</C> (off by default): see <Ref Sect="Section_Logic_switcher" />.
#!        This can either improve or degrade the performance depending on the concrete example.
#!    * <C>DisableSanityChecks</C>: see <Ref Sect="Section_Sanity_checks" />.
#!    * <C>DisableAddForCategoricalOperations</C>: see <Ref Sect="Section_Automatic_adds" />.
#!    * <C>DeactivateToDoList</C>: see the package <C>ToolsForHomalg</C>.
#!    * Use <C>CreateCapCategoryObjectWithAttributes</C> (<Ref Sect="Section_Adding_Objects_to_a_Category" />)
#!        instead of <C>AddObject</C> and
#!        <C>CreateCapCategoryMorphismWithAttributes</C> (<Ref Sect="Section_Adding_Morphisms_to_a_Category" />)
#!        instead of <C>AddMorphism</C>.
#!    * Pass the option <C>overhead := false</C> to <C>CreateCapCategory</C>.
#!        Note: this may have unintended effects. Use with care!

#############################################
##
#! @Section LaTeX
##
#############################################

#! @Description
#! The argument is a cell $c$.
#! The output is a LaTeX string $s$ (without enclosing dollar signs) that may be used to print out $c$ nicely.
#! @Returns a string
#! @Arguments c
DeclareOperation( "LaTeXOutput", [ IsCapCategoryCell ] );

#! @Description
#! The argument is a category $C$.
#! The output is a LaTeX string $s$ (without enclosing dollar signs) that may be used to print out $C$ nicely.
#! @Returns a string
#! @Arguments C
DeclareOperation( "LaTeXOutput", [ IsCapCategory ] );
