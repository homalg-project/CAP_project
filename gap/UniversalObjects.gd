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
#!  @Section Cokernel
##
####################################

## Main Operations and Attributes
#! @Description
#!  Cokernel of a given morphism.
#! @Returns IsHomalgCategoryObject
DeclareAttribute( "Cokernel",
                  IsHomalgCategoryMorphism );

#! @Description
#! Projection $B \twoheadrightarrow \mathrm{Coker}(\alpha)$ into the cokernel of a given morphism $\alpha: A \rightarrow B$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha
DeclareAttribute( "CokernelProj",
                  IsHomalgCategoryMorphism );

#! @Description
#! Cokernel projection of an object which was created as a cokernel.
#! @Returns IsHomalgCategoryMorphism
DeclareAttribute( "CokernelProj",
                  IsHomalgCategoryObject );

#! @Description
#! Projection $B \twoheadrightarrow K$ of a given cokernel $K$ of a given morphism $\alpha: A \rightarrow B$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha, K
DeclareOperation( "CokernelProjWithGivenCokernel",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

#! @Description
#! Given a morphism $\alpha: A \rightarrow B$ and a testmorphism $\tau: B \rightarrow T$ such that $\tau \circ \alpha = 0$, this method
#! returns the unique morphism $u: \mathrm{Coker}(\alpha) \rightarrow T$ such that $\tau = u \circ \epsilon$, where 
#! $\epsilon: B \rightarrow \mathrm{Coker}(\alpha)$ denotes the cokernel projection.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha, tau
DeclareOperation( "CokernelColift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );
#! @Description
#! Given a morphism $\alpha: A \rightarrow B$ with its cokernel $K$ and a testmorphism $\tau: B \rightarrow T$ 
#! such that $\tau \circ \alpha = 0$, this method returns the unique morphism $u: K \rightarrow T$ such that 
#! $\tau = u \circ \epsilon$, where $\epsilon: B \rightarrow K$ denotes the cokernel projection.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha, tau, K
DeclareOperation( "CokernelColiftWithGivenCokernel",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

## Function Attributes
#! @AutoDoc
#! @BeginGroup

#! @Description
#! These attributes store the implementations of the basic algorithms for a cokernel. 
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
#! @EndGroup
#! @EndAutoDoc


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
#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a cokernel object. 
#! Note that we chose <C>WasCreatedAsCokernel</C> to be a filter rather than a property,
#! because by default, a filter is set to false. 
DeclareFilter( "WasCreatedAsCokernel" );

#! @Chapter Universal Objects

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
#! @Section Terminal Object
##
####################################

## Main Operations and Attributes

#! @BeginGroup 

#! @Description
#! Terminal object of a category $C$
#! @Returns IsHomalgCategoryObject
#! @Arguments C
DeclareAttribute( "TerminalObject",
                  IsHomalgCategory );

#! @Description
#! or of a cell $c$ in $C$
#! @Arguments c
DeclareAttribute( "TerminalObject",
                  IsHomalgCategoryCell );

#! @EndGroup 

#! @Description
#! Given an object $A$ this method returns the unique morphism $u: A \rightarrow T$ from 
#! $A$ into the terminal object $T$ of the category of $A$
#! @Returns IsHomalgCategoryMorphism
#! @Arguments A
DeclareAttribute( "UniversalMorphismIntoTerminalObject",
                  IsHomalgCategoryObject );

#! @Description
#! Given an object $A$ and a terminal object $T$ this method returns the unique morphism $u: A \rightarrow T$ from 
#! $A$ to $T$
#! @Returns IsHomalgCategoryMorphism
#! @Arguments A, T
DeclareOperation( "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

## Function Attributes

#! @BeginGroup

#! @AutoDoc
#! @Description
#! These attributes store the implementations of the basic algorithms for a terminal object. 
DeclareAttribute( "TerminalObjectFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismIntoTerminalObjectFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismIntoTerminalObjectWithGivenTerminalObjectFunction",
                  IsHomalgCategory );
#! @EndAutoDoc

# @EndGroup

## Add Operations

#! @AutoDoc
#! @BeginGroup

#! @Description
#! These operations add a given method $f$ to a category $C$, i.e., the
#! method AddX installs a method $X$ for the category $C$.
#! @Arguments C, f
DeclareOperation( "AddTerminalObject",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoTerminalObject",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                  [ IsHomalgCategory, IsFunction ] );

#! @EndGroup

#! @EndAutoDoc

## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a terminal object. 
#! Note that we chose <C>WasCreatedAsTerminalObject</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsTerminalObject" );

#! @Chapter Universal Objects

####################################
##
#! @Section Initial Object
##
####################################

## Main Operations and Attributes

#! @BeginGroup 

#! @Description
#! Initial object of a category $C$
#! @Returns IsHomalgCategoryObject
#! @Arguments C
DeclareAttribute( "InitialObject",
                  IsHomalgCategory );

#! @Description
#! or of a cell $c$ in $C$
#! @Arguments c
DeclareAttribute( "InitialObject",
                  IsHomalgCategoryCell );

#! @EndGroup 

#! @Description
#! Given an object $A$ this method returns the unique morphism $u: I \rightarrow A$
#! from the initial object $I$ of the category of $A$ to $A$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments A
DeclareAttribute( "UniversalMorphismFromInitialObject",
                  IsHomalgCategoryObject );

#! @Description
#! Given an object $A$ and an initial object $I$ this method returns the unique morphism $u: I \rightarrow A$ from 
#! $I$ to $A$
#! @Returns IsHomalgCategoryMorphism
#! @Arguments A, I
DeclareOperation( "UniversalMorphismFromInitialObjectWithGivenInitialObject",
                  [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

## Function Attributes

#! @BeginGroup

#! @AutoDoc
#! @Description
#! These attributes store the implementations of the basic algorithms for a initial object. 
DeclareAttribute( "InitialObjectFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromInitialObjectFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromInitialObjectWithGivenInitialObjectFunction",
                  IsHomalgCategory );
#! @EndAutoDoc

# @EndGroup

## Add Operations

#! @AutoDoc
#! @BeginGroup

#! @Description
#! These operations add a given method $f$ to a category $C$, i.e., the
#! method AddX installs a method $X$ for the category $C$.
#! @Arguments C, f
DeclareOperation( "AddInitialObject",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromInitialObject",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromInitialObjectWithGivenInitialObject",
                  [ IsHomalgCategory, IsFunction ] );
#! @EndGroup

#! @EndAutoDoc

## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a initial object. 
#! Note that we chose <C>WasCreatedAsInitialObject</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsInitialObject" );

#! @Chapter Universal Objects

####################################
##
## Scheme for Universal Object
##
####################################

## Main Operations and Attributes

## Function Attributes

## Add Operations

## WasCreatedAs Filter
