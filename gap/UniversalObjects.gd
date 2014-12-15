#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Universal Objects
#! Let $I$ and $A$ be categories. A functor $D: I \rightarrow A$ is sometimes also called
#! a diagram with index category $I$.
#! A limit of a diagram $D$ is an object $X$ together with a collection of morphisms
#! $(s_i: X \rightarrow D_i)_{i \in I}$, called a source, such that for every other source
#! $(t_i: T \rightarrow D_i)_{i \in I}$, there exists a unique morphism $u: T \rightarrow X$ such that
#! $s_i \circ u = t_i$ for all $i$. 
#! Dually, a colimit of a diagram $D$ is an object $X$ together with a collection of morphisms
#! $(s_i: D_i \rightarrow X)_{i \in I}$, called a sink, such that for every other sink
#! $(t_i: D_i \rightarrow T)_{i \in I}$, there exists a unique morphism $u: X \rightarrow T$ such that
#! $u \circ s_i = t_i$ for all $i$. 
#! We call such objects universal.
#! For every universal object $X$, there are 5 methods which can be installed:
#! * $D \mapsto X$: Constructor of $X$ with a diagram $D$ (i.e. a list of morphisms and objects) as an input 
#! * $D \mapsto s_i$: Constructor of source/sink data with input $D$
#! * $(D,X) \mapsto s_i$: Constructor of source/sink data with input $D$ and $X$
#! * $(D, t_i) \mapsto u$: Constructor of universal property morphism with input $D$ and a test source/sink $T$
#! * $(D, t_i, X) \mapsto u$: Constructor of universal property morphism with input $D$ and a test source/sink $T$ and $X$
#! The convention in CategoriesForHomalg is: every diagram $D$ should only have one universal object $X$.
#! Thus every computed $X$ will be cached. For example, if you compute the pullback object of a given
#! diagram twice, you will get identical objects (IsIdenticalObj will return true).
#! <Br/>
#! This convention becomes inevitable if you build functors out of universal objects, because 
#! functors are in particular mathematical maps which only allow exactly one output for one given input.
#! <Br/>
#! This convention also clarifies the relevance of the constructors which have $D$ and $X$ as an input:
#! if you have a constructor for $D \mapsto X$, you must also have a constructor
#! for $(D,X) \mapsto s_i$ in order to compute the $s_i$. Because if you first construct $X$
#! from $D$, $X$ is once and for all cached as the universal object of $D$. In particular, the
#! maps $s_i$ must have source/ range identical to $X$. But this can only be guaranteed by
#! having $X$ as part of the input in the constructor of the $s_i$.
#! <Br/>
#! The following combinations of implementations of the above constructors allow a full functionality 
#! of the universal object in question:
#! * implement all constructors
#! * implement $D \mapsto s_i$ and $(D, t_i, X) \mapsto u$
#! * implement $D \mapsto X$, $(D,X) \mapsto s_i$ and $(D, t_i, X) \mapsto u$
#! * implement $D \mapsto X$, $D \mapsto s_i$, $(D,X) \mapsto s_i$ and $(D, t_i, X) \mapsto u$
#! * implement $D \mapsto X$, $(D,X) \mapsto s_i$, $(D, t_i) \mapsto u$ and $(D, t_i, X) \mapsto u$
#! Sometimes, there are even shorter ways: in an abelian category, all you have to implement 
#! for a kernel is:
#! * KernelEmb
#! * MonoAsKernelLift
#! One note: a derived method should never use constructors with given $X$ as an input.
#! The internals of CategoriesForHomalg will take care that no confusion accurs. For example: if you
#! call KernelEmb of a morphism $\alpha$, CategoriesForHomalg works as follows:
#! * Check the cache: is the kernel embedding of $\alpha$ already computed? If yes, return this cached embedding.
#! * Otherwise, check if the kernel object of $\alpha$ is already computed. If yes, call KernelEmbWithGivenKernel( $\alpha$ ). If no, call KernelEmb( $\alpha$ ).
#! 
#! One further note: every universal object stores if it was created as such and therefore can be used to access universal property morphisms (if computable).
#############################################################################

####################################
##
#! @Section Type system
##
####################################

#! Explaination of methods of the form $\texttt{Add}F( f, C )$ for a function name $F$ (e.g. KernelLift, DirectProduct),
#! a function $f$ and a HomalgCategory $C$:
#! The method $\texttt{Add}F( f, C )$ installs the method with the name $F$ properly such that it can be
#! used within the context of the given category $C$. 
#! Valid types for the (multiple) arguments of $F$ are:
#! * HomalgCategoryObject
#! * HomalgCategoryMorphism
#! * List containing only HomalgCategoryObjects
#! * List containing only HomalgCategoryMorphisms
#! * Integer
#! Valid types for the output of $F$ are:
#! * HomalgCategoryObject
#! * HomalgCategoryMorphism.
#! Note the name convention: If $\texttt{Add}F$ is a method, then so is $F$.


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
#! @Arguments alpha
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
#! @Arguments K
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
DeclareOperation( "AddKernelObject",
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

## Application of KernelObject to path
DeclareOperation( "ApplicationOfKernelObjectToPath",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );


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
#! @Arguments alpha
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
#! @Arguments C
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
#! @Arguments C
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
#! @Arguments C
DeclareAttribute( "TerminalObjectFunction",
                  IsHomalgCategory );

#! @Arguments C
DeclareAttribute( "UniversalMorphismIntoTerminalObjectFunction",
                  IsHomalgCategory );

#! @Arguments C
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
#! @Arguments C
DeclareAttribute( "InitialObjectFunction",
                  IsHomalgCategory );

#! @Arguments C
DeclareAttribute( "UniversalMorphismFromInitialObjectFunction",
                  IsHomalgCategory );

#! @Arguments C
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
                           [ IsList, IsHomalgCategoryObject ] );

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
#! where $(S_1, \dots, S_n)$ is a list of objects in $C$.
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
#! there exists a unique morphism $u: I \rightarrow T$ such that $\tau_i = u \circ \iota_i$ for all $i = 1 \dots n$.

## Main Operations and Attributes

DeclareGlobalFunction( "Coproduct" );

DeclareOperationWithCache( "CoproductOp",
                           [ IsList, IsHomalgCategoryObject ] );

DeclareGlobalFunction( "InjectionOfCofactor" );

DeclareOperation( "InjectionOfCofactorOfCoproduct",
                  [ IsList, IsInt ] );

DeclareOperation( "InjectionOfCofactorOfCoproductOp",
                  [ IsList, IsInt, IsHomalgCategoryObject ] );

DeclareOperation( "InjectionOfCofactorOfCoproductWithGivenCoproduct",
                  [ IsList, IsInt, IsHomalgCategoryObject ] );

DeclareGlobalFunction( "UniversalMorphismFromCoproduct" );

DeclareOperation( "UniversalMorphismFromCoproductOp",
                  [ IsList, IsList, IsHomalgCategoryObject ] );

DeclareOperation( "UniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsList, IsList, IsHomalgCategoryObject ] );

## Function Attributes
#! @AutoDoc
#! @BeginGroup

#! @Description
#! These attributes store the implementations of the basic algorithms for a coproduct. 
DeclareAttribute( "CoproductFunction",
                  IsHomalgCategory );

DeclareAttribute( "InjectionOfCofactorOfCoproductFunction",
                  IsHomalgCategory );

DeclareAttribute( "InjectionOfCofactorOfCoproductWithGivenCoproductFunction",
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
#! where $(I_1, \dots, I_n)$ is a list of objects in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddCoproduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (I_1, \dots, I_n), i ) \mapsto \iota_i$ to the category $C$
#! where $(I_1, \dots, I_n)$ is a list of objects in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddInjectionOfCofactorOfCoproduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (I_1, \dots, I_n), i, I ) \mapsto \iota_i$ to the category $C$
#! where $(I_1, \dots, I_n)$ is a list of objects in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddInjectionOfCofactorOfCoproductWithGivenCoproduct",
                  [ IsHomalgCategory, IsFunction ] );

#FIXME: it is inconsistent with the convention that the diagram does not have to be given as an input!
#! @Description
#! This operation adds the given function $f: ( ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}  ) \mapsto u$ to the category $C$
#! where $( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromCoproduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}, I  ) \mapsto u$ to the category $C$
#! where $( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ is a list of morphisms in $C$.
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

#! Let $C$ be a category. Let $n \in \mathbb{N}$. Denote by $C^n$ the $n$-th direct product of $C$ with itself. 
#! Now take $(P_1, \dots, P_n) \in C^n$. An object $P$ equipped with morphisms 
#! $(\pi_i: P \rightarrow P_i)_{i = 1 \dots n} \in C^n$ is called a direct product of
#! $(P_1, \dots, P_n)$ if for every collection of morphisms $( \tau_i: T \rightarrow P_i )_{i = 1 \dots n} \in C^n$
#! there exists a unique morphism $u: T \rightarrow P$ such that $\tau_i = \pi_i \circ u $ for all $i = 1 \dots n$.


## Main Operations and Attributes
# the first argument (diagram) is an object of the product category. This is superior to a list of objects
# because:
# *IsWellDefined will be handled properly
# *no caching issues?


## Main Operations and Attributes
#! @Description
#! Direct product of a given diagram $D$, where $D$ is a list of objects.
#! The second argument $M$ is an object needed for the method
#! selection.
#! @Returns IsHomalgCategoryObject
#! @Arguments D, M
DeclareOperationWithCache( "DirectProductOp",
                           [ IsList, IsHomalgCategoryObject ] );

#! @Description
#! Projection in the $i$-th factor of the direct product given by $D$.
#! $D$ can either be an object created as a direct product or a list
#! of objects $D = (A_i)$ representing a diagram.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments D, i
DeclareGlobalFunction( "ProjectionInFactor" );

DeclareOperation( "ProjectionInFactorOfDirectProduct",
                  [ IsList, IsInt ] );
#! @Description
#! Projection in the $i$-th factor of the direct product given by $D$.
#! $D$ can either be an object created as a direct product or a list
#! of objects representing a diagram. The third argument $M$
#! is an object needed for the method selection.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments D, i, M
DeclareOperation( "ProjectionInFactorOfDirectProductOp",
                  [ IsList, IsInt, IsHomalgCategoryObject ] );

#! @Description
#! Projection in the $i$-th factor of the direct product $P = \prod_j A_j$ 
#! given by a list of objects $D = (A_j)$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments D, i, P
DeclareOperation( "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
                  [ IsList, IsInt, IsHomalgCategoryObject ] );

#! @Description
#! Given finitely many morphisms $\alpha_i: A \rightarrow B_i$ this method
#! returns the unique morphism $\alpha: A \rightarrow \prod_j B_j$ such that
#! $\pi_i \circ \alpha = \alpha_i$, where $\pi_i$ denotes the $i$-th projection
#! $\prod_j B_j \rightarrow B_i$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments alpha_i
DeclareGlobalFunction( "UniversalMorphismIntoDirectProduct" );

# TODO: Fix this documentation (new argument)
# @Description
# Given finitely many morphisms $D = (\alpha_i: A \rightarrow B_i)$ as a
# list of objects, this method
# returns a unique morphism $\alpha: A \rightarrow \prod_j B_j$ such that
# $\pi_i \circ \alpha = \alpha_i$, where $\pi_i$ denotes the $i$-th projection
# $\prod_j B_j \rightarrow B_i$. The second argument $M$ is needed for the method selection.
# @Returns IsHomalgCategoryMorphism
# @Arguments D, M
DeclareOperation( "UniversalMorphismIntoDirectProductOp",
                  [ IsList, IsList, IsHomalgCategoryObject ] );

# TODO: Fix this documentation (new argument)
#! @Description
#! Given finitely many morphisms $D = (\alpha_i: A \rightarrow B_i)$ as a
#! list of objects, and given the direct product $P = \prod_j B_j$, this method
#! returns the unique morphism $\alpha: A \rightarrow P$ such that
#! $\pi_i \circ \alpha = \alpha_i$, where $\pi_i$ denotes the $i$-th projection
#! $P \rightarrow B_i$.
#! @Returns IsHomalgCategoryMorphism
#! @Arguments D, P
DeclareOperation( "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsList, IsList, IsHomalgCategoryObject ] );

## Function Attributes
#! @AutoDoc
#! @BeginGroup

#! @Description
#! These attributes store the implementations of the basic algorithms for a direct product. 
DeclareAttribute( "DirectProductFunction",
                  IsHomalgCategory );

DeclareAttribute( "ProjectionInFactorOfDirectProductFunction",
                  IsHomalgCategory );

DeclareAttribute( "ProjectionInFactorOfDirectProductWithGivenDirectProductFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismIntoDirectProductFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismIntoDirectProductWithGivenDirectProductFunction",
                  IsHomalgCategory );
#! @EndGroup
#! @EndAutoDoc

## Add Operations

#! @Description
#! This operation adds the given function $f: ( (P_1, \dots, P_n) ) \mapsto P$ to the category $C$
#! where $(P_1, \dots, P_n)$ is a list of objects in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (P_1, \dots, P_n), i ) \mapsto \pi_i$ to the category $C$
#! where $(P_1, \dots, P_n)$ is a list of objects in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddProjectionInFactorOfDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (P_1, \dots, P_n), i, P ) \mapsto \pi_i$ to the category $C$
#! where $(P_1, \dots, P_n)$ is a list of objects in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddProjectionInFactorOfDirectProductWithGivenDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( ( \tau_i: T \rightarrow P_i )_{i = 1 \dots n} ) \mapsto u$ to the category $C$
#! where $( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( ( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}, P ) \mapsto u$ to the category $C$
#! where $( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsHomalgCategory, IsFunction ] );


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

#! Let $C$ be a category. Let $n \in \mathbb{N}$. Denote by $C^n$ the $n$-th direct product of $C$ with itself. 
#! Now take $(\beta_i: P_i \rightarrow B)_{i = 1 \dots n} \in C^n$. An object $P$ equipped with morphisms 
#! $(\pi_i: P \rightarrow P_i)_{i = 1 \dots n} \in C^n$ is called a pullback of
#! $(\beta_i)_{i = 1 \dots n}$ if for every collection of morphisms $( \tau_i: T \rightarrow P_i )_{i = 1 \dots n} \in C^n$
#! with the property $\beta_i \circ \tau_i = \beta_j \circ \tau_j$ for all $i,j = 1, \dots, n$,
#! there exists a unique morphism $u: T \rightarrow P$ such that $\tau_i = \pi_i \circ u $ for all $i = 1 \dots n$.

## Main Operations and Attributes

# FIXME:
# Declared as an operation in MatricesForHomalg!
# DeclareGlobalFunction( "Pullback" );
DeclareGlobalFunction( "FiberProduct" );

DeclareOperationWithCache( "PullbackOp",
                           [ IsList, IsHomalgCategoryMorphism ] );

DeclareOperation( "ProjectionInFactorOfPullback",
                  [ IsList, IsInt ] );

DeclareOperation( "ProjectionInFactorOfPullbackOp",
                  [ IsList, IsInt, IsHomalgCategoryMorphism ] );

DeclareOperation( "ProjectionInFactorOfPullbackWithGivenPullback",
                  [ IsList, IsInt, IsHomalgCategoryObject ] );

DeclareGlobalFunction( "UniversalMorphismIntoPullback" );

DeclareOperation( "UniversalMorphismIntoPullbackOp",
                  [ IsList, IsList, IsHomalgCategoryMorphism ] );

DeclareOperation( "UniversalMorphismIntoPullbackWithGivenPullback",
                  [ IsList, IsList, IsHomalgCategoryObject ] );

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


#! @Description
#! This operation adds the given function $f: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n} ) \mapsto P$ to the category $C$
#! where $(\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddFiberProduct",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, i ) \mapsto \pi_i$ to the category $C$
#! where $(\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddProjectionInFactorOfPullback",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, i, P ) \mapsto \pi_i$ to the category $C$
#! where $(\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddProjectionInFactorOfPullbackWithGivenPullback",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, ( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}  ) \mapsto u$ 
#! to the category $C$
#! where $(\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$ and $( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}$ are lists of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoPullback",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, ( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}, P ) \mapsto u$ 
#! to the category $C$
#! where $(\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$ and $( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}$ are lists of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoPullbackWithGivenPullback",
                  [ IsHomalgCategory, IsFunction ] );



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

#! Let $C$ be a category. Let $n \in \mathbb{N}$. Denote by $C^n$ the $n$-th direct product of $C$ with itself. 
#! Now take $(\beta_i: B \rightarrow I_i)_{i = 1 \dots n} \in C^n$. An object $I$ equipped with morphisms 
#! $(\iota_i: I_i \rightarrow I)_{i = 1 \dots n} \in C^n$ is called a pushout of
#! $(\beta_i)_{i = 1 \dots n}$ if for every collection of morphisms $( \tau_i: I_i \rightarrow T )_{i = 1 \dots n} \in C^n$
#! with the property $\tau_i \circ \beta_i  = \tau_j \circ \beta_j $ for all $i,j = 1, \dots, n$,
#! there exists a unique morphism $u: I \rightarrow T$ such that $\tau_i = u \circ \iota_i$ for all $i = 1 \dots n$.


## Main Operations and Attributes

DeclareGlobalFunction( "Pushout" );

DeclareOperationWithCache( "PushoutOp",
                           [ IsList, IsHomalgCategoryMorphism ] );

## DeclareGlobalFunction( "InjectionOfCofactor" ); to be adjusted

DeclareOperation( "InjectionOfCofactorOfPushout",
                  [ IsList, IsInt ] );

DeclareOperation( "InjectionOfCofactorOfPushoutOp",
                  [ IsList, IsInt, IsHomalgCategoryMorphism ] );

DeclareOperation( "InjectionOfCofactorOfPushoutWithGivenPushout",
                  [ IsList, IsInt, IsHomalgCategoryObject ] );

DeclareGlobalFunction( "UniversalMorphismFromPushout" );

DeclareOperation( "UniversalMorphismFromPushoutOp",
                  [ IsList, IsList, IsHomalgCategoryMorphism ] );

DeclareOperation( "UniversalMorphismFromPushoutWithGivenPushout",
                  [ IsList, IsList, IsHomalgCategoryObject ] );

## Function Attributes
#! @AutoDoc
#! @BeginGroup

#! @Description
#! These attributes store the implementations of the basic algorithms for a pushout. 
DeclareAttribute( "PushoutFunction",
                  IsHomalgCategory );

DeclareAttribute( "InjectionOfCofactorOfPushoutFunction",
                  IsHomalgCategory );

DeclareAttribute( "InjectionOfCofactorOfPushoutWithGivenPushoutFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromPushoutFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromPushoutWithGivenPushoutFunction",
                  IsHomalgCategory );
#! @EndGroup
#! @EndAutoDoc

## Add Operations


#! @Description
#! This operation adds the given function $f: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n} ) \mapsto I$ to the category $C$
#! where $(\beta_i: B \rightarrow I_i)_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddPushout",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, i ) \mapsto \iota_i$ to the category $C$
#! where $(\beta_i: B \rightarrow I_i)_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddInjectionOfCofactorOfPushout",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, i, I ) \mapsto \iota_i$ to the category $C$
#! where $(\beta_i: B \rightarrow I_i)_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddInjectionOfCofactorOfPushoutWithGivenPushout",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n} ) \mapsto u$ 
#! to the category $C$ where $(\beta_i: B \rightarrow I_i)_{i = 1 \dots n}$ and $( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ are lists of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromPushout",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}, I ) \mapsto u$ 
#! to the category $C$ where $(\beta_i: B \rightarrow I_i)_{i = 1 \dots n}$ and $( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ are lists of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromPushoutWithGivenPushout",
                  [ IsHomalgCategory, IsFunction ] );



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

#! Let $\alpha: A \rightarrow B$ be a morphism. The image of $\alpha$ is
#! the smallest monomorphism $\iota: I \hookrightarrow B$ through which $\alpha$ factors, i.e.,
#! such that there exists a morphism $c: A \rightarrow I$ with $\iota \circ c = \alpha$.
#! Smallest in this context means that for every other factorization of $\alpha = \tau_1 \circ \tau_2$
#! with $\tau_1: A \rightarrow T, \tau_2: T \rightarrow B$
#! where $\tau_2$ is a monomorphism, there exists a unique morphism $u: I \rightarrow T$
#! such that $\iota = \tau_2 \circ u$ and $\tau_1 = u \circ c$.

## Main Operations and Attributes

## FIXME: Image is a function (rename: ImageObject -> Image)
DeclareAttributeWithToDoForIsWellDefined( "ImageObject",
                                          IsHomalgCategoryMorphism );

#convenience function
DeclareAttributeWithToDoForIsWellDefined( "ImageEmbedding",
                                          IsHomalgCategoryObject );

DeclareAttributeWithToDoForIsWellDefined( "ImageEmbedding",
                                          IsHomalgCategoryMorphism );

#convenience function
DeclareAttributeWithToDoForIsWellDefined( "CoastrictionToImage",
                                          IsHomalgCategoryObject );

DeclareAttributeWithToDoForIsWellDefined( "CoastrictionToImage",
                                          IsHomalgCategoryMorphism );

DeclareOperation( "ImageEmbeddingWithGivenImage",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

DeclareOperation( "CoastrictionToImageWithGivenImage",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryObject ] );

DeclareOperation( "UniversalMorphismFromImage",
                  [ IsHomalgCategoryMorphism, IsList ] );

DeclareOperation( "UniversalMorphismFromImageWithGivenImage",
                  [ IsHomalgCategoryMorphism, IsList, IsHomalgCategoryObject ] );

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

DeclareAttribute( "CoastrictionToImageFunction",
                  IsHomalgCategory );

DeclareAttribute( "CoastrictionToImageWithGivenImageFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromImageFunction",
                  IsHomalgCategory );

DeclareAttribute( "UniversalMorphismFromImageWithGivenImageFunction",
                  IsHomalgCategory );


#! @EndGroup
#! @EndAutoDoc

## Add Operations

#! @Description
#! This operation adds the given function $f: \alpha \mapsto I$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddImageObject",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: \alpha \mapsto \iota$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddImageEmbedding",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: (\alpha, I) \mapsto \iota$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddImageEmbeddingWithGivenImage",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: \alpha \mapsto c$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddCoastrictionToImage",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: (\alpha, I) \mapsto c$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddCoastrictionToImageWithGivenImage",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: (\alpha, [\tau_1, \tau_2]) \mapsto u$ to the category $C$.
#! Note that $[\tau_1, \tau_2]$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromImage",
                  [ IsHomalgCategory, IsFunction ] );

#! @Description
#! This operation adds the given function $f: (\alpha, [\tau_1, \tau_2], I) \mapsto u$ to the category $C$.
#! Note that $[\tau_1, \tau_2]$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromImageWithGivenImage",
                  [ IsHomalgCategory, IsFunction ] );

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
