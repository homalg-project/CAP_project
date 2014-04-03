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

DeclareProperty( "CanComputeInverse",
                 IsHomalgCategoryObject );

DeclareProperty( "CanComputeKernel",
                 IsHomalgCategoryObject );

DeclareProperty( "CanComputeKernelEmb",
                 IsHomalgCategoryObject );

DeclareProperty( "CanComputeKernelLift",
                 IsHomalgCategoryObject );

DeclareProperty( "CanComputeCokernel",
                 IsHomalgCategoryObject );

DeclareProperty( "CanComputeCokernelProj",
                 IsHomalgCategoryObject );

DeclareProperty( "CanComputeCokernelColift",
                 IsHomalgCategoryObject );

DeclareProperty( "CanComputePreCompose",
                 IsHomalgCategoryObject );

DeclareProperty( "CanComputePostCompose",
                 IsHomalgCategoryObject );

DeclareProperty( "CanComputeEpiAsCokernelColift",
                 IsHomalgCategoryObject );

DeclareProperty( "CanComputeMonoAsKernelLift",
                 IsHomalgCategoryObject );

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

DeclareProperty( "CanComputeDirectSum",
                 IsHomalgCategoryObject );

DeclareOperation( "DirectSumOp",
                  [ IsList, IsHomalgCategoryObject ] );

DeclareAttribute( "FirstSummand",
                  IsHomalgCategoryObject );

DeclareAttribute( "SecondSummand",
                  IsHomalgCategoryObject );

DeclareProperty( "CanComputeProjectionInFirstFactor",
                 IsHomalgCategoryObject );

DeclareAttribute( "ProjectionInFirstFactor",
                  IsHomalgCategoryObject );

DeclareProperty( "CanComputeProjectionInSecondFactor",
                 IsHomalgCategoryObject );

DeclareAttribute( "ProjectionInSecondFactor",
                  IsHomalgCategoryObject );

DeclareProperty( "CanComputeInjectionFromFirstSummand",
                 IsHomalgCategoryObject );

DeclareAttribute( "InjectionFromFirstSummand",
                  IsHomalgCategoryObject );

DeclareProperty( "CanComputeInjectionFromSecondSummand",
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

DeclareProperty( "CanComputeIdentityMorphism",
                 IsHomalgCategoryObject );

DeclareAttribute( "IdentityMorphism",
                  IsHomalgCategoryObject );

###################################
##
## ZeroObject
##
###################################

DeclareProperty( "CanComputeZeroObject",
                 IsHomalgCategoryObject );

DeclareAttribute( "ZeroObject",
                  IsHomalgCategoryObject );

DeclareProperty( "CanComputeMorphismFromZeroObject",
                 IsHomalgCategoryObject );

DeclareAttribute( "MorphismFromZeroObject",
                  IsHomalgCategoryObject );

DeclareProperty( "CanComputeMorphismIntoZeroObject",
                 IsHomalgCategoryObject );

DeclareAttribute( "MorphismIntoZeroObject",
                  IsHomalgCategoryObject );

DeclareProperty( "CanComputeZeroMorphism",
                 IsHomalgCategoryObject );

DeclareOperation( "ZeroMorphism",
                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );