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

DeclareGlobalFunction( "UNIVERSAL_MORPHISM_INTO_BIASED_WEAK_FIBER_PRODUCT_PREFUNCTION" );

DeclareGlobalFunction( "UNIVERSAL_MORPHISM_FROM_BIASED_WEAK_PUSHOUT_PREFUNCTION" );

##TODO: Adjust documentation

####################################
##
#! @Section Weak kernel
##
####################################

#! For a given morphism $\alpha: A \rightarrow B$, a weak kernel of $\alpha$ consists of three parts:
#! * an object $K$, 
#! * a morphism $\iota: K \rightarrow A$ such that $\alpha \circ \iota \sim_{K,B} 0$,
#! * a dependent function $u$ mapping each morphism $\tau: T \rightarrow A$ satisfying $\alpha \circ \tau \sim_{T,B} 0$ to a morphism $u(\tau): T \rightarrow K$ such that $\iota \circ u( \tau ) \sim_{T,A} \tau$. 
#! The triple $( K, \iota, u )$ is called a <Emph>weak kernel</Emph> of $\alpha$.
#! We denote the object $K$ of such a triple by $\mathrm{WeakKernelObject}(\alpha)$.
#! We say that the morphism $u(\tau)$ is induced by the
#! <Emph>universal property of the weak kernel</Emph>.

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2};
#! \node (T) at (-\w,\w) {$T$};
#! \node (K) at (-\w,0) {$K$};
#! \node (A) at (0,0) {$A$};
#! \node (B) at (\w,0) {$B$};
#! \draw[-latex] (A) to node[pos=0.45, above] {$\alpha$} (B);
#! \draw[-latex] (K) to node[pos=0.45, above] {$\iota$} (A);
#! \draw[-latex] (T) to node[pos=0.45, above right] {$\tau$} (A);
#! \draw[-latex] (T) to node[pos=0.45, left] {$\exists u( \tau )$} (K);
#! \draw[-latex, dotted] (T) to [out = 0, in = 90] node[pos=0.45, above right] {$\alpha \circ \tau \sim_{T,B} 0$} (B);
#! \draw[-latex, dotted] (K) to [out = -45, in = -135] node[pos=0.45, below] {$\alpha \circ \iota \sim_{K,B} 0$} (B);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

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

#! For a given morphism $\alpha: A \rightarrow B$, a weak cokernel of $\alpha$ consists of three parts:
#! * an object $K$,
#! * a morphism $\epsilon: B \rightarrow K$ such that $\epsilon \circ \alpha \sim_{A,K} 0$,
#! * a dependent function $u$ mapping each $\tau: B \rightarrow T$ satisfying $\tau \circ \alpha \sim_{A, T} 0$ to a morphism $u(\tau):K \rightarrow T$ such that $u(\tau) \circ \epsilon \sim_{B,T} \tau$.
#! The triple $( K, \epsilon, u )$ is called a <Emph>weak cokernel</Emph> of $\alpha$.
#! We denote the object $K$ of such a triple by $\mathrm{WeakCokernelObject}(\alpha)$.
#! We say that the morphism $u(\tau)$ is induced by the
#! <Emph>universal property of the weak cokernel</Emph>.

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2};
#! \node (A) at (0,0) {$A$};
#! \node (B) at (\w,0) {$B$};
#! \node (K) at (2*\w,0) {$K$};
#! \node (T) at (2*\w,\w) {$T$};
#! \draw[-latex] (A) to node[pos=0.45, above] {$\alpha$} (B);
#! \draw[-latex] (B) to node[pos=0.45, above] {$\epsilon$} (K);
#! \draw[-latex] (B) to node[pos=0.45, above left] {$\tau$} (T);
#! \draw[-latex] (K) to node[pos=0.45, right] {$\exists u( \tau )$} (T);
#! \draw[-latex, dotted] (A) to [out = 90, in = 180] node[pos=0.45, above left] {$\tau \circ \alpha \sim_{A,T} 0$} (T);
#! \draw[-latex, dotted] (A) to [out = -45, in = -135] node[pos=0.45, below] {$\epsilon \circ \alpha \sim_{A,K} 0$} (K);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly


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

#! For a given pair of morphisms $(\alpha: A \rightarrow B, \beta \colon C \rightarrow B)$, a weak bi-fiber product of $(\alpha, \beta)$ consists of three parts:
#! * an object $P$,
#! * morphisms $\pi_1: P \rightarrow A$, $\pi_2: P \rightarrow B$ such that $\alpha \circ \pi_1 \sim_{P,B} \beta \circ \pi_2$,
#! * a dependent function $u$ mapping each pair $\tau = ( \tau_1, \tau_2 )$ of morphisms $\tau_1: T \rightarrow A$, $\tau_2: T \rightarrow C$ with the property $\alpha \circ \tau_1 \sim_{T,B} \beta \circ \tau_2$ to a morphism $u(\tau):T \rightarrow P$ such that $\pi_1 \circ u( \tau ) \sim_{A,T} \tau_1$ and $\pi_2 \circ u( \tau ) \sim_{C,T} \tau_2$.
#! The quadrupel $( P, \pi_1, \pi_2, u )$ is called a <Emph>weak bi-fiber product</Emph> of $(\alpha,\beta)$.
#! We denote the object $P$ of such a quadrupel by $\mathrm{WeakBiFiberProduct}(\alpha,\beta)$.
#! We say that the morphism $u(\tau)$ is induced by the
#! <Emph>universal property of the weak bi-fiber product</Emph>.

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2};
#! \node (A) at (0,0) {$A$};
#! \node (B) at (\w,0) {$B$};
#! \node (C) at (\w,\w) {$C$};
#! \node (P) at (0,\w) {$P$};
#! \node (T) at (-\w,2*\w) {$T$};
#! \draw[-latex] (A) to node[pos=0.45, above] {$\alpha$} (B);
#! \draw[-latex] (C) to node[pos=0.45, right] {$\beta$} (B);
#! \draw[-latex] (P) to node[pos=0.45, left] {$\pi_1$} (A);
#! \draw[-latex] (P) to node[pos=0.45, above] {$\pi_2$} (C);
#! \draw[-latex] (T) to [out = -90, in = 180] node[pos=0.45, left] {$\tau_1$} (A);
#! \draw[-latex] (T) to [out = 0, in = 90] node[pos=0.45, above] {$\tau_2$} (C);
#! \draw[-latex] (T) to node[pos=0.45, above right] {$\exists u( \tau )$} (P);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

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

DeclareOperation( "WeakBiFiberProductMorphismToDirectSum",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

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

##
DeclareOperation( "AddWeakBiFiberProductMorphismToDirectSum",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWeakBiFiberProductMorphismToDirectSum",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWeakBiFiberProductMorphismToDirectSum",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWeakBiFiberProductMorphismToDirectSum",
                  [ IsCapCategory, IsList ] );

####################################
##
#! @Section Biased weak fiber product
##
####################################

#! For a given pair of morphisms $(\alpha: A \rightarrow B, \beta \colon C \rightarrow B)$, a biased weak fiber product of $(\alpha, \beta)$ consists of three parts:
#! * an object $P$,
#! * a morphism $\pi: P \rightarrow A$ such that there exists a morphism $\delta: P \rightarrow C$ such that $\beta \circ \delta \sim_{P,B} \alpha \circ \pi$,
#! * a dependent function $u$ mapping each $\tau: T \rightarrow A$, which admits a morphism $\mu \colon T \rightarrow C$ with $\beta \circ \mu \sim_{T,B} \alpha \circ \tau$, to a morphism $u(\tau):T \rightarrow P$ such that $\pi \circ u(\tau) \sim_{T,A} \tau$.
#! The triple $( P, \pi, u )$ is called a <Emph>biased weak fiber product</Emph> of $(\alpha,\beta)$.
#! We denote the object $P$ of such a triple by $\mathrm{BiasedWeakFiberProduct}(\alpha,\beta)$.
#! We say that the morphism $u(\tau)$ is induced by the
#! <Emph>universal property of the biased weak fiber product</Emph>.

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2};
#! \node (A) at (0,0) {$A$};
#! \node (B) at (\w,0) {$B$};
#! \node (C) at (\w,\w) {$C$};
#! \node (P) at (0,\w) {$P$};
#! \node (T) at (-\w,2*\w) {$T$};
#! \draw[-latex] (A) to node[pos=0.45, above] {$\alpha$} (B);
#! \draw[-latex] (C) to node[pos=0.45, right] {$\beta$} (B);
#! \draw[-latex] (P) to node[pos=0.45, left] {$\pi$} (A);
#! \draw[-latex] (T) to [out = -90, in = 180] node[pos=0.45, left] {$\tau$} (A);
#! \draw[-latex] (T) to node[pos=0.45, above right] {$\exists u( \tau )$} (P);
#! \draw[-latex, dotted] (P) to node[pos=0.45, above] {$\delta$} (C);
#! \draw[-latex, dotted] (T) to [out = 0, in = 90] node[pos=0.45, above] {$\mu$} (C);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly


## Main Operations and Attributes


DeclareOperation( "BiasedWeakFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

## corresponds to projection in 1st factor
DeclareOperation( "ProjectionOfBiasedWeakFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "ProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "UniversalMorphismIntoBiasedWeakFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "UniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>FiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n} ) \mapsto P$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddBiasedWeakFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBiasedWeakFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBiasedWeakFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBiasedWeakFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ProjectionInFactorOfFiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, k ) \mapsto \pi_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddProjectionOfBiasedWeakFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionOfBiasedWeakFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionOfBiasedWeakFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionOfBiasedWeakFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ProjectionInFactorOfFiberProductWithGivenFiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, k,P ) \mapsto \pi_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoFiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, \tau  ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoBiasedWeakFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoBiasedWeakFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoBiasedWeakFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoBiasedWeakFiberProduct",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismIntoFiberProductWithGivenFiberProduct</C>.
#! $F: ( (\beta_i: P_i \rightarrow B)_{i = 1 \dots n}, \tau, P  ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
                  [ IsCapCategory, IsList ] );

####################################
##
#! @Section Weak bi-pushout
##
####################################

#! For a given pair of morphisms $(\alpha: A \rightarrow B, \beta \colon A \rightarrow C)$, a weak bi-pushout of $(\alpha, \beta)$ consists of three parts:
#! * an object $P$,
#! * morphisms $\iota_1: B \rightarrow P$, $\iota_2: C \rightarrow P$ such that $\iota_1 \circ \alpha \sim_{A,P} \iota_2 \circ \beta$,
#! * a dependent function $u$ mapping each pair $\tau = (\tau_1, \tau_2)$ of morphisms $\tau_1: B \rightarrow T$, $\tau_2: C \rightarrow T$ with the property $\tau_1 \circ \alpha \sim_{A,T} \tau_2 \circ \beta$ to a morphism $u(\tau): P \rightarrow T$ such that $u( \tau ) \circ \iota_1 \sim_{B,T} \tau_1$ and $u( \tau ) \circ \iota_2 \sim_{C,T} \tau_2$.
#! The quadrupel $( P, \iota_1, \iota_2, u )$ is called a <Emph>weak bi-pushout</Emph> of $(\alpha,\beta)$.
#! We denote the object $P$ of such a quadrupel by $\mathrm{WeakBiPushout}(\alpha,\beta)$.
#! We say that the morphism $u(\tau)$ is induced by the
#! <Emph>universal property of the weak bi-pushout</Emph>.

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2};
#! \node (A) at (0,0) {$A$};
#! \node (B) at (\w,0) {$B$};
#! \node (C) at (0,\w) {$C$};
#! \node (P) at (\w,\w) {$P$};
#! \node (T) at (2*\w,2*\w) {$T$};
#! \draw[-latex] (A) to node[pos=0.45, above] {$\alpha$} (B);
#! \draw[-latex] (A) to node[pos=0.45, left] {$\beta$} (C);
#! \draw[-latex] (B) to node[pos=0.45, right] {$\iota_1$} (P);
#! \draw[-latex] (B) to [out = 0, in = -90] node[pos=0.45, right] {$\tau_1$} (T);
#! \draw[-latex] (P) to node[pos=0.45, above left] {$\exists u( \tau )$} (T);
#! \draw[-latex] (C) to node[pos=0.45, above] {$\iota_2$} (P);
#! \draw[-latex] (C) to [out = 90, in = 180] node[pos=0.45, above] {$\tau_2$} (T);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly


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

DeclareOperation( "DirectSumMorphismToWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

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

##
DeclareOperation( "AddDirectSumMorphismToWeakBiPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDirectSumMorphismToWeakBiPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDirectSumMorphismToWeakBiPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectSumMorphismToWeakBiPushout",
                  [ IsCapCategory, IsList ] );

####################################
##
#! @Section Biased weak pushout
##
####################################

#! For a given pair of morphisms $(\alpha: A \rightarrow B, \beta: A \rightarrow C)$, a biased weak pushout  of $(\alpha, \beta)$ consists of three parts:
#! * an object $P$,
#! * a morphism $\iota: B \rightarrow P$ such that there exists a morphism $\delta: C \rightarrow P$ such that $\delta \circ \beta \sim_{A,P} \iota \circ \alpha$,
#! * a dependent function $u$ mapping each $\tau: B \rightarrow T$, which admits a morphism $\mu \colon C \rightarrow T$ with $\mu \circ \beta \sim_{B,T} \tau \circ \alpha$, to a morphism $u(\tau):P \rightarrow T$ such that $u(\tau) \circ \iota \sim_{A,T} \tau$.
#! The triple $( P, \iota, u )$ is called a <Emph>biased weak pushout</Emph> of $(\alpha,\beta)$.
#! We denote the object $P$ of such a triple by $\mathrm{BiasedWeakPushout}(\alpha,\beta)$.
#! We say that the morphism $u(\tau)$ is induced by the
#! <Emph>universal property of the biased weak pushout</Emph>.

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2};
#! \node (A) at (0,0) {$A$};
#! \node (B) at (\w,0) {$B$};
#! \node (C) at (0,\w) {$C$};
#! \node (P) at (\w,\w) {$P$};
#! \node (T) at (2*\w,2*\w) {$T$};
#! \draw[-latex] (A) to node[pos=0.45, above] {$\alpha$} (B);
#! \draw[-latex] (A) to node[pos=0.45, left] {$\beta$} (C);
#! \draw[-latex] (B) to node[pos=0.45, right] {$\iota$} (P);
#! \draw[-latex] (B) to [out = 0, in = -90] node[pos=0.45, right] {$\tau$} (T);
#! \draw[-latex] (P) to node[pos=0.45, above left] {$\exists u( \tau )$} (T);
#! \draw[-latex, dotted] (C) to node[pos=0.45, above] {$\delta$} (P);
#! \draw[-latex, dotted] (C) to [out = 90, in = 180] node[pos=0.45, above] {$\mu$} (T);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

DeclareOperation( "BiasedWeakPushout",
                   [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "InjectionOfBiasedWeakPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "InjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "UniversalMorphismFromBiasedWeakPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "UniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>Pushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n} ) \mapsto I$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddBiasedWeakPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBiasedWeakPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBiasedWeakPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBiasedWeakPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InjectionOfCofactorOfPushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, k ) \mapsto \iota_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInjectionOfBiasedWeakPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfBiasedWeakPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfBiasedWeakPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfBiasedWeakPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InjectionOfCofactorOfPushoutWithGivenPushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, k, I ) \mapsto \iota_k$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromPushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, \tau ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromBiasedWeakPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromBiasedWeakPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromBiasedWeakPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromBiasedWeakPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalMorphismFromPushout</C>.
#! $F: ( (\beta_i: B \rightarrow I_i)_{i = 1 \dots n}, \tau, I ) \mapsto u(\tau)$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout",
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

DeclareAttribute( "SomeInjectiveObjectForCokernelObject",
                  IsCapCategoryMorphism );

DeclareAttribute( "MonomorphismToSomeInjectiveObjectForCokernelObject",
                  IsCapCategoryMorphism );

DeclareOperation( "MonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject",
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


DeclareOperation( "AddSomeInjectiveObjectForCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSomeInjectiveObjectForCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddSomeInjectiveObjectForCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSomeInjectiveObjectForCokernelObject",
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


DeclareOperation( "AddMonomorphismToSomeInjectiveObjectForCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonomorphismToSomeInjectiveObjectForCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonomorphismToSomeInjectiveObjectForCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonomorphismToSomeInjectiveObjectForCokernelObject",
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


DeclareOperation( "AddMonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject",
                  [ IsCapCategory, IsList ] );

####################################
##
#! @Section Free abelian category
##
####################################

##
DeclareAttribute( "AsMorphismInFreeAbelianCategory",
                  IsCapCategoryMorphism );

####################################
##
#! @Section Finitely presented functors
##
####################################

##
DeclareOperation( "CovariantExtAsFreydCategoryObject",
                  [ IsCapCategoryObject, IsInt ] );


