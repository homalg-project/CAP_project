#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Universal Objects
##
#############################################################################


## needed for multiple genesis
DeclareOperation( "AddToGenesis",
                  [ IsCapCategoryCell, IsObject, IsObject ] );

####################################
##
#! @Section Kernel
##
####################################

#! For a given morphism $\alpha: A \rightarrow B$, a kernel of $\alpha$ consists of three parts:
#! * an object $K$, 
#! * a morphism $\iota: K \rightarrow A$ such that $\alpha \circ \iota \sim_{K,B} 0$,
#! * a dependent function $u$ mapping each morphism $\tau: T \rightarrow A$ satisfying $\alpha \circ \tau \sim_{T,B} 0$ to a morphism $u(\tau): T \rightarrow K$ such that $\iota \circ u( \tau ) \sim_{T,A} \tau$. 
#! The triple $( K, \iota, u )$ is called a <Emph>kernel</Emph> of $\alpha$ if the morphisms $u( \tau )$ are uniquely determined up to
#! congruence of morphisms.
#! We denote the object $K$ of such a triple by $\mathrm{KernelObject}(\alpha)$.
#! $\\$
#! $\mathrm{KernelObject}$ is a functorial operation. This means:
#! for $\mu: A \rightarrow A'$, $\nu: B \rightarrow B'$,
#! $\alpha: A \rightarrow B$, $\alpha': A' \rightarrow B'$ such that $\nu \circ \alpha \sim_{A,B'} \alpha' \circ \mu$,
#! we obtain a morphism $\mathrm{KernelObject}( \alpha ) \rightarrow \mathrm{KernelObject}( \alpha' )$.


## Main Operations and Attributes
#! @Description
#! The argument is a morphism $\alpha$.
#! The output is the kernel $K$ of $\alpha$.
#! @Returns an object
#! @Arguments alpha
DeclareAttributeWithToDoForIsWellDefined( "KernelObject",
                                          IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the kernel embedding $\iota: \mathrm{KernelObject}(\alpha) \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{KernelObject}(\alpha),A)$
#! @Arguments alpha
DeclareAttributeWithToDoForIsWellDefined( "KernelEmb",
                                          IsCapCategoryMorphism );

#! @Description
#! This is a convenience method.
#! The argument is an object $K$ that was created as a kernel.
#! The output is the kernel embedding $\iota: K \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(K,A)$
#! @Arguments K
DeclareAttributeWithToDoForIsWellDefined( "KernelEmb",
                                          IsCapCategoryObject );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and an object $K = \mathrm{KernelObject}(\alpha)$.
#! The output is the kernel embedding $\iota: K \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(K,A)$
#! @Arguments alpha, K
DeclareOperation( "KernelEmbWithGivenKernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! This is a convenience method.
#! The arguments are an object $K$ which was created as a kernel,
#! and a test morphism $\tau: T \rightarrow A$.
#! The output is the morphism $u(\tau): T \rightarrow K$
#! given by the universal property of the kernel.
#! @Returns a morphism in $\mathrm{Hom}(T,K)$
#! @Arguments K, tau
DeclareOperation( "KernelLift",
                  [ IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and a test morphism $\tau: T \rightarrow A$.
#! The output is the morphism $u(\tau): T \rightarrow \mathrm{KernelObject}(\alpha)$
#! given by the universal property of the kernel.
#! @Returns a morphism in $\mathrm{Hom}(T,\mathrm{KernelObject}(\alpha))$
#! @Arguments alpha, tau
DeclareOperation( "KernelLift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$,
#! a test morphism $\tau: T \rightarrow A$,
#! and an object $K = \mathrm{KernelObject}(\alpha)$.
#! The output is the morphism $u(\tau): T \rightarrow K$
#! given by the universal property of the kernel.
#! @Returns a morphism in $\mathrm{Hom}(T,K)$
#! @Arguments alpha, tau, K
DeclareOperation( "KernelLiftWithGivenKernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );


## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>KernelObject</C>.
#! $F: \alpha \mapsto \mathrm{KernelObject}(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddKernelObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>KernelEmb</C>.
#! $F: \alpha \mapsto \iota$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddKernelEmb",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddKernelEmb",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddKernelEmb",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddKernelEmb",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>KernelEmbWithGivenKernelObject</C>.
#! $F: (\alpha, K) \mapsto \iota$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddKernelEmbWithGivenKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddKernelEmbWithGivenKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddKernelEmbWithGivenKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddKernelEmbWithGivenKernelObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>KernelLift</C>.
#! $F: (\alpha, \tau) \mapsto u(\tau)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddKernelLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddKernelLift",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddKernelLift",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddKernelLift",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>KernelLiftWithGivenKernelObject</C>.
#! $F: (\alpha, \tau, K) \mapsto u$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddKernelLiftWithGivenKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddKernelLiftWithGivenKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddKernelLiftWithGivenKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddKernelLiftWithGivenKernelObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a list $L = [ \alpha: A \rightarrow B, [ \mu: A \rightarrow A', \nu: B \rightarrow B' ], \alpha': A' \rightarrow B' ]$ of morphisms.
#! The output is the morphism
#! $\mathrm{KernelObject}( \alpha ) \rightarrow \mathrm{KernelObject}( \alpha' )$
#! given by the functorality of the kernel.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{KernelObject}( \alpha ), \mathrm{KernelObject}( \alpha' ) )$
#! @Arguments L
DeclareOperation( "KernelObjectFunctorial",
                  [ IsList ] );

#! @Description
#! The arguments are three morphism
#! $\alpha: A \rightarrow B$, $\mu: A \rightarrow A'$, $\alpha': A' \rightarrow B'$.
#! The output is the morphism
#! $\mathrm{KernelObject}( \alpha ) \rightarrow \mathrm{KernelObject}( \alpha' )$
#! given by the functorality of the kernel.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{KernelObject}( \alpha ), \mathrm{KernelObject}( \alpha' ) )$
#! @Arguments alpha, mu, alpha_prime
DeclareOperation( "KernelObjectFunctorial",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>KernelObjectFunctorial</C>.
#! $F: (\alpha, \mu, \alpha') \mapsto (\mathrm{KernelObject}( \alpha ) \rightarrow \mathrm{KernelObject}( \alpha' ))$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddKernelObjectFunctorial",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddKernelObjectFunctorial",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddKernelObjectFunctorial",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddKernelObjectFunctorial",
                  [ IsCapCategory, IsList ] );

## WasCreatedAs Filter
#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a kernel object. 
#! Note that we chose <C>WasCreatedAsKernelObject</C> to be a filter rather than a property,
#! because by default, a filter is set to false. 
DeclareFilter( "WasCreatedAsKernelObject" );

#! @Chapter Universal Objects

####################################
##
#!  @Section Cokernel
##
####################################

#! For a given morphism $\alpha: A \rightarrow B$, a cokernel of $\alpha$ consists of three parts:
#! * an object $K$,
#! * a morphism $\epsilon: B \rightarrow K$ such that $\epsilon \circ \alpha \sim_{A,K} 0$,
#! * a dependent function $u$ mapping each $\tau: B \rightarrow T$ satisfying $\tau \circ \alpha \sim_{A, T} 0$ to a morphism $u(\tau):K \rightarrow T$ such that $u(\tau) \circ \epsilon \sim_{B,T} \tau$.
#! The triple $( K, \epsilon, u )$ is called a <Emph>cokernel</Emph> of $\alpha$ if the morphisms $u( \tau )$ are uniquely determined up to
#! congruence of morphisms.
#! $\\$
#! $\mathrm{Cokernel}$ is a functorial operation. This means:
#! for $\mu: A \rightarrow A'$, $\nu: B \rightarrow B'$,
#! $\alpha: A \rightarrow B$, $\alpha': A' \rightarrow B'$ such that $\nu \circ \alpha \sim_{A,B'} \alpha' \circ \mu$,
#! we obtain a morphism $\mathrm{Cokernel}( \alpha ) \rightarrow \mathrm{Cokernel}( \alpha' )$.



## Main Operations and Attributes
#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the cokernel $K$ of $\alpha$.
#! @Returns an object
#! @Arguments alpha
DeclareAttributeWithToDoForIsWellDefined( "Cokernel",
                                          IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the cokernel projection $\epsilon: B \rightarrow \mathrm{Cokernel}( \alpha )$.
#! @Returns a morphism in $\mathrm{Hom}(B, \mathrm{Cokernel}( \alpha ))$
#! @Arguments alpha
DeclareAttributeWithToDoForIsWellDefined( "CokernelProj",
                                          IsCapCategoryMorphism );

#! @Description
#! This is a convenience method.
#! The argument is an object $K$ which was created as a cokernel.
#! The output is the cokernel projection $\epsilon: B \rightarrow K$.
#! @Returns a morphism in $\mathrm{Hom}(B, K)$
#! @Arguments K
DeclareAttributeWithToDoForIsWellDefined( "CokernelProj",
                                          IsCapCategoryObject );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and an object $K = \mathrm{Cokernel}(\alpha)$.
#! The output is the cokernel projection $\epsilon: B \rightarrow \mathrm{Cokernel}( \alpha )$.
#! @Returns a morphism in $\mathrm{Hom}(B, K)$
#! @Arguments alpha, K
DeclareOperation( "CokernelProjWithGivenCokernel",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );


#! @Description
#! This is a convenience method.
#! The arguments are an object $K$ which was created as a cokernel,
#! and a test morphism $\tau: B \rightarrow T$.
#! The output is the morphism $u(\tau): K \rightarrow T$
#! given by the universal property of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(K,T)$
#! @Arguments K, tau
DeclareOperation( "CokernelColift",
                  [ IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and a test morphism $\tau: B \rightarrow T$.
#! The output is the morphism $u(\tau): \mathrm{Cokernel}(\alpha) \rightarrow T$
#! given by the universal property of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Cokernel}(\alpha),T)$
#! @Arguments alpha, tau
DeclareOperation( "CokernelColift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$,
#! a test morphism $\tau: B \rightarrow T$,
#! and an object $K = \mathrm{Cokernel}(\alpha)$.
#! The output is the morphism $u(\tau): K \rightarrow T$
#! given by the universal property of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(K,T)$
#! @Arguments alpha, tau, K
DeclareOperation( "CokernelColiftWithGivenCokernel",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );


## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>Cokernel</C>.
#! $F: \alpha \mapsto K$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCokernel",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernel",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCokernel",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCokernel",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelProj</C>.
#! $F: \alpha \mapsto \epsilon$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCokernelProj",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernelProj",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCokernelProj",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCokernelProj",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelProj</C>.
#! $F: (\alpha, K) \mapsto \epsilon$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCokernelProjWithGivenCokernel",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernelProjWithGivenCokernel",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCokernelProjWithGivenCokernel",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCokernelProjWithGivenCokernel",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelProj</C>.
#! $F: (\alpha, \tau) \mapsto u(\tau)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCokernelColift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernelColift",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCokernelColift",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCokernelColift",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelProj</C>.
#! $F: (\alpha, \tau, K) \mapsto u(\tau)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCokernelColiftWithGivenCokernel",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernelColiftWithGivenCokernel",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCokernelColiftWithGivenCokernel",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCokernelColiftWithGivenCokernel",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The argument is a list $L = [ \alpha: A \rightarrow B, [ \mu:A \rightarrow A', \nu: B \rightarrow B' ], \alpha': A' \rightarrow B' ]$.
#! The output is the morphism
#! $\mathrm{Cokernel}( \alpha ) \rightarrow \mathrm{Cokernel}( \alpha' )$
#! given by the functorality of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Cokernel}( \alpha ), \mathrm{Cokernel}( \alpha' ))$
#! @Arguments L
DeclareOperation( "CokernelFunctorial",
                  [ IsList ] );

#! @Description
#! The arguments are three morphisms
#! $\alpha: A \rightarrow B, \nu: B \rightarrow B', \alpha': A' \rightarrow B'$.
#! The output is the morphism
#! $\mathrm{Cokernel}( \alpha ) \rightarrow \mathrm{Cokernel}( \alpha' )$
#! given by the functorality of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Cokernel}( \alpha ), \mathrm{Cokernel}( \alpha' ))$
#! @Arguments alpha, nu, alpha_prime
DeclareOperation( "CokernelFunctorial",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddCokernelFunctorial",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernelFunctorial",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCokernelFunctorial",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCokernelFunctorial",
                  [ IsCapCategory, IsList ] );

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
#! @Section Zero Object
##
####################################

#! A zero object consists of three parts:
#! * an object $Z$,
#! * a function $u_{\mathrm{in}}$ mapping each object $A$ to a morphism $u_{\mathrm{in}}(A): A \rightarrow Z$,
#! * a function $u_{\mathrm{out}}$ mapping each object $A$ to a morphism $u_{\mathrm{out}}(A): Z \rightarrow A$.
#! The triple $(Z, u_{\mathrm{in}}, u_{\mathrm{out}})$ is called a <Emph>zero object</Emph> if the morphisms 
#! $u_{\mathrm{in}}(A)$, $u_{\mathrm{out}}(A)$ are uniquely determined up to congruence of morphisms.

## Main Operations and Attributes

#! @Description
#! The argument is a category $C$.
#! The output is a zero object $Z$ of $C$.
#! @Returns an object
#! @Arguments C
DeclareAttribute( "ZeroObject",
                  IsCapCategory );

#! @Description
#! This is a convenience method.
#! The argument is a cell $c$.
#! The output is a zero object $Z$ of the
#! category $C$ for which $c \in C$.
#! @Returns an object
#! @Arguments c
DeclareAttribute( "ZeroObject",
                  IsCapCategoryCell );

#! @Description
#! This is a convenience method.
#! The argument is an object $A$.
#! It calls $\mathrm{UniversalMorphismFromZeroObject}$ on $A$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{ZeroObject}, A)$
#! @Arguments A
DeclareAttribute( "MorphismFromZeroObject",
                  IsCapCategoryObject );

#! @Description
#! This is a convenience method.
#! The argument is an object $A$.
#! It calls $\mathrm{UniversalMorphismIntoZeroObject}$ on $A$.
#! @Returns a morphism in $\mathrm{Hom}(A, \mathrm{ZeroObject})$
#! @Arguments A
DeclareAttribute( "MorphismIntoZeroObject",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $A$.
#! The output is the universal morphism $u_{\mathrm{out}}: \mathrm{ZeroObject} \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{ZeroObject}, A)$
#! @Arguments A
DeclareAttribute( "UniversalMorphismFromZeroObject",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $A$,
#! and a zero object $Z = \mathrm{ZeroObject}$.
#! The output is the universal morphism $u_{\mathrm{out}}: Z \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(Z, A)$
#! @Arguments A
DeclareOperation( "UniversalMorphismFromZeroObjectWithGivenZeroObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $A$.
#! The output is the universal morphism $u_{\mathrm{in}}: A \rightarrow \mathrm{ZeroObject}$.
#! @Returns a morphism in $\mathrm{Hom}(A, \mathrm{ZeroObject})$
#! @Arguments A
DeclareAttribute( "UniversalMorphismIntoZeroObject",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $A$,
#! and a zero object $Z = \mathrm{ZeroObject}$.
#! The output is the universal morphism $u_{\mathrm{in}}: A \rightarrow Z$.
#! @Returns a morphism in $\mathrm{Hom}(A, Z)$
#! @Arguments A
DeclareOperation( "UniversalMorphismIntoZeroObjectWithGivenZeroObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is a category $C$.
#! The output is the unique isomorphism $\mathrm{ZeroObject} \rightarrow \mathrm{InitialObject}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{ZeroObject}, \mathrm{InitialObject})$
#! @Arguments C
DeclareAttribute( "IsomorphismFromZeroObjectToInitialObject",
                  IsCapCategory );

#! @Description
#! The argument is a category $C$.
#! The output is the unique isomorphism $\mathrm{InitialObject} \rightarrow \mathrm{ZeroObject}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{InitialObject}, \mathrm{ZeroObject})$
#! @Arguments C
DeclareAttribute( "IsomorphismFromInitialObjectToZeroObject",
                  IsCapCategory );

#! @Description
#! The argument is a category $C$.
#! The output is the unique isomorphism $\mathrm{ZeroObject} \rightarrow \mathrm{TerminalObject}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{ZeroObject}, \mathrm{TerminalObject})$
#! @Arguments C
DeclareAttribute( "IsomorphismFromZeroObjectToTerminalObject",
                  IsCapCategory );

#! @Description
#! The argument is a category $C$.
#! The output is the unique isomorphism $\mathrm{TerminalObject} \rightarrow \mathrm{ZeroObject}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{TerminalObject}, \mathrm{ZeroObject})$
#! @Arguments C
DeclareAttribute( "IsomorphismFromTerminalObjectToZeroObject",
                  IsCapCategory );

## Add Operations


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ZeroObject</C>.
#! $F: () \mapsto \mathrm{ZeroObject}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddZeroObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddZeroObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddZeroObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddZeroObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoZeroObject</C>.
#! $F: A \mapsto u_{\mathrm{in}}(A)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoZeroObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoZeroObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoZeroObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoZeroObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoZeroObjectWithGivenZeroObject</C>.
#! $F: (A, Z) \mapsto u_{\mathrm{in}}(A)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoZeroObjectWithGivenZeroObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoZeroObjectWithGivenZeroObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoZeroObjectWithGivenZeroObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoZeroObjectWithGivenZeroObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromZeroObject</C>.
#! $F: A \mapsto u_{\mathrm{out}}(A)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromZeroObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromZeroObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromZeroObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromZeroObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromZeroObjectWithGivenZeroObject</C>.
#! $F: (A,Z) \mapsto u_{\mathrm{out}}(A)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromZeroObjectWithGivenZeroObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromZeroObjectWithGivenZeroObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromZeroObjectWithGivenZeroObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromZeroObjectWithGivenZeroObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromZeroObjectToInitialObject</C>.
#! $F: () \mapsto (\mathrm{ZeroObject} \rightarrow \mathrm{InitialObject})$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromZeroObjectToInitialObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromZeroObjectToInitialObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromZeroObjectToInitialObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromZeroObjectToInitialObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromInitialObjectToZeroObject</C>.
#! $F: () \mapsto ( \mathrm{InitialObject} \rightarrow \mathrm{ZeroObject})$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromInitialObjectToZeroObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInitialObjectToZeroObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromInitialObjectToZeroObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromInitialObjectToZeroObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromZeroObjectToTerminalObject</C>.
#! $F: () \mapsto (\mathrm{ZeroObject} \rightarrow \mathrm{TerminalObject})$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromZeroObjectToTerminalObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromZeroObjectToTerminalObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromZeroObjectToTerminalObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromZeroObjectToTerminalObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromTerminalObjectToZeroObject</C>.
#! $F: () \mapsto ( \mathrm{TerminalObject} \rightarrow \mathrm{ZeroObject})$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromTerminalObjectToZeroObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromTerminalObjectToZeroObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromTerminalObjectToZeroObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromTerminalObjectToZeroObject",
                  [ IsCapCategory, IsList ] );

## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a zero object. 
#! Note that we chose <C>WasCreatedAsZeroObject</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsZeroObject" );

#! @Chapter Universal Objects

####################################
##
#! @Section Terminal Object
##
####################################

#! A terminal object consists of two parts:
#! * an object $T$,
#! * a function $u$ mapping each object $A$ to a morphism $u( A ): A \rightarrow T$.
#! The pair $( T, u )$ is called a <Emph>terminal object</Emph> if the morphisms $u( A )$ are uniquely determined up to
#! congruence of morphisms.
#! $\\$
#! $\mathrm{TerminalObject}$ is a functorial operation. This just means:
#! There exists a unique morphism $T \rightarrow T$.

## Main Operations and Attributes

#! @Description
#! The argument is a category $C$.
#! The output is a terminal object $T$ of $C$.
#! @Returns an object
#! @Arguments C
DeclareAttribute( "TerminalObject",
                  IsCapCategory );

#! @Description
#! This is a convenience method.
#! The argument is a cell $c$.
#! The output is a terminal object $T$ of the
#! category $C$ for which $c \in C$.
#! @Returns an object
#! @Arguments c
DeclareAttribute( "TerminalObject",
                  IsCapCategoryCell );


#! @Description
#! The argument is an object $A$.
#! The output is the universal morphism $u(A): A \rightarrow \mathrm{TerminalObject}$.
#! @Returns a morphism in $\mathrm{Hom}( A, \mathrm{TerminalObject} )$
#! @Arguments A
DeclareAttributeWithToDoForIsWellDefined( "UniversalMorphismIntoTerminalObject",
                                          IsCapCategoryObject );

#! @Description
#! The argument are an object $A$,
#! and an object $T = \mathrm{TerminalObject}$.
#! The output is the universal morphism $u(A): A \rightarrow T$.
#! @Returns a morphism in $\mathrm{Hom}( A, T )$
#! @Arguments A, T
DeclareOperation( "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## Add Operations


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>TerminalObject</C>.
#! $F: () \mapsto T$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTerminalObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTerminalObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

## don't document this function
DeclareOperation( "AddTerminalObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTerminalObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoTerminalObject</C>.
#! $F: A \mapsto u(A)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoTerminalObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoTerminalObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoTerminalObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoTerminalObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoTerminalObjectWithGivenTerminalObject</C>.
#! $F: (A,T) \mapsto u(A)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                  [ IsCapCategory, IsList ] );



#! @Description
#! The argument is a category $C$.
#! The output is the unique morphism $\mathrm{TerminalObject} \rightarrow \mathrm{TerminalObject}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{TerminalObject}, \mathrm{TerminalObject} )$
#! @Arguments C
DeclareAttribute( "TerminalObjectFunctorial",
                  IsCapCategory );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>TerminalObjectFunctorial</C>.
#! $F: () \mapsto (T \rightarrow T)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTerminalObjectFunctorial",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTerminalObjectFunctorial",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTerminalObjectFunctorial",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTerminalObjectFunctorial",
                  [ IsCapCategory, IsList ] );

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

#! An initial object consists of two parts:
#! * an object $I$,
#! * a function $u$ mapping each object $A$ to a morphism $u( A ): I \rightarrow A$.
#! The pair $(I,u)$ is called a \textbf{initial object} if the morphisms $u(A)$ are uniquely determined up to
#! congruence of morphisms.
#!
#! $\mathrm{TerminalObject}$ is a functorial operation. This just means:
#! There exists a unique morphisms $I \rightarrow I$.

## Main Operations and Attributes


#! @Description
#! The argument is a category $C$.
#! The output is an initial object $I$ of $C$.
#! @Returns an object
#! @Arguments C
DeclareAttribute( "InitialObject",
                  IsCapCategory );

#! @Description
#! This is a convenience method.
#! The argument is a cell $c$.
#! The output is an initial object $I$ of the category $C$
#! for which $c \in C$.
#! @Returns an object
#! @Arguments c
DeclareAttribute( "InitialObject",
                  IsCapCategoryCell );


#! @Description
#! The argument is an object $A$.
#! The output is the universal morphism $u(A): \mathrm{InitialObject} \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{InitialObject} \rightarrow A)$.
#! @Arguments A
DeclareAttributeWithToDoForIsWellDefined( "UniversalMorphismFromInitialObject",
                                          IsCapCategoryObject );

#! @Description
#! The arguments are an object $A$,
#! and an object $I = \mathrm{InitialObject}$.
#! The output is the universal morphism $u(A): \mathrm{InitialObject} \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{InitialObject} \rightarrow A)$.
#! @Arguments A, I
DeclareOperation( "UniversalMorphismFromInitialObjectWithGivenInitialObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InitialObject</C>.
#! $F: () \mapsto I$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInitialObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInitialObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInitialObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInitialObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromInitialObject</C>.
#! $F: A \mapsto u(A)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromInitialObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromInitialObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromInitialObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromInitialObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromInitialObjectWithGivenInitialObject</C>.
#! $F: (A,I) \mapsto u(A)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromInitialObjectWithGivenInitialObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromInitialObjectWithGivenInitialObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromInitialObjectWithGivenInitialObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromInitialObjectWithGivenInitialObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a category $C$.
#! The output is the unique morphism $\mathrm{InitialObject} \rightarrow \mathrm{InitialObject}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{InitialObject}, \mathrm{InitialObject} )$
#! @Arguments C
DeclareAttribute( "InitialObjectFunctorial",
                  IsCapCategory );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InitialObjectFunctorial</C>.
#! $F: () \rightarrow ( I \rightarrow I )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInitialObjectFunctorial",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInitialObjectFunctorial",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInitialObjectFunctorial",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInitialObjectFunctorial",
                  [ IsCapCategory, IsList ] );

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
#! @Section Direct Sum
##
####################################

#! For a given list $D = (S_1, \dots, S_n)$, a direct sum consists of five parts:
#! * an object $S$,
#! * a list of morphisms $\pi = (\pi_i: S \rightarrow S_i)_{i = 1 \dots n}$,
#! * a list of morphisms $\iota = (\iota_i: S_i \rightarrow S)_{i = 1 \dots n}$,
#! * a dependent function $u_{\mathrm{in}}$ mapping every list $\tau = ( \tau_i: T \rightarrow S_i )_{i = 1 \dots n}$
#!  to a morphism $u_{\mathrm{in}}(\tau): T \rightarrow S$ such that
#!  $\pi_i \circ u_{\mathrm{in}}(\tau) \sim_{T,S_i} \tau_i$ for all $i = 1, \dots, n$.
#! * a dependent function $u_{\mathrm{out}}$ mapping every list $\tau = ( \tau_i: S_i \rightarrow T )_{i = 1 \dots n}$
#!  to a morphism $u_{\mathrm{out}}(\tau): S \rightarrow T$ such that
#!   $u_{\mathrm{out}}(\tau) \circ \iota_i \sim_{S_i, T} \tau_i$ for all $i = 1, \dots, n$,
#! such that
#! * $\sum_{i=1}^{n} \iota_i \circ \pi_i = \mathrm{id}_S$,
#! * $\pi_j \circ \iota_i = \delta_{i,j}$,
#! where $\delta_{i,j} \in \mathrm{Hom}( S_i, S_j )$ is the identity if $i=j$, and $0$ otherwise.
#! The $5$-tuple $(S, \pi, \iota, u_{\mathrm{in}}, u_{\mathrm{out}})$ is called a <Emph>direct sum</Emph> of $D$
#! if the morphisms 
#! $u_{\mathrm{in}}(\tau)$, $u_{\mathrm{out}}(\tau)$ are uniquely determined up to congruence of morphisms.


## Main Operations and Attributes

DeclareOperationWithCache( "DirectSumOp",
                           [ IsList, IsCapCategoryObject ] );

DeclareOperation( "ProjectionInFactorOfDirectSum",
                  [ IsList, IsInt ] );

DeclareOperation( "ProjectionInFactorOfDirectSumOp",
                  [ IsList, IsInt, IsCapCategoryObject ] );

DeclareOperation( "ProjectionInFactorOfDirectSumWithGivenDirectSum",
                  [ IsList, IsInt, IsCapCategoryObject ] );

DeclareOperation( "InjectionOfCofactorOfDirectSum",
                  [ IsList, IsInt ] );

DeclareOperation( "InjectionOfCofactorOfDirectSumOp",
                  [ IsList, IsInt, IsCapCategoryObject ] );

DeclareOperation( "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
                  [ IsList, IsInt, IsCapCategoryObject ] );

DeclareGlobalFunction( "UniversalMorphismIntoDirectSum" );

DeclareOperation( "UniversalMorphismIntoDirectSumOp",
                  [ IsList, IsList, IsCapCategoryObject ] );

DeclareOperation( "UniversalMorphismIntoDirectSumWithGivenDirectSum",
                  [ IsList, IsList, IsCapCategoryObject ] );

DeclareGlobalFunction( "UniversalMorphismFromDirectSum" );

DeclareOperation( "UniversalMorphismFromDirectSumOp",
                  [ IsList, IsList, IsCapCategoryObject ] );

DeclareOperation( "UniversalMorphismFromDirectSumWithGivenDirectSum",
                  [ IsList, IsList, IsCapCategoryObject ] );

DeclareOperation( "IsomorphismFromDirectSumToDirectProduct",
                  [ IsList ] );

DeclareOperation( "IsomorphismFromDirectSumToDirectProductOp",
                  [ IsList, IsCapCategoryObject ] );

DeclareOperation( "IsomorphismFromDirectProductToDirectSum",
                  [ IsList ] );

DeclareOperation( "IsomorphismFromDirectProductToDirectSumOp",
                  [ IsList, IsCapCategoryObject ] );


DeclareOperation( "IsomorphismFromDirectSumToCoproduct",
                  [ IsList ] );

DeclareOperation( "IsomorphismFromDirectSumToCoproductOp",
                  [ IsList, IsCapCategoryObject ] );

DeclareOperation( "IsomorphismFromCoproductToDirectSum",
                  [ IsList ] );

DeclareOperation( "IsomorphismFromCoproductToDirectSumOp",
                  [ IsList, IsCapCategoryObject ] );


## convenience methods

DeclareOperationWithCache( "MorphismBetweenDirectSums",
                           [ IsList ] );

DeclareOperationWithCache( "MorphismBetweenDirectSumsOp",
                           [ IsList, IsInt, IsInt, IsCapCategoryMorphism ] );


DeclareOperation( "AddProjectionInFactorOfDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectSum",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "AddProjectionInFactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "AddInjectionOfCofactorOfDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfDirectSum",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "AddInjectionOfCofactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "AddUniversalMorphismIntoDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectSum",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "AddUniversalMorphismIntoDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "AddUniversalMorphismFromDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromDirectSum",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "AddUniversalMorphismFromDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "AddIsomorphismFromDirectSumToDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromDirectSumToDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromDirectSumToDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromDirectSumToDirectProduct",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "AddIsomorphismFromDirectProductToDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromDirectProductToDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromDirectProductToDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromDirectProductToDirectSum",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "AddIsomorphismFromDirectSumToCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromDirectSumToCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromDirectSumToCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromDirectSumToCoproduct",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "AddIsomorphismFromCoproductToDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromCoproductToDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoproductToDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoproductToDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! This operation adds the given function $f: ( (S_1, \dots, S_n) ) \mapsto S$ to the category $C$,
#! where $(S_1, \dots, S_n)$ is a list of objects in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectSum",
                  [ IsCapCategory, IsList ] );


#! @Section Functorial methods for direct sum

#! Direct sum is a functorial operation. This means:
#! For $(\mu_i: S_i \rightarrow S'_i)_{i=1\dots n}$,
#! we obtain a morphism $\phi: \mathrm{DirectSum}( S_1, \dots, S_n ) \rightarrow \mathrm{DirectSum}( S_1', \dots, S_n' )$.


#! @Description
#! This method takes $L = [ \mu_1, \dots, \mu_n ]$ as an input.
#! @Returns $\phi$
#! @Arguments L
DeclareOperation( "DirectSumFunctorial",
                  [ IsList ] );

DeclareOperation( "AddDirectSumFunctorial",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDirectSumFunctorial",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDirectSumFunctorial",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectSumFunctorial",
                  [ IsCapCategory, IsList ] );

#! @Description
#! This method takes $L = [ \mu_1, \dots, \mu_n ]$ and a morphism $m$ for the method selection.
#! @Returns $\phi$
#! @Arguments L, m
DeclareOperation( "DirectSumFunctorialOp",
                  [ IsList, IsCapCategoryMorphism ] );

## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a direct sum object. 
#! Note that we chose <C>WasCreatedAsDirectSum</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsDirectSum" );

DeclareProperty( "IS_IMPLIED_DIRECT_SUM", 
                 IsCapCategoryObject );

#! @Chapter Universal Objects



####################################
##
#! @Section Coproduct
##
####################################

#! For a given list of objects $D = ( I_1, \dots, I_n )$, a coproduct of $D$ consists of three parts:
#! * an object $I$,
#! * a list of morphisms $\iota = ( \iota_i: I_i \rightarrow I )_{i = 1 \dots n}$
#! * a dependent function $u$ mapping each list of morphisms $\tau = ( \tau_i: I_i \rightarrow T )$
#!  to a morphism $u( \tau ): I \rightarrow T$ such that $u( \tau ) \circ \iota_i \sim_{I_i, T} \tau_i$ for all $i = 1, \dots, n$.
#! The triple $( I, \iota, u )$ is called a <Emph>coproduct</Emph> of $D$ if the morphisms $u( \tau )$ are uniquely determined up to
#! congruence of morphisms.

## Main Operations and Attributes

DeclareGlobalFunction( "Coproduct" );

DeclareOperationWithCache( "CoproductOp",
                           [ IsList, IsCapCategoryObject ] );

DeclareGlobalFunction( "InjectionOfCofactor" );

DeclareOperation( "InjectionOfCofactorOfCoproduct",
                  [ IsList, IsInt ] );

DeclareOperation( "InjectionOfCofactorOfCoproductOp",
                  [ IsList, IsInt, IsCapCategoryObject ] );

DeclareOperation( "InjectionOfCofactorOfCoproductWithGivenCoproduct",
                  [ IsList, IsInt, IsCapCategoryObject ] );

DeclareGlobalFunction( "UniversalMorphismFromCoproduct" );

DeclareOperation( "UniversalMorphismFromCoproductOp",
                  [ IsList, IsList, IsCapCategoryObject ] );

DeclareOperation( "UniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsList, IsList, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! This operation adds the given function $f: ( (I_1, \dots, I_n) ) \mapsto I$ to the category $C$
#! where $(I_1, \dots, I_n)$ is a list of objects in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoproduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( (I_1, \dots, I_n), i ) \mapsto \iota_i$ to the category $C$
#! where $(I_1, \dots, I_n)$ is a list of objects in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddInjectionOfCofactorOfCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfCoproduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( (I_1, \dots, I_n), i, I ) \mapsto \iota_i$ to the category $C$
#! where $(I_1, \dots, I_n)$ is a list of objects in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddInjectionOfCofactorOfCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsList ] );


#FIXME: it is inconsistent with the convention that the diagram does not have to be given as an input!
#! @Description
#! This operation adds the given function $f: ( ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}  ) \mapsto u$ to the category $C$
#! where $( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromCoproduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}, I  ) \mapsto u$ to the category $C$
#! where $( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsList ] );


#! @Section Functorial methods for coproduct

#! Coproduct is a functorial operation. This means:
#! For $(\mu_i: I_i \rightarrow I'_i)_{i=1\dots n}$,
#! we obtain a morphism $\phi: \mathrm{Coproduct}( I_1, \dots, I_n ) \rightarrow \mathrm{Coproduct}( I_1', \dots, I_n' )$.


#! @Description
#! This method takes $L = [ \mu_1, \dots, \mu_n ]$ as an input.
#! @Returns $\phi$
#! @Arguments L
DeclareOperation( "CoproductFunctorial",
                  [ IsList ] );

DeclareOperation( "AddCoproductFunctorial",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoproductFunctorial",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoproductFunctorial",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoproductFunctorial",
                  [ IsCapCategory, IsList ] );



DeclareOperation( "CoproductFunctorialOp",
                  [ IsList, IsCapCategoryMorphism ] );



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

#! For a given list of objects $D = ( P_1, \dots, P_n )$, a direct product of $D$ consists of three parts:
#! * an object $P$,
#! * a list of morphisms $\pi = ( \pi_i: P \rightarrow P_i )_{i = 1 \dots n}$ 
#! * a dependent function $u$ mapping each list of morphisms $\tau = ( \tau_i: T \rightarrow P_i )_{i = 1, \dots, n}$ 
#!  to a morphism $u(\tau): T \rightarrow P$ such that $\pi_i \circ u( \tau ) \sim_{T,P_i} \tau_i$ for all $i = 1, \dots, n$.
#! The triple $( P, \pi, u )$ is called a <Emph>direct product</Emph> of $D$ if the morphisms $u( \tau )$ are uniquely determined up to
#! congruence of morphisms.

## Main Operations and Attributes
#! @Description
#! Direct product of a given diagram $D$, where $D$ is a list of objects.
#! The second argument $M$ is an object needed for the method
#! selection.
#! @Returns IsCapCategoryObject
#! @Arguments D, M
DeclareOperationWithCache( "DirectProductOp",
                           [ IsList, IsCapCategoryObject ] );

#! @Description
#! Projection in the $i$-th factor of the direct product given by $D$.
#! $D$ can either be an object created as a direct product or a list
#! of objects $D = (A_i)$ representing a diagram.
#! @Returns IsCapCategoryMorphism
#! @Arguments D, i
DeclareGlobalFunction( "ProjectionInFactor" );

DeclareOperation( "ProjectionInFactorOfDirectProduct",
                  [ IsList, IsInt ] );
#! @Description
#! Projection in the $i$-th factor of the direct product given by $D$.
#! $D$ can either be an object created as a direct product or a list
#! of objects representing a diagram. The third argument $M$
#! is an object needed for the method selection.
#! @Returns IsCapCategoryMorphism
#! @Arguments D, i, M
DeclareOperation( "ProjectionInFactorOfDirectProductOp",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! Projection in the $i$-th factor of the direct product $P = \prod_j A_j$ 
#! given by a list of objects $D = (A_j)$.
#! @Returns IsCapCategoryMorphism
#! @Arguments D, i, P
DeclareOperation( "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! Given finitely many morphisms $\alpha_i: A \rightarrow P_i$ this method
#! returns the unique morphism $\alpha: A \rightarrow \prod_j P_j$ such that
#! $\pi_i \circ \alpha = \alpha_i$, where $\pi_i$ denotes the $i$-th projection
#! $\prod_j P_j \rightarrow P_i$.
#! @Returns a morphism in $\mathrm{Hom}(A, \prod_j P_j)$
#! @Arguments alpha_i
DeclareGlobalFunction( "UniversalMorphismIntoDirectProduct" );


#! @Description
#! The arguments are a list of objects $L = (P_1, \dots, P_n)$,
#! a list of morphisms $D = (\alpha_i: A \rightarrow P_i)$,
#! and an object $M$ only needed for method selection.
#! This method
#! returns the unique morphism $\alpha: A \rightarrow \prod_j P_j$ such that
#! $\pi_i \circ \alpha = \alpha_i$, where $\pi_i$ denotes the $i$-th projection
#! $\prod_j P_j \rightarrow P_i$.
#! @Returns a morphism in $\mathrm{Hom}(A,\prod_j P_j)$
#! @Arguments L, D, M
DeclareOperation( "UniversalMorphismIntoDirectProductOp",
                  [ IsList, IsList, IsCapCategoryObject ] );

# TODO: Fix this documentation (new argument)
#! @Description
#! The arguments are a list of objects $L = (P_1, \dots, P_n)$,
#! a list of morphisms $D = (\alpha_i: A \rightarrow P_i)$,
#! and the direct product $P = \prod_j P_j$.
#! This method
#! returns the unique morphism $\alpha: A \rightarrow \prod_j P_j$ such that
#! $\pi_i \circ \alpha = \alpha_i$, where $\pi_i$ denotes the $i$-th projection
#! $\prod_j P_j \rightarrow P_i$.
#! @Returns a morphism in $\mathrm{Hom}(A,P)$
#! @Arguments L, D, P
DeclareOperation( "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsList, IsList, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! This operation adds the given function $f: ( (P_1, \dots, P_n) ) \mapsto P$ to the category $C$
#! where $(P_1, \dots, P_n)$ is a list of objects in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectProduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( (P_1, \dots, P_n), i ) \mapsto \pi_i$ to the category $C$
#! where $(P_1, \dots, P_n)$ is a list of objects in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddProjectionInFactorOfDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectProduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( (P_1, \dots, P_n), i, P ) \mapsto \pi_i$ to the category $C$
#! where $(P_1, \dots, P_n)$ is a list of objects in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddProjectionInFactorOfDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( ( \tau_i: T \rightarrow P_i )_{i = 1 \dots n} ) \mapsto u$ to the category $C$
#! where $( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectProduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( ( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}, P ) \mapsto u$ to the category $C$
#! where $( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsList ] );


#! @Section Functorial methods for direct product

#! DirectProduct is a functorial operation. This means:
#! For $(\mu_i: P_i \rightarrow P'_i)_{i=1\dots n}$,
#! we obtain a morphism $\phi: \mathrm{DirectProduct}( P_1, \dots, P_n ) \rightarrow \mathrm{DirectProduct}( P_1', \dots, P_n' )$.


#! @Description
#! This method takes $L = [ \mu_1, \dots, \mu_n ]$ as an input.
#! @Returns $\phi$
#! @Arguments L
DeclareOperation( "DirectProductFunctorial",
                  [ IsList ] );

DeclareOperation( "AddDirectProductFunctorial",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDirectProductFunctorial",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDirectProductFunctorial",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectProductFunctorial",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "DirectProductFunctorialOp",
                  [ IsList, IsCapCategoryMorphism ] );


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
#! @Section Fiber Product
##
####################################

#! For a given list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$, 
#! a fiber product of $D$ consists of three parts:
#! * an object $P$,
#! * a list of morphisms $\pi = ( \pi_i: P \rightarrow P_i )_{i = 1 \dots n}$ such that
#!  $\beta_i \circ \pi_i  \sim_{P, B} \beta_j \circ \pi_j$ for all pairs $i,j$.
#! * a dependent function $u$ mapping each list of morphisms
#!  $\tau = ( \tau_i: T \rightarrow P_i )$ such that
#!  $\beta_i \circ \tau_i  \sim_{P, B} \beta_j \circ \tau_j$ for all pairs $i,j$
#!  to a morphism $u( \tau ): T \rightarrow P$ such that
#!  $\pi_i \circ u( \tau ) \sim_{T, P_i} \tau_i$ for all $i = 1, \dots, n$.
#! The triple $( P, \pi, u )$ is called a <Emph>fiber product</Emph> of $D$ if the morphisms $u( \tau )$ are uniquely determined up to
#! congruence of morphisms.

## Main Operations and Attributes

# FIXME:
# Declared as an operation in MatricesForCap!
# DeclareGlobalFunction( "FiberProduct" );

##
DeclareOperation( "IsomorphismFromFiberProductToKernelOfDiagonalDifference",
                  [ IsList ] );
##
DeclareOperation( "IsomorphismFromFiberProductToKernelOfDiagonalDifferenceOp",
                  [ IsList, IsCapCategoryMorphism ] );

##
DeclareOperation( "AddIsomorphismFromFiberProductToKernelOfDiagonalDifference",
                  [ IsCapCategory, IsFunction ] );
##
DeclareOperation( "AddIsomorphismFromFiberProductToKernelOfDiagonalDifference",
                  [ IsCapCategory, IsFunction, IsInt ] );
##
DeclareOperation( "AddIsomorphismFromFiberProductToKernelOfDiagonalDifference",
                  [ IsCapCategory, IsList, IsInt ] );
##
DeclareOperation( "AddIsomorphismFromFiberProductToKernelOfDiagonalDifference",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct",
                  [ IsList ] );
##
DeclareOperation( "IsomorphismFromKernelOfDiagonalDifferenceToFiberProductOp",
                  [ IsList, IsCapCategoryMorphism ] );

##
DeclareOperation( "AddIsomorphismFromKernelOfDiagonalDifferenceToFiberProduct",
                  [ IsCapCategory, IsFunction ] );

##
DeclareOperation( "AddIsomorphismFromKernelOfDiagonalDifferenceToFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

##
DeclareOperation( "AddIsomorphismFromKernelOfDiagonalDifferenceToFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

##
DeclareOperation( "AddIsomorphismFromKernelOfDiagonalDifferenceToFiberProduct",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "DirectSumDiagonalDifference",
                  [ IsList ] );

##
DeclareOperationWithCache( "DirectSumDiagonalDifferenceOp",
                           [ IsList, IsCapCategoryMorphism ] );

##
DeclareOperation( "FiberProductEmbeddingInDirectSum",
                  [ IsList ] );

##
DeclareOperationWithCache( "FiberProductEmbeddingInDirectSumOp",
                           [ IsList, IsCapCategoryMorphism ] );

##
DeclareOperation( "AddFiberProductEmbeddingInDirectSum",
                  [ IsCapCategory, IsFunction ] );

##
DeclareOperation( "AddFiberProductEmbeddingInDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

##
DeclareOperation( "AddFiberProductEmbeddingInDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddFiberProductEmbeddingInDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! This function either accepts a list $D = (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$
#! of morphisms or 
#! arbitrary many arrows $\beta_i: P_i \rightarrow B$ as an input and returns
#! the pullback $P$.
#! @Returns IsCapCategoryObject
#! @Arguments D, j
DeclareGlobalFunction( "FiberProduct" );

#! @Description
#! This function takes $D = (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$
#! as an input and a morphism for the method selection and returns the pullback $P$ of $D$.
#! @Returns IsCapCategoryObject
#! @Arguments D, j
DeclareOperationWithCache( "FiberProductOp",
                           [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! Given a list of morphisms $D = (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$ and an integer $j$
#! this method returns the $j-th$ projection $\pi_j$ into the pullback $P$ of $D$.
#! @Returns IsCapCategoryMorphism
#! @Arguments D, j
DeclareOperation( "ProjectionInFactorOfFiberProduct",
                  [ IsList, IsInt ] );

#! @Description
#! Given a list of morphisms $D = (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$, an integer $j$,
#! and a morphism $m$ used for the method selection,
#! this method returns the $j-th$ projection $\pi_j$ into the pullback $P$ of $D$.
#! @Returns IsCapCategoryMorphism
#! @Arguments D, j, m
DeclareOperation( "ProjectionInFactorOfFiberProductOp",
                  [ IsList, IsInt, IsCapCategoryMorphism ] );

#! @Description
#! Given a list of morphisms $D = (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$, an integer $j$,
#! and a pullback $P$
#! this method returns the $j-th$ projection $\pi_j$ into the pullback $P$ of $D$.
#! @Returns IsCapCategoryMorphism
#! @Arguments D, j, m
DeclareOperation( "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! This convenience method may be used in three ways:
#! 1) The input is a list of morphisms $D = (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$
#! and a test source $( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}$ and computes
#! the universal morphism $u$ into the pullback of $D$. 
#! 2) The input is a list of morphisms $D = (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$
#! and arbitrary many morphisms $\tau_i: T \rightarrow P_i$ which define a test source and
#! computes the universal morphism $u$ into the pullback of $D$. 
#! 3) The input is an object $P$ which is a pullback 
#! and arbitrary many morphisms $\tau_i: T \rightarrow P_i$ which define a test source and
#! computes the universal morphism $u$ into the pullback $P$
#! @Returns IsCapCategoryMorphism
DeclareGlobalFunction( "UniversalMorphismIntoFiberProduct" );

#! @Description
#! Given a list of morphisms $D = (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$,
#! a test source $T = ( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}$ and a morphism $m$ for the method selection,
#! this method computes
#! the universal morphism $u$ into the pullback of $D$. 
#! @Returns IsCapCategoryMorphism
#! @Arguments D, T, m
DeclareOperation( "UniversalMorphismIntoFiberProductOp",
                  [ IsList, IsList, IsCapCategoryMorphism ] );

#! @Description
#! Given a list of morphisms $D = (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$,
#! a test source $T = ( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}$ and a pullback $P$ of $D$
#! this method computes
#! the universal morphism $u$ into the pullback $P$.
#! @Returns IsCapCategoryMorphism
#! @Arguments D, T, P
DeclareOperation( "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
                  [ IsList, IsList, IsCapCategoryObject ] );

## Add Operations


#! @Description
#! This operation adds the given function $f: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n} ) \mapsto P$ to the category $C$
#! where $(\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddFiberProduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, i ) \mapsto \pi_i$ to the category $C$
#! where $(\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddProjectionInFactorOfFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfFiberProduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, i, P ) \mapsto \pi_i$ to the category $C$
#! where $(\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddProjectionInFactorOfFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, ( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}  ) \mapsto u$ 
#! to the category $C$
#! where $(\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$ and $( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}$ are lists of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoFiberProduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, ( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}, P ) \mapsto u$ 
#! to the category $C$
#! where $(\beta_i: P_i \rightarrow B)_{i = 1 \dots n}$ and $( \tau_i: T \rightarrow P_i )_{i = 1 \dots n}$ are lists of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismIntoFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsList ] );


#! @Section Functorial methods for pullback

#! FiberProduct is a functorial operation. This means:
#! For a second diagram $\beta_i': P_i' \rightarrow B'$ and a natural morphism
#! between pullback diagrams (i.e., a collection of morphisms
#! $(\mu_i: P_i \rightarrow P'_i)_{i=1\dots n}$ and $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \mu_i = \beta \circ \beta_i$ for $i = 1, \dots n$)
#! we obtain a morphism $\phi: \mathrm{FiberProduct}( \beta_1, \dots, \beta_n ) \rightarrow \mathrm{FiberProduct}( \beta_1', \dots, \beta_n' )$.


#! @Description
#! This method takes $L = [ [ \beta_1, \mu_1, \beta_1' ], \dots, [ \beta_n, \mu_n, \beta_n' ] ]$ as an input.
#! Note that $\beta$ is not needed for the computation of $\phi$.
#! @Returns $\phi$
#! @Arguments L
DeclareOperation( "FiberProductFunctorial",
                  [ IsList ] );

DeclareOperation( "AddFiberProductFunctorial",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddFiberProductFunctorial",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddFiberProductFunctorial",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddFiberProductFunctorial",
                  [ IsCapCategory, IsList ] );

#! This method takes $L = [ [ \beta_1, \mu_1, \beta_1' ], \dots, [ \beta_n, \mu_n, \beta_n' ] ]$ 
#! and $\beta$ as an input.
#! @Returns $\phi$
#! @Arguments L, beta
DeclareOperation( "FiberProductFunctorialOp",
                  [ IsList, IsCapCategoryMorphism ] );

## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for a pullback. 
#! Note that we chose <C>WasCreatedAsFiberProduct</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsFiberProduct" );

#! @Chapter Universal Objects

####################################
##
#! @Section Pushout
##
####################################

#! For a given list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$,
#! a pushout of $D$ consists of three parts:
#! * an object $I$,
#! * a list of morphisms $\iota = ( \iota_i: I_i \rightarrow I )_{i = 1 \dots n}$ such that
#!  $\iota_i \circ \beta_i \sim_{B,I} \iota_j \circ \beta_j$ for all pairs $i,j$,
#! * a dependent function $u$ mapping each list of morphisms
#!  $\tau = ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ such that
#!  $\tau_i \circ \beta_i \sim_{B,T} \tau_j \circ \beta_j$
#!  to a morphism $u( \tau ): I \rightarrow T$ such that
#!  $u( \tau ) \circ \iota_i \sim_{I_i, T} \tau_i$ for all $i = 1, \dots, n$.
#! The triple $( I, \iota, u )$ is called a <Emph>pushout</Emph> of $D$ if the morphisms $u( \tau )$ are uniquely determined up to
#! congruence of morphisms.

##
DeclareOperation( "IsomorphismFromPushoutToCokernelOfDiagonalDifference",
                  [ IsList ] );

##
DeclareOperation( "IsomorphismFromPushoutToCokernelOfDiagonalDifferenceOp",
                  [ IsList, IsCapCategoryMorphism ] );

##
DeclareOperation( "AddIsomorphismFromPushoutToCokernelOfDiagonalDifference",
                  [ IsCapCategory, IsFunction ] );
##
DeclareOperation( "AddIsomorphismFromPushoutToCokernelOfDiagonalDifference",
                  [ IsCapCategory, IsFunction, IsInt ] );
##
DeclareOperation( "AddIsomorphismFromPushoutToCokernelOfDiagonalDifference",
                  [ IsCapCategory, IsList, IsInt ] );
##
DeclareOperation( "AddIsomorphismFromPushoutToCokernelOfDiagonalDifference",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "IsomorphismFromCokernelOfDiagonalDifferenceToPushout",
                  [ IsList ] );

##
DeclareOperation( "IsomorphismFromCokernelOfDiagonalDifferenceToPushoutOp",
                  [ IsList, IsCapCategoryMorphism ] );

##
DeclareOperation( "AddIsomorphismFromCokernelOfDiagonalDifferenceToPushout",
                  [ IsCapCategory, IsFunction ] );
##
DeclareOperation( "AddIsomorphismFromCokernelOfDiagonalDifferenceToPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
##
DeclareOperation( "AddIsomorphismFromCokernelOfDiagonalDifferenceToPushout",
                  [ IsCapCategory, IsList, IsInt ] );
##
DeclareOperation( "AddIsomorphismFromCokernelOfDiagonalDifferenceToPushout",
                  [ IsCapCategory, IsList ] );



## Main Operations and Attributes
##
DeclareOperation( "DirectSumCodiagonalDifference",
                  [ IsList ] );

##
DeclareOperationWithCache( "DirectSumCodiagonalDifferenceOp",
                           [ IsList, IsCapCategoryMorphism ] );

##
DeclareOperation( "DirectSumProjectionInPushout",
                  [ IsList ] );

##
DeclareOperationWithCache( "DirectSumProjectionInPushoutOp",
                           [ IsList, IsCapCategoryMorphism ] );

##
DeclareOperation( "AddDirectSumProjectionInPushout",
                  [ IsCapCategory, IsFunction ] );

##
DeclareOperation( "AddDirectSumProjectionInPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

##
DeclareOperation( "AddDirectSumProjectionInPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectSumProjectionInPushout",
                  [ IsCapCategory, IsList ] );

DeclareGlobalFunction( "Pushout" );

DeclareOperationWithCache( "PushoutOp",
                           [ IsList, IsCapCategoryMorphism ] );

## DeclareGlobalFunction( "InjectionOfCofactor" ); to be adjusted

DeclareOperation( "InjectionOfCofactorOfPushout",
                  [ IsList, IsInt ] );

DeclareOperation( "InjectionOfCofactorOfPushoutOp",
                  [ IsList, IsInt, IsCapCategoryMorphism ] );

DeclareOperation( "InjectionOfCofactorOfPushoutWithGivenPushout",
                  [ IsList, IsInt, IsCapCategoryObject ] );

DeclareGlobalFunction( "UniversalMorphismFromPushout" );

DeclareOperation( "UniversalMorphismFromPushoutOp",
                  [ IsList, IsList, IsCapCategoryMorphism ] );

DeclareOperation( "UniversalMorphismFromPushoutWithGivenPushout",
                  [ IsList, IsList, IsCapCategoryObject ] );

## Add Operations


#! @Description
#! This operation adds the given function $f: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n} ) \mapsto I$ to the category $C$
#! where $(\beta_i: B \rightarrow I_i)_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddPushout",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, i ) \mapsto \iota_i$ to the category $C$
#! where $(\beta_i: B \rightarrow I_i)_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddInjectionOfCofactorOfPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfPushout",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, i, I ) \mapsto \iota_i$ to the category $C$
#! where $(\beta_i: B \rightarrow I_i)_{i = 1 \dots n}$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddInjectionOfCofactorOfPushoutWithGivenPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfPushoutWithGivenPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfPushoutWithGivenPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfPushoutWithGivenPushout",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n} ) \mapsto u$ 
#! to the category $C$ where $(\beta_i: B \rightarrow I_i)_{i = 1 \dots n}$ and $( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ are lists of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromPushout",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}, I ) \mapsto u$ 
#! to the category $C$ where $(\beta_i: B \rightarrow I_i)_{i = 1 \dots n}$ and $( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ are lists of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromPushoutWithGivenPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromPushoutWithGivenPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromPushoutWithGivenPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromPushoutWithGivenPushout",
                  [ IsCapCategory, IsList ] );


#! @Section Functorial methods for pushout

#! FiberProduct is a functorial operation. This means:
#! For a second diagram $\beta_i': B' \rightarrow I_i'$ and a natural morphism
#! between pushout diagrams (i.e., a collection of morphisms
#! $(\mu_i: I_i \rightarrow I'_i)_{i=1\dots n}$ and $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \beta = \mu_i \circ \beta_i$ for $i = 1, \dots n$)
#! we obtain a morphism $\phi: \mathrm{Pushout}( \beta_1, \dots, \beta_n ) \rightarrow \mathrm{Pushout}( \beta_1', \dots, \beta_n' )$.


#! @Description
#! This method takes $L = [ [ \beta_1, \mu_1, \beta_1' ], \dots, [ \beta_n, \mu_n, \beta_n' ] ]$ as an input.
#! Note that $\beta$ is not needed for the computation of $\phi$.
#! @Returns $\phi$
#! @Arguments L
DeclareOperation( "PushoutFunctorial",
                  [ IsList ] );

DeclareOperation( "AddPushoutFunctorial",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddPushoutFunctorial",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddPushoutFunctorial",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddPushoutFunctorial",
                  [ IsCapCategory, IsList ] );

#! This method takes $L = [ [ \beta_1, \mu_1, \beta_1' ], \dots, [ \beta_n, \mu_n, \beta_n' ] ]$ 
#! and $\beta$ as an input.
#! @Returns $\phi$
#! @Arguments L, beta
DeclareOperation( "PushoutFunctorialOp",
                  [ IsList, IsCapCategoryMorphism ] );


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

#! For a given morphism $\alpha: A \rightarrow B$, an image of $\alpha$ consists of four parts:
#! * an object $I$,
#! * a morphism $c: A \rightarrow I$,
#! * a monomorphism $\iota: I \hookrightarrow B$ such that $\iota \circ c \sim_{A,B} \alpha$,
#! * a dependent function $u$ mapping each pair of morphisms $\tau = ( \tau_1: A \rightarrow T, \tau_2: T \hookrightarrow B )$
#!  where $\tau_2$ is a monomorphism
#!  such that $\tau_2 \circ \tau_1 \sim_{A,T} \alpha$ to a morphism
#!  $u(\tau): I \rightarrow T$ such that
#!  $\tau_2 \circ u(\tau) \sim_{I,B} \iota$ and $u(\tau) \circ c \sim_{A,T} \tau_1$.
#! The $4$-tuple $( I, c, \iota, u )$ is called an <Emph>image</Emph> of $\alpha$ if the morphisms $u( \tau )$ are uniquely determined up to
#! congruence of morphisms.

## Main Operations and Attributes

DeclareOperation( "IsomorphismFromImageObjectToKernelOfCokernel",
                  [ IsCapCategoryMorphism ] );

DeclareOperation( "AddIsomorphismFromImageObjectToKernelOfCokernel",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromImageObjectToKernelOfCokernel",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromImageObjectToKernelOfCokernel",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromImageObjectToKernelOfCokernel",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "IsomorphismFromKernelOfCokernelToImageObject",
                  [ IsCapCategoryMorphism ] );

DeclareOperation( "AddIsomorphismFromKernelOfCokernelToImageObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromKernelOfCokernelToImageObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromKernelOfCokernelToImageObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromKernelOfCokernelToImageObject",
                  [ IsCapCategory, IsList ] );

## FIXME: Image is a function (rename: ImageObject -> Image)
DeclareAttributeWithToDoForIsWellDefined( "ImageObject",
                                          IsCapCategoryMorphism );

#convenience function
DeclareAttributeWithToDoForIsWellDefined( "ImageEmbedding",
                                          IsCapCategoryObject );

DeclareAttributeWithToDoForIsWellDefined( "ImageEmbedding",
                                          IsCapCategoryMorphism );

#convenience function
DeclareAttributeWithToDoForIsWellDefined( "CoastrictionToImage",
                                          IsCapCategoryObject );

DeclareAttributeWithToDoForIsWellDefined( "CoastrictionToImage",
                                          IsCapCategoryMorphism );

DeclareOperation( "ImageEmbeddingWithGivenImageObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "CoastrictionToImageWithGivenImageObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "UniversalMorphismFromImage",
                  [ IsCapCategoryMorphism, IsList ] );

DeclareOperation( "UniversalMorphismFromImageWithGivenImageObject",
                  [ IsCapCategoryMorphism, IsList, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! This operation adds the given function $f: \alpha \mapsto I$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddImageObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddImageObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddImageObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddImageObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: \alpha \mapsto \iota$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddImageEmbedding",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddImageEmbedding",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddImageEmbedding",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddImageEmbedding",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: (\alpha, I) \mapsto \iota$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddImageEmbeddingWithGivenImageObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddImageEmbeddingWithGivenImageObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddImageEmbeddingWithGivenImageObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddImageEmbeddingWithGivenImageObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: \alpha \mapsto c$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddCoastrictionToImage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoastrictionToImage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoastrictionToImage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoastrictionToImage",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: (\alpha, I) \mapsto c$ to the category $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddCoastrictionToImageWithGivenImageObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoastrictionToImageWithGivenImageObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoastrictionToImageWithGivenImageObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoastrictionToImageWithGivenImageObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: (\alpha, [\tau_1, \tau_2]) \mapsto u$ to the category $C$.
#! Note that $[\tau_1, \tau_2]$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromImage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromImage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromImage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromImage",
                  [ IsCapCategory, IsList ] );


#! @Description
#! This operation adds the given function $f: (\alpha, [\tau_1, \tau_2], I) \mapsto u$ to the category $C$.
#! Note that $[\tau_1, \tau_2]$ is a list of morphisms in $C$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddUniversalMorphismFromImageWithGivenImageObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromImageWithGivenImageObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromImageWithGivenImageObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromImageWithGivenImageObject",
                  [ IsCapCategory, IsList ] );


## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

#! @Description 
#! When created, this filter is set to true for an image. 
#! Note that we chose <C>WasCreatedAsImageObject</C> to be a filter rather than a property,
#! because by default, a filter is set to false.
DeclareFilter( "WasCreatedAsImageObject" );
#! @Chapter Universal Objects

####################################
##
#! @Section Coimage
##
####################################

#! For a given morphism $\alpha: A \rightarrow B$, a coimage of $\alpha$ consists of four parts:
#! * an object $C$,
#! * an epimorphism $\pi: A \twoheadrightarrow C$,
#! * a morphism $a: C \rightarrow B$ such that $a \circ \pi \sim_{A,B} \alpha$,
#! * a dependent function $u$ mapping each pair of morphisms $\tau = ( \tau_1: A \twoheadrightarrow T, \tau_2: T \rightarrow B )$
#!  where $\tau_1$ is an epimorphism
#!  such that $\tau_2 \circ \tau_1 \sim_{A,B} \alpha$ to a morphism
#!  $u(\tau): T \rightarrow C$ such that
#!  $u( \tau ) \circ \tau_1 \sim_{A,C} \pi$ and $a \circ u( \tau ) \sim_{T,B} \tau_2$.
#! The $4$-tuple $( C, \pi, a, u )$ is called a <Emph>coimage</Emph> of $\alpha$ if the morphisms $u( \tau )$ are uniquely determined up to
#! congruence of morphisms.

DeclareOperation( "IsomorphismFromCoimageToCokernelOfKernel",
                  [ IsCapCategoryMorphism ] );

DeclareOperation( "AddIsomorphismFromCoimageToCokernelOfKernel",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromCoimageToCokernelOfKernel",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoimageToCokernelOfKernel",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoimageToCokernelOfKernel",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "IsomorphismFromCokernelOfKernelToCoimage",
                  [ IsCapCategoryMorphism ] );

DeclareOperation( "AddIsomorphismFromCokernelOfKernelToCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromCokernelOfKernelToCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromCokernelOfKernelToCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromCokernelOfKernelToCoimage",
                  [ IsCapCategory, IsList ] );


DeclareAttributeWithToDoForIsWellDefined( "Coimage",
                                          IsCapCategoryMorphism );

#convenience function
DeclareAttributeWithToDoForIsWellDefined( "CoimageProjection",
                                          IsCapCategoryObject );

DeclareAttributeWithToDoForIsWellDefined( "CoimageProjection",
                                          IsCapCategoryMorphism );

#convenience function
DeclareAttributeWithToDoForIsWellDefined( "AstrictionToCoimage",
                                          IsCapCategoryObject );

DeclareAttributeWithToDoForIsWellDefined( "AstrictionToCoimage",
                                          IsCapCategoryMorphism );

DeclareOperation( "CoimageProjectionWithGivenCoimage",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AstrictionToCoimageWithGivenCoimage",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "UniversalMorphismIntoCoimage",
                  [ IsCapCategoryMorphism, IsList ] );

DeclareOperation( "UniversalMorphismIntoCoimageWithGivenCoimage",
                  [ IsCapCategoryMorphism, IsList, IsCapCategoryObject ] );

## Add Operations

DeclareOperation( "AddCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoimage",
                  [ IsCapCategory, IsList ] );



DeclareOperation( "AddCoimageProjection",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoimageProjection",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoimageProjection",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoimageProjection",
                  [ IsCapCategory, IsList ] );



DeclareOperation( "AddCoimageProjectionWithGivenCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoimageProjectionWithGivenCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoimageProjectionWithGivenCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoimageProjectionWithGivenCoimage",
                  [ IsCapCategory, IsList ] );



DeclareOperation( "AddAstrictionToCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAstrictionToCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAstrictionToCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAstrictionToCoimage",
                  [ IsCapCategory, IsList ] );



DeclareOperation( "AddAstrictionToCoimageWithGivenCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAstrictionToCoimageWithGivenCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAstrictionToCoimageWithGivenCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAstrictionToCoimageWithGivenCoimage",
                  [ IsCapCategory, IsList ] );



DeclareOperation( "AddUniversalMorphismIntoCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoCoimage",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "AddUniversalMorphismIntoCoimageWithGivenCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoCoimageWithGivenCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoCoimageWithGivenCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoCoimageWithGivenCoimage",
                  [ IsCapCategory, IsList ] );




## WasCreatedAs Filter

#! @Chapter Technical Details

#! @Section Universal Objects

DeclareFilter( "WasCreatedAsCoimage" );
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
