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

## needed for multiple genesis
DeclareOperation( "AddToGenesis",
                  [ IsHomalgCategoryCell, IsObject, IsObject ] );

####################################
##
#! @Section Kernel
##
####################################

#! Let $\alpha: A \rightarrow B$ be a morphism. A kernel of $\alpha$ is a morphism
#! $\iota: K \rightarrow A$ such that $\alpha \circ \iota = 0$ and such that for 
#! every test morphism $\tau: T \rightarrow A$ with $\alpha \circ \tau = 0$, there
#! exists a unique morphism $u: T \rightarrow K$ such that $\iota \circ u = \tau$.

## Main Operations and Attributes
#! @Description
#!  Kernel of a given morphism.
#! @Returns IsHomalgCategoryObject
DeclareAttributeWithToDoForIsWellDefined( "KernelObject",
                                          IsHomalgCategoryMorphism );

#! @Description
#! Embedding of the kernel of a given morphism $\alpha$ into the source of $\alpha$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha
DeclareAttributeWithToDoForIsWellDefined( "KernelEmb",
                                          IsHomalgCategoryMorphism );

#! @Description
#! Kernel embedding of an object which was created as a kernel.
#! @Returns IsHomalgCategoryMorphism
DeclareAttributeWithToDoForIsWellDefined( "KernelEmb",
                                          IsHomalgCategoryObject );

#! @Description
#! Embedding of a given kernel $K$ of a given morphism $\alpha$ into the source of $\alpha$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha, K
DeclareOperation( "KernelEmbWithGivenKernel",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

# @Description
#! Given a kernel $K$ of a morphism $\alpha:A \rightarrow B$ and a testmorphism $\tau: T \rightarrow A$ such that $\alpha \circ \tau = 0$, this method
#! returns the unique morphism $u: T \rightarrow K$ such that $\tau = \epsilon \circ u$, where $\epsilon: \mathrm{Kern}(\alpha) \rightarrow A$
#! denotes the kernel embedding.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments K, tau
DeclareOperation( "KernelLift",
                  [ IsHomalgCategoryObject, IsHomalgCategoryMorphism ] );

#! @Description
#! Given a morphism $\alpha: A \rightarrow B$ and a testmorphism $\tau: T \rightarrow A$ such that $\alpha \circ \tau = 0$, this method
#! returns the unique morphism $u: T \rightarrow K$ such that $\tau = \epsilon \circ u$, where $\epsilon: \mathrm{Kern}(\alpha) \rightarrow A$
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

#! @Description
#! This operation adds the given function $f: \alpha \mapsto K$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddKernel",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: \alpha \mapsto \iota$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddKernelEmb",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: (\alpha, K) \mapsto \iota$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddKernelEmbWithGivenKernel",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: (\alpha, \tau) \mapsto u$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddKernelLift",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: (\alpha, \tau, K) \mapsto u$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddKernelLiftWithGivenKernel",
                  [ IsHomalgCategory, IsFunction ] );

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

#! Let $\alpha: A \rightarrow B$ be a morphism. A cokernel of $\alpha$ is a morphism
#! $\epsilon: B \rightarrow C$ such that $\epsilon \circ \alpha = 0$ and such that for 
#! every test morphism $\tau: B \rightarrow T$ with $\tau \circ \alpha = 0$, there
#! exists a unique morphism $u: C \rightarrow T$ such that $u \circ \epsilon  = \tau$.


## Main Operations and Attributes
#! @Description
#!  Cokernel of a given morphism.
#! @Returns IsHomalgCategoryObject
DeclareAttributeWithToDoForIsWellDefined( "Cokernel",
                                          IsHomalgCategoryMorphism );

#! @Description
#! Projection $B \twoheadrightarrow \mathrm{Coker}(\alpha)$ into the cokernel of a given morphism $\alpha: A \rightarrow B$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha
DeclareAttributeWithToDoForIsWellDefined( "CokernelProj",
                                          IsHomalgCategoryMorphism );

#! @Description
#! Cokernel projection of an object which was created as a cokernel.
#! @Returns IsHomalgCategoryMorphism
DeclareAttributeWithToDoForIsWellDefined( "CokernelProj",
                                          IsHomalgCategoryObject );

#! @Description
#! Projection $B \twoheadrightarrow C$ of a given cokernel $C$ of a given morphism $\alpha: A \rightarrow B$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha, C
DeclareOperation( "CokernelProjWithGivenCokernel",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );


#! @Description
#! Given a cokernel $C$ of a morphism $\alpha: A \rightarrow B$ and a testmorphism $\tau: B \rightarrow T$ such that $\tau \circ \alpha = 0$, this method
#! returns the unique morphism $u: \mathrm{Coker}(\alpha) \rightarrow T$ such that $\tau = u \circ \epsilon$, where 
#! $\epsilon: B \rightarrow \mathrm{Coker}(\alpha)$ denotes the cokernel projection.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments C, tau
DeclareOperation( "CokernelColift",
                  [ IsHomalgCategoryObject, IsHomalgCategoryMorphism ] );

#! @Description
#! Given a morphism $\alpha: A \rightarrow B$ and a testmorphism $\tau: B \rightarrow T$ such that $\tau \circ \alpha = 0$, this method
#! returns the unique morphism $u: \mathrm{Coker}(\alpha) \rightarrow T$ such that $\tau = u \circ \epsilon$, where 
#! $\epsilon: B \rightarrow \mathrm{Coker}(\alpha)$ denotes the cokernel projection.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha, tau
DeclareOperation( "CokernelColift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );
#! @Description
#! Given a morphism $\alpha: A \rightarrow B$ with its cokernel $C$ and a testmorphism $\tau: B \rightarrow T$ 
#! such that $\tau \circ \alpha = 0$, this method returns the unique morphism $u: C \rightarrow T$ such that 
#! $\tau = u \circ \epsilon$, where $\epsilon: B \rightarrow C$ denotes the cokernel projection.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha, tau, C
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
#! @Description
#! This operation adds the given function $f: \alpha \mapsto C$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddCokernel",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: \alpha \mapsto \epsilon$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddCokernelProj",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: (\alpha, C) \mapsto \epsilon$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddCokernelProjWithGivenCokernel",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: (\alpha, \tau) \mapsto u$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddCokernelColift",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: (\alpha, \tau, C) \mapsto u$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
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
#! @Section Zero object
##
####################################

#! A zero object of a category $C$ is an object $Z$ which is an initial and a terminal object.

## Main Operations and Attributes

#! @BeginGroup 

#! @Description
#! Zero object of a category $C$
#! @Returns IsHomalgCategoryObject
#! @Arguments C
DeclareAttribute( "ZeroObject",
                  IsHomalgCategory );

#! @Description
#! or of a cell $c$ in $C$
#! @Arguments c
DeclareAttribute( "ZeroObject",
                  IsHomalgCategoryCell );

DeclareAttributeWithToDoForIsWellDefined( "MorphismFromZeroObject",
                                          IsHomalgCategoryObject );

DeclareAttributeWithToDoForIsWellDefined( "MorphismIntoZeroObject",
                                          IsHomalgCategoryObject );

#! @EndGroup 


## Function Attributes

#! @BeginGroup

#! @Description
#! These attributes store the implementations of the basic algorithms for a terminal object. 
DeclareAttribute( "ZeroObjectFunction",
                  IsHomalgCategory );

#! @EndGroup

## Add Operations

#! @Description
#! This operation adds the given function $f$: (no argument) $\mapsto Z$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddZeroObject",
                  [ IsHomalgCategory, IsFunction ] );




## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a zero object. 
#! Note that we chose <C>WasCreatedAsZeroObject</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsZeroObject" );

DeclareProperty( "IS_IMPLIED_ZERO_OBJECT", 
                 IsHomalgCategoryObject );
#! @Chapter Universal Objects

####################################
##
#! @Section Terminal object
##
####################################

#! An object $T$ of a category $C$ is called terminal if for every object $A$
#! there exists a unique morphism $u: A \rightarrow T$.

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
DeclareAttributeWithToDoForIsWellDefined( "UniversalMorphismIntoTerminalObject",
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

#! @EndGroup

## Add Operations


#! @Description
#! This operation adds the given function $f$: (no argument) $\mapsto T$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddTerminalObject",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: A \mapsto u$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoTerminalObject",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: (A, T) \mapsto u$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                  [ IsHomalgCategory, IsFunction ] );


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

#! An object $I$ of a category $C$ is called initial if for every object $A$
#! there exists a unique morphism $u: I \rightarrow A$.

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
DeclareAttributeWithToDoForIsWellDefined( "UniversalMorphismFromInitialObject",
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
#! These attributes store the implementations of the basic algorithms for an initial object. 
DeclareAttribute( "InitialObjectFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromInitialObjectFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromInitialObjectWithGivenInitialObjectFunction",
                  IsHomalgCategory );
#! @EndAutoDoc

#! @EndGroup

## Add Operations

#! @AutoDoc
#! @BeginGroup

#! @Description
#! This operation adds the given function $f$: (no argument) $\mapsto I$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddInitialObject",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: A \mapsto u$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromInitialObject",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: (A, T) \mapsto u$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromInitialObjectWithGivenInitialObject",
                  [ IsHomalgCategory, IsFunction ] );
#! @EndGroup

#! @EndAutoDoc

## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for an initial object. 
#! Note that we chose <C>WasCreatedAsInitialObject</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsInitialObject" );

#! @Chapter Universal Objects

####################################
##
#! @Section Direct sum
##
####################################

#! Let $C$ be an additive category. Let $n \in \mathbb{N}$. Denote by $C^n$ the $n$-th direct product of $C$ with itself. 
#! Now take $(S_1, \dots, S_n) \in C^n$. An object $S$ equipped with morphisms $\pi_i: S \rightarrow S_i$ and
#! $\iota_i: S_i \rightarrow S$ is called direct sum of
#! $(S_1, \dots, S_n)$ if
#! - $\sum_{i = 1}^n (\iota_i \circ \pi_i) = \mathrm{id}_S$,
#! - for all $i,j \in \{ 1 \dots n \}$: $\pi_j\iota_i  = \delta_{ij}\mathrm{id}_{S_i}$, where $\delta_{ij}$ denotes the Kronecker delta.
#! Note: this implies that $S$ is a direct product with respect to the $\pi_i$ and a coproduct with
#! respect to the $\iota_i$.

## Main Operations and Attributes

DeclareOperationWithCache( "DirectSumOp",
                           [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

## Function Attributes
#! @AutoDoc
#! @BeginGroup

#! @Description
#! These attributes store the implementations of the basic algorithms for a direct sum. 
DeclareAttribute( "DirectSumFunction",
                  IsHomalgCategory );
#! @EndGroup
#! @EndAutoDoc

#! @Description
#! This operation adds the given function $f: ( (S_1, \dots, S_n) ) \mapsto S$ to the category $C$,
#! where $(S_1, \dots, S_n)$ is an object of the product category $C^n$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddDirectSum",
                  [ IsHomalgCategory, IsFunction ] );


## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a direct sum object. 
#! Note that we chose <C>WasCreatedAsDirectSum</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsDirectSum" );

DeclareProperty( "IS_IMPLIED_DIRECT_SUM", 
                 IsHomalgCategoryObject );

#! @Chapter Universal Objects



####################################
##
#! @Section Coproduct
##
####################################

#! Let $C$ be a category. Let $n \in \mathbb{N}$. Denote by $C^n$ the $n$-th direct product of $C$ with itself. 
#! Now take $(I_1, \dots, I_n) \in C^n$. An object $I$ equipped with morphisms 
#! $(\iota_i: I_i \rightarrow I)_{i = 1 \dots n} \in C^n$ is called a coproduct of
#! $(I_1, \dots, I_n)$ if for every collection of morphisms $( \tau_i: I_i \rightarrow T )_{i = 1 \dots n} \in C^n$
#! there exists a unique morphism $u: I \rightarrow T$ such that $\tau_i = \tau \circ \iota_i$ for all $i = 1 \dots n$.

## Main Operations and Attributes

DeclareGlobalFunction( "Coproduct" );

DeclareOperationWithCache( "CoproductOp",
                           [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

DeclareGlobalFunction( "InjectionOfCofactor" );

DeclareOperation( "InjectionOfCofactorOp",
                  [ IsHomalgCategoryObject, IsInt, IsHomalgCategoryObject ] );

DeclareOperation( "InjectionOfCofactorWithGivenCoproduct",
                  [ IsHomalgCategoryObject, IsInt, IsHomalgCategoryObject ] );

DeclareGlobalFunction( "UniversalMorphismFromCoproduct" );

DeclareOperation( "UniversalMorphismFromCoproductOp",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareOperation( "UniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

## Function Attributes
#! @AutoDoc
#! @BeginGroup

#! @Description
#! These attributes store the implementations of the basic algorithms for a coproduct. 
DeclareAttribute( "CoproductFunction",
                  IsHomalgCategory );

DeclareAttribute( "InjectionOfCofactorFunction",
                  IsHomalgCategory );

DeclareAttribute( "InjectionOfCofactorWithGivenCoproductFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromCoproductFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromCoproductWithGivenCoproductFunction",
                  IsHomalgCategory );
#! @EndGroup
#! @EndAutoDoc

## Add Operations

#! @Description
#! This operation adds the given function $f: ( (I_1, \dots, I_n) ) \mapsto I$ to the category $C$
#! where $(I_1, \dots, I_n)$ is an object of the product category $C^n$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddCoproduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (I_1, \dots, I_n), i ) \mapsto \iota_i$ to the category $C$
#! where $(I_1, \dots, I_n)$ is an object of the product category $C^n$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddInjectionOfCofactor",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (I_1, \dots, I_n), i, I ) \mapsto \iota_i$ to the category $C$
#! where $(I_1, \dots, I_n)$ is an object of the product category $C^n$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddInjectionOfCofactorWithGivenCoproduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}  ) \mapsto u$ to the category $C$
#! where $( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ is a morphism of the product category $C^n$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromCoproduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}, I  ) \mapsto u$ to the category $C$
#! where $( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ is a morphism of the product category $C^n$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsHomalgCategory, IsFunction ] );


## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a coproduct object. 
#! Note that we chose <C>WasCreatedAsCoprodcut</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsCoproduct" );
#! @Chapter Universal Objects


####################################
##
#! @Section Direct Product
##
####################################

## Main Operations and Attributes
# the first argument (diagram) is an object of the product category. This is superior to a list of objects
# because:
# *IsWellDefined will be handled properly
# *no caching issues?


## Main Operations and Attributes
#! @Description
#! Direct product of a given diagram $D$, where $D$ is an object in 
#! a product category. The second argument $M$ is an object needed for the method
#! selection.
#! @Returns IsHomalgCategoryObject
#! @Arguments D, M
DeclareOperationWithCache( "DirectProductOp",
                           [ IsHomalgCategoryObject, IsHomalgCategoryObject ] );

#! @Description
#! Projection in the $i$-th factor of the direct product given by $D$.
#! $D$ can either be an object created as a direct product or an object
#! in a product category $D = (A_i)$ representing a diagram.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments D, i
DeclareGlobalFunction( "ProjectionInFactor" );

# @Description
# Projection in the $i$-th factor of the direct product given by $D$.
# $D$ can either be an object created as a direct product or an object
# in a product category representing a diagram. The second argument $M$
# is an object needed for the method selection.
# @Returns IsHomalgCategoryMorphism
# @Arguments D, M, i
DeclareOperation( "ProjectionInFactorOp",
                  [ IsHomalgCategoryObject, IsInt, IsHomalgCategoryObject ] );

#! @Description
#! Projection in the $i$-th factor of the direct product $P = \prod_j A_j$ 
#! given by an object of a product category $D = (A_j)$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments D, P, i
DeclareOperation( "ProjectionInFactorWithGivenDirectProduct",
                  [ IsHomalgCategoryObject, IsInt, IsHomalgCategoryObject ] );

#! @Description
#! Given finitely many morphisms $\alpha_i: A \rightarrow B_i$ this method
#! returns the unique morphism $\alpha: A \rightarrow \prod_j B_j$ such that
#! $\pi_i \circ \alpha = \alpha_i$, where $\pi_i$ denotes the $i$-th projection
#! $\prod_j B_j \rightarrow B_i$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha_i
DeclareGlobalFunction( "UniversalMorphismIntoDirectProduct" );

# @Description
# Given finitely many morphisms $D = (\alpha_i: A \rightarrow B_i)$ as an
# object in the product category, this method
# returns a unique morphism $\alpha: A \rightarrow \prod_j B_j$ such that
# $\pi_i \circ \alpha = \alpha_i$, where $\pi_i$ denotes the $i$-th projection
# $\prod_j B_j \rightarrow B_i$. The second argument $M$ is needed for the method selection.
# @Returns IsHomalgCategoryMorphism
# @Arguments D, M
DeclareOperation( "UniversalMorphismIntoDirectProductOp",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

#! @Description
#! Given finitely many morphisms $D = (\alpha_i: A \rightarrow B_i)$ as an
#! object in a product category, and given the direct product $P = \prod_j B_j$, this method
#! returns the unique morphism $\alpha: A \rightarrow P$ such that
#! $\pi_i \circ \alpha = \alpha_i$, where $\pi_i$ denotes the $i$-th projection
#! $P \rightarrow B_i$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments D, P
DeclareOperation( "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

## Function Attributes
#! @AutoDoc
#! @BeginGroup

#! @Description
#! These attributes store the implementations of the basic algorithms for a direct product. 
DeclareAttribute( "DirectProductFunction",
                  IsHomalgCategory );

DeclareAttribute( "ProjectionInFactorFunction",
                  IsHomalgCategory );

DeclareAttribute( "ProjectionInFactorWithGivenDirectProductFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismIntoDirectProductFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismIntoDirectProductWithGivenDirectProductFunction",
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
DeclareOperation( "AddDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddProjectionInFactor",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddProjectionInFactorWithGivenDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );
#! @EndGroup
#! @EndAutoDoc


## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a terminal object. 
#! Note that we chose <C>WasCreatedAsDirectProduct</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsDirectProduct" );

#! @Chapter Universal Objects


####################################
##
#! @Section Pullback
##
####################################

## Main Operations and Attributes

# FIXME:
# Declared as an operation in MatricesForHomalg!
# DeclareGlobalFunction( "Pullback" );

DeclareGlobalFunction( "FiberProduct" );

DeclareOperationWithCache( "PullbackOp",
                           [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

## DeclareGlobalFunction( "ProjectionInFactor" ); to be adjusted

DeclareOperation( "ProjectionInFactorOp",
                  [ IsHomalgCategoryMorphism, IsInt, IsHomalgCategoryMorphism ] );

DeclareOperation( "ProjectionInFactorOfPullbackWithGivenPullback",
                  [ IsHomalgCategoryMorphism, IsInt, IsHomalgCategoryObject ] );

DeclareGlobalFunction( "UniversalMorphismIntoPullback" );

DeclareOperation( "UniversalMorphismIntoPullbackOp",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareOperation( "UniversalMorphismIntoPullbackWithGivenPullback",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

## Function Attributes
#! @AutoDoc
#! @BeginGroup

#! @Description
#! These attributes store the implementations of the basic algorithms for a pullback. 
DeclareAttribute( "PullbackFunction",
                  IsHomalgCategory );

DeclareAttribute( "ProjectionInFactorOfPullbackFunction",
                  IsHomalgCategory );

DeclareAttribute( "ProjectionInFactorOfPullbackWithGivenPullbackFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismIntoPullbackFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismIntoPullbackWithGivenPullbackFunction",
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
DeclareOperation( "AddPullback",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddProjectionInFactorOfPullback",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddProjectionInFactorOfPullbackWithGivenPullback",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoPullback",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoPullbackWithGivenPullback",
                  [ IsHomalgCategory, IsFunction ] );
#! @EndGroup
#! @EndAutoDoc


## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a pullback. 
#! Note that we chose <C>WasCreatedAsPullback</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsPullback" );

#! @Chapter Universal Objects

####################################
##
#! @Section Pushout
##
####################################

## Main Operations and Attributes

DeclareGlobalFunction( "Pushout" );

DeclareOperationWithCache( "PushoutOp",
                           [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

## DeclareGlobalFunction( "InjectionOfCofactor" ); to be adjusted

DeclareOperation( "InjectionOfCofactorOp",
                  [ IsHomalgCategoryMorphism, IsInt, IsHomalgCategoryMorphism ] );

DeclareOperation( "InjectionOfCofactorWithGivenPushout",
                  [ IsHomalgCategoryMorphism, IsInt, IsHomalgCategoryObject ] );

DeclareGlobalFunction( "UniversalMorphismFromPushout" );

DeclareOperation( "UniversalMorphismFromPushoutOp",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareOperation( "UniversalMorphismFromPushoutWithGivenPushout",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

## Function Attributes
#! @AutoDoc
#! @BeginGroup

#! @Description
#! These attributes store the implementations of the basic algorithms for a pushout. 
DeclareAttribute( "PushoutFunction",
                  IsHomalgCategory );

DeclareAttribute( "InjectionOfCofactorOfPushoutFunction",
                  IsHomalgCategory );

DeclareAttribute( "InjectionOfCofactorWithGivenPushoutFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromPushoutFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromPushoutWithGivenPushoutFunction",
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
DeclareOperation( "AddPushout",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddInjectionOfCofactorOfPushout",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddInjectionOfCofactorWithGivenPushout",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromPushout",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromPushoutWithGivenPushout",
                  [ IsHomalgCategory, IsFunction ] );
#! @EndGroup
#! @EndAutoDoc


## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a pushout. 
#! Note that we chose <C>WasCreatedAsPushout</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsPushout" );

#! @Chapter Universal Objects

####################################
##
#! @Section Image
##
####################################

## Main Operations and Attributes

## FIXME: Image is a function
DeclareAttributeWithToDoForIsWellDefined( "ImageObject",
                                          IsHomalgCategoryMorphism );

#convenience function
DeclareAttributeWithToDoForIsWellDefined( "ImageEmbedding",
                                          IsHomalgCategoryObject );

DeclareAttributeWithToDoForIsWellDefined( "ImageEmbedding",
                                          IsHomalgCategoryMorphism );

DeclareOperation( "ImageEmbeddingWithGivenImage",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

## Function Attributes
#! @AutoDoc
#! @BeginGroup

#! @Description
#! These attributes store the implementations of the basic algorithms for an image. 
DeclareAttribute( "ImageFunction",
                  IsHomalgCategory );

DeclareAttribute( "ImageEmbeddingFunction",
                  IsHomalgCategory );

DeclareAttribute( "ImageEmbeddingWithGivenImageFunction",
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
DeclareOperation( "AddImage",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddImageEmbedding",
                  [ IsHomalgCategory, IsFunction ] );

#! @Arguments C, f
DeclareOperation( "AddImageEmbeddingWithGivenImage",
                  [ IsHomalgCategory, IsFunction ] );
#! @EndGroup
#! @EndAutoDoc


## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for an image. 
#! Note that we chose <C>WasCreatedAsImage</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsImage" );
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
