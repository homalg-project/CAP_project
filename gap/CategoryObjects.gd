#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
#! @Chapter Category object
##
#############################################################################

###################################
##
#! @Section Categories
##
###################################

DeclareCategory( "IsHomalgCategoryObject",
                 IsHomalgCategoryCell );

DeclareFilter( "WasCreatedAsDirectSum" );

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
                  IsHomalgCategoryCell );

###################################
##
#! @Section Add function
##
###################################

DeclareProperty( "IsProjective",
                 IsHomalgCategoryObject );

DeclareProperty( "IsInjective",
                 IsHomalgCategoryObject );

DeclareProperty( "IsZero",
                 IsHomalgCategoryObject );

###################################
##
#! @Section Add function
##
###################################

DeclareOperation( "Add",
                  [ IsHomalgCategory, IsHomalgCategoryObject ] );

###################################
##
#! @Section Direct sum attributes
##
###################################


DeclareOperation( "DirectSumOp",
                  [ IsList, IsHomalgCategoryObject ] );

DeclareAttribute( "FirstSummand",
                  IsHomalgCategoryObject );

DeclareAttribute( "SecondSummand",
                  IsHomalgCategoryObject );

# 
# DeclareAttribute( "ProjectionInFirstFactor",
#                   IsHomalgCategoryObject );
# 
# 
# DeclareAttribute( "ProjectionInSecondFactor",
#                   IsHomalgCategoryObject );


DeclareAttribute( "InjectionFromFirstSummand",
                  IsHomalgCategoryObject );


DeclareAttribute( "InjectionFromSecondSummand",
                  IsHomalgCategoryObject );

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
## ZeroObject
##
###################################


DeclareAttribute( "ZeroObject",
                  IsHomalgCategoryObject );


DeclareAttribute( "MorphismFromZeroObject",
                  IsHomalgCategoryObject );


DeclareAttribute( "MorphismIntoZeroObject",
                  IsHomalgCategoryObject );


DeclareOperation( "ZeroMorphism",
                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

###################################
##
## Direct Product
##
###################################








