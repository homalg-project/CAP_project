# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Universal Objects

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

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \node (K) at (-\w,0) {$K$};
#! \node (T) at (-\w,\w) {$T$};
#! \node (A) at (0,0) {$A$};
#! \node (B) at (\w,0) {$B$};
#! \draw[-latex] (A) to node[pos=0.45, above] {$\alpha$} (B);
#! \draw[-latex] (K) to node[pos=0.45, above] {$\iota$} (A);
#! \draw[-latex] (T) to node[pos=0.45, above right] {$\tau$} (A);
#! \draw[dashed, -latex] (T) to node[pos=0.45, left] {$\exists ! u( \tau )$} (K);
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
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the zero morphism $0: \mathrm{KernelObject}(\alpha) \rightarrow B$.
#! @Returns the zero morphism in $\mathrm{Hom}( \mathrm{KernelObject}(\alpha), B )$
#! @Arguments alpha
DeclareOperation( "MorphismFromKernelObjectToSink",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$
#! and an object $K = \mathrm{KernelObject}(\alpha)$.
#! The output is the zero morphism $0: K \rightarrow B$.
#! @Returns the zero morphism in $\mathrm{Hom}( K, B )$
#! @Arguments alpha, K
DeclareOperation( "MorphismFromKernelObjectToSinkWithGivenKernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$, a test object $T$,
#! and a test morphism $\tau: T \rightarrow A$ satisfying $\alpha \circ \tau \sim_{T,B} 0$.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism $u(\tau): T \rightarrow \mathrm{KernelObject}(\alpha)$
#! given by the universal property of the kernel.
#! @Returns a morphism in $\mathrm{Hom}(T,\mathrm{KernelObject}(\alpha))$
#! @Arguments alpha, T, tau
DeclareOperation( "KernelLift",
                  [ IsCapCategoryMorphism, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$, a test object $T$,
#! a test morphism $\tau: T \rightarrow A$ satisfying $\alpha \circ \tau \sim_{T,B} 0$,
#! and an object $K = \mathrm{KernelObject}(\alpha)$.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism $u(\tau): T \rightarrow K$
#! given by the universal property of the kernel.
#! @Returns a morphism in $\mathrm{Hom}(T,K)$
#! @Arguments alpha, T, tau, K
DeclareOperation( "KernelLiftWithGivenKernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

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
#! \draw[dashed, -latex] (K) to node[pos=0.45, right] {$\exists ! u( \tau )$} (T);
#! \draw[-latex, dotted] (A) to [out = 90, in = 180] node[pos=0.45, above left] {$\tau \circ \alpha \sim_{A, T} 0$} (T);
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
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the zero morphism $0: A \rightarrow \mathrm{CokernelObject}(\alpha)$.
#! @Returns the zero morphism in $\mathrm{Hom}( A, \mathrm{CokernelObject}( \alpha ) )$.
#! @Arguments alpha
DeclareOperation( "MorphismFromSourceToCokernelObject",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$
#! and an object $K = \mathrm{CokernelObject}(\alpha)$.
#! The output is the zero morphism $0: A \rightarrow K$.
#! @Returns the zero morphism in $\mathrm{Hom}( A, K )$.
#! @Arguments alpha, K
DeclareOperation( "MorphismFromSourceToCokernelObjectWithGivenCokernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$, a test object $T$,
#! and a test morphism $\tau: B \rightarrow T$ satisfying $\tau \circ \alpha \sim_{A, T} 0$.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism $u(\tau): \mathrm{CokernelObject}(\alpha) \rightarrow T$
#! given by the universal property of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{CokernelObject}(\alpha),T)$
#! @Arguments alpha, T, tau
DeclareOperation( "CokernelColift",
                  [ IsCapCategoryMorphism, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow B$, a test object $T$,
#! a test morphism $\tau: B \rightarrow T$ satisfying $\tau \circ \alpha \sim_{A, T} 0$,
#! and an object $K = \mathrm{CokernelObject}(\alpha)$.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism $u(\tau): K \rightarrow T$
#! given by the universal property of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(K,T)$
#! @Arguments alpha, T, tau, K
DeclareOperation( "CokernelColiftWithGivenCokernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The argument is a list $L = [ \alpha: A \rightarrow B, [ \mu:A \rightarrow A', \nu: B \rightarrow B' ], \alpha': A' \rightarrow B' ]$.
#! The output is the morphism
#! $\mathrm{CokernelObject}( \alpha ) \rightarrow \mathrm{CokernelObject}( \alpha' )$
#! given by the functoriality of the cokernel.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{CokernelObject}( \alpha ), \mathrm{CokernelObject}( \alpha' ))$
#! @Arguments L
DeclareOperation( "CokernelObjectFunctorial",
                  [ IsList ] );

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
#! This is a synonym for `UniversalMorphismFromZeroObject`.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{ZeroObject}, A)$
#! @Arguments A
# DeclareAttribute( "MorphismFromZeroObject", IsCapCategoryObject );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonymAttr( "MorphismFromZeroObject",
                    UniversalMorphismFromZeroObject );

#! @Description
#! This is a synonym for `UniversalMorphismIntoZeroObject`.
#! @Returns a morphism in $\mathrm{Hom}(A, \mathrm{ZeroObject})$
#! @Arguments A
# DeclareAttribute( "MorphismIntoZeroObject", IsCapCategoryObject );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonymAttr( "MorphismIntoZeroObject",
                    UniversalMorphismIntoZeroObject );

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

#! @Description
#! The argument is a category $C$.
#! The output is the unique morphism $\mathrm{ZeroObject} \rightarrow \mathrm{ZeroObject}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{ZeroObject}, \mathrm{ZeroObject} )$
#! @Arguments C
DeclareAttribute( "ZeroObjectFunctorial",
                  IsCapCategory );

#! @Description
#! The argument is a category $C$ and a zero object $\mathrm{ZeroObject}(C)$ twice (for compatibility with other functorials).
#! The output is the unique morphism $zero_object1 \rightarrow zero_object2$.
#! @Returns a morphism in $\mathrm{Hom}(zero_object1, zero_object2)$
#! @Arguments C, zero_object1, zero_object2
DeclareOperation( "ZeroObjectFunctorialWithGivenZeroObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

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

#! @Description
#! The argument is a category $C$.
#! The output is the unique morphism $\mathrm{TerminalObject} \rightarrow \mathrm{TerminalObject}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{TerminalObject}, \mathrm{TerminalObject} )$
#! @Arguments C
DeclareAttribute( "TerminalObjectFunctorial",
                  IsCapCategory );

#! @Description
#! The argument is a category $C$ and a terminal object $\mathrm{TerminalObject}(C)$ twice (for compatibility with other functorials).
#! The output is the unique morphism $terminal_object1 \rightarrow terminal_object2$.
#! @Returns a morphism in $\mathrm{Hom}(terminal_object1, terminal_object2)$
#! @Arguments C, terminal_object1, terminal_object2
DeclareOperation( "TerminalObjectFunctorialWithGivenTerminalObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

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
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{InitialObject}, A)$.
#! @Arguments A
DeclareAttribute( "UniversalMorphismFromInitialObject",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $A$,
#! and an object $I = \mathrm{InitialObject}$.
#! The output is the universal morphism $u(A): \mathrm{InitialObject} \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(I, A)$.
#! @Arguments A, I
DeclareOperation( "UniversalMorphismFromInitialObjectWithGivenInitialObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is a category $C$.
#! The output is the unique morphism $\mathrm{InitialObject} \rightarrow \mathrm{InitialObject}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{InitialObject}, \mathrm{InitialObject} )$
#! @Arguments C
DeclareAttribute( "InitialObjectFunctorial",
                  IsCapCategory );

#! @Description
#! The argument is a category $C$ and an initial object $\mathrm{InitialObject}(C)$ twice (for compatibility with other functorials).
#! The output is the unique morphism $initial_object1 \rightarrow initial_object2$.
#! @Returns a morphism in $\mathrm{Hom}(initial_object1, initial_object2)$
#! @Arguments C, initial_object1, initial_object2
DeclareOperation( "InitialObjectFunctorialWithGivenInitialObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Chapter Universal Objects

####################################
##
#! @Section Direct Sum
##
####################################

#! For an integer $n \geq 1$ and a given list $D = (S_1, \dots, S_n)$ in an Ab-category, a direct sum consists of five parts:
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

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \def\a{20}
#! \node (S) at (0,0) {$S$};
#! \node (S1) at (-\w,0) {$S_1$};
#! \node (S2) at (\w,0) {$S_2$};
#! \node (T) at (0,\w) {$T$};
#! \draw[-latex] (S) to [out = 180-\a, in = \a] node[pos=0.45, above] {$\pi_1$} (S1);
#! \draw[-latex] (S) to [out = \a, in = 180-\a] node[pos=0.45, above] {$\pi_2$} (S2);
#! \draw[-latex] (S1) to [out = -\a, in = -180+\a] node[pos=0.45, below] {$\iota_1$} (S);
#! \draw[-latex] (S2) to [out = -180+\a, in = -\a] node[pos=0.45, below] {$\iota_2$} (S);
#! \draw[-latex] (T) to [out = -180, in = 90] node[pos=0.45, above left] {$\tau_1$} (S1);
#! \draw[-latex] (T) to [out = 0, in = 90] node[pos=0.45, above right] {$\tau_2$} (S2);
#! \draw[dashed, -latex] (T) to node[pos=0.45, left] {$\exists u_{in} ( \tau )$} (S);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \def\a{20}
#! \node (S) at (0,0) {$S$};
#! \node (S1) at (-\w,0) {$S_1$};
#! \node (S2) at (\w,0) {$S_2$};
#! \node (T) at (0,\w) {$T$};
#! \draw[-latex] (S) to [out = 180-\a, in = \a] node[pos=0.45, above] {$\pi_1$} (S1);
#! \draw[-latex] (S) to [out = \a, in = 180-\a] node[pos=0.45, above] {$\pi_2$} (S2);
#! \draw[-latex] (S1) to [out = -\a, in = -180+\a] node[pos=0.45, below] {$\iota_1$} (S);
#! \draw[-latex] (S2) to [out = -180+\a, in = -\a] node[pos=0.45, below] {$\iota_2$} (S);
#! \draw[-latex] (S1) to [out = 90, in = -180] node[pos=0.45, above left] {$\tau_1$} (T);
#! \draw[-latex] (S2) to [out = 90, in = 0] node[pos=0.45, above right] {$\tau_2$} (T);
#! \draw[dashed, -latex] (S) to node[pos=0.45, left] {$\exists u_{out} ( \tau )$} (T);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly



## Main Operations and Attributes

#! @Description
#! This is a convenience method.
#! There are two different ways to use this method:
#! * The argument is a list of objects $D = (S_1, \dots, S_n)$.
#! * The arguments are objects $S_1, \dots, S_n$.
#! The output is the direct sum $\bigoplus_{i=1}^n S_i$.
#! @Returns an object
# DeclareGlobalFunction( "DirectSum" ); # already defined by GAP

#! @Description
#! The argument is a list of objects $D = (S_1, \dots, S_n)$.
#! The output is the direct sum $\bigoplus_{i=1}^n S_i$.
#! @Returns an object
#! @Arguments D
DeclareOperation( "DirectSumOp",
                           [ IsList ] );

# for compatibility with GAP's DirectSum function
DeclareOperation( "DirectSumOp",
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
#! and an object $S = \bigoplus_{i=1}^n S_i$.
#! The output  is the $k$-th injection
#! $\iota_k: S_k \rightarrow S$.
#! @Returns a morphism in $\mathrm{Hom}( S_k, S )$
#! @Arguments D,k,S
DeclareOperation( "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$, a test object $T$,
#! and a list of morphisms $\tau = ( \tau_i: T \rightarrow S_i )_{i = 1 \dots n}$.
#! For convenience, the diagram <A>D</A> and/or the test object <A>T</A> can be omitted
#! and are automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u_{\mathrm{in}}(\tau): T \rightarrow \bigoplus_{i=1}^n S_i$
#! given by the universal property of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}(T, \bigoplus_{i=1}^n S_i)$
#! @Arguments D, T, tau
DeclareOperation( "UniversalMorphismIntoDirectSum",
                  [ IsList, IsCapCategoryObject, IsList ] );

DeclareOperation( "UniversalMorphismIntoDirectSum",
                  [ IsList ] );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$, a test object $T$,
#! a list of morphisms $\tau = ( \tau_i: T \rightarrow S_i )_{i = 1 \dots n}$,
#! and an object $S = \bigoplus_{i=1}^n S_i$.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u_{\mathrm{in}}(\tau): T \rightarrow S$
#! given by the universal property of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}(T, S)$
#! @Arguments D, T, tau, S
DeclareOperation( "UniversalMorphismIntoDirectSumWithGivenDirectSum",
                  [ IsList, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$, a test object $T$,
#! and a list of morphisms $\tau = ( \tau_i: S_i \rightarrow T )_{i = 1 \dots n}$.
#! For convenience, the diagram <A>D</A> and/or the test object <A>T</A> can be omitted
#! and are automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u_{\mathrm{out}}(\tau): \bigoplus_{i=1}^n S_i \rightarrow T$
#! given by the universal property of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}(\bigoplus_{i=1}^n S_i, T)$
#! @Arguments D, T, tau
DeclareOperation( "UniversalMorphismFromDirectSum",
                  [ IsList, IsCapCategoryObject, IsList ] );

DeclareOperation( "UniversalMorphismFromDirectSum",
                  [ IsList ] );

#! @Description
#! The arguments are a list of objects $D = (S_1, \dots, S_n)$, a test object $T$,
#! a list of morphisms $\tau = ( \tau_i: S_i \rightarrow T )_{i = 1 \dots n}$,
#! and an object $S = \bigoplus_{i=1}^n S_i$.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u_{\mathrm{out}}(\tau): S \rightarrow T$
#! given by the universal property of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}(S, T)$
#! @Arguments D, T, tau, S
DeclareOperation( "UniversalMorphismFromDirectSumWithGivenDirectSum",
                  [ IsList, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The argument is a list of objects $D = (S_1, \dots, S_n)$.
#! The output is the canonical isomorphism
#! $\bigoplus_{i=1}^n S_i \rightarrow \prod_{i=1}^{n}S_i$.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n S_i, \prod_{i=1}^{n}S_i )$
#! @Arguments D
DeclareOperation( "IsomorphismFromDirectSumToDirectProduct",
                  [ IsList ] );

#! @Description
#! The argument is a list of objects $D = (S_1, \dots, S_n)$.
#! The output is the canonical isomorphism
#! $\prod_{i=1}^{n}S_i \rightarrow \bigoplus_{i=1}^n S_i$.
#! @Returns a morphism in $\mathrm{Hom}( \prod_{i=1}^{n}S_i, \bigoplus_{i=1}^n S_i )$
#! @Arguments D
DeclareOperation( "IsomorphismFromDirectProductToDirectSum",
                  [ IsList ] );

#! @Description
#! The argument is a list of objects $D = (S_1, \dots, S_n)$.
#! The output is the canonical isomorphism
#! $\bigoplus_{i=1}^n S_i \rightarrow \bigsqcup_{i=1}^{n}S_i$.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n S_i, \bigsqcup_{i=1}^{n}S_i )$
#! @Arguments D
DeclareOperation( "IsomorphismFromDirectSumToCoproduct",
                  [ IsList ] );

#! @Description
#! The argument is a list of objects $D = (S_1, \dots, S_n)$.
#! The output is the canonical isomorphism
#! $\bigsqcup_{i=1}^{n}S_i \rightarrow \bigoplus_{i=1}^n S_i$.
#! @Returns a morphism in $\mathrm{Hom}( \bigsqcup_{i=1}^{n}S_i, \bigoplus_{i=1}^n S_i )$
#! @Arguments D
DeclareOperation( "IsomorphismFromCoproductToDirectSum",
                  [ IsList ] );

#! @Description
#! The arguments are given as follows:
#! * <A>diagram_S</A> is a list of objects $(A_i)_{i = 1 \dots m}$,
#! * <A>diagram_T</A> is a list of objects $(B_j)_{j = 1 \dots n}$,
#! * <A>M</A> is a list of lists of morphisms $( ( \phi_{i,j}: A_i \rightarrow B_j )_{j = 1 \dots n} )_{i = 1 \dots m}$.
#! The output is the morphism
#! $\bigoplus_{i=1}^{m}A_i \rightarrow \bigoplus_{j=1}^n B_j$
#! defined by the matrix $M$.
#! @Returns a morphism in $\mathrm{Hom}(\bigoplus_{i=1}^{m}A_i, \bigoplus_{j=1}^n B_j)$
#! @Arguments diagram_S, M, diagram_T
DeclareOperation( "MorphismBetweenDirectSums",
                  [ IsList, IsList, IsList ] );

#! @Description
#! This is a convenience method.
#! The argument $M = ( ( \phi_{i,j}: A_i \rightarrow B_j )_{j = 1 \dots n} )_{i = 1 \dots m}$
#! is a (non-empty) list of (non-empty) lists of morphisms.
#! The output is the morphism
#! $\bigoplus_{i=1}^{m}A_i \rightarrow \bigoplus_{j=1}^n B_j$
#! defined by the matrix $M$.
#! @Returns a morphism in $\mathrm{Hom}(\bigoplus_{i=1}^{m}A_i, \bigoplus_{j=1}^n B_j)$
#! @Arguments M
DeclareOperation( "MorphismBetweenDirectSums",
                  [ IsList ] );

#! @Description
#! The arguments are given as follows:
#! * <A>diagram_S</A> is a list of objects $(A_i)_{i = 1 \dots m}$,
#! * <A>diagram_T</A> is a list of objects $(B_j)_{j = 1 \dots n}$,
#! * <A>S</A> is the direct sum $\bigoplus_{i=1}^{m}A_i$,
#! * <A>T</A> is the direct sum $\bigoplus_{j=1}^{n}B_j$,
#! * <A>M</A> is a list of lists of morphisms $( ( \phi_{i,j}: A_i \rightarrow B_j )_{j = 1 \dots n} )_{i = 1 \dots m}$.
#! The output is the morphism
#! $\bigoplus_{i=1}^{m}A_i \rightarrow \bigoplus_{j=1}^n B_j$
#! defined by the matrix $M$.
#! @Returns a morphism in $\mathrm{Hom}(\bigoplus_{i=1}^{m}A_i, \bigoplus_{j=1}^n B_j)$
#! @Arguments S, diagram_S, M, diagram_T, T
DeclareOperation( "MorphismBetweenDirectSumsWithGivenDirectSums",
                  [ IsCapCategoryObject, IsList, IsList, IsList, IsCapCategoryObject ] );

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
#! The arguments are
#! a list of objects $(S_i)_{i = 1 \dots n}$,
#! a list of morphisms $L = ( \mu_1: S_1 \rightarrow S_1', \dots, \mu_n: S_n \rightarrow S_n' )$,
#! and a list of objects $(S_i')_{i = 1 \dots n}$.
#! For convenience, <A>source_diagram</A> and <A>range_diagram</A> can be omitted
#! and are automatically derived from <A>L</A> in that case.
#! The output is a morphism
#! $\bigoplus_{i=1}^n S_i \rightarrow \bigoplus_{i=1}^n S_i'$
#! given by the functoriality of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n S_i, \bigoplus_{i=1}^n S_i' )$
#! @Arguments source_diagram, L, range_diagram
DeclareOperation( "DirectSumFunctorial",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The arguments are an object $d_1 = \bigoplus_{i=1}^n S_i$,
#! a list of objects $(S_i)_{i = 1 \dots n}$,
#! a list of morphisms $L = ( \mu_1: S_1 \rightarrow S_1', \dots, \mu_n: S_n \rightarrow S_n' )$,
#! a list of objects $(S_i')_{i = 1 \dots n}$,
#! and an object $d_2 = \bigoplus_{i=1}^n S_i'$.
#! For convenience, <A>source_diagram</A> and <A>range_diagram</A> can be omitted
#! and are automatically derived from <A>L</A> in that case.
#! The output is a morphism
#! $d_1 \rightarrow d_2$
#! given by the functoriality of the direct sum.
#! @Returns a morphism in $\mathrm{Hom}( d_1, d_2 )$
#! @Arguments d_1, source_diagram, L, range_diagram, d_2
DeclareOperation( "DirectSumFunctorialWithGivenDirectSums",
                  [ IsCapCategoryObject, IsList, IsList, IsList, IsCapCategoryObject ] );

#! @Chapter Universal Objects

####################################
##
#! @Section Coproduct
##
####################################

#! For an integer $n \geq 1$ and a given list of objects $D = ( I_1, \dots, I_n )$, a coproduct of $D$ consists of three parts:
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

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \node (I) at (0,0) {$I$};
#! \node (I1) at (-\w,0) {$I_1$};
#! \node (I2) at (\w,0) {$I_2$};
#! \node (T) at (0,\w) {$T$};
#! \draw[-latex] (S1) to node[pos=0.45, below] {$\iota_1$} (S);
#! \draw[-latex] (S2) to node[pos=0.45, below] {$\iota_2$} (S);
#! \draw[-latex] (S1) to [out = 90, in = -180] node[pos=0.45, above left] {$\tau_1$} (T);
#! \draw[-latex] (S2) to [out = 90, in = 0] node[pos=0.45, above right] {$\tau_2$} (T);
#! \draw[dashed, -latex] (S) to node[pos=0.45, left] {$\exists ! u ( \tau )$} (T);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly


## Main Operations and Attributes

#! @Description
#! The argument is a list of objects $D = ( I_1, \dots, I_n )$.
#! The output is the coproduct $\bigsqcup_{i=1}^n I_i$.
#! @Returns an object
#! @Arguments D
DeclareOperation( "Coproduct",
                  [ IsList ] );

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
#! and an object $I = \bigsqcup_{i=1}^n I_i$.
#! The output is the $k$-th injection
#! $\iota_k: I_k \rightarrow I$.
#! @Returns a morphism in $\mathrm{Hom}(I_k, I)$
#! @Arguments D,k,I
DeclareOperation( "InjectionOfCofactorOfCoproductWithGivenCoproduct",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = ( I_1, \dots, I_n )$, a test object $T$,
#! and a list of morphisms $\tau = ( \tau_i: I_i \rightarrow T )$.
#! For convenience, the diagram <A>D</A> and/or the test object <A>T</A> can be omitted
#! and are automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u( \tau ): \bigsqcup_{i=1}^n I_i \rightarrow T$
#! given by the universal property of the coproduct.
#! @Returns a morphism in $\mathrm{Hom}(\bigsqcup_{i=1}^n I_i, T)$
#! @Arguments D, T, tau
DeclareOperation( "UniversalMorphismFromCoproduct",
                  [ IsList, IsCapCategoryObject, IsList ] );

DeclareOperation( "UniversalMorphismFromCoproduct",
                  [ IsList ] );

#! @Description
#! The arguments are a list of objects $D = ( I_1, \dots, I_n )$, a test object $T$,
#! a list of morphisms $\tau = ( \tau_i: I_i \rightarrow T )$,
#! and an object $I = \bigsqcup_{i=1}^n I_i$.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u( \tau ): I \rightarrow T$
#! given by the universal property of the coproduct.
#! @Returns a morphism in $\mathrm{Hom}(I, T)$
#! @Arguments D, T, tau, I
DeclareOperation( "UniversalMorphismFromCoproductWithGivenCoproduct",
                  [ IsList, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! a list of objects $(I_i)_{i = 1 \dots n}$,
#! a list $L = ( \mu_1: I_1 \rightarrow I_1', \dots, \mu_n: I_n \rightarrow I_n' )$,
#! and a list of objects $(I_i')_{i = 1 \dots n}$.
#! For convenience, <A>source_diagram</A> and <A>range_diagram</A> can be omitted
#! and are automatically derived from <A>L</A> in that case.
#! The output is a morphism
#! $\bigsqcup_{i=1}^n I_i \rightarrow \bigsqcup_{i=1}^n I_i'$
#! given by the functoriality of the coproduct.
#! @Returns a morphism in $\mathrm{Hom}(\bigsqcup_{i=1}^n I_i, \bigsqcup_{i=1}^n I_i')$
#! @Arguments source_diagram, L, range_diagram
DeclareOperation( "CoproductFunctorial",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The arguments are an object $s = \bigsqcup_{i=1}^n I_i$, 
#! a list of objects $(I_i)_{i = 1 \dots n}$,
#! a list $L = ( \mu_1: I_1 \rightarrow I_1', \dots, \mu_n: I_n \rightarrow I_n' )$,
#! a list of objects $(I_i')_{i = 1 \dots n}$,
#! and an object $r = \bigsqcup_{i=1}^n I_i'$.
#! For convenience, <A>source_diagram</A> and <A>range_diagram</A> can be omitted
#! and are automatically derived from <A>L</A> in that case.
#! The output is a morphism
#! $\bigsqcup_{i=1}^n I_i \rightarrow \bigsqcup_{i=1}^n I_i'$
#! given by the functoriality of the coproduct.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, source_diagram, L, range_diagram, r
DeclareOperation( "CoproductFunctorialWithGivenCoproducts",
                  [ IsCapCategoryObject, IsList, IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a morphism $\alpha: I \rightarrow A$,
#! a list $D = (I_1, \dots, I_n)$ of objects with $I = \bigsqcup_{j=1}^n I_j$,
#! and an integer $k$.
#! The output is the component morphism
#! $I_k \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(I_k, A)$
#! @Arguments alpha, D, k
DeclareOperation( "ComponentOfMorphismFromCoproduct",
                  [ IsCapCategoryMorphism, IsList, IsInt ] );

#! @Chapter Universal Objects

####################################
##
#! @Section Direct Product
##
####################################

#! For an integer $n \geq 1$ and a given list of objects $D = ( P_1, \dots, P_n )$, a direct product of $D$ consists of three parts:
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

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \node (P) at (0,0) {$P$};
#! \node (P1) at (-\w,0) {$P_1$};
#! \node (P2) at (\w,0) {$P_2$};
#! \node (T) at (0,\w) {$T$};
#! \draw[-latex] (P) to node[pos=0.45, above] {$\pi_1$} (P1);
#! \draw[-latex] (P) to node[pos=0.45, above] {$\pi_2$} (P2);
#! \draw[-latex] (T) to [out = -180, in = 90] node[pos=0.45, above left] {$\tau_1$} (P1);
#! \draw[-latex] (T) to [out = 0, in = 90] node[pos=0.45, above right] {$\tau_2$} (P2);
#! \draw[dashed, -latex] (T) to node[pos=0.45, left] {$\exists ! u ( \tau )$} (P);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly


## Main Operations and Attributes

#! @Description
#! This is a convenience method.
#! There are two different ways to use this method:
#! * The argument is a list of objects $D = ( P_1, \dots, P_n )$.
#! * The arguments are objects $P_1, \dots, P_n$.
#! The output is the direct product $\prod_{i=1}^n P_i$.
#! @Returns an object
# DeclareGlobalFunction( "DirectProduct" ); # already defined by GAP

#! @Description
#! The argument is a list of objects $D = ( P_1, \dots, P_n )$.
#! The output is the direct product $\prod_{i=1}^n P_i$.
#! @Returns an object
#! @Arguments D
DeclareOperation( "DirectProductOp",
                           [ IsList ] );

# for compatibility with GAP's DirectProduct function
DeclareOperation( "DirectProductOp",
                  [ IsList, IsCapCategoryObject ] );
DeclareOperation( "DirectProductOp",
                  [ IsList, IsCapCategory ] );

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
#! and an object $P = \prod_{i=1}^n P_i$.
#! The output is the $k$-th projection
#! $\pi_k: P \rightarrow P_k$.
#! @Returns a morphism in $\mathrm{Hom}(P, P_k)$
#! @Arguments D,k,P
DeclareOperation( "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $D = ( P_1, \dots, P_n )$, a test object $T$,
#! and a list of morphisms $\tau = ( \tau_i: T \rightarrow P_i )_{i = 1, \dots, n}$.
#! For convenience, the diagram <A>D</A> and/or the test object <A>T</A> can be omitted
#! and are automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u(\tau): T \rightarrow \prod_{i=1}^n P_i$
#! given by the universal property of the direct product.
#! @Returns a morphism in $\mathrm{Hom}(T, \prod_{i=1}^n P_i)$
#! @Arguments D, T, tau
DeclareOperation( "UniversalMorphismIntoDirectProduct",
                  [ IsList, IsCapCategoryObject, IsList ] );

DeclareOperation( "UniversalMorphismIntoDirectProduct",
                  [ IsList ] );

#! @Description
#! The arguments are a list of objects $D = ( P_1, \dots, P_n )$, a test object $T$,
#! a list of morphisms $\tau = ( \tau_i: T \rightarrow P_i )_{i = 1, \dots, n}$,
#! and an object $P = \prod_{i=1}^n P_i$.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u(\tau): T \rightarrow \prod_{i=1}^n P_i$
#! given by the universal property of the direct product.
#! @Returns a morphism in $\mathrm{Hom}(T, \prod_{i=1}^n P_i)$
#! @Arguments D, T, tau, P
DeclareOperation( "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
                  [ IsList, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! a list of objects $(P_i)_{i = 1 \dots n}$,
#! a list of morphisms $L = (\mu_i: P_i \rightarrow P'_i)_{i=1\dots n}$,
#! and a list of objects $(P_i')_{i = 1 \dots n}$.
#! For convenience, <A>source_diagram</A> and <A>range_diagram</A> can be omitted
#! and are automatically derived from <A>L</A> in that case.
#! The output is a morphism
#! $\prod_{i=1}^n P_i \rightarrow \prod_{i=1}^n P_i'$
#! given by the functoriality of the direct product.
#! @Returns a morphism in $\mathrm{Hom}( \prod_{i=1}^n P_i, \prod_{i=1}^n P_i' )$
#! @Arguments source_diagram, L, range_diagram
DeclareOperation( "DirectProductFunctorial",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The arguments are an object $s = \prod_{i=1}^n P_i$,
#! a list of objects $(P_i)_{i = 1 \dots n}$,
#! a list of morphisms $L = (\mu_i: P_i \rightarrow P'_i)_{i=1\dots n}$,
#! a list of objects $(P_i')_{i = 1 \dots n}$,
#! and an object $r = \prod_{i=1}^n P_i'$.
#! For convenience, <A>source_diagram</A> and <A>range_diagram</A> can be omitted
#! and are automatically derived from <A>L</A> in that case.
#! The output is a morphism
#! $\prod_{i=1}^n P_i \rightarrow \prod_{i=1}^n P_i'$
#! given by the functoriality of the direct product.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, source_diagram, L, range_diagram r
DeclareOperation( "DirectProductFunctorialWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsList, IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a morphism $\alpha: A \rightarrow P$,
#! a list $D = (P_1, \dots, P_n)$ of objects with $P = \prod_{j=1}^n P_j$,
#! and an integer $k$.
#! The output is the component morphism
#! $A \rightarrow P_k$.
#! @Returns a morphism in $\mathrm{Hom}(A, P_k)$
#! @Arguments alpha, D, k
DeclareOperation( "ComponentOfMorphismIntoDirectProduct",
                  [ IsCapCategoryMorphism, IsList, IsInt ] );

#! @Chapter Universal Objects

####################################
##
#! @Section Equalizer
##
####################################

#! For an integer $n \geq 1$ and a given list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$,
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

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \node (E) at (-\w,0) {$E$};
#! \node (T) at (-\w,\w) {$T$};
#! \node (A) at (0,0) {$A$};
#! \node (B) at (\w,0) {$B$};
#! \draw[-latex] (A) to [out = 20, in = 180-20] node[pos=0.45, above] {$\beta_1$} (B);
#! \draw[-latex] (A) to [out = -20, in = -180+20] node[pos=0.45, below] {$\beta_2$} (B);
#! \draw[-latex] (E) to node[pos=0.45, above] {$\iota$} (A);
#! \draw[-latex] (T) to node[pos=0.45, above right] {$\tau$} (A);
#! \draw[dashed, -latex] (T) to node[pos=0.45, left] {$\exists ! u( \tau )$} (E);
#! \draw[-latex, dotted] (T) to [out = 0, in = 90] node[pos=0.45, above right] {$\beta_2 \circ \tau \sim_{T,B} \beta_1 \circ \tau$} (B);
#! \draw[-latex, dotted] (E) to [out = -45, in = -135] node[pos=0.45, below] {$\beta_2 \circ \iota \sim_{E,B} \beta_1 \circ \iota$} (B);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly


## Main Operations and Attributes

#! @Description
#! This is a convenience method.
#! There are three different ways to use this method:
#! * The arguments are an object $A$ and a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$.
#! * The argument is a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$.
#! * The arguments are morphisms $\beta_1: A \rightarrow B, \dots, \beta_n: A \rightarrow B$.
#! The output is the equalizer $\mathrm{Equalizer}(D)$.
#! @Returns an object
DeclareGlobalFunction( "Equalizer" );

#! @Description
#! The arguments are an object $A$ and list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! The output is the equalizer $\mathrm{Equalizer}(D)$.
#! @Returns an object
#! @Arguments A, D
DeclareOperation( "EqualizerOp",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $A$ and a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! The output is the equalizer embedding
#! $\iota: \mathrm{Equalizer}(D) \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Equalizer}(D), A )$
#! @Arguments A, D
DeclareOperation( "EmbeddingOfEqualizer",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $A$, a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$,
#! and an object $E = \mathrm{Equalizer}(D)$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! The output is the equalizer embedding
#! $\iota: E \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}( E, A )$
#! @Arguments A, D, E
DeclareOperation( "EmbeddingOfEqualizerWithGivenEqualizer",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $A$ and a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! The output is the composition $\mu: \mathrm{Equalizer}(D) \rightarrow B$
#! of the embedding $\iota: \mathrm{Equalizer}(D) \rightarrow A$ and $\beta_1$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Equalizer}(D), B )$
#! @Arguments A, D
DeclareOperation( "MorphismFromEqualizerToSink",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $A$, a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$
#! and an object $E = \mathrm{Equalizer}(D)$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! The output is the composition $\mu: E \rightarrow B$
#! of the embedding $\iota: E \rightarrow A$ and $\beta_1$.
#! @Returns a morphism in $\mathrm{Hom}( E, B )$
#! @Arguments A, D, E
DeclareOperation( "MorphismFromEqualizerToSinkWithGivenEqualizer",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $A$, a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$, a test object $T$,
#! and a morphism $ \tau: T \rightarrow A $
#! such that $\beta_i \circ \tau  \sim_{T, B} \beta_j \circ \tau$ for all pairs $i,j$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u( \tau ): T \rightarrow \mathrm{Equalizer}(D)$
#! given by the universal property of the equalizer.
#! @Returns a morphism in $\mathrm{Hom}( T, \mathrm{Equalizer}(D) )$
#! @Arguments A, D, T, tau
DeclareOperation( "UniversalMorphismIntoEqualizer",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $A$, a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$, a test object $T$,
#! a morphism $\tau: T \rightarrow A )$
#! such that $\beta_i \circ \tau  \sim_{T, B} \beta_j \circ \tau$ for all pairs $i,j$,
#! and an object $E = \mathrm{Equalizer}(D)$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u( \tau ): T \rightarrow E$
#! given by the universal property of the equalizer.
#! @Returns a morphism in $\mathrm{Hom}( T, E )$
#! @Arguments A, D, T, tau, E
DeclareOperation( "UniversalMorphismIntoEqualizerWithGivenEqualizer",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of morphisms
#! $L_s = (\beta_i: A \rightarrow B)_{i = 1 \dots n}$,
#! a morphism
#! $\mu: A \rightarrow A'$,
#! and a list of morphisms
#! $L_r = (\beta_i': A' \rightarrow B')_{i = 1 \dots n}$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \mu \sim_{A,B'} \beta \circ \beta_i$ for $i = 1, \dots, n$.
#! The output is the morphism
#! $\mathrm{Equalizer}( ( \beta_i )_{i=1 \dots n} ) \rightarrow \mathrm{Equalizer}( ( \beta_i' )_{i=1 \dots n} )$
#! given by the functorality of the equalizer.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Equalizer}( ( \beta_i )_{i=1 \dots n} ), \mathrm{Equalizer}( ( \beta_i' )_{i=1 \dots n} ))$
#! @Arguments Ls, mu, Lr
DeclareOperation( "EqualizerFunctorial",
                  [ IsList, IsCapCategoryMorphism, IsList ] );

#! @Description
#! The arguments are an object $s = \mathrm{Equalizer}( ( \beta_i )_{i=1 \dots n} )$,
#! a list of morphisms
#! $L_s = (\beta_i: A \rightarrow B)_{i = 1 \dots n}$,
#! a morphism
#! $\mu: A \rightarrow A'$,
#! and a list of morphisms
#! $L_r = (\beta_i': A' \rightarrow B')_{i = 1 \dots n}$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \mu \sim_{A,B'} \beta \circ \beta_i$ for $i = 1, \dots, n$,
#! and an object $r = \mathrm{Equalizer}( ( \beta_i' )_{i=1 \dots n} )$.
#! The output is the morphism
#! $s \rightarrow r$
#! given by the functorality of the equalizer.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, Ls, mu, Lr, r
DeclareOperation( "EqualizerFunctorialWithGivenEqualizers",
                  [ IsCapCategoryObject, IsList, IsCapCategoryMorphism, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object A and a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$.
#! The output is a morphism
#! $A \rightarrow \prod_{i=1}^{n-1} B$
#! such that its kernel equalizes the $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}( A, \prod_{i=1}^{n-1} B )$
#! @Arguments A, D
DeclareOperation( "JointPairwiseDifferencesOfMorphismsIntoDirectProduct",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object A and a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\mathrm{Equalizer}(D) \rightarrow \Delta$,
#! where $\Delta$ denotes the kernel object equalizing the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Equalizer}(D), \Delta)$
#! @Arguments A, D
DeclareOperation( "IsomorphismFromEqualizerToKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProduct",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object A and a list of morphisms $D = ( \beta_i: A \rightarrow B )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\Delta \rightarrow \mathrm{Equalizer}(D)$,
#! where $\Delta$ denotes the kernel object equalizing the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\Delta, \mathrm{Equalizer}(D))$
#! @Arguments A, D
DeclareOperation( "IsomorphismFromKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProductToEqualizer",
                  [ IsCapCategoryObject, IsList ] );

#! @Chapter Universal Objects

####################################
##
#! @Section Coequalizer
##
####################################

#! For an integer $n \geq 1$ and a given list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$,
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

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \node (B) at (0,0) {$B$};
#! \node (A) at (\w,0) {$A$};
#! \node (C) at (2*\w,0) {$C$};
#! \node (T) at (2*\w,\w) {$T$};
#! \draw[-latex] (B) to [out = 20, in = 180-20] node[pos=0.45, above] {$\beta_1$} (A);
#! \draw[-latex] (B) to [out = -20, in = -180+20] node[pos=0.45, below] {$\beta_2$} (A);
#! \draw[-latex] (A) to node[pos=0.45, above] {$\pi$} (C);
#! \draw[-latex] (A) to node[pos=0.45, above left] {$\tau$} (T);
#! \draw[dashed, -latex] (C) to node[pos=0.45, right] {$\exists ! u( \tau )$} (T);
#! \draw[-latex, dotted] (B) to [out = 90, in = 180] node[pos=0.45, above left] {$\tau \circ \beta_1 \sim_{B,T} \tau \circ \beta_2$} (T);
#! \draw[-latex, dotted] (B) to [out = -45, in = -135] node[pos=0.45, below] {$\pi \circ \beta_1 \sim_{B,C} \pi \circ \beta_2$} (C);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

## Main Operations and Attributes


#! @Description
#! This is a convenience method.
#! There are three different ways to use this method:
#! * The arguments are an object $A$ and a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$.
#! * The argument is a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$.
#! * The arguments are morphisms $\beta_1: B \rightarrow A, \dots, \beta_n: B \rightarrow A$.
#! The output is the coequalizer $\mathrm{Coequalizer}(D)$.
#! @Returns an object
DeclareGlobalFunction( "Coequalizer" );

#! @Description
#! The arguments are an object $A$ and a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! The output is the coequalizer $\mathrm{Coequalizer}(D)$.
#! @Returns an object
#! @Arguments A, D
DeclareOperation( "CoequalizerOp",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $A$ and a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! The output is the projection
#! $\pi: A \rightarrow \mathrm{Coequalizer}( D )$.
#! @Returns a morphism in $\mathrm{Hom}( A, \mathrm{Coequalizer}( D ) )$.
#! @Arguments A, D
DeclareOperation( "ProjectionOntoCoequalizer",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $A$, a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$,
#! and an object $C = \mathrm{Coequalizer}(D)$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! The output is the projection
#! $\pi: A \rightarrow C$.
#! @Returns a morphism in $\mathrm{Hom}( A, C )$.
#! @Arguments A, D, C
DeclareOperation( "ProjectionOntoCoequalizerWithGivenCoequalizer",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $A$ and a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! The output is the composition $\mu: B \rightarrow \mathrm{Coequalizer}(D)$
#! of $\beta_1$ and the projection $\pi: A \rightarrow \mathrm{Coequalizer}( D )$.
#! @Returns a morphism in $\mathrm{Hom}( B, \mathrm{Coequalizer}( D ) )$.
#! @Arguments A, D
DeclareOperation( "MorphismFromSourceToCoequalizer",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $A$, a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$
#! and an object $C = \mathrm{Coequalizer}(D)$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! The output is the composition $\mu: B \rightarrow C$
#! of $\beta_1$ and the projection $\pi: A \rightarrow C$.
#! @Returns a morphism in $\mathrm{Hom}( B, C )$.
#! @Arguments A, D, C
DeclareOperation( "MorphismFromSourceToCoequalizerWithGivenCoequalizer",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $A$, a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$, a test object $T$,
#! and a morphism $\tau: A \rightarrow T $ such that
#! $\tau \circ \beta_i \sim_{B,T} \tau \circ \beta_j$ for all pairs $i,j$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u( \tau ): \mathrm{Coequalizer}(D) \rightarrow T$
#! given by the universal property of the coequalizer.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coequalizer}(D), T )$
#! @Arguments A, D, T, tau
DeclareOperation( "UniversalMorphismFromCoequalizer",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $A$, a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$, a test object $T$,
#! a morphism $\tau: A \rightarrow T $ such that
#! $\tau \circ \beta_i \sim_{B,T} \tau \circ \beta_j$,
#! and an object $C = \mathrm{Coequalizer}(D)$.
#! For convenience, the object $A$ can be omitted and is automatically derived from $D$ in that case.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u( \tau ): C \rightarrow T$
#! given by the universal property of the coequalizer.
#! @Returns a morphism in $\mathrm{Hom}( C, T )$
#! @Arguments A, D, T, tau, C
DeclareOperation( "UniversalMorphismFromCoequalizerWithGivenCoequalizer",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of morphisms
#! $L_s = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$,
#! a morphism
#! $\mu: A \rightarrow A'$,
#! and a list of morphisms
#! $L_r = ( \beta_i': B' \rightarrow A' )_{i = 1 \dots n}$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \beta \sim_{B, A'} \mu \circ \beta_i$ for $i = 1, \dots n$.
#! The output is the morphism
#! $\mathrm{Coequalizer}( ( \beta_i )_{i=1}^n ) \rightarrow \mathrm{Coequalizer}( ( \beta_i' )_{i=1}^n )$
#! given by the functorality of the coequalizer.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Coequalizer}( ( \beta_i )_{i=1 \dots n} ), \mathrm{Coequalizer}( ( \beta_i' )_{i=1 \dots n} ))$
#! @Arguments Ls, mu, Lr
DeclareOperation( "CoequalizerFunctorial",
                  [ IsList, IsCapCategoryMorphism, IsList ] );

#! @Description
#! The arguments are an object $s = \mathrm{Coequalizer}( ( \beta_i )_{i=1}^n )$,
#! a list of morphisms
#! $L_s = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$,
#! a morphism
#! $\mu: A \rightarrow A'$,
#! and a list of morphisms
#! $L_r = ( \beta_i': B' \rightarrow A' )_{i = 1 \dots n}$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \beta \sim_{B, A'} \mu \circ \beta_i$ for $i = 1, \dots n$,
#! and an object $r = \mathrm{Coequalizer}( ( \beta_i' )_{i=1}^n )$.
#! The output is the morphism
#! $s \rightarrow r$
#! given by the functorality of the coequalizer.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, Ls, mu, Lr, r
DeclareOperation( "CoequalizerFunctorialWithGivenCoequalizers",
                  [ IsCapCategoryObject, IsList, IsCapCategoryMorphism, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object A and a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\bigsqcup_{i=1}^{n-1} B \rightarrow A$
#! such that its cokernel coequalizes the $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\bigsqcup_{i=1}^{n-1} B, A)$
#! @Arguments A, D
DeclareOperation( "JointPairwiseDifferencesOfMorphismsFromCoproduct",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object A and a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\mathrm{Coequalizer}(D) \rightarrow \Delta$,
#! where $\Delta$ denotes the cokernel object coequalizing the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Coequalizer}(D), \Delta)$
#! @Arguments A, D
DeclareOperation( "IsomorphismFromCoequalizerToCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproduct",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object A and a list of morphisms $D = ( \beta_i: B \rightarrow A )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\Delta \rightarrow \mathrm{Coequalizer}(D)$,
#! where $\Delta$ denotes the cokernel object coequalizing the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\Delta, \mathrm{Coequalizer}(D))$
#! @Arguments A, D
DeclareOperation( "IsomorphismFromCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproductToCoequalizer",
                  [ IsCapCategoryObject, IsList ] );

#! @Chapter Universal Objects

####################################
##
#! @Section Fiber Product (= Pullback)
##
####################################

#! For an integer $n \geq 1$ and a given list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$,
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

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \node (T) at (-\w,2*\w) {$T$};
#! \node (P) at (0,\w) {$P$};
#! \node (P1) at (0,0) {$P_1$};
#! \node (B) at (\w,0) {$B$};
#! \node (P2) at (\w,\w) {$P_2$};
#! \draw[-latex] (P) to node[pos=0.45, left] {$\pi_1$} (P1);
#! \draw[-latex] (P) to node[pos=0.45, above] {$\pi_2$} (P2);
#! \draw[-latex] (P1) to node[pos=0.45, below] {$\beta_1$} (B);
#! \draw[-latex] (P2) to node[pos=0.45, right] {$\beta_2$} (B);
#! \draw[-latex] (T) to [out = -90, in = 180] node[pos=0.45, left] {$\tau_1$} (P1);
#! \draw[-latex] (T) to [out = 0, in = 90] node[pos=0.45, above] {$\tau_2$} (P2);
#! \draw[-latex, dashed] (T) to node[pos=0.45, above right] {$\exists ! u ( \tau )$} (P);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

## Main Operations and Attributes


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
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\Delta \rightarrow \mathrm{FiberProduct}(D)$,
#! where $\Delta$ denotes the equalizer of the product diagram of the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}(\Delta, \mathrm{FiberProduct}(D))$
#! @Arguments D
DeclareOperation( "IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct",
                  [ IsList ] );

#! @Description
#! This is a convenience method.
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$.
#! The output is the natural embedding
#! $\mathrm{FiberProduct}(D) \rightarrow \prod_{i=1}^n P_i$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{FiberProduct}(D), \prod_{i=1}^n P_i )$
#! @Arguments D
DeclareOperation( "FiberProductEmbeddingInDirectProduct",
                  [ IsList ] );
#! @Description
#! This is a convenience method.
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$.
#! The output is the natural embedding
#! $\mathrm{FiberProduct}(D) \rightarrow \bigoplus_{i=1}^n P_i$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{FiberProduct}(D), \bigoplus_{i=1}^n P_i )$
#! @Arguments D
DeclareOperation( "FiberProductEmbeddingInDirectSum",
                  [ IsList ] );

#! @Description
#! This is a convenience method.
#! There are two different ways to use this method:
#! * The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$.
#! * The arguments are morphisms $\beta_1: P_1 \rightarrow B, \dots, \beta_n: P_n \rightarrow B$.
#! The output is the fiber product $\mathrm{FiberProduct}(D)$.
#! @Returns an object
DeclareGlobalFunction( "FiberProduct" );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$.
#! The output is the fiber product $\mathrm{FiberProduct}(D)$.
#! @Returns an object
#! @Arguments D
DeclareOperation( "FiberProductOp",
                           [ IsList ] );

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
#! and an object $P = \mathrm{FiberProduct}(D)$.
#! The output is the $k$-th projection
#! $\pi_{k}: P \rightarrow P_k$.
#! @Returns a morphism in $\mathrm{Hom}( P, P_k )$
#! @Arguments D,k,P
DeclareOperation( "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$.
#! The output is the composition $\mu: \mathrm{FiberProduct}(D) \rightarrow B$
#! of the $1$-st projection $\pi_1: \mathrm{FiberProduct}(D) \rightarrow P_1$ and $\beta_1$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{FiberProduct}(D), B )$
#! @Arguments D
DeclareOperation( "MorphismFromFiberProductToSink",
                  [ IsList ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$
#! and an object $P = \mathrm{FiberProduct}(D)$.
#! The output is the composition $\mu: P \rightarrow B$
#! of the $1$-st projection $\pi_1: P \rightarrow P_1$ and $\beta_1$.
#! @Returns a morphism in $\mathrm{Hom}( P, B )$
#! @Arguments D, P
DeclareOperation( "MorphismFromFiberProductToSinkWithGivenFiberProduct",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$, a test object $T$,
#! and a list of morphisms $\tau = ( \tau_i: T \rightarrow P_i )$
#! such that $\beta_i \circ \tau_i  \sim_{T, B} \beta_j \circ \tau_j$ for all pairs $i,j$.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u( \tau ): T \rightarrow \mathrm{FiberProduct}(D)$
#! given by the universal property of the fiber product.
#! @Returns a morphism in $\mathrm{Hom}( T, \mathrm{FiberProduct}(D) )$
#! @Arguments D, T, tau
DeclareOperation( "UniversalMorphismIntoFiberProduct",
                  [ IsList, IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: P_i \rightarrow B )_{i = 1 \dots n}$, a test object $T$,
#! a list of morphisms $\tau = ( \tau_i: T \rightarrow P_i )$
#! such that $\beta_i \circ \tau_i  \sim_{T, B} \beta_j \circ \tau_j$ for all pairs $i,j$,
#! and an object $P = \mathrm{FiberProduct}(D)$.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u( \tau ): T \rightarrow P$
#! given by the universal property of the fiber product.
#! @Returns a morphism in $\mathrm{Hom}( T, P )$
#! @Arguments D, T, tau, P
DeclareOperation( "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
                  [ IsList, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are three lists of morphisms
#! $L_s = ( \beta_i: P_i \rightarrow B)_{i = 1 \dots n}$,
#! $L_m = ( \mu_i: P_i \rightarrow P_i' )_{i = 1 \dots n}$,
#! $L_r = ( \beta_i': P_i' \rightarrow B')_{i = 1 \dots n}$
#! having the same length $n$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \mu_i \sim_{P_i,B'} \beta \circ \beta_i$ for $i = 1, \dots, n$.
#! The output is the morphism
#! $\mathrm{FiberProduct}( ( \beta_i )_{i=1 \dots n} ) \rightarrow \mathrm{FiberProduct}( ( \beta_i' )_{i=1 \dots n} )$
#! given by the functoriality of the fiber product.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{FiberProduct}( ( \beta_i )_{i=1 \dots n} ), \mathrm{FiberProduct}( ( \beta_i' )_{i=1 \dots n} ))$
#! @Arguments Ls, Lm, Lr
DeclareOperation( "FiberProductFunctorial",
                  [ IsList, IsList, IsList ] );


#! @Description
#! The arguments are an object $s = \mathrm{FiberProduct}( ( \beta_i )_{i=1 \dots n} )$,
#! three lists of morphisms
#! $L_s = ( \beta_i: P_i \rightarrow B)_{i = 1 \dots n}$,
#! $L_m = ( \mu_i: P_i \rightarrow P_i' )_{i = 1 \dots n}$,
#! $L_r = ( \beta_i': P_i' \rightarrow B')_{i = 1 \dots n}$
#! having the same length $n$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \mu_i \sim_{P_i,B'} \beta \circ \beta_i$ for $i = 1, \dots, n$,
#! and an object $r = \mathrm{FiberProduct}( ( \beta_i' )_{i=1 \dots n} )$.
#! The output is the morphism
#! $s \rightarrow r$
#! given by the functoriality of the fiber product.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, Ls, Lm, Lr, r
DeclareOperation( "FiberProductFunctorialWithGivenFiberProducts",
                  [ IsCapCategoryObject, IsList, IsList, IsList, IsCapCategoryObject ] );

#! @Chapter Universal Objects

####################################
##
#! @Section Pushout
##
####################################

#! For an integer $n \geq 1$ and a given list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$,
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

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \node (B) at (0,0) {$B$};
#! \node (I1) at (\w,0) {$I_1$};
#! \node (I2) at (0,\w) {$I_2$};
#! \node (I) at (\w,\w) {$I$};
#! \node (T) at (2*\w,2*\w) {$T$};
#! \draw[-latex] (B) to node[pos=0.45, below] {$\beta_1$} (I1);
#! \draw[-latex] (B) to node[pos=0.45, left] {$\beta_2$} (I2);
#! \draw[-latex] (I1) to node[pos=0.45, left] {$\iota_1$} (I);
#! \draw[-latex] (I2) to node[pos=0.45, above] {$\iota_2$} (I);
#! \draw[-latex] (I1) to [out = 0, in = -90] node[pos=0.45, right] {$\tau_1$} (T);
#! \draw[-latex] (I2) to [out = 90, in = 180] node[pos=0.45, above] {$\tau_2$} (T);
#! \draw[-latex, dashed] (I) to node[pos=0.45, above left] {$\exists ! u ( \tau )$} (T);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

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
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$.
#! The output is a morphism
#! $\Delta \rightarrow \mathrm{Pushout}(D)$,
#! where $\Delta$ denotes the coequalizer of the coproduct diagram of the morphisms $\beta_i$.
#! @Returns a morphism in $\mathrm{Hom}( \Delta, \mathrm{Pushout}(D))$
#! @Arguments D
DeclareOperation( "IsomorphismFromCoequalizerOfCoproductDiagramToPushout",
                  [ IsList ] );

#! @Description
#! This is a convenience method.
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$.
#! The output is the natural projection
#! $\bigsqcup_{i=1}^n I_i \rightarrow \mathrm{Pushout}(D)$.
#! @Returns a morphism in $\mathrm{Hom}( \bigsqcup {i=1}^n I_i, \mathrm{Pushout}(D) )$
#! @Arguments D
DeclareOperation( "PushoutProjectionFromCoproduct",
                  [ IsList ] );

#! @Description
#! This is a convenience method.
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$.
#! The output is the natural projection
#! $\bigoplus_{i=1}^n I_i \rightarrow \mathrm{Pushout}(D)$.
#! @Returns a morphism in $\mathrm{Hom}( \bigoplus_{i=1}^n I_i, \mathrm{Pushout}(D) )$
#! @Arguments D
DeclareOperation( "PushoutProjectionFromDirectSum",
                  [ IsList ] );

#! @Description
#! The argument is a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$.
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
#! and an object $I = \mathrm{Pushout}(D)$.
#! The output is the $k$-th injection
#! $\iota_k: I_k \rightarrow I$.
#! @Returns a morphism in $\mathrm{Hom}( I_k, I )$.
#! @Arguments D, k, I
DeclareOperation( "InjectionOfCofactorOfPushoutWithGivenPushout",
                  [ IsList, IsInt, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$.
#! The output is the composition $\mu: B \rightarrow \mathrm{Pushout}(D)$
#! of $\beta_1$ and the $1$-st injection $\iota_1: I_1 \rightarrow \mathrm{Pushout}( D )$.
#! @Returns a morphism in $\mathrm{Hom}( B, \mathrm{Pushout}( D ) )$.
#! @Arguments D
DeclareOperation( "MorphismFromSourceToPushout",
                  [ IsList ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$
#! and an object $I = \mathrm{Pushout}(D)$.
#! The output is the composition $\mu: B \rightarrow I$
#! of $\beta_1$ and the $1$-st injection $\iota_1: I_1 \rightarrow I$.
#! @Returns a morphism in $\mathrm{Hom}( B, I )$.
#! @Arguments D, I
DeclareOperation( "MorphismFromSourceToPushoutWithGivenPushout",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$, a test object $T$,
#! and a list of morphisms $\tau = ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ such that
#! $\tau_i \circ \beta_i \sim_{B,T} \tau_j \circ \beta_j$.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u( \tau ): \mathrm{Pushout}(D) \rightarrow T$
#! given by the universal property of the pushout.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Pushout}(D), T )$
#! @Arguments D, T, tau
DeclareOperation( "UniversalMorphismFromPushout",
                  [ IsList, IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a list of morphisms $D = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$, a test object $T$,
#! a list of morphisms $\tau = ( \tau_i: I_i \rightarrow T )_{i = 1 \dots n}$ such that
#! $\tau_i \circ \beta_i \sim_{B,T} \tau_j \circ \beta_j$,
#! and an object $I = \mathrm{Pushout}(D)$.
#! For convenience, the test object <A>T</A> can be omitted and is automatically derived from <A>tau</A> in that case.
#! The output is the morphism
#! $u( \tau ): I \rightarrow T$
#! given by the universal property of the pushout.
#! @Returns a morphism in $\mathrm{Hom}( I, T )$
#! @Arguments D, T, tau, I
DeclareOperation( "UniversalMorphismFromPushoutWithGivenPushout",
                  [ IsList, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are three lists of morphisms
#! $L_s = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$,
#! $L_m = ( \mu_i: I_i \rightarrow I_i' )_{i = 1 \dots n}$,
#! $L_r = (  \beta_i': B' \rightarrow I_i' )_{i = 1 \dots n}$
#! having the same length $n$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \beta \sim_{B, I_i'} \mu_i \circ \beta_i$ for $i = 1, \dots n$.
#! The output is the morphism
#! $\mathrm{Pushout}( ( \beta_i )_{i=1}^n ) \rightarrow \mathrm{Pushout}( ( \beta_i' )_{i=1}^n )$
#! given by the functoriality of the pushout.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Pushout}( ( \beta_i )_{i=1}^n ), \mathrm{Pushout}( ( \beta_i' )_{i=1}^n ))$
#! @Arguments Ls, Lm, Lr
DeclareOperation( "PushoutFunctorial",
                  [ IsList, IsList, IsList ] );


#! @Description
#! The arguments are an object $s = \mathrm{Pushout}( ( \beta_i )_{i=1}^n )$,
#! three lists of morphisms
#! $L_s = ( \beta_i: B \rightarrow I_i )_{i = 1 \dots n}$,
#! $L_m = ( \mu_i: I_i \rightarrow I_i' )_{i = 1 \dots n}$,
#! $L_r = ( \beta_i': B' \rightarrow I_i' )_{i = 1 \dots n}$
#! having the same length $n$
#! such that there exists a morphism $\beta: B \rightarrow B'$
#! such that $\beta_i' \circ \beta \sim_{B, I_i'} \mu_i \circ \beta_i$ for $i = 1, \dots n$,
#! and an object $r = \mathrm{Pushout}( ( \beta_i' )_{i=1}^n )$.
#! The output is the morphism
#! $s \rightarrow r$
#! given by the functoriality of the pushout.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, Ls, Lm, Lr, r
DeclareOperation( "PushoutFunctorialWithGivenPushouts",
                  [ IsCapCategoryObject, IsList, IsList, IsList, IsCapCategoryObject ] );

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

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \node (A) at (-\w,0) {$A$};
#! \node (B) at (\w,0) {$B$};
#! \node (I) at (0,-\w) {$I$};
#! \node (T) at (0,-2*\w) {$T$};
#! \draw[-latex] (A) to node[pos=0.45, above] {$\alpha$} (B);
#! \draw[-latex] (A) to node[pos=0.45, above right] {$c$} (I);
#! \draw[right hook-latex] (I) to node[pos=0.45, above left] {$\iota$} (B);
#! \draw[-latex] (A) to [out = -90, in = 180] node[pos=0.45, below left] {$\tau_1$} (T);
#! \draw[right hook-latex] (T) to [out = 0, in = -90] node[pos=0.45, right] {$\tau_2$} (B);
#! \draw[-latex, dashed] (I) to node[pos=0.45, right] {$u( \tau )$} (T);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is the canonical morphism
#! $\mathrm{im}(\alpha) \rightarrow \mathrm{KernelObject}( \mathrm{CokernelProjection}( \alpha ) )$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{im}(\alpha), \mathrm{KernelObject}( \mathrm{CokernelProjection}( \alpha ) ) )$
#! @Arguments alpha
DeclareAttribute( "IsomorphismFromImageObjectToKernelOfCokernel",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is the canonical morphism
#! $\mathrm{KernelObject}( \mathrm{CokernelProjection}( \alpha ) ) \rightarrow \mathrm{im}(\alpha)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{KernelObject}( \mathrm{CokernelProjection}( \alpha ) ), \mathrm{im}(\alpha) )$
#! @Arguments alpha
DeclareAttribute( "IsomorphismFromKernelOfCokernelToImageObject",
                  IsCapCategoryMorphism );

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

#! @Description
#! The arguments are three morphisms
#! $\alpha: A \rightarrow B$, $\nu: B \rightarrow B'$, $\alpha': A' \rightarrow B'$.
#! The output is the morphism
#! $\mathrm{ImageObject}( \alpha ) \rightarrow \mathrm{ImageObject}( \alpha' )$
#! given by the functoriality of the image.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{ImageObject}( \alpha ), \mathrm{ImageObject}( \alpha' ) )$
#! @Arguments alpha, nu, alpha_prime
DeclareOperation( "ImageObjectFunctorial",
        [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{ImageObject}( \alpha )$,
#! three morphisms
#! $\alpha: A \rightarrow B$, $\nu: B \rightarrow B'$, $\alpha': A' \rightarrow B'$,
#! and an object $r = \mathrm{ImageObject}( \alpha' )$.
#! The output is the morphism
#! $\mathrm{ImageObject}( \alpha ) \rightarrow \mathrm{ImageObject}( \alpha' )$
#! given by the functoriality of the image.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, alpha, nu, alpha_prime, r
DeclareOperation( "ImageObjectFunctorialWithGivenImageObjects",
        [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

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

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2}
#! \node (A) at (-\w,0) {$A$};
#! \node (B) at (\w,0) {$B$};
#! \node (C) at (0,-\w) {$C$};
#! \node (T) at (0,-2*\w) {$T$};
#! \draw[-latex] (A) to node[pos=0.45, above] {$\alpha$} (B);
#! \draw[-twohead] (A) to node[pos=0.45, above right] {$\pi$} (C);
#! \draw[-latex] (C) to node[pos=0.45, above left] {$a$} (B);
#! \draw[-twohead] (A) to [out = -90, in = 180] node[pos=0.45, below left] {$\tau_1$} (T);
#! \draw[-latex] (T) to [out = 0, in = -90] node[pos=0.45, right] {$\tau_2$} (B);
#! \draw[-latex, dashed] (T) to node[pos=0.45, right] {$u( \tau )$} (C);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the canonical morphism
#! $\mathrm{coim}( \alpha ) \rightarrow \mathrm{CokernelObject}( \mathrm{KernelEmbedding}( \alpha ) )$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{coim}( \alpha ), \mathrm{CokernelObject}( \mathrm{KernelEmbedding}( \alpha ) ) )$.
#! @Arguments alpha
DeclareAttribute( "IsomorphismFromCoimageToCokernelOfKernel",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the canonical morphism
#! $\mathrm{CokernelObject}( \mathrm{KernelEmbedding}( \alpha ) ) \rightarrow \mathrm{coim}( \alpha )$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{CokernelObject}( \mathrm{KernelEmbedding}( \alpha ) ), \mathrm{coim}( \alpha ) )$.
#! @Arguments alpha
DeclareAttribute( "IsomorphismFromCokernelOfKernelToCoimage",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is the coimage $\mathrm{coim}( \alpha )$.
#! @Returns an object
#! @Arguments alpha
DeclareAttribute( "CoimageObject",
                  IsCapCategoryMorphism );

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
DeclareOperation( "CoimageProjectionWithGivenCoimageObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

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
DeclareOperation( "AstrictionToCoimageWithGivenCoimageObject",
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
DeclareOperation( "UniversalMorphismIntoCoimageWithGivenCoimageObject",
                  [ IsCapCategoryMorphism, IsList, IsCapCategoryObject ] );

#! Whenever the <C>CoastrictionToImage</C> is an epi,
#! or the <C>AstrictionToCoimage</C> is a mono,
#! there is a canonical morphism from the image to the coimage.
#! If this canonical morphism is an isomorphism, we call it
#! the <Emph>canonical identification</Emph> (between image and coimage).


#! @Description
#! The arguments are three morphisms
#! $\alpha: A \rightarrow B, \mu: A \rightarrow A', \alpha': A' \rightarrow B'$.
#! The output is the morphism
#! $\mathrm{CoimageObject}( \alpha ) \rightarrow \mathrm{CoimageObject}( \alpha' )$
#! given by the functoriality of the coimage.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{CoimageObject}( \alpha ), \mathrm{CoimageObject}( \alpha' ))$
#! @Arguments alpha, mu, alpha_prime
DeclareOperation( "CoimageObjectFunctorial",
        [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );


#! @Description
#! The arguments are an object $s = \mathrm{CoimageObject}( \alpha )$,
#! three morphisms
#! $\alpha: A \rightarrow B, \mu: A \rightarrow A', \alpha': A' \rightarrow B'$,
#! and an object $r = \mathrm{CoimageObject}( \alpha' )$.
#! The output is the morphism
#! $\mathrm{CoimageObject}( \alpha ) \rightarrow \mathrm{CoimageObject}( \alpha' )$
#! given by the functoriality of the coimage.
#! @Returns a morphism in $\mathrm{Hom}(s, r)$
#! @Arguments s, alpha, mu, alpha_prime, r
DeclareOperation( "CoimageObjectFunctorialWithGivenCoimageObjects",
        [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

####################################
##
#! @Section Morphism between Coimage and Image
##
####################################

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
#! @Arguments C, alpha, I
DeclareOperation( "MorphismFromCoimageToImageWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The argument is a morphism $\alpha: A \rightarrow B$.
#! The output is the inverse of the canonical morphism (in an abelian category)
#! $\mathrm{im}(\alpha) \rightarrow \mathrm{coim}(\alpha)$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{im}(\alpha), \mathrm{coim}(\alpha))$
#! @Arguments alpha
DeclareAttribute( "InverseOfMorphismFromCoimageToImage",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $C = \mathrm{coim}(\alpha)$,
#! a morphism $\alpha: A \rightarrow B$,
#! and an object $I = \mathrm{im}(\alpha)$.
#! The output is the inverse of the canonical morphism (in an abelian category)
#! $I \rightarrow C$.
#! @Returns a morphism in $\mathrm{Hom}(I,C)$
#! @Arguments I, alpha, C
DeclareOperation( "InverseOfMorphismFromCoimageToImageWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Chapter Universal Objects

####################################
##
#! @Section Homology objects
##
####################################

#! In an abelian category, we can define the operation
#! that takes as an input a pair of morphisms $\alpha: A \rightarrow B$, $\beta: B \rightarrow C$
#! and outputs the subquotient of $B$ given by
#! * $H := \mathrm{KernelObject}( \beta )/ (\mathrm{KernelObject}( \beta ) \cap \mathrm{ImageObject( \alpha )}$).
#! This object is called a <Emph>homology object</Emph> of the pair $\alpha, \beta$.
#! Note that we do not need the precomposition of $\alpha$ and $\beta$ to be zero
#! in order to make sense of this notion.

#! Moreover, given a second pair $\gamma: D \rightarrow E$, $\delta: E \rightarrow F$ of morphisms,
#! and a morphism $\epsilon: B \rightarrow E$ such that
#! there exists $\omega_1: A \rightarrow D$, $\omega_2: C \rightarrow F$
#! with $\epsilon \circ \alpha \sim_{A,E} \gamma \circ \omega_1$
#! and $\omega_2 \circ \beta \sim_{B,F} \delta \circ \epsilon$
#! there is a functorial way to obtain from these data a morphism between the two corresponding homology objects.

## Main Operations and Attributes
#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B, \beta: B \rightarrow C$.
#! The output is the homology object $H$ of this pair.
#! @Returns an object
#! @Arguments alpha, beta
DeclareOperation( "HomologyObject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The argument are five morphisms $\alpha: A \rightarrow B$, $\beta: B \rightarrow C$,
#! $\epsilon: B \rightarrow E$,
#! $\gamma: D \rightarrow E, \delta: E \rightarrow F$
#! such that
#! there exists $\omega_1: A \rightarrow D$, $\omega_2: C \rightarrow F$
#! with $\epsilon \circ \alpha \sim_{A,E} \gamma \circ \omega_1$
#! and $\omega_2 \circ \beta \sim_{B,F} \delta \circ \epsilon$.
#! The output is the functorial morphism induced by $\epsilon$ between the corresponding homology objects $H_1$ and $H_2$,
#! where $H_1$ denotes the homology object of the pair $\alpha, \beta$,
#! and $H_2$ denotes the homology object of the pair $\gamma, \delta$.
#! @Returns a morphism in $\mathrm{Hom}( H_1, H_2 )$
#! @Arguments alpha, beta, epsilon, gamma, delta
DeclareOperation( "HomologyObjectFunctorial",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! @Description
#! The arguments are an object $H_1$, a list $L$ consisting of five morphisms $\alpha: A \rightarrow B$, $\beta: B \rightarrow C$,
#! $\epsilon: B \rightarrow E$,
#! $\gamma: D \rightarrow E, \delta: E \rightarrow F$,
#! and an object $H_2$, such that
#! $H_1 = \mathrm{HomologyObject}( \alpha, \beta )$
#! and $H_2 = \mathrm{HomologyObject}( \gamma, \delta )$,
#! and such that there exists $\omega_1: A \rightarrow D$, $\omega_2: C \rightarrow F$
#! with $\epsilon \circ \alpha \sim_{A,E} \gamma \circ \omega_1$
#! and $\omega_2 \circ \beta \sim_{B,F} \delta \circ \epsilon$.
#! The output is the functorial morphism induced by $\epsilon$ between the corresponding homology objects $H_1$ and $H_2$,
#! where $H_1$ denotes the homology object of the pair $\alpha, \beta$,
#! and $H_2$ denotes the homology object of the pair $\gamma, \delta$.
#! @Returns a morphism in $\mathrm{Hom}( H_1, H_2 )$
#! @Arguments H_1, L, H_2
DeclareOperation( "HomologyObjectFunctorialWithGivenHomologyObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B, \beta: B \rightarrow C$.
#! The output is the natural isomorphism from the homology object $H$ of $\alpha$ and $\beta$
#! to the construction of the homology object as
#! $\mathrm{ImageObject}( \mathrm{PreCompose}( \mathrm{KernelEmbedding}( \beta ), \mathrm{CokernelProjection}( \alpha ) ) )$,
#! denoted by $I$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{HomologyObject}( \alpha, \beta ), I )$
#! @Arguments alpha, beta
DeclareOperation( "IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha: A \rightarrow B, \beta: B \rightarrow C$.
#! The output is the natural isomorphism from the construction of the homology object as
#! $\mathrm{ImageObject}( \mathrm{PreCompose}( \mathrm{KernelEmbedding}( \beta ), \mathrm{CokernelProjection}( \alpha ) ) )$,
#! denoted by $I$,
#! to the homology object $H$ of $\alpha$ and $\beta$.
#! @Returns a morphism in $\mathrm{Hom}( I, \mathrm{HomologyObject}( \alpha, \beta ) )$
#! @Arguments alpha, beta
DeclareOperation( "IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Chapter Universal Objects

###################################
##
#! @Section Projective covers and injective envelopes
##
###################################

#! @Description
#!  The argument is an object $A$.
#!  The output is a projective cover of $A$.
#! @Arguments A
#! @Returns an object
DeclareAttribute( "ProjectiveCoverObject",
        IsCapCategoryObject );

#! @Description
#!  The argument is an object $A$.
#!  The output is an epimorphism from a projective cover of $A$.
#! @Arguments A
#! @Returns an epimorphism
DeclareAttribute( "EpimorphismFromProjectiveCoverObject",
        IsCapCategoryObject );

#! @Description
#!  The argument is an object $A$.
#!  The output is the epimorphism from the projective cover $P$ of $A$.
#! @Arguments A, P
#! @Returns an epimorphism
DeclareOperation( "EpimorphismFromProjectiveCoverObjectWithGivenProjectiveCoverObject",
        [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  The argument is an object $A$.
#!  The output is an injective envelope of $A$.
#! @Arguments A
#! @Returns an object
DeclareAttribute( "InjectiveEnvelopeObject",
        IsCapCategoryObject );

#! @Description
#!  The argument is an object $A$.
#!  The output is a monomorphism into an injective envelope of $A$.
#! @Arguments A
#! @Returns a monomorphism
DeclareAttribute( "MonomorphismIntoInjectiveEnvelopeObject",
        IsCapCategoryObject );

#! @Description
#!  The argument is an object $A$.
#!  The output is a monomorphism into an injective envelope $I$ of $A$.
#! @Arguments A, I
#! @Returns a monomorphism
DeclareOperation( "MonomorphismIntoInjectiveEnvelopeObjectWithGivenInjectiveEnvelopeObject",
        [ IsCapCategoryObject, IsCapCategoryObject ] );

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
