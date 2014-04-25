#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
#! @Chapter Universal Objects
##
#############################################################################

####################################
##
## Kernel
##
####################################

## Main Operations and Attributes
DeclareAttribute( "KernelObject",
                  IsHomalgCategoryMorphism );

DeclareAttribute( "KernelEmb",
                  IsHomalgCategoryMorphism );

DeclareAttribute( "KernelEmb",
                  IsHomalgCategoryObject );

DeclareOperation( "KernelEmbWithGivenKernel",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

DeclareOperation( "KernelLift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareOperation( "KernelLiftWithGivenKernel",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

## Function Attributes
DeclareAttribute( "KernelFunction",
                  IsHomalgCategory );

DeclareAttribute( "KernelEmbFunction",
                  IsHomalgCategory );

DeclareAttribute( "KernelEmbWithGivenKernelFunction",
                  IsHomalgCategory );

DeclareAttribute( "KernelLiftFunction",
                  IsHomalgCategory );

DeclareAttribute( "KernelLiftWithGivenKernelFunction",
                  IsHomalgCategory );

## Add Operations
DeclareOperation( "AddKernel",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddKernelEmb",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddKernelEmbWithGivenKernel",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddKernelLift",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddKernelLiftWithGivenKernel",
                  [ IsHomalgCategory, IsFunction ] );

## WasCreatedAs Filter
DeclareFilter( "WasCreatedAsKernel" );


####################################
##
## Cokernel
##
####################################

## Main Operations and Attributes
DeclareAttribute( "Cokernel",
                  IsHomalgCategoryMorphism );

DeclareAttribute( "CokernelProj",
                  IsHomalgCategoryMorphism );

DeclareAttribute( "CokernelProj",
                  IsHomalgCategoryObject );

DeclareOperation( "CokernelProjWithGivenCokernel",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

DeclareOperation( "CokernelColift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareOperation( "CokernelColiftWithGivenCokernel",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

## Function Attributes
DeclareAttribute( "CokernelFunction",
                  IsHomalgCategory );

DeclareAttribute( "CokernelProjFunction",
                  IsHomalgCategory );

DeclareAttribute( "CokernelProjWithGivenCokernelFunction",
                  IsHomalgCategory );

DeclareAttribute( "CokernelColiftFunction",
                  IsHomalgCategory );

DeclareAttribute( "CokernelColiftWithGivenCokernelFunction",
                  IsHomalgCategory );

## Add Operations
DeclareOperation( "AddCokernel",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddCokernelProj",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddCokernelProjWithGivenCokernel",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddCokernelColift",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddCokernelColiftWithGivenCokernel",
                  [ IsHomalgCategory, IsFunction ] );

## WasCreatedAs Filter
DeclareFilter( "WasCreatedAsCokernel" );


####################################
##
## Direct Product
##
####################################

## Main Operations and Attributes

DeclareOperationWithCache( "DirectProductObject",
                           [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

DeclareOperation( "ProjectionInFirstFactor",
                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

DeclareAttribute( "ProjectionInFirstFactor",
                  IsHomalgCategoryObject );

DeclareOperation( "ProjectionInSecondFactor",
                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

DeclareAttribute( "ProjectionInSecondFactor",
                  IsHomalgCategoryObject );

DeclareOperation( "ProjectionInFirstFactorWithGivenDirectProduct",
                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

DeclareOperation( "ProjectionInSecondFactorWithGivenDirectProduct",
                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

DeclareOperation( "UniversalMorphismIntoDirectProduct",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareOperation( "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

## Function Attributes

DeclareAttribute( "DirectProductFunction",
                  IsHomalgCategory );

DeclareAttribute( "ProjectionInFirstFactorOfDirectProductFunction",
                  IsHomalgCategory );

DeclareAttribute( "ProjectionInSecondFactorOfDirectProductFunction",
                  IsHomalgCategory );

DeclareAttribute( "ProjectionInFirstFactorWithGivenDirectProductFunction",
                  IsHomalgCategory );

DeclareAttribute( "ProjectionInSecondFactorWithGivenDirectProductFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismIntoDirectProductFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismIntoDirectProductWithGivenDirectProductFunction",
                  IsHomalgCategory );

## Add Operations

DeclareOperation( "AddDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFirstFactorOfDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );


DeclareOperation( "AddProjectionInSecondFactorOfDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );


DeclareOperation( "AddProjectionInFirstFactorWithGivenDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );


DeclareOperation( "AddProjectionInSecondFactorWithGivenDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );


DeclareOperation( "AddUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );

## WasCreatedAs Filter

DeclareFilter( "WasCreatedAsDirectProduct" );

####################################
##
## Terminal Object
##
####################################

## Main Operations and Attributes

DeclareAttribute( "TerminalObject",
                  IsHomalgCategory );

DeclareAttribute( "TerminalObject",
                  IsHomalgCategoryCell );

DeclareAttribute( "UniversalMorphismIntoTerminalObject",
                  IsHomalgCategoryObject );

DeclareOperation( "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

## Function Attributes

DeclareAttribute( "TerminalObjectFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismIntoTerminalObjectFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismIntoTerminalObjectWithGivenTerminalObjectFunction",
                  IsHomalgCategory );

## Add Operations

DeclareOperation( "AddTerminalObject",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoTerminalObject",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                  [ IsHomalgCategory, IsFunction ] );

## WasCreatedAs Filter

DeclareFilter( "WasCreatedAsTerminalObject" );

####################################
##
## Initial Object
##
####################################

## Main Operations and Attributes

DeclareAttribute( "InitialObject",
                  IsHomalgCategory );

DeclareAttribute( "InitialObject",
                  IsHomalgCategoryCell );

DeclareAttribute( "UniversalMorphismFromInitialObject",
                  IsHomalgCategoryObject );

DeclareOperation( "UniversalMorphismFromInitialObjectWithGivenInitialObject",
                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

## CanCompute Properties

DeclareProperty( "CanComputeInitialObject",
                 IsHomalgCategory );

DeclareProperty( "CanComputeInitialObject",
                 IsHomalgCategoryCell );

DeclareProperty( "CanComputeUniversalMorphismFromInitialObject",
                 IsHomalgCategory );

DeclareProperty( "CanComputeUniversalMorphismFromInitialObject",
                 IsHomalgCategoryCell );

DeclareProperty( "CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject",
                 IsHomalgCategory );

DeclareProperty( "CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject",
                 IsHomalgCategoryCell );

## Function Attributes

DeclareAttribute( "InitialObjectFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromInitialObjectFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromInitialObjectWithGivenInitialObjectFunction",
                  IsHomalgCategory );

## Add Operations

DeclareOperation( "AddInitialObject",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromInitialObject",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromInitialObjectWithGivenInitialObject",
                  [ IsHomalgCategory, IsFunction ] );

## WasCreatedAs Filter

DeclareFilter( "WasCreatedAsInitialObject" );

####################################
##
## Scheme for Universal Object
##
####################################

## Main Operations and Attributes

## Function Attributes

## Add Operations

## WasCreatedAs Filter
