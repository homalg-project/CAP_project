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
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

## CanCompute Properties
DeclareProperty( "CanComputeKernel",
                 IsHomalgCategory );

DeclareProperty( "CanComputeKernel",
                 IsHomalgCategoryCell );

DeclareProperty( "CanComputeKernelEmb",
                 IsHomalgCategory );

DeclareProperty( "CanComputeKernelEmb",
                 IsHomalgCategoryCell );

DeclareProperty( "CanComputeKernelEmbWithGivenKernel",
                 IsHomalgCategory );

DeclareProperty( "CanComputeKernelEmbWithGivenKernel",
                 IsHomalgCategoryCell );

DeclareProperty( "CanComputeKernelLift",
                 IsHomalgCategory );

DeclareProperty( "CanComputeKernelLift",
                 IsHomalgCategoryCell );

DeclareProperty( "CanComputeKernelLiftWithGivenKernel",
                 IsHomalgCategory );

DeclareProperty( "CanComputeKernelLiftWithGivenKernel",
                 IsHomalgCategoryCell );

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

## CanCompute Properties
DeclareProperty( "CanComputeCokernel",
                 IsHomalgCategory );

DeclareProperty( "CanComputeCokernel",
                 IsHomalgCategoryCell );

DeclareProperty( "CanComputeCokernelProj",
                 IsHomalgCategory );

DeclareProperty( "CanComputeCokernelProj",
                 IsHomalgCategoryCell );

DeclareProperty( "CanComputeCokernelProjWithGivenCokernel",
                 IsHomalgCategory );

DeclareProperty( "CanComputeCokernelProjWithGivenCokernel",
                 IsHomalgCategoryCell );

DeclareProperty( "CanComputeCokernelColift",
                 IsHomalgCategory );

DeclareProperty( "CanComputeCokernelColift",
                 IsHomalgCategoryCell );

DeclareProperty( "CanComputeCokernelColiftWithGivenCokernel",
                 IsHomalgCategory );

DeclareProperty( "CanComputeCokernelColiftWithGivenCokernel",
                 IsHomalgCategoryCell );

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

## CanCompute Properties

DeclareProperty( "CanComputeDirectProduct",
                 IsHomalgCategory );

DeclareProperty( "CanComputeProjectionInFirstFactorOfDirectProduct",
                 IsHomalgCategory );

DeclareProperty( "CanComputeProjectionInSecondFactorOfDirectProduct",
                 IsHomalgCategory );

DeclareProperty( "CanComputeProjectionInFirstFactorWithGivenDirectProduct",
                 IsHomalgCategory );

DeclareProperty( "CanComputeProjectionInSecondFactorWithGivenDirectProduct",
                 IsHomalgCategory );

DeclareProperty( "CanComputeUniversalMorphismIntoDirectProduct",
                 IsHomalgCategory );

DeclareProperty( "CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                 IsHomalgCategory );

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
## CanCompute Properties

# DeclareFilter( "CanComputeTerminalObject" );
# 
# DeclareFilter( "CanComputeUniversalMorphismIntoTerminalObject" );
# 
# DeclareFilter( "CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject" );

DeclareProperty( "CanComputeTerminalObject",
                 IsHomalgCategory );

DeclareProperty( "CanComputeTerminalObject",
                 IsHomalgCategoryCell );

DeclareProperty( "CanComputeUniversalMorphismIntoTerminalObject",
                 IsHomalgCategory );

DeclareProperty( "CanComputeUniversalMorphismIntoTerminalObject",
                 IsHomalgCategoryCell );

DeclareProperty( "CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                 IsHomalgCategory );

DeclareProperty( "CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                 IsHomalgCategoryCell );

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
## Scheme for Universal Object
##
####################################

## Main Operations and Attributes

## CanCompute Properties

## Function Attributes

## Add Operations

## WasCreatedAs Filter
