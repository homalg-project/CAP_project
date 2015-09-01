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

DeclareOperation( "AddIsEqualForObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEqualForObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEqualForObjects",
                  [ IsCapCategory, IsList ] );


DeclareOperationWithCache( "IsEqualForObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );


DeclareOperation( "AddPropertyToMatchAtIsEqualForObjects",
                  [ IsCapCategory, IsString ] );


###################################
##
#! @Section Properties
##
###################################

##
DeclareFamilyProperty( "IsProjective",
                       IsCapCategoryObject, "object" : reinstall := false );

DeclareOperation( "AddIsProjective",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsProjective",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsProjective",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsProjective",
                  [ IsCapCategory, IsList ] );

##
DeclareFamilyProperty( "IsInjective",
                       IsCapCategoryObject, "object" : reinstall := false );

DeclareOperation( "AddIsInjective",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsInjective",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsInjective",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsInjective",
                  [ IsCapCategory, IsList ] );

##
DeclareFamilyProperty( "IsTerminal",
                       IsCapCategoryObject, "object" : reinstall := false );

DeclareOperation( "AddIsTerminal",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsTerminal",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsTerminal",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsTerminal",
                  [ IsCapCategory, IsList ] );

##
DeclareFamilyProperty( "IsInitial",
                       IsCapCategoryObject, "object" : reinstall := false );

DeclareOperation( "AddIsInitial",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsInitial",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsInitial",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsInitial",
                  [ IsCapCategory, IsList ] );

###################################
##
#! @Section Zero object
##
###################################

DeclareFamilyProperty( "IsZero",
                       IsCapCategoryObject, "object" : reinstall := false );

DeclareOperation( "AddIsZeroForObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsZeroForObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsZeroForObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsZeroForObjects",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "IsZeroForObjects", 
                  [ IsCapCategoryObject ] );


###################################
##
#! @Section Adding Objects to a Category
##
###################################

DeclareOperation( "Add",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareOperation( "AddObject",
                  [ IsCapCategory, IsObject ] );

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

DeclareOperation( "AddZeroMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddZeroMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddZeroMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddZeroMorphism",
                  [ IsCapCategory, IsList ] );

###################################
##
## IsWellDefined
##
###################################

DeclareOperation( "AddIsWellDefinedForObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsWellDefinedForObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsWellDefinedForObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsWellDefinedForObjects",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "IsWellDefinedForObjects",
                  [ IsCapCategoryObject ] );






