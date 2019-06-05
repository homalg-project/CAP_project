#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
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
##
#############################################################################


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

DeclareGlobalVariable( "CAP_INTERNAL_DERIVATION_GRAPH" );

DeclareGlobalVariable( "CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST" );

## Syntax for categorical property with no dual counterpart:
## [ , "property" ]
InstallValue( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST, [ ] );

DeclareGlobalVariable( "CATEGORIES_FAMILY_PROPERTIES" );

InstallValue( CATEGORIES_FAMILY_PROPERTIES,

              rec( ) );

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
                 IsObject );

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

DeclareCategory( "IsCellOfSkeletalCategory",
                 IsCapCategoryCell );

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
  function( property_list )
    local i;

    if Length( property_list ) > 2 or Length( property_list ) < 1 then
        Error( "only length 1 or two allowed " );
        return;
    fi;

    Add( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST, property_list );

    for i in [ 1 .. 2 ] do
        if IsBound( property_list[ i ] ) and IsString( property_list[ i ] ) then
            DeclareProperty( property_list[ i ], IsCapCategory );
        fi;
    od;
end );

Perform(
## This is the CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST
    [ [ "IsEnrichedOverCommutativeRegularSemigroup" ],
      [ "IsAbCategory" ],
      [ "IsLinearCategoryOverCommutativeRing" ],
      [ "IsAdditiveCategory" ],
      [ "IsPreAbelianCategory" ],
      [ "IsAbelianCategory" ],
      [ "IsAbelianCategoryWithEnoughProjectives", "IsAbelianCategoryWithEnoughInjectives" ]
    ],
    AddCategoricalProperty );

DeclareAttribute( "TheoremRecord",
                  IsCapCategory, "mutable" );

DeclareOperation( "AddCategoryToFamily",
                  [ IsCapCategory, IsString ] );

###################################
##
#! @Section Constructor
##
###################################

DeclareGlobalFunction( "CREATE_CAP_CATEGORY_OBJECT" );

DeclareGlobalFunction( "CREATE_CAP_CATEGORY_FILTERS" );

DeclareGlobalFunction( "INSTALL_ADD_FUNCTIONS_FOR_CATEGORY" );

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

###################################
##
#! @Section Internal Attributes
##
###################################

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

#! @Description
#! The argument is a category $C$.
#! The output is a filter in which all cells
#! of $C$ shall lie.
#! @Arguments C
#! @Returns a filter
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
#! The argument is a category $C$ which is expected to lie in the
#! filter <C>IsLinearCategoryOverCommutativeRing</C>.
#! The output is a commutative ring over which the category is linear.
#! @Arguments C
#! @Returns a ring
DeclareAttribute( "CommutativeRingOfLinearCategory",
                  IsCapCategory );

##
DeclareAttribute( "RangeCategoryOfHomomorphismStructure",
                  IsCapCategory );

#############################################
##
#! @Section Logic switcher
#! @SectionLabel Logic_switcher
##
#############################################

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


#! @Description
#! The argument is a category $C$ and a string $s$,
#! which should be the name of a basic operation, e.g., PreCompose.
#! If applying this method is possible in $C$, the method returns <C>true</C>, <C>false</C> otherwise.
#! If the string is not the name of a basic operation, an error is raised.
#! @Returns <C>true</C> or <C>false</C>
#! @Arguments C,s
DeclareOperation( "CanCompute",
                  [ IsCapCategory, IsString ] );

#! @Description
#! The arguments are a category $C$ and a string $s$.
#! If $s$ is a categorical property (e.g. <C>"IsAbelianCategory"</C>),
#! the output is a list of strings with basic operations
#! which are missing in $C$ to have the categorical property
#! constructively.
#! If $s$ is not a categorical property, an error is raised.
#! @Returns a list
#! @Arguments C,s
DeclareOperation( "CheckConstructivenessOfCategory",
                  [ IsCapCategory, IsString ] );

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

## Undocumented, but kept for compatibility
DeclareGlobalFunction( "DisableBasicOperationTypeCheck" );
DeclareGlobalFunction( "EnablePartialBasicOperationTypeCheck" );
DeclareGlobalFunction( "EnableFullBasicOperationTypeCheck" );
DeclareGlobalFunction( "EnableBasicOperationTypeCheck" );

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

#!  CAP has several settings which can improve the performance.
#!  In the following some of these are listed.
#!    * <C>DeactivateCachingOfCategory</C>: see <Ref Sect="Section_Caching" />.
#!        This can either improve or degrade the performance depending on the concrete example.
#!    * <C>CapCategorySwitchLogicOff</C>: see <Ref Sect="Section_Logic_switcher" />.
#!        This can either improve or degrade the performance depending on the concrete example.
#!    * <C>DisableSanityChecks</C>: see <Ref Sect="Section_Sanity_checks" />.
#!    * <C>DisableAddForCategoricalOperations</C>: see <Ref Sect="Section_Automatic_adds" />.
#!    * <C>DeactivateToDoList</C>: see the package <C>ToolsForHomalg</C>.
#!    * use <C>ObjectifyObjectForCAPWithAttributes</C> (<Ref Sect="Section_Adding_Objects_to_a_Category" />)
#!        instead of <C>AddObject</C> and
#!        <C>ObjectifyMorphismForCAPWithAttributes</C> (<Ref Sect="Section_Adding_Morphisms_to_a_Category" />)
#!        instead of <C>AddMorphism</C>.
