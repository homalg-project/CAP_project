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
#! We say that the morphism $u(\tau)$ is induced by the
#! <Emph>universal property of the kernel</Emph>.
#! $\\ $
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
DeclareAttribute( "KernelObject",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the kernel embedding $\iota: \mathrm{KernelObject}(\alpha) \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{KernelObject}(\alpha),A)$
#! @Arguments alpha
DeclareAttribute( "KernelEmbedding",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and an object $K = \mathrm{KernelObject}(\alpha)$.
#! The output is the kernel embedding $\iota: K \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(K,A)$
#! @Arguments alpha, K
DeclareOperation( "KernelEmbeddingWithGivenKernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and a test morphism $\tau: T \rightarrow A$ satisfying $\alpha \circ \tau \sim_{T,B} 0$.
#! The output is the morphism $u(\tau): T \rightarrow \mathrm{KernelObject}(\alpha)$
#! given by the universal property of the kernel.
#! @Returns a morphism in $\mathrm{Hom}(T,\mathrm{KernelObject}(\alpha))$
#! @Arguments alpha, tau
DeclareOperation( "KernelLift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$,
#! a test morphism $\tau: T \rightarrow A$ satisfying $\alpha \circ \tau \sim_{T,B} 0$,
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
#! to the category for the basic operation <C>KernelEmbedding</C>.
#! $F: \alpha \mapsto \iota$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddKernelEmbedding",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddKernelEmbedding",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddKernelEmbedding",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddKernelEmbedding",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>KernelEmbeddingWithGivenKernelObject</C>.
#! $F: (\alpha, K) \mapsto \iota$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddKernelEmbeddingWithGivenKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddKernelEmbeddingWithGivenKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddKernelEmbeddingWithGivenKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddKernelEmbeddingWithGivenKernelObject",
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
#! given by the functoriality of the kernel.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{KernelObject}( \alpha ), \mathrm{KernelObject}( \alpha' ) )$
#! @Arguments L
DeclareOperation( "KernelObjectFunctorial",
                  [ IsList ] );

#! @Description
#! The arguments are three morphisms
#! $\alpha: A \rightarrow B$, $\mu: A \rightarrow A'$, $\alpha': A' \rightarrow B'$.
#! The output is the morphism
#! $\mathrm{KernelObject}( \alpha ) \rightarrow \mathrm{KernelObject}( \alpha' )$
#! given by the functoriality of the kernel.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{KernelObject}( \alpha ), \mathrm{KernelObject}( \alpha' ) )$
#! @Arguments alpha, mu, alpha_prime
DeclareOperation( "KernelObjectFunctorial",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{KernelObject}( \alpha )$,
#! three morphisms
#! $\alpha: A \rightarrow B$, $\mu: A \rightarrow A'$, $\alpha': A' \rightarrow B'$,
#! and an object $r = \mathrm{KernelObject}( \alpha' )$.
#! The output is the morphism
#! $\mathrm{KernelObject}( \alpha ) \rightarrow \mathrm{KernelObject}( \alpha' )$
#! given by the functoriality of the kernel.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, alpha, mu, alpha_prime, r
DeclareOperation( "KernelObjectFunctorialWithGivenKernelObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, 
                    IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = \mathrm{KernelObject}( \alpha )$,
#! four morphisms
#! $\alpha: A \rightarrow B$, $\mu: A \rightarrow A'$, $\nu: B \rightarrow B'$, $\alpha': A' \rightarrow B'$,
#! and an object $r = \mathrm{KernelObject}( \alpha' )$.
#! The output is the morphism
#! $\mathrm{KernelObject}( \alpha ) \rightarrow \mathrm{KernelObject}( \alpha' )$
#! given by the functoriality of the kernel.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, alpha, mu, nu, alpha_prime, r
DeclareOperation( "KernelObjectFunctorialWithGivenKernelObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism,
                    IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>KernelObjectFunctorialWithGivenKernelObjects</C>.
#! $F: (\mathrm{KernelObject}( \alpha ), \alpha, \mu, \alpha', \mathrm{KernelObject}( \alpha' )) \mapsto (\mathrm{KernelObject}( \alpha ) \rightarrow \mathrm{KernelObject}( \alpha' ))$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddKernelObjectFunctorialWithGivenKernelObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddKernelObjectFunctorialWithGivenKernelObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddKernelObjectFunctorialWithGivenKernelObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddKernelObjectFunctorialWithGivenKernelObjects",
                  [ IsCapCategory, IsList ] );

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
#! We denote the object $K$ of such a triple by $\mathrm{CokernelObject}(\alpha)$.
#! We say that the morphism $u(\tau)$ is induced by the
#! <Emph>universal property of the cokernel</Emph>.
#! $\\ $
#! $\mathrm{CokernelObject}$ is a functorial operation. This means:
#! for $\mu: A \rightarrow A'$, $\nu: B \rightarrow B'$,
#! $\alpha: A \rightarrow B$, $\alpha': A' \rightarrow B'$ such that $\nu \circ \alpha \sim_{A,B'} \alpha' \circ \mu$,
#! we obtain a morphism $\mathrm{CokernelObject}( \alpha ) \rightarrow \mathrm{CokernelObject}( \alpha' )$.



## Main Operations and Attributes
#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the cokernel $K$ of $\alpha$.
#! @Returns an object
#! @Arguments alpha
DeclareAttribute( "CokernelObject",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the cokernel projection $\epsilon: B \rightarrow \mathrm{CokernelObject}( \alpha )$.
#! @Returns a morphism in $\mathrm{Hom}(B, \mathrm{CokernelObject}( \alpha ))$
#! @Arguments alpha
DeclareAttribute( "CokernelProjection",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and an object $K = \mathrm{CokernelObject}(\alpha)$.
#! The output is the cokernel projection $\epsilon: B \rightarrow \mathrm{CokernelObject}( \alpha )$.
#! @Returns a morphism in $\mathrm{Hom}(B, K)$
#! @Arguments alpha, K
DeclareOperation( "CokernelProjectionWithGivenCokernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );


#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and a test morphism $\tau: B \rightarrow T$ satisfying $\tau \circ \alpha \sim_{A, T} 0$.
#! The output is the morphism $u(\tau): \mathrm{CokernelObject}(\alpha) \rightarrow T$
#! given by the universal property of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{CokernelObject}(\alpha),T)$
#! @Arguments alpha, tau
DeclareOperation( "CokernelColift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$,
#! a test morphism $\tau: B \rightarrow T$ satisfying $\tau \circ \alpha \sim_{A, T} 0$,
#! and an object $K = \mathrm{CokernelObject}(\alpha)$.
#! The output is the morphism $u(\tau): K \rightarrow T$
#! given by the universal property of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(K,T)$
#! @Arguments alpha, tau, K
DeclareOperation( "CokernelColiftWithGivenCokernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );


## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelObject</C>.
#! $F: \alpha \mapsto K$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCokernelObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelProjection</C>.
#! $F: \alpha \mapsto \epsilon$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCokernelProjection",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernelProjection",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCokernelProjection",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCokernelProjection",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelProjection</C>.
#! $F: (\alpha, K) \mapsto \epsilon$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCokernelProjectionWithGivenCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernelProjectionWithGivenCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCokernelProjectionWithGivenCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCokernelProjectionWithGivenCokernelObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelProjection</C>.
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
#! to the category for the basic operation <C>CokernelProjection</C>.
#! $F: (\alpha, \tau, K) \mapsto u(\tau)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCokernelColiftWithGivenCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernelColiftWithGivenCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCokernelColiftWithGivenCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCokernelColiftWithGivenCokernelObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The argument is a list $L = [ \alpha: A \rightarrow B, [ \mu:A \rightarrow A', \nu: B \rightarrow B' ], \alpha': A' \rightarrow B' ]$.
#! The output is the morphism
#! $\mathrm{CokernelObject}( \alpha ) \rightarrow \mathrm{CokernelObject}( \alpha' )$
#! given by the functoriality of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{CokernelObject}( \alpha ), \mathrm{CokernelObject}( \alpha' ))$
#! @Arguments L
DeclareOperation( "CokernelObjectFunctorial",
                  [ IsList ] );

DeclareSynonym( "CokernelFunctorial", CokernelObjectFunctorial );
## FIXME: Change this once we have moved to GAP 4.9
## DeclareDeprecatedSynonym( "CokernelFunctorial", CokernelObjectFunctorial );

#! @Description
#! The arguments are three morphisms
#! $\alpha: A \rightarrow B, \nu: B \rightarrow B', \alpha': A' \rightarrow B'$.
#! The output is the morphism
#! $\mathrm{CokernelObject}( \alpha ) \rightarrow \mathrm{CokernelObject}( \alpha' )$
#! given by the functoriality of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{CokernelObject}( \alpha ), \mathrm{CokernelObject}( \alpha' ))$
#! @Arguments alpha, nu, alpha_prime
DeclareOperation( "CokernelObjectFunctorial",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{CokernelObject}( \alpha )$,
#! three morphisms
#! $\alpha: A \rightarrow B, \nu: B \rightarrow B', \alpha': A' \rightarrow B'$,
#! and an object $r = \mathrm{CokernelObject}( \alpha' )$.
#! The output is the morphism
#! $\mathrm{CokernelObject}( \alpha ) \rightarrow \mathrm{CokernelObject}( \alpha' )$
#! given by the functoriality of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, alpha, nu, alpha_prime, r
DeclareOperation( "CokernelObjectFunctorialWithGivenCokernelObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, 
                    IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = \mathrm{CokernelObject}( \alpha )$,
#! four morphisms
#! $\alpha: A \rightarrow B, \mu: A \rightarrow A', \nu: B \rightarrow B', \alpha': A' \rightarrow B'$,
#! and an object $r = \mathrm{CokernelObject}( \alpha' )$.
#! The output is the morphism
#! $\mathrm{CokernelObject}( \alpha ) \rightarrow \mathrm{CokernelObject}( \alpha' )$
#! given by the functoriality of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, alpha, mu, nu, alpha_prime, r
DeclareOperation( "CokernelObjectFunctorialWithGivenCokernelObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism,
                    IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );


DeclareSynonym( "CokernelFunctorialWithGivenCokernelObjects", CokernelObjectFunctorialWithGivenCokernelObjects );
## FIXME:
## DeclareDeprecatedSynonym( "CokernelFunctorialWithGivenCokernelObjects", CokernelObjectFunctorialWithGivenCokernelObjects );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelObjectFunctorialWithGivenCokernelObjects</C>.
#! $F: (\mathrm{CokernelObject}( \alpha ), \alpha, \nu, \alpha', \mathrm{CokernelObject}( \alpha' )) \mapsto (\mathrm{CokernelObject}( \alpha ) \rightarrow \mathrm{CokernelObject}( \alpha' ))$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCokernelObjectFunctorialWithGivenCokernelObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernelObjectFunctorialWithGivenCokernelObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCokernelObjectFunctorialWithGivenCokernelObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCokernelObjectFunctorialWithGivenCokernelObjects",
                  [ IsCapCategory, IsList ] );

DeclareSynonym( "AddCokernelFunctorialWithGivenCokernelObjects", AddCokernelObjectFunctorialWithGivenCokernelObjects );
## FIXME:
## DeclareDeprecatedSynonym( "AddCokernelFunctorialWithGivenCokernelObjects", AddCokernelObjectFunctorialWithGivenCokernelObjects );

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
#! We denote the object $Z$ of such a triple by $\mathrm{ZeroObject}$.
#! We say that the morphisms $u_{\mathrm{in}}(A)$ and $u_{\mathrm{out}}(A)$ are induced by the
#! <Emph>universal property of the zero object</Emph>.
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
#! @Arguments A, Z
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
#! @Arguments A, Z
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

#! @Description
#! The argument is a category $C$.
#! The output is the unique morphism $\mathrm{ZeroObject} \rightarrow \mathrm{ZeroObject}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{ZeroObject}, \mathrm{ZeroObject} )$
#! @Arguments C
DeclareAttribute( "ZeroObjectFunctorial",
                  IsCapCategory );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ZeroObjectFunctorial</C>.
#! $F: () \mapsto (T \rightarrow T)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddZeroObjectFunctorial",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddZeroObjectFunctorial",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddZeroObjectFunctorial",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddZeroObjectFunctorial",
                  [ IsCapCategory, IsList ] );

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
#! We denote the object $T$ of such a pair by $\mathrm{TerminalObject}$.
#! We say that the morphism $u( A )$ is induced by the
#! <Emph>universal property of the terminal object</Emph>.
#! $\\ $
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
DeclareAttribute( "UniversalMorphismIntoTerminalObject",
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

#! @Chapter Universal Objects

####################################
##
#! @Section Initial Object
##
####################################

#! An initial object consists of two parts:
#! * an object $I$,
#! * a function $u$ mapping each object $A$ to a morphism $u( A ): I \rightarrow A$.
#! The pair $(I,u)$ is called a <Emph>initial object</Emph> if the morphisms $u(A)$ are uniquely determined up to
#! congruence of morphisms.
#! We denote the object $I$ of such a triple by $\mathrm{InitialObject}$.
#! We say that the morphism $u( A )$ is induced by the
#! <Emph>universal property of the initial object</Emph>.
#! $\\ $
#! $\mathrm{InitialObject}$ is a functorial operation. This just means:
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
DeclareAttribute( "UniversalMorphismFromInitialObject",
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

#! @Chapter Universal Objects

####################################
##
#! @Section Direct Sum
##
####################################

#! For a given list $D = (S_1, \dots, S_n)$ in an Ab-category, a direct sum consists of five parts:
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
#! * $\sum_{i=1}^{n} \iota_i \circ \pi_i \sim_{S,S} \mathrm{id}_S$,
#! * $\pi_j \circ \iota_i \sim_{S_i, S_j} \delta_{i,j}$,
#! where $\delta_{i,j} \in \mathrm{Hom}( S_i, S_j )$ is the identity if $i=j$, and $0$ otherwise.
#! The $5$-tuple $(S, \pi, \iota, u_{\mathrm{in}}, u_{\mathrm{out}})$ is called a <Emph>direct sum</Emph> of $D$.
#! We denote the object $S$ of such a $5$-tuple by $\bigoplus_{i=1}^n S_i$.
#! We say that the morphisms $u_{\mathrm{in}}(\tau), u_{\mathrm{out}}(\tau)$ are induced by the
#! <Emph>universal property of the direct sum</Emph>.
#! $\\ $
#! $\mathrm{DirectSum}$ is a functorial operation. This means:
#! For $(\mu_i: S_i \rightarrow S'_i)_{i=1\dots n}$,
#! we obtain a morphism $\bigoplus_{i=1}^n S_i \rightarrow \bigoplus_{i=1}^n S_i'$.


## Main Operations and Attributes

#! @Description
#! The argument is a list of objects $D = (S_1, \dots, S_n)$
#! and an object for method selection.
#! The output is the direct sum $\bigoplus_{i=1}^n S_i$.
#! @Returns an object
#! @Arguments D, method_selection_object
DeclareOperationWithCache( "DirectSumOp",
                           [ IsList, IsCapCategoryObject ] );

DeclareOperation( "DirectSumOp",
                  [ IsList, IsCapCategory ] );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$
#! and an integer $k$.
#! The output is the $k$-th projection
#! $\pi_k: \bigoplus_{i=1}^n S_i \rightarrow S_k$.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n S_i, S_k )$
#! @Arguments D,k
DeclareOperation( "ProjectionInFactorOfDirectSum",
                  [ IsList, IsInt ] );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$,
#! an integer $k$,
#! and an object for method selection.
#! The output is the $k$-th projection
#! $\pi_k: \bigoplus_{i=1}^n S_i \rightarrow S_k$.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n S_i, S_k )$
#! @Arguments D,k, method_selection_object
DeclareOperation( "ProjectionInFactorOfDirectSumOp",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$,
#! an integer $k$,
#! and an object $S = \bigoplus_{i=1}^n S_i$.
#! The output is the $k$-th projection
#! $\pi_k: S \rightarrow S_k$.
#! @Returns a morphism in $\mathrm{Hom}( S, S_k )$
#! @Arguments D,k,S
DeclareOperation( "ProjectionInFactorOfDirectSumWithGivenDirectSum",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$
#! and an integer $k$.
#! The output  is the $k$-th injection
#! $\iota_k: S_k \rightarrow \bigoplus_{i=1}^n S_i$.
#! @Returns a morphism in $\mathrm{Hom}( S_k, \bigoplus_{i=1}^n S_i )$
#! @Arguments D,k
DeclareOperation( "InjectionOfCofactorOfDirectSum",
                  [ IsList, IsInt ] );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$,
#! an integer $k$,
#! and an object for method selection.
#! The output  is the $k$-th injection
#! $\iota_k: S_k \rightarrow \bigoplus_{i=1}^n S_i$.
#! @Returns a morphism in $\mathrm{Hom}( S_k, \bigoplus_{i=1}^n S_i )$
#! @Arguments D,k,method_selection_object
DeclareOperation( "InjectionOfCofactorOfDirectSumOp",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$,
#! an integer $k$,
#! and an object $S = \bigoplus_{i=1}^n S_i$.
#! The output  is the $k$-th injection
#! $\iota_k: S_k \rightarrow S$.
#! @Returns a morphism in $\mathrm{Hom}( S_k, S )$
#! @Arguments D,k,S
DeclareOperation( "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! This is a convenience method.
#! There are three different ways to use this method:
#! * The arguments are a list of objects $D = (S_1, \dots, S_n)$
#!  and a list of morphisms $\tau = ( \tau_i: T \rightarrow S_i )_{i = 1 \dots n}$.
#! * The argument is a list of morphisms $\tau = ( \tau_i: T \rightarrow S_i )_{i = 1 \dots n}$.
#! * The arguments are morphisms $\tau_1: T \rightarrow S_1, \dots, \tau_n: T \rightarrow S_n$.
#! The output is the morphism
#! $u_{\mathrm{in}}(\tau): T \rightarrow \bigoplus_{i=1}^n S_i$
#! given by the universal property of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}(T, \bigoplus_{i=1}^n S_i)$
DeclareGlobalFunction( "UniversalMorphismIntoDirectSum" );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$,
#! a list of morphisms $\tau = ( \tau_i: T \rightarrow S_i )_{i = 1 \dots n}$,
#! and an object for method selection.
#! The output is the morphism
#! $u_{\mathrm{in}}(\tau): T \rightarrow \bigoplus_{i=1}^n S_i$
#! given by the universal property of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}(T, \bigoplus_{i=1}^n S_i)$
#! @Arguments D,tau,method_selection_object
DeclareOperation( "UniversalMorphismIntoDirectSumOp",
                  [ IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$,
#! a list of morphisms $\tau = ( \tau_i: T \rightarrow S_i )_{i = 1 \dots n}$,
#! and an object $S = \bigoplus_{i=1}^n S_i$.
#! The output is the morphism
#! $u_{\mathrm{in}}(\tau): T \rightarrow S$
#! given by the universal property of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}(T, S)$
#! @Arguments D,tau,S
DeclareOperation( "UniversalMorphismIntoDirectSumWithGivenDirectSum",
                  [ IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! This is a convenience method.
#! There are three different ways to use this method:
#! * The arguments are a list of objects $D = (S_1, \dots, S_n)$
#!  and a list of morphisms $\tau = ( \tau_i: S_i \rightarrow T )_{i = 1 \dots n}$.
#! * The argument is a list of morphisms $\tau = ( \tau_i: S_i \rightarrow T )_{i = 1 \dots n}$.
#! * The arguments are morphisms $S_1 \rightarrow T, \dots, S_n \rightarrow T$.
#! The output is the morphism
#! $u_{\mathrm{out}}(\tau): \bigoplus_{i=1}^n S_i \rightarrow T$
#! given by the universal property of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}(\bigoplus_{i=1}^n S_i, T)$
DeclareGlobalFunction( "UniversalMorphismFromDirectSum" );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$,
#! a list of morphisms $\tau = ( \tau_i: S_i \rightarrow T )_{i = 1 \dots n}$,
#! and an object for method selection.
#! The output is the morphism
#! $u_{\mathrm{out}}(\tau): \bigoplus_{i=1}^n S_i \rightarrow T$
#! given by the universal property of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}(\bigoplus_{i=1}^n S_i, T)$
#! @Arguments D, tau, method_selection_object
DeclareOperation( "UniversalMorphismFromDirectSumOp",
                  [ IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$,
#! a list of morphisms $\tau = ( \tau_i: S_i \rightarrow T )_{i = 1 \dots n}$,
#! and an object $S = \bigoplus_{i=1}^n S_i$.
#! The output is the morphism
#! $u_{\mathrm{out}}(\tau): S \rightarrow T$
#! given by the universal property of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}(S, T)$
#! @Arguments D, tau, S
DeclareOperation( "UniversalMorphismFromDirectSumWithGivenDirectSum",
                  [ IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The argument is a list of objects $D = (S_1, \dots, S_n)$.
#! The output is the canonical isomorphism
#! $\bigoplus_{i=1}^n S_i \rightarrow \prod_{i=1}^{n}S_i$.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n S_i, \prod_{i=1}^{n}S_i )$
#! @Arguments D
DeclareOperation( "IsomorphismFromDirectSumToDirectProduct",
                  [ IsList ] );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$
#! and an object for method selection.
#! The output is the canonical isomorphism
#! $\bigoplus_{i=1}^n S_i \rightarrow \prod_{i=1}^{n}S_i$.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n S_i, \prod_{i=1}^{n}S_i )$
#! @Arguments D, method_selection_object
DeclareOperation( "IsomorphismFromDirectSumToDirectProductOp",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The argument is a list of objects $D = (S_1, \dots, S_n)$.
#! The output is the canonical isomorphism
#! $\prod_{i=1}^{n}S_i \rightarrow \bigoplus_{i=1}^n S_i$.
#! @Returns a morphism in $\mathrm{Hom}( \prod_{i=1}^{n}S_i, \bigoplus_{i=1}^n S_i )$
#! @Arguments D
DeclareOperation( "IsomorphismFromDirectProductToDirectSum",
                  [ IsList ] );

#! @Description
#! The argument is a list of objects $D = (S_1, \dots, S_n)$
#! and an object for method selection.
#! The output is the canonical isomorphism
#! $\prod_{i=1}^{n}S_i \rightarrow \bigoplus_{i=1}^n S_i$.
#! @Returns a morphism in $\mathrm{Hom}( \prod_{i=1}^{n}S_i, \bigoplus_{i=1}^n S_i )$
#! @Arguments D, method_selection_object
DeclareOperation( "IsomorphismFromDirectProductToDirectSumOp",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The argument is a list of objects $D = (S_1, \dots, S_n)$.
#! The output is the canonical isomorphism
#! $\bigoplus_{i=1}^n S_i \rightarrow \bigsqcup_{i=1}^{n}S_i$.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n S_i, \bigsqcup_{i=1}^{n}S_i )$
#! @Arguments D
DeclareOperation( "IsomorphismFromDirectSumToCoproduct",
                  [ IsList ] );

#! @Description
#! The argument is a list of objects $D = (S_1, \dots, S_n)$
#! and an object for method selection.
#! The output is the canonical isomorphism
#! $\bigoplus_{i=1}^n S_i \rightarrow \bigsqcup_{i=1}^{n}S_i$.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n S_i, \bigsqcup_{i=1}^{n}S_i )$
#! @Arguments D, method_selection_object
DeclareOperation( "IsomorphismFromDirectSumToCoproductOp",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The argument is a list of objects $D = (S_1, \dots, S_n)$.
#! The output is the canonical isomorphism
#! $\bigsqcup_{i=1}^{n}S_i \rightarrow \bigoplus_{i=1}^n S_i$.
#! @Returns a morphism in $\mathrm{Hom}( \bigsqcup_{i=1}^{n}S_i, \bigoplus_{i=1}^n S_i )$
#! @Arguments D
DeclareOperation( "IsomorphismFromCoproductToDirectSum",
                  [ IsList ] );

#! @Description
#! The argument is a list of objects $D = (S_1, \dots, S_n)$
#! and an object for method selection.
#! The output is the canonical isomorphism
#! $\bigsqcup_{i=1}^{n}S_i \rightarrow \bigoplus_{i=1}^n S_i$.
#! @Returns a morphism in $\mathrm{Hom}( \bigsqcup_{i=1}^{n}S_i, \bigoplus_{i=1}^n S_i )$
#! @Arguments D, method_selection_object
DeclareOperation( "IsomorphismFromCoproductToDirectSumOp",
                  [ IsList, IsCapCategoryObject ] );


#! @Description
#! The argument $M = ( ( \phi_{i,j}: A_i \rightarrow B_j )_{j = 1 \dots n} )_{i = 1 \dots m}$
#! is a list of lists of morphisms.
#! @Arguments M
#! @Group MorphismBetweenDirectSums
DeclareOperation( "MorphismBetweenDirectSums",
                  [ IsList ] );

#! @Description
#! The output is the morphism
#! $\bigoplus_{i=1}^{m}A_i \rightarrow \bigoplus_{j=1}^n B_j$
#! defined by the matrix $M$.
#! The extra arguments $S = \bigoplus_{i=1}^{m}A_i$
#! and $T = \bigoplus_{j=1}^n B_j$ are source and target of the output,
#! respectively. They must be provided in case $M$ is an empty list
#! or a list of empty lists.
#! @Returns a morphism in $\mathrm{Hom}(\bigoplus_{i=1}^{m}A_i, \bigoplus_{j=1}^n B_j)$
#! @Arguments S, M, T
#! @Group MorphismBetweenDirectSums
DeclareOperation( "MorphismBetweenDirectSums",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismBetweenDirectSums</C>.
#! $F: (\bigoplus_{i=1}^{m}A_i, M, \bigoplus_{j=1}^n B_j) \mapsto (\bigoplus_{i=1}^{m}A_i \rightarrow \bigoplus_{j=1}^n B_j)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismBetweenDirectSums",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismBetweenDirectSums",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismBetweenDirectSums",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismBetweenDirectSums",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a list
#! $M = ( \phi_{1,1}, \phi_{1,2}, \dots, \phi_{1,n}, \phi_{2,1}, \dots, \phi_{m,n} )$
#! of morphisms $\phi_{i,j}: A_i \rightarrow B_j$,
#! an integer $m$,
#! an integer $n$,
#! and a method selection morphism.
#! The output is the morphism
#! $\bigoplus_{i=1}^{m}A_i \rightarrow \bigoplus_{j=1}^n B_j$
#! defined by the list $M$ regarded as a matrix of dimension $m \times n$.
#! @Returns a morphism in $\mathrm{Hom}(\bigoplus_{i=1}^{m}A_i, \bigoplus_{j=1}^n B_j)$
#! @Arguments M, m, n, method_selection_morphism
DeclareOperationWithCache( "MorphismBetweenDirectSumsOp",
                           [ IsList, IsInt, IsInt, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow S$,
#! a list $D = (S_1, \dots, S_n)$ of objects with $S = \bigoplus_{j=1}^n S_j$,
#! and an integer $k$.
#! The output is the component morphism
#! $A \rightarrow S_k$.
#! @Returns a morphism in $\mathrm{Hom}(A, S_k)$
#! @Arguments alpha, D, k
DeclareOperation( "ComponentOfMorphismIntoDirectSum",
                  [ IsCapCategoryMorphism, IsList, IsInt ] );

#! @Description
#! The arguments are a morphism $\alpha: S \rightarrow A$,
#! a list $D = (S_1, \dots, S_n)$ of objects with $S = \bigoplus_{j=1}^n S_j$,
#! and an integer $k$.
#! The output is the component morphism
#! $S_k \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(S_k, A)$
#! @Arguments alpha, D, k
DeclareOperation( "ComponentOfMorphismFromDirectSum",
                  [ IsCapCategoryMorphism, IsList, IsInt ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ComponentOfMorphismIntoDirectSum</C>.
#! $F: (\alpha: A \rightarrow S,D,k) \mapsto (A \rightarrow S_k)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddComponentOfMorphismIntoDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddComponentOfMorphismIntoDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddComponentOfMorphismIntoDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddComponentOfMorphismIntoDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ComponentOfMorphismFromDirectSum</C>.
#! $F: (\alpha: S \rightarrow A,D,k) \mapsto (S_k \rightarrow A)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddComponentOfMorphismFromDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddComponentOfMorphismFromDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddComponentOfMorphismFromDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddComponentOfMorphismFromDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ProjectionInFactorOfDirectSum</C>.
#! $F: (D,k) \mapsto \pi_{k}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddProjectionInFactorOfDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ProjectionInFactorOfDirectSumWithGivenDirectSum</C>.
#! $F: (D,k,S) \mapsto \pi_{k}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddProjectionInFactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InjectionOfCofactorOfDirectSum</C>.
#! $F: (D,k) \mapsto \iota_{k}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInjectionOfCofactorOfDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InjectionOfCofactorOfDirectSumWithGivenDirectSum</C>.
#! $F: (D,k,S) \mapsto \iota_{k}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInjectionOfCofactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoDirectSum</C>.
#! $F: (D,\tau) \mapsto u_{\mathrm{in}}(\tau)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoDirectSumWithGivenDirectSum</C>.
#! $F: (D,\tau,S) \mapsto u_{\mathrm{in}}(\tau)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromDirectSum</C>.
#! $F: (D,\tau) \mapsto u_{\mathrm{out}}(\tau)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromDirectSumWithGivenDirectSum</C>.
#! $F: (D,\tau,S) \mapsto u_{\mathrm{out}}(\tau)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromDirectSumWithGivenDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromDirectSumToDirectProduct</C>.
#! $F: D \mapsto (\bigoplus_{i=1}^n S_i \rightarrow \prod_{i=1}^{n}S_i)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromDirectSumToDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromDirectSumToDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromDirectSumToDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromDirectSumToDirectProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromDirectProductToDirectSum</C>.
#! $F: D \mapsto ( \prod_{i=1}^{n}S_i \rightarrow  \bigoplus_{i=1}^n S_i )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromDirectProductToDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromDirectProductToDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromDirectProductToDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromDirectProductToDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromDirectSumToCoproduct</C>.
#! $F: D \mapsto ( \bigoplus_{i=1}^n S_i \rightarrow \bigsqcup_{i=1}^{n}S_i )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromDirectSumToCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromDirectSumToCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromDirectSumToCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromDirectSumToCoproduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromCoproductToDirectSum</C>.
#! $F: D \mapsto ( \bigsqcup_{i=1}^{n}S_i \rightarrow  \bigoplus_{i=1}^n S_i )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromCoproductToDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromCoproductToDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoproductToDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoproductToDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DirectSum</C>.
#! $F: D \mapsto \bigoplus_{i=1}^n S_i$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectSum",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a list of morphisms $L = ( \mu_1: S_1 \rightarrow S_1', \dots, \mu_n: S_n \rightarrow S_n' )$.
#! The output is a morphism
#! $\bigoplus_{i=1}^n S_i \rightarrow \bigoplus_{i=1}^n S_i'$
#! given by the functoriality of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n S_i, \bigoplus_{i=1}^n S_i' )$
#! @Arguments L
DeclareOperation( "DirectSumFunctorial",
                  [ IsList ] );

#! @Description
#! The arguments are an object $d_1 = \bigoplus_{i=1}^n S_i$,
#! a list of morphisms $L = ( \mu_1: S_1 \rightarrow S_1', \dots, \mu_n: S_n \rightarrow S_n' )$,
#! and an object $d_2 = \bigoplus_{i=1}^n S_i'$.
#! The output is a morphism
#! $d_1 \rightarrow d_2$
#! given by the functoriality of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}( d_1, d_2 )$
#! @Arguments d_1, L, d_2
DeclareOperation( "DirectSumFunctorialWithGivenDirectSums",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DirectSumFunctorialWithGivenDirectSums</C>.
#! $F: (\bigoplus_{i=1}^n S_i, ( \mu_1, \dots, \mu_n ), \bigoplus_{i=1}^n S_i') \mapsto (\bigoplus_{i=1}^n S_i \rightarrow \bigoplus_{i=1}^n S_i')$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDirectSumFunctorialWithGivenDirectSums",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDirectSumFunctorialWithGivenDirectSums",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDirectSumFunctorialWithGivenDirectSums",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectSumFunctorialWithGivenDirectSums",
                  [ IsCapCategory, IsList ] );

#! @Chapter Technical Details

#! @Section Universal Objects

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
#! We denote the object $I$ of such a triple by $\bigsqcup_{i=1}^n I_i$.
#! We say that the morphism $u( \tau )$ is induced by the
#! <Emph>universal property of the coproduct</Emph>.
#! $\\ $
#! $\mathrm{Coproduct}$ is a functorial operation. This means:
#! For $(\mu_i: I_i \rightarrow I'_i)_{i=1\dots n}$,
#! we obtain a morphism $\bigsqcup_{i=1}^n I_i \rightarrow \bigsqcup_{i=1}^n I_i'$.



## Main Operations and Attributes

#! @Description
#! The argument is a list of objects $D = ( I_1, \dots, I_n )$.
#! The output is the coproduct $\bigsqcup_{i=1}^n I_i$.
#! @Returns an object
#! @Arguments D
DeclareAttribute( "Coproduct",
                  IsList );

#! @Description
#! This is a convenience method.
#! The arguments are two objects $I_1, I_2$.
#! The output is the coproduct $I_1 \bigsqcup I_2$.
#! @Returns an object
#! @Arguments I1, I2
DeclareOperation( "Coproduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a convenience method.
#! The arguments are three objects $I_1, I_2, I_3$.
#! The output is the coproduct $I_1 \bigsqcup I_2 \bigsqcup I_3$.
#! @Returns an object
#! @Arguments I1, I2
DeclareOperation( "Coproduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );



#! @Description
#! The arguments are a list of objects $D = ( I_1, \dots, I_n )$
#! and a method selection object.
#! The output is the coproduct $\bigsqcup_{i=1}^n I_i$.
#! @Returns an object
#! @Arguments D, method_selection_object
DeclareOperationWithCache( "CoproductOp",
                           [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = ( I_1, \dots, I_n )$
#! and an integer $k$.
#! The output is the $k$-th injection
#! $\iota_k: I_k \rightarrow \bigsqcup_{i=1}^n I_i$.
#! @Returns a morphism in $\mathrm{Hom}(I_k, \bigsqcup_{i=1}^n I_i)$
#! @Arguments D,k
DeclareOperation( "InjectionOfCofactorOfCoproduct",
                  [ IsList, IsInt ] );

#! @Description
#! The arguments are a list of objects $D = ( I_1, \dots, I_n )$,
#! an integer $k$,
#! and a method selection object.
#! The output is the $k$-th injection
#! $\iota_k: I_k \rightarrow \bigsqcup_{i=1}^n I_i$.
#! @Returns a morphism in $\mathrm{Hom}(I_k, \bigsqcup_{i=1}^n I_i)$
#! @Arguments D,k,method_selection_object
DeclareOperation( "InjectionOfCofactorOfCoproductOp",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = ( I_1, \dots, I_n )$,
#! an integer $k$,
#! and an object $I = \bigsqcup_{i=1}^n I_i$.
#! The output is the $k$-th injection
#! $\iota_k: I_k \rightarrow I$.
#! @Returns a morphism in $\mathrm{Hom}(I_k, I)$
#! @Arguments D,k,I
DeclareOperation( "InjectionOfCofactorOfCoproductWithGivenCoproduct",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! This is a convenience method.
#! There are three different ways to use this method.
#! * The arguments are a list of objects $D = ( I_1, \dots, I_n )$,
#!  a list of morphisms $\tau = ( \tau_i: I_i \rightarrow T )$.
#! * The argument is a list of morphisms $\tau = ( \tau_i: I_i \rightarrow T )$.
#! * The arguments are morphisms $\tau_1: I_1 \rightarrow T, \dots, \tau_n: I_n \rightarrow T$
#! The output is the morphism
#! $u( \tau ): \bigsqcup_{i=1}^n I_i \rightarrow T$
#! given by the universal property of the coproduct.
#! @Returns a morphism in $\mathrm{Hom}(\bigsqcup_{i=1}^n I_i, T)$
DeclareGlobalFunction( "UniversalMorphismFromCoproduct" );

#! @Description
#! The arguments are a list of objects $D = ( I_1, \dots, I_n )$,
#! a list of morphisms $\tau = ( \tau_i: I_i \rightarrow T )$,
#! and a method selection object.
#! The output is the morphism
#! $u( \tau ): \bigsqcup_{i=1}^n I_i \rightarrow T$
#! given by the universal property of the coproduct.
#! @Returns a morphism in $\mathrm{Hom}(\bigsqcup_{i=1}^n I_i, T)$
#! @Arguments D, tau, method_selection_object
DeclareOperation( "UniversalMorphismFromCoproductOp",
                  [ IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = ( I_1, \dots, I_n )$,
#! a list of morphisms $\tau = ( \tau_i: I_i \rightarrow T )$,
#! and an object $I = \bigsqcup_{i=1}^n I_i$.
#! The output is the morphism
#! $u( \tau ): I \rightarrow T$
#! given by the universal property of the coproduct.
#! @Returns a morphism in $\mathrm{Hom}(I, T)$
#! @Arguments D, tau, I
DeclareOperation( "UniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsList, IsList, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>Coproduct</C>.
#! $F: ( (I_1, \dots, I_n) ) \mapsto I$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoproduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InjectionOfCofactorOfCoproduct</C>.
#! $F: ( (I_1, \dots, I_n), i ) \mapsto \iota_i$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInjectionOfCofactorOfCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfCoproduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InjectionOfCofactorOfCoproductWithGivenCoproduct</C>.
#! $F: ( (I_1, \dots, I_n), i, I ) \mapsto \iota_i$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInjectionOfCofactorOfCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromCoproduct</C>.
#! $F: ( (I_1, \dots, I_n), \tau ) \mapsto u( \tau )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromCoproduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromCoproductWithGivenCoproduct</C>.
#! $F: ( (I_1, \dots, I_n), \tau, I ) \mapsto u( \tau )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a list $L = ( \mu_1: I_1 \rightarrow I_1', \dots, \mu_n: I_n \rightarrow I_n' )$.
#! The output is a morphism
#! $\bigsqcup_{i=1}^n I_i \rightarrow \bigsqcup_{i=1}^n I_i'$
#! given by the functoriality of the coproduct.
#! @Returns a morphism in $\mathrm{Hom}(\bigsqcup_{i=1}^n I_i, \bigsqcup_{i=1}^n I_i')$
#! @Arguments L
DeclareOperation( "CoproductFunctorial",
                  [ IsList ] );

#! @Description
#! The arguments are an object $s = \bigsqcup_{i=1}^n I_i$, 
#! a list $L = ( \mu_1: I_1 \rightarrow I_1', \dots, \mu_n: I_n \rightarrow I_n' )$,
#! and an object $r = \bigsqcup_{i=1}^n I_i'$.
#! The output is a morphism
#! $\bigsqcup_{i=1}^n I_i \rightarrow \bigsqcup_{i=1}^n I_i'$
#! given by the functoriality of the coproduct.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, L, r
DeclareOperation( "CoproductFunctorialWithGivenCoproducts",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoproductFunctorialWithGivenCoproducts</C>.
#! $F: (\bigsqcup_{i=1}^n I_i, (\mu_1, \dots, \mu_n), \bigsqcup_{i=1}^n I_i') \rightarrow (\bigsqcup_{i=1}^n I_i \rightarrow \bigsqcup_{i=1}^n I_i')$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoproductFunctorialWithGivenCoproducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoproductFunctorialWithGivenCoproducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoproductFunctorialWithGivenCoproducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoproductFunctorialWithGivenCoproducts",
                  [ IsCapCategory, IsList ] );

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
#! We denote the object $P$ of such a triple by $\prod_{i=1}^n P_i$.
#! We say that the morphism $u( \tau )$ is induced by the
#! <Emph>universal property of the direct product</Emph>.
#! $\\ $
#! $\mathrm{DirectProduct}$ is a functorial operation. This means:
#! For $(\mu_i: P_i \rightarrow P'_i)_{i=1\dots n}$,
#! we obtain a morphism $\prod_{i=1}^n P_i \rightarrow \prod_{i=1}^n P_i'$.


## Main Operations and Attributes
#! @Description
#! The arguments are a list of objects $D = ( P_1, \dots, P_n )$
#! and an object for method selection.
#! The output is the direct product $\prod_{i=1}^n P_i$.
#! @Returns an object
#! @Arguments D
DeclareOperationWithCache( "DirectProductOp",
                           [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = ( P_1, \dots, P_n )$
#! and an integer $k$.
#! The output is the $k$-th projection
#! $\pi_k: \prod_{i=1}^n P_i \rightarrow P_k$.
#! @Returns a morphism in $\mathrm{Hom}(\prod_{i=1}^n P_i, P_k)$
#! @Arguments D,k
DeclareOperation( "ProjectionInFactorOfDirectProduct",
                  [ IsList, IsInt ] );

#! @Description
#! The arguments are a list of objects $D = ( P_1, \dots, P_n )$,
#! an integer $k$,
#! and an object for method selection.
#! The output is the $k$-th projection
#! $\pi_k: \prod_{i=1}^n P_i \rightarrow P_k$.
#! @Returns a morphism in $\mathrm{Hom}(\prod_{i=1}^n P_i, P_k)$
#! @Arguments D,k,method_selection_object
DeclareOperation( "ProjectionInFactorOfDirectProductOp",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = ( P_1, \dots, P_n )$,
#! an integer $k$,
#! and an object $P = \prod_{i=1}^n P_i$.
#! The output is the $k$-th projection
#! $\pi_k: P \rightarrow P_k$.
#! @Returns a morphism in $\mathrm{Hom}(P, P_k)$
#! @Arguments D,k,P
DeclareOperation( "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! This is a convenience method.
#! There are three different ways to use this method.
#! * The arguments are a list of objects $D = ( P_1, \dots, P_n )$
#!  and a list of morphisms $\tau = ( \tau_i: T \rightarrow P_i )_{i = 1, \dots, n}$.
#! * The argument is a list of morphisms $\tau = ( \tau_i: T \rightarrow P_i )_{i = 1, \dots, n}$.
#! * The arguments are morphisms $\tau_1: T \rightarrow P_1, \dots, \tau_n: T \rightarrow P_n$.
#! The output is the morphism
#! $u(\tau): T \rightarrow \prod_{i=1}^n P_i$
#! given by the universal property of the direct product.
#! @Returns a morphism in $\mathrm{Hom}(T, \prod_{i=1}^n P_i)$
DeclareGlobalFunction( "UniversalMorphismIntoDirectProduct" );


#! @Description
#! The arguments are a list of objects $D = ( P_1, \dots, P_n )$,
#! a list of morphisms $\tau = ( \tau_i: T \rightarrow P_i )_{i = 1, \dots, n}$,
#! and an object for method selection.
#! The output is the morphism
#! $u(\tau): T \rightarrow \prod_{i=1}^n P_i$
#! given by the universal property of the direct product.
#! @Returns a morphism in $\mathrm{Hom}(T, \prod_{i=1}^n P_i)$
#! @Arguments D, tau, method_selection_object
DeclareOperation( "UniversalMorphismIntoDirectProductOp",
                  [ IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = ( P_1, \dots, P_n )$,
#! a list of morphisms $\tau = ( \tau_i: T \rightarrow P_i )_{i = 1, \dots, n}$,
#! and an object $P = \prod_{i=1}^n P_i$.
#! The output is the morphism
#! $u(\tau): T \rightarrow \prod_{i=1}^n P_i$
#! given by the universal property of the direct product.
#! @Returns a morphism in $\mathrm{Hom}(T, \prod_{i=1}^n P_i)$
#! @Arguments D, tau, P
DeclareOperation( "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsList, IsList, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DirectProduct</C>.
#! $F: ( (P_1, \dots, P_n) ) \mapsto P$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ProjectionInFactorOfDirectProduct</C>.
#! $F: ( (P_1, \dots, P_n),k ) \mapsto \pi_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddProjectionInFactorOfDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ProjectionInFactorOfDirectProductWithGivenDirectProduct</C>.
#! $F: ( (P_1, \dots, P_n),k,P ) \mapsto \pi_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddProjectionInFactorOfDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoDirectProduct</C>.
#! $F: ( (P_1, \dots, P_n), \tau ) \mapsto u( \tau )$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectProduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoDirectProductWithGivenDirectProduct</C>.
#! $F: ( (P_1, \dots, P_n), \tau, P ) \mapsto u( \tau )$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a list of morphisms $L = (\mu_i: P_i \rightarrow P'_i)_{i=1\dots n}$.
#! The output is a morphism
#! $\prod_{i=1}^n P_i \rightarrow \prod_{i=1}^n P_i'$
#! given by the functoriality of the direct product.
#! @Returns a morphism in $\mathrm{Hom}( \prod_{i=1}^n P_i, \prod_{i=1}^n P_i' )$
#! @Arguments L
DeclareOperation( "DirectProductFunctorial",
                  [ IsList ] );

#! @Description
#! The arguments are an object $s = \prod_{i=1}^n P_i$,
#! a list of morphisms $L = (\mu_i: P_i \rightarrow P'_i)_{i=1\dots n}$,
#! and an object $r = \prod_{i=1}^n P_i'$.
#! The output is a morphism
#! $\prod_{i=1}^n P_i \rightarrow \prod_{i=1}^n P_i'$
#! given by the functoriality of the direct product.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, L, r
DeclareOperation( "DirectProductFunctorialWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DirectProductFunctorialWithGivenDirectProducts</C>.
#! $F: ( \prod_{i=1}^n P_i, (\mu_i: P_i \rightarrow P'_i)_{i=1\dots n}, \prod_{i=1}^n P_i' ) \mapsto (\prod_{i=1}^n P_i \rightarrow \prod_{i=1}^n P_i')$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDirectProductFunctorialWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDirectProductFunctorialWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDirectProductFunctorialWithGivenDirectProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectProductFunctorialWithGivenDirectProducts",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are an object $s = a \times (b \times c)$,
#! three objects $a,b,c$,
#! and an object $r = (a \times b) \times c$.
#! The output is the associator $\alpha_{a,(b,c)}: a \times (b \times c) \rightarrow (a \times b) \times c$.
#! @Returns a morphism in $\mathrm{Hom}( a \times (b \times c), (a \times b) \times c )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "AssociatorRightToLeftOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>AssociatorRightToLeftOfDirectProductsWithGivenDirectProducts</C>.
#! $F: ( a \times (b \times c), a, b, c, (a \times b) \times c ) \mapsto \alpha_{a,(b,c)}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAssociatorRightToLeftOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAssociatorRightToLeftOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAssociatorRightToLeftOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAssociatorRightToLeftOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are an object $s = (a \times b) \times c$,
#! three objects $a,b,c$,
#! and an object $r = a \times (b \times c)$.
#! The output is the associator $\alpha_{(a,b),c}: (a \times b) \times c \rightarrow a \times (b \times c)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \times b) \times c \rightarrow a \times (b \times c) )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "AssociatorLeftToRightOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>AssociatorLeftToRightOfDirectProductsWithGivenDirectProducts</C>.
#! $F: (( a \times b ) \times c, a, b, c, a \times (b \times c )) \mapsto \alpha_{(a,b),c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAssociatorLeftToRightOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAssociatorLeftToRightOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAssociatorLeftToRightOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAssociatorLeftToRightOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsList ] );


#! @Chapter Universal Objects

####################################
##
#! @Section Equalizer
##
####################################

#! For a given list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$,
#! an equalizer of $D$ consists of three parts:
#! * an object $E$,
#! * a morphism $\iota: E \rightarrow A $ such that
#!  $\beta_i \circ \iota  \sim_{E, B} \beta_j \circ \iota$ for all pairs $i,j$.
#! * a dependent function $u$ mapping each morphism
#!  $\tau = ( \tau: T \rightarrow A )$ such that
#!  $\beta_i \circ \tau  \sim_{T, B} \beta_j \circ \tau$ for all pairs $i,j$
#!  to a morphism $u( \tau ): T \rightarrow E$ such that
#!  $\iota \circ u( \tau ) \sim_{T, A} \tau$.
#! The triple $( E, \iota, u )$ is called an <Emph>equalizer</Emph> of $D$ if the morphisms $u( \tau )$ are uniquely determined up to
#! congruence of morphisms.
#! We denote the object $E$ of such a triple by $\mathrm{Equalizer}(D)$.
#! We say that the morphism $u( \tau )$ is induced by the
#! <Emph>universal property of the equalizer</Emph>.
#! $\\ $
#! $\mathrm{Equalizer}$ is a functorial operation. This means:
#! For a second diagram $D' = (\beta_i': A' \rightarrow B')_{i = 1 \dots n}$ and a natural morphism
#! between equalizer diagrams (i.e., a collection of morphisms
#! $\mu: A \rightarrow A'$ and $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \mu \sim_{A,B'} \beta \circ \beta_i$ for $i = 1, \dots, n$)
#! we obtain a morphism $\mathrm{Equalizer}( D ) \rightarrow \mathrm{Equalizer}( D' )$.

## Main Operations and Attributes

#! @Description
#! This is a convenience method.
#! There are two different ways to use this method:
#! * The argument is a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$.
#! * The arguments are morphisms $\beta_1: A \rightarrow B, \dots, \beta_n: A \rightarrow B$.
#! The output is the equalizer $\mathrm{Equalizer}(D)$.
#! @Returns an object
DeclareGlobalFunction( "Equalizer" );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is the equalizer $\mathrm{Equalizer}(D)$.
#! @Returns an object
#! @Arguments D, method_selection_morphism
DeclareOperationWithCache( "EqualizerOp",
                           [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$.
#! The output is the equalizer embedding
#! $\iota: \mathrm{Equalizer}(D) \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Equalizer}(D), A )$
#! @Arguments D
DeclareOperation( "EmbeddingOfEqualizer",
                  [ IsList ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$.
#! and a morphism for method selection.
#! The output is the equalizer embedding
#! $\iota: \mathrm{Equalizer}(D) \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Equalizer}(D), A )$
#! @Arguments D,method_selection_morphism
DeclareOperation( "EmbeddingOfEqualizerOp",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$,
#! and an object $E = \mathrm{Equalizer}(D)$.
#! The output is the equalizer embedding
#! $\iota: E \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}( E, A )$
#! @Arguments D,E
DeclareOperation( "EmbeddingOfEqualizerWithGivenEqualizer",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$
#! and a morphism $ \tau: T \rightarrow A $
#! such that $\beta_i \circ \tau  \sim_{T, B} \beta_j \circ \tau$ for all pairs $i,j$.
#! The output is the morphism
#! $u( \tau ): T \rightarrow \mathrm{Equalizer}(D)$
#! given by the universal property of the equalizer.
#! @Returns a morphism in $\mathrm{Hom}( T, \mathrm{Equalizer}(D) )$
#! @Arguments D, tau
DeclareOperation( "UniversalMorphismIntoEqualizer",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$,
#! a morphism $\tau: T \rightarrow A )$
#! such that $\beta_i \circ \tau  \sim_{T, B} \beta_j \circ \tau$ for all pairs $i,j$,
#! and an object $E = \mathrm{Equalizer}(D)$.
#! The output is the morphism
#! $u( \tau ): T \rightarrow E$
#! given by the universal property of the equalizer.
#! @Returns a morphism in $\mathrm{Hom}( T, E )$
#! @Arguments D, tau, E
DeclareOperation( "UniversalMorphismIntoEqualizerWithGivenEqualizer",
                  [ IsList, IsCapCategoryMorphism, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>Equalizer</C>.
#! $F: ( (\beta_i: A \rightarrow B)_{i = 1 \dots n} ) \mapsto E$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddEqualizer",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEqualizer",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEqualizer",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEqualizer",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>EmbeddingOfEqualizer</C>.
#! $F: ( (\beta_i: A \rightarrow B)_{i = 1 \dots n}, k ) \mapsto \iota$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddEmbeddingOfEqualizer",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEmbeddingOfEqualizer",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEmbeddingOfEqualizer",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEmbeddingOfEqualizer",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>EmbeddingOfEqualizerWithGivenEqualizer</C>.
#! $F: ( (\beta_i: A \rightarrow B)_{i = 1 \dots n},E ) \mapsto \iota$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddEmbeddingOfEqualizerWithGivenEqualizer",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEmbeddingOfEqualizerWithGivenEqualizer",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEmbeddingOfEqualizerWithGivenEqualizer",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEmbeddingOfEqualizerWithGivenEqualizer",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoEqualizer</C>.
#! $F: ( (\beta_i: A \rightarrow B)_{i = 1 \dots n}, \tau  ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoEqualizer",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoEqualizer",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoEqualizer",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoEqualizer",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoEqualizerWithGivenEqualizer</C>.
#! $F: ( (\beta_i: A \rightarrow B)_{i = 1 \dots n}, \tau, E  ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoEqualizerWithGivenEqualizer",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoEqualizerWithGivenEqualizer",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoEqualizerWithGivenEqualizer",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoEqualizerWithGivenEqualizer",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a triple
#! $L = ( (\beta_i: A \rightarrow B)_{i = 1 \dots n}, \mu: A \rightarrow A', (\beta_i': A' \rightarrow B')_{i = 1 \dots n} )$
#! with morphisms $\beta_i$, $\mu$ and $\beta_i'$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \mu \sim_{A,B'} \beta \circ \beta_i$ for $i = 1, \dots, n$.
#! The output is the morphism
#! $\mathrm{Equalizer}( ( \beta_i )_{i=1 \dots n} ) \rightarrow \mathrm{Equalizer}( ( \beta_i' )_{i=1 \dots n} )$
#! given by the functorality of the equalizer.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Equalizer}( ( \beta_i )_{i=1 \dots n} ), \mathrm{Equalizer}( ( \beta_i' )_{i=1 \dots n} ))$
#! @Arguments L
DeclareOperation( "EqualizerFunctorial",
                  [ IsList ] );

#! @Description
#! The arguments are an object $s = \mathrm{Equalizer}( ( \beta_i )_{i=1 \dots n} )$,
#! a triple
#! $L = ( (\beta_i: A \rightarrow B)_{i = 1 \dots n}, \mu: A \rightarrow A', (\beta_i': A' \rightarrow B')_{i = 1 \dots n} )$
#! with morphisms $\beta_i$, $\mu$ and $\beta_i'$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \mu \sim_{A,B'} \beta \circ \beta_i$ for $i = 1, \dots, n$,
#! and an object $r = \mathrm{Equalizer}( ( \beta_i' )_{i=1 \dots n} )$.
#! The output is the morphism
#! $s \rightarrow r$
#! given by the functorality of the equalizer.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, L, r
DeclareOperation( "EqualizerFunctorialWithGivenEqualizers",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>EqualizerFunctorialWithGivenEqualizers</C>.
#! $F: ( \mathrm{Equalizer}( ( \beta_i )_{i=1 \dots n} ), ( ( \beta_i: A \rightarrow B )_{i = 1 \dots n}, \mu: A \rightarrow A', ( \beta_i': A' \rightarrow B' )_{i = 1 \dots n} ), \mathrm{Equalizer}( ( \beta_i' )_{i=1 \dots n} ) ) \mapsto (\mathrm{Equalizer}( ( \beta_i )_{i=1 \dots n} ) \rightarrow \mathrm {Equalizer}( ( \beta_i' )_{i=1 \dots n} ) )$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddEqualizerFunctorialWithGivenEqualizers",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEqualizerFunctorialWithGivenEqualizers",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEqualizerFunctorialWithGivenEqualizers",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEqualizerFunctorialWithGivenEqualizers",
                  [ IsCapCategory, IsList ] );

#! @Chapter Universal Objects

####################################
##
#! @Section Coequalizer
##
####################################

#! For a given list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$,
#! a coequalizer of $D$ consists of three parts:
#! * an object $C$,
#! * a morphism $\pi: A \rightarrow C $ such that
#!  $\pi \circ \beta_i \sim_{B,C} \pi \circ \beta_j$ for all pairs $i,j$,
#! * a dependent function $u$ mapping the morphism
#!  $\tau: A \rightarrow T $ such that
#!  $\tau \circ \beta_i \sim_{B,T} \tau \circ \beta_j$
#!  to a morphism $u( \tau ): C \rightarrow T$ such that
#!  $u( \tau ) \circ \pi \sim_{A, T} \tau$.
#! The triple $( C, \pi, u )$ is called a <Emph>coequalizer</Emph> of $D$ if the morphisms $u( \tau )$ are uniquely determined up to
#! congruence of morphisms.
#! We denote the object $C$ of such a triple by $\mathrm{Coequalizer}(D)$.
#! We say that the morphism $u( \tau )$ is induced by the
#! <Emph>universal property of the coequalizer</Emph>.
#! $\\ $
#! $\mathrm{Coequalizer}$ is a functorial operation. This means:
#! For a second diagram $D' = (\beta_i': B' \rightarrow A')_{i = 1 \dots n}$ and a natural morphism
#! between coequalizer diagrams (i.e., a collection of morphisms
#! $\mu: A \rightarrow A'$ and $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \beta \sim_{B, A'} \mu \circ \beta_i$ for $i = 1, \dots n$)
#! we obtain a morphism $\mathrm{Coequalizer}( D ) \rightarrow \mathrm{Coequalizer}( D' )$.

## Main Operations and Attributes


#! @Description
#! This is a convenience method.
#! There are two different ways to use this method:
#! * The argument is a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$.
#! * The arguments are morphisms $\beta_1: B \rightarrow A, \dots, \beta_n: B \rightarrow A$.
#! The output is the coequalizer $\mathrm{Coequalizer}(D)$.
#! @Returns an object
DeclareGlobalFunction( "Coequalizer" );


#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is the coequalizer $\mathrm{Coequalizer}(D)$.
#! @Returns an object
#! @Arguments D, method_selection_morphism
DeclareOperationWithCache( "CoequalizerOp",
                           [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$.
#! The output is the projection
#! $\pi: A \rightarrow \mathrm{Coequalizer}( D )$.
#! @Returns a morphism in $\mathrm{Hom}( A, \mathrm{Coequalizer}( D ) )$.
#! @Arguments D
DeclareOperation( "ProjectionOntoCoequalizer",
                  [ IsList ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$,
#! and a morphism for method selection.
#! The output is the projection
#! $\pi: A \rightarrow \mathrm{Coequalizer}( D )$.
#! @Returns a morphism in $\mathrm{Hom}( A, \mathrm{Coequalizer}( D ) )$.
#! @Arguments D,method_selection_morphism
DeclareOperation( "ProjectionOntoCoequalizerOp",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$,
#! and an object $C = \mathrm{Coequalizer}(D)$.
#! The output is the projection
#! $\pi: A \rightarrow C$.
#! @Returns a morphism in $\mathrm{Hom}( A, C )$.
#! @Arguments D,C
DeclareOperation( "ProjectionOntoCoequalizerWithGivenCoequalizer",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$
#! and a morphism $\tau: A \rightarrow T $ such that
#! $\tau \circ \beta_i \sim_{B,T} \tau \circ \beta_j$ for all pairs $i,j$.
#! The output is the morphism
#! $u( \tau ): \mathrm{Coequalizer}(D) \rightarrow T$
#! given by the universal property of the coequalizer.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coequalizer}(D), T )$
#! @Arguments D, tau
DeclareOperation( "UniversalMorphismFromCoequalizer",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$,
#! a morphism $\tau: A \rightarrow T $ such that
#! $\tau \circ \beta_i \sim_{B,T} \tau \circ \beta_j$,
#! and an object $C = \mathrm{Coequalizer}(D)$.
#! The output is the morphism
#! $u( \tau ): C \rightarrow T$
#! given by the universal property of the coequalizer.
#! @Returns a morphism in $\mathrm{Hom}( C, T )$
#! @Arguments D, tau, C
DeclareOperation( "UniversalMorphismFromCoequalizerWithGivenCoequalizer",
                  [ IsList, IsCapCategoryMorphism, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>Coequalizer</C>.
#! $F: ( (\beta_i: B \rightarrow A)_{i = 1 \dots n} ) \mapsto C$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoequalizer",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoequalizer",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoequalizer",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoequalizer",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ProjectionOntoCoequalizer</C>.
#! $F: ( (\beta_i: B \rightarrow A)_{i = 1 \dots n}, k ) \mapsto \pi$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddProjectionOntoCoequalizer",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionOntoCoequalizer",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionOntoCoequalizer",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionOntoCoequalizer",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ProjectionOntoCoequalizerWithGivenCoequalizer</C>.
#! $F: ( (\beta_i: B \rightarrow A)_{i = 1 \dots n}, C) \mapsto \pi$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddProjectionOntoCoequalizerWithGivenCoequalizer",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionOntoCoequalizerWithGivenCoequalizer",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionOntoCoequalizerWithGivenCoequalizer",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionOntoCoequalizerWithGivenCoequalizer",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromCoequalizer</C>.
#! $F: ( (\beta_i: B \rightarrow A)_{i = 1 \dots n}, \tau ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromCoequalizer",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromCoequalizer",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromCoequalizer",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromCoequalizer",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromCoequalizerWithGivenCoequalizer</C>.
#! $F: ( (\beta_i: B \rightarrow A)_{i = 1 \dots n}, \tau, C ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromCoequalizerWithGivenCoequalizer",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromCoequalizerWithGivenCoequalizer",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromCoequalizerWithGivenCoequalizer",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromCoequalizerWithGivenCoequalizer",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The argument is a triple
#! $L = ( ( \beta_i: B \rightarrow A)_{i = 1 \dots n}, \mu: A \rightarrow A', ( \beta_i': B' \rightarrow A' )_{i = 1 \dots n} )$
#! with morphisms $\beta_i$, $\mu$ and $\beta_i'$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \beta \sim_{B, A'} \mu \circ \beta_i$ for $i = 1, \dots n$.
#! The output is the morphism
#! $\mathrm{Coequalizer}( ( \beta_i )_{i=1}^n ) \rightarrow \mathrm{Coequalizer}( ( \beta_i' )_{i=1}^n )$
#! given by the functorality of the coequalizer.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Coequalizer}( ( \beta_i )_{i=1 \dots n} ), \mathrm{Coequalizer}( ( \beta_i' )_{i=1 \dots n} ))$
#! @Arguments L
DeclareOperation( "CoequalizerFunctorial",
                  [ IsList ] );

#! @Description
#! The arguments are an object $s = \mathrm{Coequalizer}( ( \beta_i )_{i=1}^n )$,
#! a triple
#! $L = ( ( \beta_i: B \rightarrow A )_{i = 1 \dots n}, \mu: A \rightarrow A', ( \beta_i': B' \rightarrow A' )_{i = 1 \dots n} )$
#! with morphisms $\beta_i$, $\mu$ and $\beta_i'$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \beta \sim_{B, A'} \mu \circ \beta_i$ for $i = 1, \dots n$,
#! and an object $r = \mathrm{Coequalizer}( ( \beta_i' )_{i=1}^n )$.
#! The output is the morphism
#! $s \rightarrow r$
#! given by the functorality of the coequalizer.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, L, r
DeclareOperation( "CoequalizerFunctorialWithGivenCoequalizers",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoequalizerFunctorialWithGivenCoequalizers</C>.
#! $F: ( \mathrm{Coequalizer}( ( \beta_i )_{i=1}^n ), ( ( \beta_i: B \rightarrow A )_{i = 1 \dots n}, \mu: A \rightarrow A', ( \beta_i': B' \rightarrow A' )_{i = 1 \dots n} ), \mathrm{Coequalizer}( ( \beta_i' )_{i=1}^n ) ) \mapsto (\mathrm{Coequalizer}( ( \beta_i )_{i=1}^n ) \rightarrow \mathrm{Coequalizer}( ( \beta_i' )_{i=1}^n ) )$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoequalizerFunctorialWithGivenCoequalizers",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoequalizerFunctorialWithGivenCoequalizers",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoequalizerFunctorialWithGivenCoequalizers",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoequalizerFunctorialWithGivenCoequalizers",
                  [ IsCapCategory, IsList ] );

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
#!  $\beta_i \circ \tau_i  \sim_{T, B} \beta_j \circ \tau_j$ for all pairs $i,j$
#!  to a morphism $u( \tau ): T \rightarrow P$ such that
#!  $\pi_i \circ u( \tau ) \sim_{T, P_i} \tau_i$ for all $i = 1, \dots, n$.
#! The triple $( P, \pi, u )$ is called a <Emph>fiber product</Emph> of $D$ if the morphisms $u( \tau )$ are uniquely determined up to
#! congruence of morphisms.
#! We denote the object $P$ of such a triple by $\mathrm{FiberProduct}(D)$.
#! We say that the morphism $u( \tau )$ is induced by the
#! <Emph>universal property of the fiber product</Emph>.
#! $\\ $
#! $\mathrm{FiberProduct}$ is a functorial operation. This means:
#! For a second diagram $D' = (\beta_i': P_i' \rightarrow B')_{i = 1 \dots n}$ and a natural morphism
#! between pullback diagrams (i.e., a collection of morphisms
#! $(\mu_i: P_i \rightarrow P'_i)_{i=1\dots n}$ and $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \mu_i \sim_{P_i,B'} \beta \circ \beta_i$ for $i = 1, \dots, n$)
#! we obtain a morphism $\mathrm{FiberProduct}( D ) \rightarrow \mathrm{FiberProduct}( D' )$.

## Main Operations and Attributes


#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\mathrm{FiberProduct}(D) \rightarrow \Delta$,
#! where $\Delta$ denotes the kernel object equalizing the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{FiberProduct}(D), \Delta)$
#! @Arguments D
DeclareOperation( "IsomorphismFromFiberProductToKernelOfDiagonalDifference",
                  [ IsList ] );
#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is a morphism
#! $\mathrm{FiberProduct}(D) \rightarrow \Delta$,
#! where $\Delta$ denotes the kernel object equalizing the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{FiberProduct}(D), \Delta)$
#! @Arguments D, method_selection_morphism
DeclareOperation( "IsomorphismFromFiberProductToKernelOfDiagonalDifferenceOp",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromFiberProductToKernelOfDiagonalDifference</C>.
#! $F: ( ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n} ) \mapsto \mathrm{FiberProduct}(D) \rightarrow \Delta$
#! @Returns nothing
#! @Arguments C, F
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

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\Delta \rightarrow \mathrm{FiberProduct}(D)$,
#! where $\Delta$ denotes the kernel object equalizing the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\Delta, \mathrm{FiberProduct}(D))$
#! @Arguments D
DeclareOperation( "IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct",
                  [ IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is a morphism
#! $\Delta \rightarrow \mathrm{FiberProduct}(D)$,
#! where $\Delta$ denotes the kernel object equalizing the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\Delta, \mathrm{FiberProduct}(D))$
#! @Arguments D
DeclareOperation( "IsomorphismFromKernelOfDiagonalDifferenceToFiberProductOp",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct</C>.
#! $F: ( ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n} ) \mapsto \Delta \rightarrow \mathrm{FiberProduct}(D)$
#! @Returns nothing
#! @Arguments C, F
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

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\mathrm{FiberProduct}(D) \rightarrow \Delta$,
#! where $\Delta$ denotes the equalizer of the product diagram of the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{FiberProduct}(D), \Delta)$
#! @Arguments D
DeclareOperation( "IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram",
                  [ IsList ] );
#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is a morphism
#! $\mathrm{FiberProduct}(D) \rightarrow \Delta$,
#! where $\Delta$ denotes the equalizer of the product diagram of the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{FiberProduct}(D), \Delta)$
#! @Arguments D, method_selection_morphism
DeclareOperation( "IsomorphismFromFiberProductToEqualizerOfDirectProductDiagramOp",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram</C>.
#! $F: ( ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n} ) \mapsto \mathrm{FiberProduct}(D) \rightarrow \Delta$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromFiberProductToEqualizerOfDirectProductDiagram",
                  [ IsCapCategory, IsFunction ] );
##
DeclareOperation( "AddIsomorphismFromFiberProductToEqualizerOfDirectProductDiagram",
                  [ IsCapCategory, IsFunction, IsInt ] );
##
DeclareOperation( "AddIsomorphismFromFiberProductToEqualizerOfDirectProductDiagram",
                  [ IsCapCategory, IsList, IsInt ] );
##
DeclareOperation( "AddIsomorphismFromFiberProductToEqualizerOfDirectProductDiagram",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\Delta \rightarrow \mathrm{FiberProduct}(D)$,
#! where $\Delta$ denotes the equalizer of the product diagram of the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\Delta, \mathrm{FiberProduct}(D))$
#! @Arguments D
DeclareOperation( "IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct",
                  [ IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is a morphism
#! $\Delta \rightarrow \mathrm{FiberProduct}(D)$,
#! where $\Delta$ denotes the equalizer of the product diagram of the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\Delta, \mathrm{FiberProduct}(D))$
#! @Arguments D
DeclareOperation( "IsomorphismFromEqualizerOfDirectProductDiagramToFiberProductOp",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct</C>.
#! $F: ( ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n} ) \mapsto \Delta \rightarrow \mathrm{FiberProduct}(D)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct",
                  [ IsCapCategory, IsFunction ] );

##
DeclareOperation( "AddIsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

##
DeclareOperation( "AddIsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

##
DeclareOperation( "AddIsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\bigoplus_{i=1}^n P_i \rightarrow B$
#! such that its kernel equalizes the $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n P_i, B )$
#! @Arguments D
DeclareOperation( "DirectSumDiagonalDifference",
                  [ IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is a morphism
#! $\bigoplus_{i=1}^n P_i \rightarrow B$
#! such that its kernel equalizes the $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n P_i, B )$
#! @Arguments D, method_selection_morphism
DeclareOperationWithCache( "DirectSumDiagonalDifferenceOp",
                           [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DirectSumDiagonalDifference</C>.
#! $F: ( D ) \mapsto \mathrm{DirectSumDiagonalDifference}(D)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDirectSumDiagonalDifference",
                  [ IsCapCategory, IsFunction ] );

##
DeclareOperation( "AddDirectSumDiagonalDifference",
                  [ IsCapCategory, IsFunction, IsInt ] );

##
DeclareOperation( "AddDirectSumDiagonalDifference",
                  [ IsCapCategory, IsList, IsInt ] );

##
DeclareOperation( "AddDirectSumDiagonalDifference",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$.
#! The output is the natural embedding
#! $\mathrm{FiberProduct}(D) \rightarrow \bigoplus_{i=1}^n P_i$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{FiberProduct}(D), \bigoplus_{i=1}^n P_i )$
#! @Arguments D
DeclareOperation( "FiberProductEmbeddingInDirectSum",
                  [ IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is the natural embedding
#! $\mathrm{FiberProduct}(D) \rightarrow \bigoplus_{i=1}^n P_i$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{FiberProduct}(D), \bigoplus_{i=1}^n P_i )$
#! @Arguments D, method_selection_morphism
DeclareOperationWithCache( "FiberProductEmbeddingInDirectSumOp",
                           [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>FiberProductEmbeddingInDirectSum</C>.
#! $F: ( ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n} ) \mapsto \mathrm{FiberProduct}(D) \rightarrow \bigoplus_{i=1}^n P_i$
#! @Returns nothing
#! @Arguments C, F
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
#! This is a convenience method.
#! There are two different ways to use this method:
#! * The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$.
#! * The arguments are morphisms $\beta_1: P_1 \rightarrow B, \dots, \beta_n: P_n \rightarrow B$.
#! The output is the fiber product $\mathrm{FiberProduct}(D)$.
#! @Returns an object
DeclareGlobalFunction( "FiberProduct" );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is the fiber product $\mathrm{FiberProduct}(D)$.
#! @Returns an object
#! @Arguments D, method_selection_morphism
DeclareOperationWithCache( "FiberProductOp",
                           [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$
#! and an integer $k$.
#! The output is the $k$-th projection
#! $\pi_{k}: \mathrm{FiberProduct}(D) \rightarrow P_k$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{FiberProduct}(D), P_k )$
#! @Arguments D,k
DeclareOperation( "ProjectionInFactorOfFiberProduct",
                  [ IsList, IsInt ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$,
#! an integer $k$,
#! and a morphism for method selection.
#! The output is the $k$-th projection
#! $\pi_{k}: \mathrm{FiberProduct}(D) \rightarrow P_k$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{FiberProduct}(D), P_k )$
#! @Arguments D,k,method_selection_morphism
DeclareOperation( "ProjectionInFactorOfFiberProductOp",
                  [ IsList, IsInt, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$,
#! an integer $k$,
#! and an object $P = \mathrm{FiberProduct}(D)$.
#! The output is the $k$-th projection
#! $\pi_{k}: P \rightarrow P_k$.
#! @Returns a morphism in $\mathrm{Hom}( P, P_k )$
#! @Arguments D,k,P
DeclareOperation( "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! This is a convenience method.
#! There are two different ways to use this method:
#! * The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$
#!  and a list of morphisms $\tau = ( \tau_i: T \rightarrow P_i )$
#!  such that $\beta_i \circ \tau_i  \sim_{T, B} \beta_j \circ \tau_j$ for all pairs $i,j$.
#!  The output is the morphism
#!  $u( \tau ): T \rightarrow \mathrm{FiberProduct}(D)$
#!  given by the universal property of the fiber product.
#! * The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$
#!  and morphisms $\tau_1: T \rightarrow P_1, \dots, \tau_n: T \rightarrow P_n$
#!  such that $\beta_i \circ \tau_i  \sim_{T, B} \beta_j \circ \tau_j$ for all pairs $i,j$.
#!  The output is the morphism
#!  $u( \tau ): T \rightarrow \mathrm{FiberProduct}(D)$
#!  given by the universal property of the fiber product.
DeclareGlobalFunction( "UniversalMorphismIntoFiberProduct" );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$,
#! a list of morphisms $\tau = ( \tau_i: T \rightarrow P_i )$
#! such that $\beta_i \circ \tau_i  \sim_{T, B} \beta_j \circ \tau_j$ for all pairs $i,j$,
#! and a morphism for method selection.
#! The output is the morphism
#! $u( \tau ): T \rightarrow \mathrm{FiberProduct}(D)$
#! given by the universal property of the fiber product.
#! @Returns a morphism in $\mathrm{Hom}( T, \mathrm{FiberProduct}(D) )$
#! @Arguments D, tau, method_selection_morphism
DeclareOperation( "UniversalMorphismIntoFiberProductOp",
                  [ IsList, IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$,
#! a list of morphisms $\tau = ( \tau_i: T \rightarrow P_i )$
#! such that $\beta_i \circ \tau_i  \sim_{T, B} \beta_j \circ \tau_j$ for all pairs $i,j$,
#! and an object $P = \mathrm{FiberProduct}(D)$.
#! The output is the morphism
#! $u( \tau ): T \rightarrow P$
#! given by the universal property of the fiber product.
#! @Returns a morphism in $\mathrm{Hom}( T, P )$
#! @Arguments D, tau, P
DeclareOperation( "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
                  [ IsList, IsList, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>FiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n} ) \mapsto P$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ProjectionInFactorOfFiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, k ) \mapsto \pi_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddProjectionInFactorOfFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ProjectionInFactorOfFiberProductWithGivenFiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, k,P ) \mapsto \pi_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddProjectionInFactorOfFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoFiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, \tau  ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoFiberProduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoFiberProductWithGivenFiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, \tau, P  ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoFiberProductWithGivenFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a list of triples of morphisms
#! $L = ( (\beta_i: P_i \rightarrow B, \mu_i: P_i \rightarrow P_i', \beta_i': P_i' \rightarrow B')_{i = 1 \dots n} )$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \mu_i \sim_{P_i,B'} \beta \circ \beta_i$ for $i = 1, \dots, n$.
#! The output is the morphism
#! $\mathrm{FiberProduct}( ( \beta_i )_{i=1 \dots n} ) \rightarrow \mathrm{FiberProduct}( ( \beta_i' )_{i=1 \dots n} )$
#! given by the functoriality of the fiber product.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{FiberProduct}( ( \beta_i )_{i=1 \dots n} ), \mathrm{FiberProduct}( ( \beta_i' )_{i=1 \dots n} ))$
#! @Arguments L
DeclareOperation( "FiberProductFunctorial",
                  [ IsList ] );

#! @Description
#! The arguments are an object $s = \mathrm{FiberProduct}( ( \beta_i )_{i=1 \dots n} )$,
#! a list of triples of morphisms
#! $L = ( (\beta_i: P_i \rightarrow B, \mu_i: P_i \rightarrow P_i', \beta_i': P_i' \rightarrow B')_{i = 1 \dots n} )$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \mu_i \sim_{P_i,B'} \beta \circ \beta_i$ for $i = 1, \dots, n$,
#! and an object $r = \mathrm{FiberProduct}( ( \beta_i' )_{i=1 \dots n} )$.
#! The output is the morphism
#! $s \rightarrow r$
#! given by the functoriality of the fiber product.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, L, r
DeclareOperation( "FiberProductFunctorialWithGivenFiberProducts",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>FiberProductFunctorialWithGivenFiberProducts</C>.
#! $F: ( \mathrm{FiberProduct}( ( \beta_i )_{i=1 \dots n} ), (\beta_i: P_i \rightarrow B, \mu_i: P_i \rightarrow P_i', \beta_i': P_i' \rightarrow B')_{i = 1 \dots n}, \mathrm{FiberProduct}( ( \beta_i' )_{i=1 \dots n} ) ) \mapsto (\mathrm{FiberProduct}( ( \beta_i )_{i=1 \dots n} ) \rightarrow \mathrm{FiberProduct}( ( \beta_i' )_{i=1 \dots n} ) )$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddFiberProductFunctorialWithGivenFiberProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddFiberProductFunctorialWithGivenFiberProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddFiberProductFunctorialWithGivenFiberProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddFiberProductFunctorialWithGivenFiberProducts",
                  [ IsCapCategory, IsList ] );

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
#! We denote the object $I$ of such a triple by $\mathrm{Pushout}(D)$.
#! We say that the morphism $u( \tau )$ is induced by the
#! <Emph>universal property of the pushout</Emph>.
#! $\\ $
#! $\mathrm{Pushout}$ is a functorial operation. This means:
#! For a second diagram $D' = (\beta_i': B' \rightarrow I_i')_{i = 1 \dots n}$ and a natural morphism
#! between pushout diagrams (i.e., a collection of morphisms
#! $(\mu_i: I_i \rightarrow I'_i)_{i=1\dots n}$ and $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \beta \sim_{B, I_i'} \mu_i \circ \beta_i$ for $i = 1, \dots n$)
#! we obtain a morphism $\mathrm{Pushout}( D ) \rightarrow \mathrm{Pushout}( D' )$.

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\mathrm{Pushout}(D) \rightarrow \Delta$,
#! where $\Delta$ denotes the cokernel object coequalizing the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Pushout}(D), \Delta)$
#! @Arguments D
DeclareOperation( "IsomorphismFromPushoutToCokernelOfDiagonalDifference",
                  [ IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is a morphism
#! $\mathrm{Pushout}(D) \rightarrow \Delta$,
#! where $\Delta$ denotes the cokernel object coequalizing the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Pushout}(D), \Delta)$
#! @Arguments D, method_selection_morphism
DeclareOperation( "IsomorphismFromPushoutToCokernelOfDiagonalDifferenceOp",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromPushoutToCokernelOfDiagonalDifference</C>.
#! $F: ( ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n} ) \mapsto (\mathrm{Pushout}(D) \rightarrow \Delta)$
#! @Returns nothing
#! @Arguments C, F
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

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\Delta \rightarrow \mathrm{Pushout}(D)$,
#! where $\Delta$ denotes the cokernel object coequalizing the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}( \Delta, \mathrm{Pushout}(D))$
#! @Arguments D
DeclareOperation( "IsomorphismFromCokernelOfDiagonalDifferenceToPushout",
                  [ IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is a morphism
#! $\Delta \rightarrow \mathrm{Pushout}(D)$,
#! where $\Delta$ denotes the cokernel object coequalizing the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}( \Delta, \mathrm{Pushout}(D))$
#! @Arguments D, method_selection_morphism
DeclareOperation( "IsomorphismFromCokernelOfDiagonalDifferenceToPushoutOp",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromCokernelOfDiagonalDifferenceToPushout</C>.
#! $F: ( ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n} ) \mapsto (\Delta \rightarrow \mathrm{Pushout}(D))$
#! @Returns nothing
#! @Arguments C, F
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

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\mathrm{Pushout}(D) \rightarrow \Delta$,
#! where $\Delta$ denotes the coequalizer of the coproduct diagram of the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Pushout}(D), \Delta)$
#! @Arguments D
DeclareOperation( "IsomorphismFromPushoutToCoequalizerOfCoproductDiagram",
                  [ IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is a morphism
#! $\mathrm{Pushout}(D) \rightarrow \Delta$,
#! where $\Delta$ denotes the coequalizer of the coproduct diagram of the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Pushout}(D), \Delta)$
#! @Arguments D, method_selection_morphism
DeclareOperation( "IsomorphismFromPushoutToCoequalizerOfCoproductDiagramOp",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromPushoutToCoequalizerOfCoproductDiagram</C>.
#! $F: ( ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n} ) \mapsto (\mathrm{Pushout}(D) \rightarrow \Delta)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromPushoutToCoequalizerOfCoproductDiagram",
                  [ IsCapCategory, IsFunction ] );
##
DeclareOperation( "AddIsomorphismFromPushoutToCoequalizerOfCoproductDiagram",
                  [ IsCapCategory, IsFunction, IsInt ] );
##
DeclareOperation( "AddIsomorphismFromPushoutToCoequalizerOfCoproductDiagram",
                  [ IsCapCategory, IsList, IsInt ] );
##
DeclareOperation( "AddIsomorphismFromPushoutToCoequalizerOfCoproductDiagram",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\Delta \rightarrow \mathrm{Pushout}(D)$,
#! where $\Delta$ denotes the coequalizer of the coproduct diagram of the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}( \Delta, \mathrm{Pushout}(D))$
#! @Arguments D
DeclareOperation( "IsomorphismFromCoequalizerOfCoproductDiagramToPushout",
                  [ IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is a morphism
#! $\Delta \rightarrow \mathrm{Pushout}(D)$,
#! where $\Delta$ denotes the coequalizer of the coproduct diagram of the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}( \Delta, \mathrm{Pushout}(D))$
#! @Arguments D, method_selection_morphism
DeclareOperation( "IsomorphismFromCoequalizerOfCoproductDiagramToPushoutOp",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromCoequalizerOfCoproductDiagramToPushout</C>.
#! $F: ( ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n} ) \mapsto (\Delta \rightarrow \mathrm{Pushout}(D))$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromCoequalizerOfCoproductDiagramToPushout",
                  [ IsCapCategory, IsFunction ] );
##
DeclareOperation( "AddIsomorphismFromCoequalizerOfCoproductDiagramToPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
##
DeclareOperation( "AddIsomorphismFromCoequalizerOfCoproductDiagramToPushout",
                  [ IsCapCategory, IsList, IsInt ] );
##
DeclareOperation( "AddIsomorphismFromCoequalizerOfCoproductDiagramToPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$.
#! The output is a morphism
#! $B \rightarrow \bigoplus_{i=1}^n I_i$
#! such that its cokernel coequalizes the $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(B, \bigoplus_{i=1}^n I_i)$
#! @Arguments D
DeclareOperation( "DirectSumCodiagonalDifference",
                  [ IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is a morphism
#! $B \rightarrow \bigoplus_{i=1}^n I_i$
#! such that its cokernel coequalizes the $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(B, \bigoplus_{i=1}^n I_i)$
#! @Arguments D, method_selection_morphism
DeclareOperationWithCache( "DirectSumCodiagonalDifferenceOp",
                           [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DirectSumCodiagonalDifference</C>.
#! $F: ( D ) \mapsto \mathrm{DirectSumCodiagonalDifference}(D)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDirectSumCodiagonalDifference",
                  [ IsCapCategory, IsFunction ] );
##
DeclareOperation( "AddDirectSumCodiagonalDifference",
                  [ IsCapCategory, IsFunction, IsInt ] );
##
DeclareOperation( "AddDirectSumCodiagonalDifference",
                  [ IsCapCategory, IsList, IsInt ] );
##
DeclareOperation( "AddDirectSumCodiagonalDifference",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$.
#! The output is the natural projection
#! $\bigoplus_{i=1}^n I_i \rightarrow \mathrm{Pushout}(D)$.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n I_i, \mathrm{Pushout}(D) )$
#! @Arguments D
DeclareOperation( "DirectSumProjectionInPushout",
                  [ IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is the natural projection
#! $\bigoplus_{i=1}^n I_i \rightarrow \mathrm{Pushout}(D)$.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n I_i, \mathrm{Pushout}(D) )$
#! @Arguments D, method_selection_morphism
DeclareOperationWithCache( "DirectSumProjectionInPushoutOp",
                           [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DirectSumProjectionInPushout</C>.
#! $F: ( ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n} ) \mapsto (\bigoplus_{i=1}^n I_i \rightarrow \mathrm{Pushout}(D))$
#! @Returns nothing
#! @Arguments C, F
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

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$
#! The output is the pushout $\mathrm{Pushout}(D)$.
#! @Returns an object
#! @Arguments D
DeclareOperation( "Pushout",
                   [ IsList ] );

#! @Description
#! This is a convenience method.
#! The arguments are a morphism $\alpha$ and a morphism $\beta$.
#! The output is the pushout $\mathrm{Pushout}(\alpha, \beta)$.
#! @Returns an object
#! @Arguments D
DeclareOperation( "Pushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$
#! and a morphism for method selection.
#! The output is the pushout $\mathrm{Pushout}(D)$.
#! @Returns an object
#! @Arguments D
DeclareOperationWithCache( "PushoutOp",
                           [ IsList, IsCapCategoryMorphism ] );


#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$
#! and an integer $k$.
#! The output is the $k$-th injection
#! $\iota_k: I_k \rightarrow \mathrm{Pushout}( D )$.
#! @Returns a morphism in $\mathrm{Hom}( I_k, \mathrm{Pushout}( D ) )$.
#! @Arguments D, k
DeclareOperation( "InjectionOfCofactorOfPushout",
                  [ IsList, IsInt ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$,
#! an integer $k$,
#! and a morphism for method selection.
#! The output is the $k$-th injection
#! $\iota_k: I_k \rightarrow \mathrm{Pushout}( D )$.
#! @Returns a morphism in $\mathrm{Hom}( I_k, \mathrm{Pushout}( D ) )$.
#! @Arguments D, k, method_selection_morphism
DeclareOperation( "InjectionOfCofactorOfPushoutOp",
                  [ IsList, IsInt, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$,
#! an integer $k$,
#! and an object $I = \mathrm{Pushout}(D)$.
#! The output is the $k$-th injection
#! $\iota_k: I_k \rightarrow \mathrm{Pushout}( D )$.
#! @Returns a morphism in $\mathrm{Hom}( I_k, \mathrm{Pushout}( D ) )$.
#! @Arguments D, k, I
DeclareOperation( "InjectionOfCofactorOfPushoutWithGivenPushout",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! This is a convenience method.
#! There are two different ways to use this method:
#! * The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$
#!  and a list of morphisms $\tau = ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ such that
#!  $\tau_i \circ \beta_i \sim_{B,T} \tau_j \circ \beta_j$.
#!  The output is the morphism
#!  $u( \tau ): \mathrm{Pushout}(D) \rightarrow T$
#!  given by the universal property of the pushout.
#! * The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$
#!  and morphisms $\tau_1: I_1 \rightarrow T, \dots, \tau_n: I_n \rightarrow T$ such that
#!  $\tau_i \circ \beta_i \sim_{B,T} \tau_j \circ \beta_j$.
#!  The output is the morphism
#!  $u( \tau ): \mathrm{Pushout}(D) \rightarrow T$
#!  given by the universal property of the pushout.
DeclareGlobalFunction( "UniversalMorphismFromPushout" );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$,
#! a list of morphisms $\tau = ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ such that
#! $\tau_i \circ \beta_i \sim_{B,T} \tau_j \circ \beta_j$,
#! and a morphism for method selection.
#! The output is the morphism
#! $u( \tau ): \mathrm{Pushout}(D) \rightarrow T$
#! given by the universal property of the pushout.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Pushout}(D), T )$
#! @Arguments D, tau, method_selection_morphism
DeclareOperation( "UniversalMorphismFromPushoutOp",
                  [ IsList, IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$,
#! a list of morphisms $\tau = ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ such that
#! $\tau_i \circ \beta_i \sim_{B,T} \tau_j \circ \beta_j$,
#! and an object $I = \mathrm{Pushout}(D)$.
#! The output is the morphism
#! $u( \tau ): I \rightarrow T$
#! given by the universal property of the pushout.
#! @Returns a morphism in $\mathrm{Hom}( I, T )$
#! @Arguments D, tau, I
DeclareOperation( "UniversalMorphismFromPushoutWithGivenPushout",
                  [ IsList, IsList, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>Pushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n} ) \mapsto I$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InjectionOfCofactorOfPushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, k ) \mapsto \iota_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInjectionOfCofactorOfPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfPushout",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InjectionOfCofactorOfPushoutWithGivenPushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, k, I ) \mapsto \iota_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInjectionOfCofactorOfPushoutWithGivenPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfPushoutWithGivenPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfPushoutWithGivenPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfPushoutWithGivenPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromPushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, \tau ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromPushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, \tau, I ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromPushoutWithGivenPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromPushoutWithGivenPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromPushoutWithGivenPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromPushoutWithGivenPushout",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The argument is a list
#! $L = ( ( \beta_i: B \rightarrow I_i, \mu_i: I_i \rightarrow I_i', \beta_i': B' \rightarrow I_i' )_{i = 1 \dots n} )$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \beta \sim_{B, I_i'} \mu_i \circ \beta_i$ for $i = 1, \dots n$.
#! The output is the morphism
#! $\mathrm{Pushout}( ( \beta_i )_{i=1}^n ) \rightarrow \mathrm{Pushout}( ( \beta_i' )_{i=1}^n )$
#! given by the functoriality of the pushout.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Pushout}( ( \beta_i )_{i=1}^n ), \mathrm{Pushout}( ( \beta_i' )_{i=1}^n ))$
#! @Arguments L
DeclareOperation( "PushoutFunctorial",
                  [ IsList ] );

#! @Description
#! The arguments are an object $s = \mathrm{Pushout}( ( \beta_i )_{i=1}^n )$,
#! a list
#! $L = ( ( \beta_i: B \rightarrow I_i, \mu_i: I_i \rightarrow I_i', \beta_i': B' \rightarrow I_i' )_{i = 1 \dots n} )$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \beta \sim_{B, I_i'} \mu_i \circ \beta_i$ for $i = 1, \dots n$,
#! and an object $r = \mathrm{Pushout}( ( \beta_i' )_{i=1}^n )$.
#! The output is the morphism
#! $s \rightarrow r$
#! given by the functoriality of the pushout.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, L, r
DeclareOperation( "PushoutFunctorialWithGivenPushouts",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>PushoutFunctorial</C>.
#! $F: ( \mathrm{Pushout}( ( \beta_i )_{i=1}^n ), ( \beta_i: B \rightarrow I_i, \mu_i: I_i \rightarrow I_i', \beta_i': B' \rightarrow I_i' )_{i = 1 \dots n}, \mathrm{Pushout}( ( \beta_i' )_{i=1}^n ) ) \mapsto (\mathrm{Pushout}( ( \beta_i )_{i=1}^n ) \rightarrow \mathrm{Pushout}( ( \beta_i' )_{i=1}^n ) )$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddPushoutFunctorialWithGivenPushouts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddPushoutFunctorialWithGivenPushouts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddPushoutFunctorialWithGivenPushouts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddPushoutFunctorialWithGivenPushouts",
                  [ IsCapCategory, IsList ] );

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
#!  such that $\tau_2 \circ \tau_1 \sim_{A,B} \alpha$ to a morphism
#!  $u(\tau): I \rightarrow T$ such that
#!  $\tau_2 \circ u(\tau) \sim_{I,B} \iota$ and $u(\tau) \circ c \sim_{A,T} \tau_1$.
#! The $4$-tuple $( I, c, \iota, u )$ is called an <Emph>image</Emph> of $\alpha$ if the morphisms $u( \tau )$ are uniquely determined up to
#! congruence of morphisms.
#! We denote the object $I$ of such a $4$-tuple by $\mathrm{im}(\alpha)$.
#! We say that the morphism $u( \tau )$ is induced by the
#! <Emph>universal property of the image</Emph>.
## Main Operations and Attributes

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is the canonical morphism
#! $\mathrm{im}(\alpha) \rightarrow \mathrm{KernelObject}( \mathrm{CokernelProjection}( \alpha ) )$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{im}(\alpha), \mathrm{KernelObject}( \mathrm{CokernelProjection}( \alpha ) ) )$
#! @Arguments alpha
DeclareAttribute( "IsomorphismFromImageObjectToKernelOfCokernel",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromImageObjectToKernelOfCokernel</C>.
#! $F: \alpha \mapsto ( \mathrm{im}(\alpha) \rightarrow \mathrm{KernelObject}( \mathrm{CokernelProjection}( \alpha ) ) )$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromImageObjectToKernelOfCokernel",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromImageObjectToKernelOfCokernel",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromImageObjectToKernelOfCokernel",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromImageObjectToKernelOfCokernel",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is the canonical morphism
#! $\mathrm{KernelObject}( \mathrm{CokernelProjection}( \alpha ) ) \rightarrow \mathrm{im}(\alpha)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{KernelObject}( \mathrm{CokernelProjection}( \alpha ) ), \mathrm{im}(\alpha) )$
#! @Arguments alpha
DeclareAttribute( "IsomorphismFromKernelOfCokernelToImageObject",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromKernelOfCokernelToImageObject</C>.
#! $F: \alpha \mapsto ( \mathrm{KernelObject}( \mathrm{CokernelProjection}( \alpha ) ) \rightarrow \mathrm{im}(\alpha) )$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromKernelOfCokernelToImageObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromKernelOfCokernelToImageObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromKernelOfCokernelToImageObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromKernelOfCokernelToImageObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is the image $\mathrm{im}( \alpha )$.
#! @Returns an object
#! @Arguments alpha
DeclareAttribute( "ImageObject",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the image embedding
#! $\iota: \mathrm{im}(\alpha) \hookrightarrow B$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{im}(\alpha), B)$
#! @Arguments alpha
DeclareAttribute( "ImageEmbedding",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$
#! and an object $I = \mathrm{im}( \alpha )$.
#! The output is the image embedding
#! $\iota: I \hookrightarrow B$.
#! @Returns a morphism in $\mathrm{Hom}(I, B)$
#! @Arguments alpha, I
DeclareOperation( "ImageEmbeddingWithGivenImageObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );


#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the coastriction to image
#! $c: A \rightarrow \mathrm{im}( \alpha )$.
#! @Returns a morphism in $\mathrm{Hom}(A, \mathrm{im}( \alpha ))$
#! @Arguments alpha
DeclareAttribute( "CoastrictionToImage",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$
#! and an object $I = \mathrm{im}( \alpha )$.
#! The output is the coastriction to image
#! $c: A \rightarrow I$.
#! @Returns a morphism in $\mathrm{Hom}(A, I)$
#! @Arguments alpha, I
DeclareOperation( "CoastrictionToImageWithGivenImageObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and a pair of morphisms 
#! $\tau = ( \tau_1: A \rightarrow T, \tau_2: T \hookrightarrow B )$
#! where $\tau_2$ is a monomorphism
#! such that $\tau_2 \circ \tau_1 \sim_{A,B} \alpha$.
#! The output is the morphism
#! $u(\tau): \mathrm{im}(\alpha) \rightarrow T$
#! given by the universal property of the image.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{im}(\alpha), T)$
#! @Arguments alpha, tau
DeclareOperation( "UniversalMorphismFromImage",
                  [ IsCapCategoryMorphism, IsList ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$,
#! a pair of morphisms 
#! $\tau = ( \tau_1: A \rightarrow T, \tau_2: T \hookrightarrow B )$
#! where $\tau_2$ is a monomorphism
#! such that $\tau_2 \circ \tau_1 \sim_{A,B} \alpha$,
#! and an object $I = \mathrm{im}( \alpha )$.
#! The output is the morphism
#! $u(\tau): \mathrm{im}(\alpha) \rightarrow T$
#! given by the universal property of the image.
#! @Returns a morphism in $\mathrm{Hom}(I, T)$
#! @Arguments alpha, tau, I
DeclareOperation( "UniversalMorphismFromImageWithGivenImageObject",
                  [ IsCapCategoryMorphism, IsList, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ImageObject</C>.
#! $F: \alpha \mapsto I$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddImageObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddImageObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddImageObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddImageObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ImageEmbedding</C>.
#! $F: \alpha \mapsto \iota$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddImageEmbedding",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddImageEmbedding",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddImageEmbedding",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddImageEmbedding",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ImageEmbeddingWithGivenImageObject</C>.
#! $F: (\alpha,I) \mapsto \iota$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddImageEmbeddingWithGivenImageObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddImageEmbeddingWithGivenImageObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddImageEmbeddingWithGivenImageObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddImageEmbeddingWithGivenImageObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoastrictionToImage</C>.
#! $F: \alpha \mapsto c$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoastrictionToImage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoastrictionToImage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoastrictionToImage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoastrictionToImage",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoastrictionToImageWithGivenImageObject</C>.
#! $F: (\alpha,I) \mapsto c$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoastrictionToImageWithGivenImageObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoastrictionToImageWithGivenImageObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoastrictionToImageWithGivenImageObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoastrictionToImageWithGivenImageObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromImage</C>.
#! $F: (\alpha, \tau) \mapsto u(\tau)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromImage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromImage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromImage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromImage",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromImageWithGivenImageObject</C>.
#! $F: (\alpha, \tau, I) \mapsto u(\tau)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromImageWithGivenImageObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromImageWithGivenImageObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromImageWithGivenImageObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromImageWithGivenImageObject",
                  [ IsCapCategory, IsList ] );

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
#! We denote the object $C$ of such a $4$-tuple by $\mathrm{coim}(\alpha)$.
#! We say that the morphism $u( \tau )$ is induced by the
#! <Emph>universal property of the coimage</Emph>.


#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the canonical morphism (in a preabelian category)
#! $\mathrm{coim}(\alpha) \rightarrow \mathrm{im}(\alpha)$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{coim}(\alpha), \mathrm{im}(\alpha))$
#! @Arguments alpha
DeclareAttribute( "MorphismFromCoimageToImage",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $C = \mathrm{coim}(\alpha)$,
#! a morphism $\alpha: A \rightarrow B$,
#! and an object $I = \mathrm{im}(\alpha)$.
#! The output is the canonical morphism (in a preabelian category)
#! $C \rightarrow I$.
#! @Returns a morphism in $\mathrm{Hom}(C,I)$
#! @Arguments alpha
DeclareOperation( "MorphismFromCoimageToImageWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismFromCoimageToImageWithGivenObjects</C>.
#! $F: (C, \alpha, I) \mapsto ( C \rightarrow I )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromCoimageToImageWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromCoimageToImageWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromCoimageToImageWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromCoimageToImageWithGivenObjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the inverse of the canonical morphism (in an abelian category)
#! $\mathrm{im}(\alpha) \rightarrow \mathrm{coim}(\alpha)$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{im}(\alpha), \mathrm{coim}(\alpha))$
#! @Arguments alpha
DeclareAttribute( "InverseMorphismFromCoimageToImage",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $C = \mathrm{coim}(\alpha)$,
#! a morphism $\alpha: A \rightarrow B$,
#! and an object $I = \mathrm{im}(\alpha)$.
#! The output is the inverse of the canonical morphism (in an abelian category)
#! $I \rightarrow C$.
#! @Returns a morphism in $\mathrm{Hom}(I,C)$
#! @Arguments alpha
DeclareOperation( "InverseMorphismFromCoimageToImageWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismFromCoimageToImageWithGivenObjects</C>.
#! $F: (C, \alpha, I) \mapsto ( I \rightarrow C )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInverseMorphismFromCoimageToImageWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInverseMorphismFromCoimageToImageWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInverseMorphismFromCoimageToImageWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInverseMorphismFromCoimageToImageWithGivenObjects",
                  [ IsCapCategory, IsList ] );



#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the canonical morphism
#! $\mathrm{coim}( \alpha ) \rightarrow \mathrm{CokernelObject}( \mathrm{KernelEmbedding}( \alpha ) )$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{coim}( \alpha ), \mathrm{CokernelObject}( \mathrm{KernelEmbedding}( \alpha ) ) )$.
#! @Arguments alpha
DeclareAttribute( "IsomorphismFromCoimageToCokernelOfKernel",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromCoimageToCokernelOfKernel</C>.
#! $F: \alpha \mapsto ( \mathrm{coim}( \alpha ) \rightarrow \mathrm{CokernelObject}( \mathrm{KernelEmbedding}( \alpha ) ) )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromCoimageToCokernelOfKernel",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromCoimageToCokernelOfKernel",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoimageToCokernelOfKernel",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoimageToCokernelOfKernel",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the canonical morphism
#! $\mathrm{CokernelObject}( \mathrm{KernelEmbedding}( \alpha ) ) \rightarrow \mathrm{coim}( \alpha )$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{CokernelObject}( \mathrm{KernelEmbedding}( \alpha ) ), \mathrm{coim}( \alpha ) )$.
#! @Arguments alpha
DeclareAttribute( "IsomorphismFromCokernelOfKernelToCoimage",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromCokernelOfKernelToCoimage</C>.
#! $F: \alpha \mapsto ( \mathrm{CokernelObject}( \mathrm{KernelEmbedding}( \alpha ) ) \rightarrow \mathrm{coim}( \alpha ) )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromCokernelOfKernelToCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromCokernelOfKernelToCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromCokernelOfKernelToCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromCokernelOfKernelToCoimage",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is the coimage $\mathrm{coim}( \alpha )$.
#! @Returns an object
#! @Arguments alpha
DeclareAttribute( "Coimage",
                  IsCapCategoryMorphism );

#! @Description
#! This is a convenience method.
#! The argument is an object $C$ which was created as a coimage
#! of a morphism $\alpha: A \rightarrow B$.
#! The output is the coimage projection
#! $\pi: A \twoheadrightarrow C$.
#! @Returns a morphism in $\mathrm{Hom}(A, C)$
#! @Arguments C
DeclareAttribute( "CoimageProjection",
                  IsCapCategoryObject );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the coimage projection
#! $\pi: A \twoheadrightarrow \mathrm{coim}( \alpha )$.
#! @Returns a morphism in $\mathrm{Hom}(A, \mathrm{coim}( \alpha ))$
#! @Arguments alpha
DeclareAttribute( "CoimageProjection",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and an object $C = \mathrm{coim}(\alpha)$.
#! The output is the coimage projection
#! $\pi: A \twoheadrightarrow C$.
#! @Returns a morphism in $\mathrm{Hom}(A, C)$
#! @Arguments alpha, C
DeclareOperation( "CoimageProjectionWithGivenCoimage",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! This is a convenience method.
#! The argument is an object $C$ which was created as a coimage
#! of a morphism $\alpha: A \rightarrow B$.
#! The output is the astriction to coimage
#! $a: C \rightarrow B$.
#! @Returns a morphism in $\mathrm{Hom}(C,B)$
#! @Arguments C
DeclareAttribute( "AstrictionToCoimage",
                  IsCapCategoryObject );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the astriction to coimage
#! $a: \mathrm{coim}( \alpha ) \rightarrow B$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{coim}( \alpha ),B)$
#! @Arguments alpha
DeclareAttribute( "AstrictionToCoimage",
                  IsCapCategoryMorphism );

#! @Description
#! The argument are a morphism $\alpha: A \rightarrow B$
#! and an object $C = \mathrm{coim}( \alpha )$.
#! The output is the astriction to coimage
#! $a: C \rightarrow B$.
#! @Returns a morphism in $\mathrm{Hom}(C,B)$
#! @Arguments alpha, C
DeclareOperation( "AstrictionToCoimageWithGivenCoimage",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and a pair of morphisms
#! $\tau = ( \tau_1: A \twoheadrightarrow T, \tau_2: T \rightarrow B )$
#! where $\tau_1$ is an epimorphism
#! such that $\tau_2 \circ \tau_1 \sim_{A,B} \alpha$.
#! The output is the morphism
#! $u(\tau): T \rightarrow \mathrm{coim}( \alpha )$
#! given by the universal property of the coimage.
#! @Returns a morphism in $\mathrm{Hom}(T, \mathrm{coim}( \alpha ))$
#! @Arguments alpha, tau
DeclareOperation( "UniversalMorphismIntoCoimage",
                  [ IsCapCategoryMorphism, IsList ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$,
#! a pair of morphisms
#! $\tau = ( \tau_1: A \twoheadrightarrow T, \tau_2: T \rightarrow B )$
#! where $\tau_1$ is an epimorphism
#! such that $\tau_2 \circ \tau_1 \sim_{A,B} \alpha$,
#! and an object $C = \mathrm{coim}( \alpha )$.
#! The output is the morphism
#! $u(\tau): T \rightarrow C$
#! given by the universal property of the coimage.
#! @Returns a morphism in $\mathrm{Hom}(T, C)$
#! @Arguments alpha, tau, C
DeclareOperation( "UniversalMorphismIntoCoimageWithGivenCoimage",
                  [ IsCapCategoryMorphism, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>Coimage</C>.
#! $F: \alpha \mapsto C$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoimage",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoimageProjection</C>.
#! $F: \alpha \mapsto \pi$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoimageProjection",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoimageProjection",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoimageProjection",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoimageProjection",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoimageProjectionWithGivenCoimage</C>.
#! $F: (\alpha,C) \mapsto \pi$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoimageProjectionWithGivenCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoimageProjectionWithGivenCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoimageProjectionWithGivenCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoimageProjectionWithGivenCoimage",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>AstrictionToCoimage</C>.
#! $F: \alpha \mapsto a$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAstrictionToCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAstrictionToCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAstrictionToCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAstrictionToCoimage",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>AstrictionToCoimageWithGivenCoimage</C>.
#! $F: (\alpha,C) \mapsto a$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAstrictionToCoimageWithGivenCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAstrictionToCoimageWithGivenCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAstrictionToCoimageWithGivenCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAstrictionToCoimageWithGivenCoimage",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoCoimage</C>.
#! $F: (\alpha, \tau) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoCoimage",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoCoimageWithGivenCoimage</C>.
#! $F: (\alpha, \tau,C) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoCoimageWithGivenCoimage",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoCoimageWithGivenCoimage",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoCoimageWithGivenCoimage",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoCoimageWithGivenCoimage",
                  [ IsCapCategory, IsList ] );


####################################
##
#! @Section Subobject Classifier
##
####################################

#! A subobject classifier object consists of three parts:
#! * an object $\Omega$,
#! * a function $\mathrm{true}$ providing a morphism $\mathrm{true}: 1 \rightarrow \Omega$,
#! * a function $\chi$ mapping each monomorphism $i : A \rightarrow S$ to a morphism $\chi_i : S \to \Omega$.
#! The triple $(\Omega,\mathrm{true},\chi)$ is called a <Emph>subobject classifier</Emph> if
#! for each monomorphism $i : A \to S$, the morphism $\chi_i : S \to \Omega$ is the unique
#! morphism such that $\chi_i \circ i = \mathrm{true} \circ \ast$ determine a pullback diagram.
## Main Operations and Attributes

#! @Description
#! The argument is a category $C$.
#! The output is a subobject classifier object $\Omega$ of $C$.
#! @Returns an object
#! @Arguments C
DeclareAttribute( "SubobjectClassifier",
                  IsCapCategory );

#! @Description
#! This is a convenience method.
#! The argument is a cell $c$.
#! The output is a subobject classifier $\Omega$ of the
#! category $C$ for which $c \in C$.
#! @Returns an object
#! @Arguments c
DeclareAttribute( "SubobjectClassifier",
                  IsCapCategoryCell );


#! @Description
#! The arguments are a terminal object of the category and
#! a subobject classifier.
#! The output is the truth morphism to the subobject classifier
#! $\mathrm{true}: \mathrm{TerminalObject} \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{TerminalObject} , \mathrm{SubobjectClassifier} )$
#! @Arguments T, W
DeclareOperation( "TruthMorphismIntoSubobjectClassifierWithGivenObjects",
                  [ IsCapCategoryObject , IsCapCategoryObject ]);


#! @Description
#! The argument is a category $C$.
#! The output is the truth morphism to the subobject classifier 
#! $\mathrm{true}: \mathrm{TerminalObject} \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{TerminalObject} , \mathrm{SubobjectClassifier} )$
#! @Arguments C
DeclareOperation( "TruthMorphismIntoSubobjectClassifier",
                  [ IsCapCategory ] );

#! @Description
#! This is a convenience method.
#! The argument is a cell $c$.
#! The output is the truth morphism to the subobject classifier 
#! $\mathrm{true}: \mathrm{TerminalObject} \rightarrow \mathrm{SubobjectClassifier}$
#! of the category $C$ for which $c \in C$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{TerminalObject} , \mathrm{SubobjectClassifier} )$
#! @Arguments c
DeclareOperation( "TruthMorphismIntoSubobjectClassifier",
                  [ IsCapCategoryCell ] );


#! @Description
#! The argument is a monomorphism $m : A \rightarrow S$.
#! The output is its classifying morphism 
#! $\chi_m : S \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Range}(m) , \mathrm{SubobjectClassifier} )$
#! @Arguments m
DeclareOperation( "ClassifyingMorphismOfSubobject",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a monomorphism $m : A \rightarrow S$ and
#! a subobject classifier $\Omega$. The output is the classifying morphism 
#! of the monomorphism $\chi_m : S \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Range}(m) , \mathrm{SubobjectClassifier} )$
#! @Arguments m, omega
DeclareOperation( "ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  [ IsCapCategoryMorphism , IsCapCategoryObject ] );


#! @Description
#! The argument is a classifying morphism $\chi : S \rightarrow \Omega$.
#! The output is the subobject monomorphism of the classifying morphism, 
#! $m : A \rightarrow S$.
#! @Returns a monomorphism in $\mathrm{Hom}( A , S )$
#! @Arguments chi
DeclareOperation( "SubobjectOfClassifyingMorphism" , 
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>SubobjectClassifier</C>.
#! $F : () \mapsto \mathrm{SubobjectClassifier}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddSubobjectClassifier",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSubobjectClassifier",
                  [ IsCapCategory, IsFunction, IsInt ] );

## don't document this function
DeclareOperation( "AddSubobjectClassifier",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSubobjectClassifier",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ to the category
#! for the basic operation <C>ClassifyingMorphismOfSubobject</C>.
#! $F : m \mapsto \mathrm{ClassifyingMorphism}(m)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddClassifyingMorphismOfSubobject",
                  [ IsCapCategory , IsFunction ] );

DeclareOperation( "AddClassifyingMorphismOfSubobject",
                  [ IsCapCategory, IsFunction, IsInt ] );

## don't document this function
DeclareOperation( "AddClassifyingMorphismOfSubobject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddClassifyingMorphismOfSubobject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ to the category
#! for the basic operation <C>ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier</C>.
#! $F : (m, \Omega) \mapsto \mathrm{ClassifyingMorphism}(m)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  [ IsCapCategory , IsFunction ] );

DeclareOperation( "AddClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  [ IsCapCategory, IsFunction, IsInt ] );

## don't document this function
DeclareOperation( "AddClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ to the category
#! for the basic operation 
#! <C>TruthMorphismIntoSubobjectClassifierWithGivenObjects</C>.
#! $F : (1, \Omega) \mapsto \mathrm{true}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTruthMorphismIntoSubobjectClassifierWithGivenObjects",
                  [ IsCapCategory , IsFunction ] );

DeclareOperation( "AddTruthMorphismIntoSubobjectClassifierWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

## don't document this function
DeclareOperation( "AddTruthMorphismIntoSubobjectClassifierWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTruthMorphismIntoSubobjectClassifierWithGivenObjects",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ to the category
#! for the basic operation <C>SubobjectOfClassifyingMorphism</C>.
#! $F : m \mapsto \mathrm{SubobjectOfClassifyingMorphism}(m)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddSubobjectOfClassifyingMorphism",
                  [ IsCapCategory , IsFunction ] );

DeclareOperation( "AddSubobjectOfClassifyingMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

## don't document this function
DeclareOperation( "AddSubobjectOfClassifyingMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSubobjectOfClassifyingMorphism",
                  [ IsCapCategory, IsList ] );




#! @Chapter Universal Objects

####################################
##
#! @Section Convenience Methods
##
####################################

####################################
##
## Scheme for Universal Object
##
####################################

## Main Operations and Attributes

## Function Attributes

## Add Operations
