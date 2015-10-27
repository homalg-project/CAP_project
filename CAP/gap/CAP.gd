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

DeclareGlobalVariable( "CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST" );

DeclareGlobalFunction( "CAP_INTERNAL_INSTALL_PRINT_FUNCTION" );

DeclareGlobalVariable( "CAP_INTERNAL_DERIVATION_GRAPH" );

## FIXME: GET RID OF THIS!!!
InstallValue( CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST,
              rec( 
              MathematicalPropertiesOfCategories := [
                "IsEnrichedOverCommutativeRegularSemigroup",
                "IsAbCategory",
                "IsAdditiveCategory", 
                "IsPreAbelianCategory", 
                "IsAbelianCategory",
                "IsMonoidalCategory",
                "IsBraidedMonoidalCategory",
                "IsSymmetricMonoidalCategory",
                "IsSymmetricClosedMonoidalCategory",
                "IsRigidSymmetricClosedMonoidalCategory",
                "IsStrictMonoidalCategory"
              ] ) );

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
                 IsObject );

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
                 IsCapCategoryCell and IsAdditiveElementWithInverse );

#! @Description
#! The GAP category of CAP category $2$-cells.
#! Every $2$-cell of a CAP category lies in
#! this GAP category.
#! @Arguments object
DeclareCategory( "IsCapCategoryTwoCell",
                 IsCapCategoryCell );

## Earliest possible place
BindGlobal( "INSTALL_CAN_COMPUTE_PROPERTIES",
            
  function( )
    local i, internal_list;
    
    internal_list :=  CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.MathematicalPropertiesOfCategories;
    
    for i in internal_list do
        
        DeclareProperty( i, IsCapCategory );
        
    od;
    
end );

INSTALL_CAN_COMPUTE_PROPERTIES( );

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
#! The argument is a cateogry $C$.
#! The output is a filter in which $C$ lies.
#! @Arguments C
#! @Returns a filter
DeclareAttribute( "CategoryFilter",
                  IsCapCategory );

#! @Description
#! The argument is a cateogry $C$.
#! The output is a filter in which all cells
#! of $C$ shall lie.
#! @Arguments C
#! @Returns a filter
DeclareAttribute( "CellFilter",
                  IsCapCategory );

#! @Description
#! The argument is a cateogry $C$.
#! The output is a filter in which all objects
#! of $C$ shall lie.
#! @Arguments C
#! @Returns a filter
DeclareAttribute( "ObjectFilter",
                  IsCapCategory );

#! @Description
#! The argument is a cateogry $C$.
#! The output is a filter in which all morphisms
#! of $C$ shall lie.
#! @Arguments C
#! @Returns a filter
DeclareAttribute( "MorphismFilter",
                  IsCapCategory );

#! @Description
#! The argument is a cateogry $C$.
#! The output is a filter in which all $2$-cells
#! of $C$ shall lie.
#! @Arguments C
#! @Returns a filter
DeclareAttribute( "TwoCellFilter",
                  IsCapCategory );

#############################################
##
#! @Section Logic switcher
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
#! which should be the name of a primitive operation, e.g., PreCompose.
#! If applying this method is possible in $C$, the method returns <C>true</C>, <C>false</C> otherwise.
#! If the string is not the name of a primitive operation, an error is raised.
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

DeclareGlobalFunction( "SetCachingOfCategory" );
DeclareGlobalFunction( "SetCachingOfCategoryWeak" );
DeclareGlobalFunction( "SetCachingOfCategoryCrisp" );
DeclareGlobalFunction( "DeactivateCachingOfCategory" );

####################################
##
#! @Section Type check
##
####################################

#! @BeginGroup
#! @Description
#!  Most basic operations have a prefunction, which does a (sometimes partial)
#!  typecheck at the beginning of the operation. These functions enable or disable this check
#!  for a category. (Enabled by default)
#! @Arguments category
DeclareGlobalFunction( "DisableBasicOperationTypeCheck" );
DeclareGlobalFunction( "EnableBasicOperationTypeCheck" );
#! @EndGroup

