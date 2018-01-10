#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#! @Chapter Freyd categories
#!
##
#############################################################################

DeclareGlobalVariable( "FREYD_CATEGORIES_METHOD_NAME_RECORD" );

DeclareGlobalFunction( "WEAK_BI_FIBER_PRODUCT_PREFUNCTION" );

DeclareGlobalFunction( "UNIVERSAL_MORPHISM_INTO_WEAK_BI_FIBER_PRODUCT_PREFUNCTION" );

DeclareGlobalFunction( "WEAK_BI_PUSHOUT_PREFUNCTION" );

DeclareGlobalFunction( "UNIVERSAL_MORPHISM_FROM_WEAK_BI_PUSHOUT_PREFUNCTION" );

##TODO: Adjust documentation

####################################
##
#! @Section Weak kernel
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
DeclareAttribute( "WeakKernelObject",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the kernel embedding $\iota: \mathrm{KernelObject}(\alpha) \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{KernelObject}(\alpha),A)$
#! @Arguments alpha
DeclareAttribute( "WeakKernelEmbedding",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and an object $K = \mathrm{KernelObject}(\alpha)$.
#! The output is the kernel embedding $\iota: K \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(K,A)$
#! @Arguments alpha, K
DeclareOperation( "WeakKernelEmbeddingWithGivenWeakKernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and a test morphism $\tau: T \rightarrow A$ satisfying $\alpha \circ \tau \sim_{T,B} 0$.
#! The output is the morphism $u(\tau): T \rightarrow \mathrm{KernelObject}(\alpha)$
#! given by the universal property of the kernel.
#! @Returns a morphism in $\mathrm{Hom}(T,\mathrm{KernelObject}(\alpha))$
#! @Arguments alpha, tau
DeclareOperation( "WeakKernelLift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$,
#! a test morphism $\tau: T \rightarrow A$ satisfying $\alpha \circ \tau \sim_{T,B} 0$,
#! and an object $K = \mathrm{KernelObject}(\alpha)$.
#! The output is the morphism $u(\tau): T \rightarrow K$
#! given by the universal property of the kernel.
#! @Returns a morphism in $\mathrm{Hom}(T,K)$
#! @Arguments alpha, tau, K
DeclareOperation( "WeakKernelLiftWithGivenWeakKernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );


## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>KernelObject</C>.
#! $F: \alpha \mapsto \mathrm{KernelObject}(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddWeakKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWeakKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWeakKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWeakKernelObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>KernelEmbedding</C>.
#! $F: \alpha \mapsto \iota$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddWeakKernelEmbedding",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWeakKernelEmbedding",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWeakKernelEmbedding",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWeakKernelEmbedding",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>KernelEmbeddingWithGivenKernelObject</C>.
#! $F: (\alpha, K) \mapsto \iota$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddWeakKernelEmbeddingWithGivenWeakKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWeakKernelEmbeddingWithGivenWeakKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWeakKernelEmbeddingWithGivenWeakKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWeakKernelEmbeddingWithGivenWeakKernelObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>KernelLift</C>.
#! $F: (\alpha, \tau) \mapsto u(\tau)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddWeakKernelLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWeakKernelLift",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWeakKernelLift",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWeakKernelLift",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>KernelLiftWithGivenKernelObject</C>.
#! $F: (\alpha, \tau, K) \mapsto u$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddWeakKernelLiftWithGivenWeakKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWeakKernelLiftWithGivenWeakKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWeakKernelLiftWithGivenWeakKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWeakKernelLiftWithGivenWeakKernelObject",
                  [ IsCapCategory, IsList ] );


####################################
##
#!  @Section Weak cokernel
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
DeclareAttribute( "WeakCokernelObject",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the cokernel projection $\epsilon: B \rightarrow \mathrm{CokernelObject}( \alpha )$.
#! @Returns a morphism in $\mathrm{Hom}(B, \mathrm{CokernelObject}( \alpha ))$
#! @Arguments alpha
DeclareAttribute( "WeakCokernelProjection",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and an object $K = \mathrm{CokernelObject}(\alpha)$.
#! The output is the cokernel projection $\epsilon: B \rightarrow \mathrm{CokernelObject}( \alpha )$.
#! @Returns a morphism in $\mathrm{Hom}(B, K)$
#! @Arguments alpha, K
DeclareOperation( "WeakCokernelProjectionWithGivenWeakCokernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );


#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and a test morphism $\tau: B \rightarrow T$ satisfying $\tau \circ \alpha \sim_{A, T} 0$.
#! The output is the morphism $u(\tau): \mathrm{CokernelObject}(\alpha) \rightarrow T$
#! given by the universal property of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{CokernelObject}(\alpha),T)$
#! @Arguments alpha, tau
DeclareOperation( "WeakCokernelColift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$,
#! a test morphism $\tau: B \rightarrow T$ satisfying $\tau \circ \alpha \sim_{A, T} 0$,
#! and an object $K = \mathrm{CokernelObject}(\alpha)$.
#! The output is the morphism $u(\tau): K \rightarrow T$
#! given by the universal property of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(K,T)$
#! @Arguments alpha, tau, K
DeclareOperation( "WeakCokernelColiftWithGivenWeakCokernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );


## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelObject</C>.
#! $F: \alpha \mapsto K$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddWeakCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWeakCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWeakCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWeakCokernelObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelProjection</C>.
#! $F: \alpha \mapsto \epsilon$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddWeakCokernelProjection",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWeakCokernelProjection",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWeakCokernelProjection",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWeakCokernelProjection",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelProjection</C>.
#! $F: (\alpha, K) \mapsto \epsilon$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddWeakCokernelProjectionWithGivenWeakCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWeakCokernelProjectionWithGivenWeakCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWeakCokernelProjectionWithGivenWeakCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWeakCokernelProjectionWithGivenWeakCokernelObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelProjection</C>.
#! $F: (\alpha, \tau) \mapsto u(\tau)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddWeakCokernelColift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWeakCokernelColift",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWeakCokernelColift",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWeakCokernelColift",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CokernelProjection</C>.
#! $F: (\alpha, \tau, K) \mapsto u(\tau)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddWeakCokernelColiftWithGivenWeakCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWeakCokernelColiftWithGivenWeakCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWeakCokernelColiftWithGivenWeakCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWeakCokernelColiftWithGivenWeakCokernelObject",
                  [ IsCapCategory, IsList ] );

####################################
##
#! @Section Weak bi-fiber product
##
####################################


## Main Operations and Attributes


DeclareOperation( "WeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "ProjectionInFirstFactorOfWeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "ProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "ProjectionInSecondFactorOfWeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "ProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "UniversalMorphismIntoWeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "UniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );


## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>FiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n} ) \mapsto P$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWeakBiFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWeakBiFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ProjectionInFactorOfFiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, k ) \mapsto \pi_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddProjectionInFirstFactorOfWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFirstFactorOfWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFirstFactorOfWeakBiFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFirstFactorOfWeakBiFiberProduct",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "AddProjectionInSecondFactorOfWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInSecondFactorOfWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInSecondFactorOfWeakBiFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInSecondFactorOfWeakBiFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ProjectionInFactorOfFiberProductWithGivenFiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, k,P ) \mapsto \pi_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "AddProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoFiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, \tau  ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoWeakBiFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoWeakBiFiberProduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoFiberProductWithGivenFiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, \tau, P  ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategory, IsList ] );

####################################
##
#! @Section Weak bi-pushout
##
####################################


DeclareOperation( "WeakBiPushout",
                   [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "InjectionOfFirstCofactorOfWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "InjectionOfSecondCofactorOfWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "InjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "InjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "UniversalMorphismFromWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "UniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );


## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>Pushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n} ) \mapsto I$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddWeakBiPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWeakBiPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWeakBiPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWeakBiPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InjectionOfCofactorOfPushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, k ) \mapsto \iota_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInjectionOfFirstCofactorOfWeakBiPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfFirstCofactorOfWeakBiPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfFirstCofactorOfWeakBiPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfFirstCofactorOfWeakBiPushout",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfWeakBiPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfWeakBiPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfWeakBiPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfWeakBiPushout",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InjectionOfCofactorOfPushoutWithGivenPushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, k, I ) \mapsto \iota_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromPushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, \tau ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromWeakBiPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromWeakBiPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromWeakBiPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromWeakBiPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromPushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, \tau, I ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategory, IsList ] );

####################################
##
#! @Section Abelian constructions
##
####################################

DeclareAttribute( "SomeProjectiveObjectForKernelObject",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $A$.
#! The output is an epimorphism $\pi: P \rightarrow A$
#! with $P$ a projective object that equals the output of $\mathrm{SomeProjectiveObject}(A)$.
#! @Returns a morphism in $\mathrm{Hom}(P,A)$
#! @Arguments A
DeclareAttribute( "EpimorphismFromSomeProjectiveObjectForKernelObject",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are an object $A$
#! and a projective object $P$ that equals the output of $\mathrm{SomeProjectiveObject}(A)$.
#! The output is an epimorphism $\pi: P \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(P,A)$
#! @Arguments A, P
DeclareOperation( "EpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>SomeProjectiveObject</C>.
#! $F: A \mapsto P$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddSomeProjectiveObjectForKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSomeProjectiveObjectForKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddSomeProjectiveObjectForKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSomeProjectiveObjectForKernelObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>EpimorphismFromSomeProjectiveObject</C>.
#! $F: A \mapsto \pi$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddEpimorphismFromSomeProjectiveObjectForKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEpimorphismFromSomeProjectiveObjectForKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEpimorphismFromSomeProjectiveObjectForKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEpimorphismFromSomeProjectiveObjectForKernelObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>AddEpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject</C>.
#! $F: (A,P) \mapsto \pi$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddEpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject",
                  [ IsCapCategory, IsList ] );
