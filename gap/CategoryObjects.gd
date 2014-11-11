#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Category object
#!  Any GAP object which is IsHomalgCategoryObject can be added to a category
#!  and then becomes an object in this category.
#!  Any object can belong to one or no category.
#!  After a GAP object is added to the category, it knows which things can be
#!  computed in its category and to which category it belongs.
#!  It knows categorial properties and attributes, and the functions for existential quantifiers
#!  can be applied to the object.
#!  If an GAP object in the category was constructed by a categorial construction
#!  it knows its Genesis.
##
#############################################################################

###################################
##
#! @Section Categories
##
###################################

## Moved to CategoriesForHomalg.gd

# DeclareFilter( "WasCreatedAsDirectSum" );

###################################
##
#! @Section Functions for all objects
##
###################################

#! @Description
#! This is the place where the category of an object is stored,
#! once it is set. This also makes sure that an object only belongs to
#! one category
#! @Group Category getter
DeclareAttribute( "HomalgCategory",
                  IsHomalgCategoryObject );

###################################
##
#! @Section Technical stuff
##
###################################

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_OBJECT" );

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_CREATE_OBJECT_PRINT" );

DeclareAttribute( "Genesis",
                  IsHomalgCategoryCell, 
                  "mutable" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_FOR_EQUAL_OBJECTS" );

DeclareGlobalVariable( "PROPAGATION_LIST_FOR_EQUAL_OBJECTS" );

###################################
##
#! @Section Constructive Object-sets
##
###################################

DeclareOperation( "AddIsEqualForObjects",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperationWithCache( "IsEqualForObjects",
                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

DeclareAttribute( "ObjectEqualityFunction",
                  IsHomalgCategory );

DeclareOperation( "AddPropertyToMatchAtIsEqualForObjects",
                  [ IsHomalgCategory, IsString ] );

###################################
##
#! @Section Properties
##
###################################

DeclareProperty( "IsProjective",
                 IsHomalgCategoryObject );

DeclareProperty( "IsInjective",
                 IsHomalgCategoryObject );

DeclareProperty( "IsTerminal",
                 IsHomalgCategoryObject );

DeclareProperty( "IsInitial",
                 IsHomalgCategoryObject );

###################################
##
#! @Section Zero object
##
###################################

DeclareProperty( "IsZero",
                 IsHomalgCategoryObject );

DeclareOperation( "AddIsZeroForObjects",
                  [ IsHomalgCategory, IsFunction ] );

DeclareAttribute( "IsZeroForObjectsFunction",
                  IsHomalgCategory );

###################################
##
#! @Section Add function
##
###################################

DeclareOperation( "Add",
                  [ IsHomalgCategory, IsHomalgCategoryObject ] );

###################################
##
#! @Section Element functions
##
###################################

###################################
##
## IdentityMorphism
##
###################################


DeclareAttributeWithToDoForIsWellDefined( "IdentityMorphism",
                                          IsHomalgCategoryObject );

###################################
##
## Zero Morphism
##
###################################

DeclareOperation( "ZeroMorphism",
                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

###################################
##
## IsWellDefined
##
###################################

DeclareOperation( "AddIsWellDefinedForObjects",
                  [ IsHomalgCategory, IsFunction ] );

DeclareAttribute( "IsWellDefinedForObjectsFunction",
                  IsHomalgCategory );





