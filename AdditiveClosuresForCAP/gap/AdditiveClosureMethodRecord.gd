# SPDX-License-Identifier: GPL-2.0-or-later
# AdditiveClosuresForCAP: Additive closures for pre-abelian categories
#
# Declarations
#
#! @Chapter Basic operations

DeclareGlobalVariable( "ADDITIVE_CLOSURE_METHOD_NAME_RECORD" );

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
#! \def\w{2}
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
#! The output is the weak kernel $K$ of $\alpha$.
#! @Returns an object
#! @Arguments alpha
DeclareAttribute( "WeakKernelObject",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the weak kernel embedding $\iota: \mathrm{WeakKernelObject}(\alpha) \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{WeakKernelObject}(\alpha),A)$
#! @Arguments alpha
DeclareAttribute( "WeakKernelEmbedding",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and an object $K = \mathrm{WeakKernelObject}(\alpha)$.
#! The output is the weak kernel embedding $\iota: K \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(K,A)$
#! @Arguments alpha, K
DeclareOperation( "WeakKernelEmbeddingWithGivenWeakKernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and a test morphism $\tau: T \rightarrow A$ satisfying $\alpha \circ \tau \sim_{T,B} 0$.
#! The output is the morphism $u(\tau): T \rightarrow \mathrm{WeakKernelObject}(\alpha)$
#! given by the universal property of the weak kernel.
#! @Returns a morphism in $\mathrm{Hom}(T,\mathrm{WeakKernelObject}(\alpha))$
#! @Arguments alpha, tau
DeclareOperation( "WeakKernelLift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$,
#! a test morphism $\tau: T \rightarrow A$ satisfying $\alpha \circ \tau \sim_{T,B} 0$,
#! and an object $K = \mathrm{WeakKernelObject}(\alpha)$.
#! The output is the morphism $u(\tau): T \rightarrow K$
#! given by the universal property of the weak kernel.
#! @Returns a morphism in $\mathrm{Hom}(T,K)$
#! @Arguments alpha, tau, K
DeclareOperation( "WeakKernelLiftWithGivenWeakKernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

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
#! \def\w{2}
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
#! The output is the weak cokernel $K$ of $\alpha$.
#! @Returns an object
#! @Arguments alpha
DeclareAttribute( "WeakCokernelObject",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the weak cokernel projection $\epsilon: B \rightarrow \mathrm{WeakCokernelObject}( \alpha )$.
#! @Returns a morphism in $\mathrm{Hom}(B, \mathrm{WeakCokernelObject}( \alpha ))$
#! @Arguments alpha
DeclareAttribute( "WeakCokernelProjection",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and an object $K = \mathrm{WeakCokernelObject}(\alpha)$.
#! The output is the weak cokernel projection $\epsilon: B \rightarrow \mathrm{WeakCokernelObject}( \alpha )$.
#! @Returns a morphism in $\mathrm{Hom}(B, K)$
#! @Arguments alpha, K
DeclareOperation( "WeakCokernelProjectionWithGivenWeakCokernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );


#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and a test morphism $\tau: B \rightarrow T$ satisfying $\tau \circ \alpha \sim_{A, T} 0$.
#! The output is the morphism $u(\tau): \mathrm{WeakCokernelObject}(\alpha) \rightarrow T$
#! given by the universal property of the weak cokernel.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{WeakCokernelObject}(\alpha),T)$
#! @Arguments alpha, tau
DeclareOperation( "WeakCokernelColift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$,
#! a test morphism $\tau: B \rightarrow T$ satisfying $\tau \circ \alpha \sim_{A, T} 0$,
#! and an object $K = \mathrm{WeakCokernelObject}(\alpha)$.
#! The output is the morphism $u(\tau): K \rightarrow T$
#! given by the universal property of the weak cokernel.
#! @Returns a morphism in $\mathrm{Hom}(K,T)$
#! @Arguments alpha, tau, K
DeclareOperation( "WeakCokernelColiftWithGivenWeakCokernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

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
#! \def\w{2}
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

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$.
#! The output is the weak bi-fiber product $P$ of $\alpha$ and $\beta$.
#! @Returns an object
#! @Arguments alpha, beta
DeclareOperation( "WeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$.
#! The output is the first weak bi-fiber product projection $\pi_1: P \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}( P, A )$
#! @Arguments alpha, beta
DeclareOperation( "ProjectionInFirstFactorOfWeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$
#! and an object $P = \mathrm{WeakBiFiberProduct}( \alpha, \beta )$.
#! The output is the first weak bi-fiber product projection $\pi_1: P \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}( P, A )$
#! @Arguments alpha, beta, P
DeclareOperation( "ProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$.
#! The output is the second weak bi-fiber product projection $\pi_2: P \rightarrow C$.
#! @Returns a morphism in $\mathrm{Hom}( P, C )$
#! @Arguments alpha, beta
DeclareOperation( "ProjectionInSecondFactorOfWeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$
#! and an object $P = \mathrm{WeakBiFiberProduct}( \alpha, \beta )$.
#! The output is the second weak bi-fiber product projection $\pi_2: P \rightarrow C$.
#! @Returns a morphism in $\mathrm{Hom}( P, C )$
#! @Arguments alpha, beta, P
DeclareOperation( "ProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are four morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$,
#! $\tau_1: T \rightarrow A$, $\tau_2: T \rightarrow C$.
#! The output is the morphism $u( \tau )$ induced by the universal property of the weak bi-fiber product
#! $P$ of $\alpha$ and $\beta$.
#! @Returns a morphism in $\mathrm{Hom}( T, P )$
#! @Arguments alpha, beta, tau_1, tau_2
DeclareOperation( "UniversalMorphismIntoWeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are four morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$,
#! $\tau_1: T \rightarrow A$, $\tau_2: T \rightarrow C$
#! and an object $P = \mathrm{WeakBiFiberProduct}( \alpha, \beta )$.
#! The output is the morphism $u( \tau )$ induced by the universal property of the weak bi-fiber product
#! $P$.
#! @Returns a morphism in $\mathrm{Hom}( T, P )$
#! @Arguments alpha, beta, tau_1, tau_2, P
DeclareOperation( "UniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$.
#! The output is the morphism $P \rightarrow A \oplus C$ obtained
#! from the two weak bi-fiber product projections $\pi_1$ and $\pi_2$ and
#! the universal property of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}( P, A \oplus C )$
#! @Arguments alpha, beta
DeclareOperation( "WeakBiFiberProductMorphismToDirectSum",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

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
#! \def\w{2}
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

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$.
#! The output is the biased weak fiber product $P$ of $\alpha$ and $\beta$.
#! @Returns an object
#! @Arguments alpha, beta
DeclareOperation( "BiasedWeakFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

## corresponds to projection in 1st factor
#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$.
#! The output is the biased weak fiber product projection $\pi: P \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}( P, A )$
#! @Arguments alpha, beta
DeclareOperation( "ProjectionOfBiasedWeakFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$,
#! and an object $P = \mathrm{BiasedWeakFiberProduct}( \alpha, \beta )$.
#! The output is the biased weak fiber product projection $\pi: P \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}( P, A )$
#! @Arguments alpha, beta, P
DeclareOperation( "ProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are three morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$,
#! $\tau: T \rightarrow A$.
#! The output is the morphism $u( \tau )$ induced by the universal property of the biased weak fiber product
#! $P$ of $\alpha$ and $\beta$.
#! @Returns a morphism in $\mathrm{Hom}( T, P )$
#! @Arguments alpha, beta, tau
DeclareOperation( "UniversalMorphismIntoBiasedWeakFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are three morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$,
#! $\tau: T \rightarrow A$
#! and an object $P = \mathrm{BiasedWeakFiberProduct}( \alpha, \beta )$.
#! The output is the morphism $u( \tau )$ induced by the universal property of the biased weak fiber product
#! $P$ of $\alpha$ and $\beta$.
#! @Returns a morphism in $\mathrm{Hom}( T, P )$
#! @Arguments alpha, beta, tau, P
DeclareOperation( "UniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

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
#! \def\w{2}
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


#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: A \rightarrow C$.
#! The output is the weak bi-pushout $P$ of $\alpha$ and $\beta$.
#! @Returns an object
#! @Arguments alpha, beta
DeclareOperation( "WeakBiPushout",
                   [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: A \rightarrow C$.
#! The output is the first weak bi-pushout injection $\iota_1: B \rightarrow P$.
#! @Returns a morphism in $\mathrm{Hom}( B, P )$
#! @Arguments alpha, beta
DeclareOperation( "InjectionOfFirstCofactorOfWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: A \rightarrow C$.
#! The output is the second weak bi-pushout injection $\iota_2: C \rightarrow P$.
#! @Returns a morphism in $\mathrm{Hom}( C, P )$
#! @Arguments alpha, beta
DeclareOperation( "InjectionOfSecondCofactorOfWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: A \rightarrow C$
#! and an object $P = \mathrm{WeakBiPushout}( \alpha, \beta )$.
#! The output is the first weak bi-pushout injection $\iota_1: B \rightarrow P$.
#! @Returns a morphism in $\mathrm{Hom}( B, P )$
#! @Arguments alpha, beta, P
DeclareOperation( "InjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: A \rightarrow C$
#! and an object $P = \mathrm{WeakBiPushout}( \alpha, \beta )$.
#! The output is the second weak bi-pushout injection $\iota_2: C \rightarrow P$.
#! @Returns a morphism in $\mathrm{Hom}( C, P )$
#! @Arguments alpha, beta, P
DeclareOperation( "InjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are four morphisms $\alpha: A \rightarrow B$, $\beta: A \rightarrow C$,
#! $\tau_1: B \rightarrow T$, $\tau_2: C \rightarrow T$.
#! The output is the morphism $u( \tau )$ induced by the universal property of the weak bi-pushout
#! $P$ of $\alpha$ and $\beta$.
#! @Returns a morphism in $\mathrm{Hom}( P, T )$
#! @Arguments alpha, beta, tau_1, tau_2
DeclareOperation( "UniversalMorphismFromWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are four morphisms $\alpha: A \rightarrow B$, $\beta: A \rightarrow C$,
#! $\tau_1: B \rightarrow T$, $\tau_2: C \rightarrow T$,
#! and an object $P = \mathrm{WeakBiPushout}( \alpha, \beta )$.
#! The output is the morphism $u( \tau )$ induced by the universal property of the weak bi-pushout
#! $P$ of $\alpha$ and $\beta$.
#! @Returns a morphism in $\mathrm{Hom}( P, T )$
#! @Arguments alpha, beta, tau_1, tau_2, P
DeclareOperation( "UniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: C \rightarrow B$.
#! The output is the morphism $B \oplus C \rightarrow P$ obtained
#! from the two weak bi-fiber product injections $\iota_1$ and $\iota_2$ and
#! the universal property of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}(B \oplus C, P )$
#! @Arguments alpha, beta
DeclareOperation( "DirectSumMorphismToWeakBiPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

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
#! \def\w{2}
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

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: A \rightarrow C$.
#! The output is the biased weak pushout $P$ of $\alpha$ and $\beta$.
#! @Returns an object
#! @Arguments alpha, beta
DeclareOperation( "BiasedWeakPushout",
                   [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: A \rightarrow C$.
#! The output is the biased weak pushout injection $\iota: B \rightarrow P$.
#! @Returns a morphism in $\mathrm{Hom}( B, P )$
#! @Arguments alpha, beta
DeclareOperation( "InjectionOfBiasedWeakPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B$, $\beta: A \rightarrow C$
#! and an object $P = \mathrm{BiasedWeakPushout}( \alpha, \beta )$.
#! The output is the biased weak pushout injection $\iota: B \rightarrow P$.
#! @Returns a morphism in $\mathrm{Hom}( B, P )$
#! @Arguments alpha, beta, P
DeclareOperation( "InjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are three morphisms $\alpha: A \rightarrow B$, $\beta: A \rightarrow C$,
#! $\tau: B \rightarrow T$.
#! The output is the morphism $u( \tau )$ induced by the universal property of the biased weak pushout
#! $P$ of $\alpha$ and $\beta$.
#! @Returns a morphism in $\mathrm{Hom}( P, T )$
#! @Arguments alpha, beta, tau
DeclareOperation( "UniversalMorphismFromBiasedWeakPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are three morphisms $\alpha: A \rightarrow B$, $\beta: A \rightarrow C$,
#! $\tau: B \rightarrow T$
#! and an object $P = \mathrm{BiasedWeakPushout}( \alpha, \beta )$.
#! The output is the morphism $u( \tau )$ induced by the universal property of the biased weak pushout
#! $P$ of $\alpha$ and $\beta$.
#! @Returns a morphism in $\mathrm{Hom}( P, T )$
#! @Arguments alpha, beta, tau, P
DeclareOperation( "UniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

