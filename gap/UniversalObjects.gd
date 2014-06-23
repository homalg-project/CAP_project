#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Universal Objects
#! For every universal object $X$, there are 5 methods which can be installed:
#! * Constructor of $X$ with a diagram $D$ (i.e. a list of morphisms and objects) as an input
#! * Constructor of source/sink data with input $D$
#! * Constructor of source/sink data with input $D$ and $X$
#! * Constructor of universal property morphism with input $D$ and a test source/sink $T$
#! * Constructor of universal property morphism with input $D$ and a test source/sink $T$ and $X$
#! Every universal object stores if it was created as such and therefore can be used to access universal property morphisms (if computable).
#############################################################################

####################################
##
#! @Section Kernel
##
####################################

## Main Operations and Attributes
#! @Description
#!  Kernel of a given morphism.
#! @Returns IsHomalgCategoryObject
DeclareAttribute( "KernelObject",
                  IsHomalgCategoryMorphism );

#! @Description
#! Embedding of the kernel of a given morphism $\alpha$ into the source of $\alpha$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha
DeclareAttribute( "KernelEmb",
                  IsHomalgCategoryMorphism );

#! @Description
#! Kernel embedding of an object which was created as a kernel.
#! @Returns IsHomalgCategoryMorphism
DeclareAttribute( "KernelEmb",
                  IsHomalgCategoryObject );

#! @Description
#! Embedding of a given kernel $K$ of a given morphism $\alpha$ into the source of $\alpha$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha, K
DeclareOperation( "KernelEmbWithGivenKernel",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

#! @Description
#! Given a morphism $\alpha: A \rightarrow B$ and a testmorphism $\tau: T \rightarrow A$ such that $\alpha \circ \tau = 0$, this method
#! returns the unique morphism $u: T \rightarrow \mathrm{Kern}( \alpha )$ such that $\tau = \epsilon \circ u$, where $\epsilon: \mathrm{Kern}(\alpha) \rightarrow A$
#! denotes the kernel embedding.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha, tau
DeclareOperation( "KernelLift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

#! @Description
#! Given a morphism $\alpha: A \rightarrow B$ with a kernel $K$ and a testmorphism $\tau: T \rightarrow A$ such that $\alpha \circ \tau = 0$, this method
#! returns the unique morphism $u: T \rightarrow K$ such that $\tau = \epsilon \circ u$, where $\epsilon: K \rightarrow A$
#! denotes the kernel embedding.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha, tau, K
DeclareOperation( "KernelLiftWithGivenKernel",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

## Function Attributes
#! @AutoDoc
#! @BeginGroup

#! @Description
#! These attributes store the implementations of the basic algorithms for a kernel. 
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
#! @EndGroup
#! @EndAutoDoc

## Add Operations
#! @AutoDoc
#! @BeginGroup

#! @Description
#! These operations add a given method $f$ to a category $C$, i.e., the
#! method AddX installs a method $X$ for the category $C$.
#! @Arguments C, f
DeclareOperation( "AddKernel",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddKernelEmb",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddKernelEmbWithGivenKernel",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddKernelLift",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddKernelLiftWithGivenKernel",
                  [ IsHomalgCategory, IsFunction ] );
#! @EndGroup
#! @EndAutoDoc

## WasCreatedAs Filter
#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a kernel object. 
#! Note that we chose <C>WasCreatedAsKernel</C> to be a filter rather than a property,
#! because by default, a filter is set to false. 
DeclareFilter( "WasCreatedAsKernel" );
#! @Chapter Universal Objects

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


DeclareOperation( "AddProjectionInFirstFactorOfDirectProductWithGivenDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );


DeclareOperation( "AddProjectionInSecondFactorOfDirectProductWithGivenDirectProduct",
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
