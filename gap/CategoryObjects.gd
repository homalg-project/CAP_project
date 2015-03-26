#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Category object
#!  Any GAP object which is IsCapCategoryObject can be added to a category
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

## Moved to CAP.gd

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
DeclareAttribute( "CapCategory",
                  IsCapCategoryObject );

###################################
##
#! @Section Technical stuff
##
###################################

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_OBJECT" );

DeclareGlobalFunction( "CAP_INTERNAL_CREATE_OBJECT_PRINT" );

DeclareAttribute( "Genesis",
                  IsCapCategoryCell, 
                  "mutable" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_FOR_EQUAL_OBJECTS" );

DeclareGlobalVariable( "PROPAGATION_LIST_FOR_EQUAL_OBJECTS" );

###################################
##
## Constructive Object-sets
##
###################################

DeclareOperation( "AddIsEqualForObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperationWithCache( "IsEqualForObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareAttribute( "ObjectEqualityFunction",
                  IsCapCategory );

DeclareOperation( "AddPropertyToMatchAtIsEqualForObjects",
                  [ IsCapCategory, IsString ] );

###################################
##
#! @Section Properties
##
###################################

DeclareFamilyProperty( "IsProjective",
                       IsCapCategoryObject, "object" : reinstall := false );

DeclareFamilyProperty( "IsInjective",
                       IsCapCategoryObject, "object" : reinstall := false );

DeclareFamilyProperty( "IsTerminal",
                       IsCapCategoryObject, "object" : reinstall := false );

DeclareFamilyProperty( "IsInitial",
                       IsCapCategoryObject, "object" : reinstall := false );

###################################
##
#! @Section Zero object
##
###################################

DeclareFamilyProperty( "IsZero",
                       IsCapCategoryObject, "object" : reinstall := false );

DeclareOperation( "AddIsZeroForObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "IsZeroForObjectsFunction",
                  IsCapCategory );

###################################
##
#! @Section Add function
##
###################################

DeclareOperation( "Add",
                  [ IsCapCategory, IsCapCategoryObject ] );

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
                                          IsCapCategoryObject );

###################################
##
## Zero Morphism
##
###################################

DeclareOperation( "ZeroMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

###################################
##
## IsWellDefined
##
###################################

DeclareOperation( "AddIsWellDefinedForObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "IsWellDefinedForObjectsFunction",
                  IsCapCategory );





