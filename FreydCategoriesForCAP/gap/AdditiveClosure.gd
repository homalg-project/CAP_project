#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#! @Chapter Additive closure
#!
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of additive closures of Ab-categories.
#! @Arguments object
#! @Returns true or false
DeclareCategory( "IsAdditiveClosureCategory",
                 IsCapCategory );

#! @Description
#! The GAP category of objects in additive closures of Ab-categories.
#! @Arguments object
#! @Returns true or false
DeclareCategory( "IsAdditiveClosureObject",
                 IsCapCategoryObject );

#! @Description
#! The GAP category of morphisms in additive closures of Ab-categories.
#! @Arguments object
#! @Returns true or false
DeclareCategory( "IsAdditiveClosureMorphism",
                 IsCapCategoryMorphism );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_ADDITIVE_CLOSURE" );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_OF_RANDOM_METHODS_FOR_ADDITIVE_CLOSURE" );

####################################
##
#! @Section Constructors
##
####################################


#! @Description
#! The argument is an Ab-category $C$. The output is its additive closure $C^\oplus$.
#! @Arguments C
#! @Returns the category $C^\oplus$
DeclareAttribute( "AdditiveClosure",
                  IsCapCategory );

#! @Description
#! The argument is a list of objects $L=[A_1,\dots,A_n]$ in an Ab-category $C$. The output is the formal direct sum
#! $A_1\oplus\dots\oplus A_n$ in the additive closure $C^\oplus$.
#! @Arguments L, C^\oplus
#! @Returns an object in $C^\oplus$
DeclareOperation( "AdditiveClosureObject",
                  [ IsList, IsAdditiveClosureCategory ] );

#! @Description
#! The argument is an object $A$ in an Ab-category $C$. The output is the image of $A$ under the inclusion functor $\iota:C\to C^\oplus$.
#! @Arguments A
#! @Returns an object in $C^\oplus$
DeclareAttribute( "AsAdditiveClosureObject",
                  IsCapCategoryObject );

#! @Description
#! The arguments are formal direct sums $A=A_1\oplus\dots\oplus A_m$, $B=B_1\oplus\dots\oplus B_n$ in some additive category $C^\oplus$
#! and an $m\times n$ matrix $M :=(\alpha_{ij}:A_i\to B_j)_{ij}$ for $i=1,\dots,m,j=1,\dots,n$.
#! The output is the formal morphism between $A$ and $B$ that is defined by $M$.
#! @Arguments A, M, B
#! @Returns a morphism in $\mathrm{Hom}_{C^\oplus}(A,B)$
DeclareOperation( "AdditiveClosureMorphism",
                  [ IsAdditiveClosureObject, IsList, IsAdditiveClosureObject ] );

#! @Description
#! The argument is a morphism $\alpha$ in an Ab-category $C$. The output is the image of $\alpha$ under the inclusion functor $\iota:C\to C^\oplus$.
#! @Arguments alpha
#! @Returns a morphism in $C^\oplus$
DeclareAttribute( "AsAdditiveClosureMorphism",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an Ab-category $C$. The output is the inclusion functor $\iota:C\to C^\oplus$.
#! @Arguments C
#! @Returns a functor $C\to C^\oplus$
DeclareAttribute( "InclusionFunctorInAdditiveClosure",
                  IsCapCategory );

#! @Description
#! The argument is a functor $F:C\to D$, and the output is the extension functor
#! $F^\oplus:C^\oplus \to D^\oplus$.
#! @Arguments F
#! @Returns a functor $C^\oplus \to D^\oplus$
DeclareAttribute( "ExtendFunctorToAdditiveClosures",
                  IsCapFunctor );

#! @Description
#! The argument is a functor $F:C\to D$, where $D$ is an additive category. The output is the extension functor
#! $F^\oplus:C^\oplus \to D$.
#! @Arguments F
#! @Returns a functor $C^\oplus \to D$
DeclareAttribute( "ExtendFunctorWithAdditiveRangeToFunctorFromAdditiveClosureOfSource",
                  IsCapFunctor );

#! @Description
#! The argument is a functor $F:C\to D$. If $D$ is not known to be an additive category, then return
#! <C>ExtendFunctorToAdditiveClosures</C>(<A>F</A>), otherwise return
#! <C>ExtendFunctorWithAdditiveRangeToFunctorFromAdditiveClosureOfSource</C>(<A>F</A>).
#! @Arguments F
#! @Returns a functor $C^\oplus \to D^\oplus$ or $C^\oplus \to D$
DeclareAttribute( "ExtendFunctorToAdditiveClosureOfSource",
                  IsCapFunctor );

#! @Description
#! The argument is a natural transformation $\eta:(F:C\to D)\Rightarrow (G:C\to D)$ where $D$
#! is an additive category.
#! The ouput is the extension natural transformation
#! $\eta^\oplus:(F^\oplus:C^\oplus\to D)\to(G^\oplus:C^\oplus\to D)$.
#! @Arguments eta
#! @Returns a natural transformation from $F^\oplus$ to $G^\oplus$
DeclareAttribute( "ExtendNaturalTransformationToAdditiveClosureOfSource",
                  IsCapNaturalTransformation );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is some additive closure category $A:=C^\oplus$. The output is $C$.
#! @Arguments A
#! @Returns the category $C$
DeclareAttribute( "UnderlyingCategory",
                  IsAdditiveClosureCategory );

#! @Description
#! The argument is a formal direct sum $A:=A_1\oplus\dots\oplus A_m$ in some additive closure category $C^\oplus$.
#! The output is the list $[A_1,\dots,A_m]$.
#! @Arguments A
#! @Returns a list of the objects in $C$
DeclareAttribute( "ObjectList",
                  IsAdditiveClosureObject );

#! @Description
#! The argument is a morphism $\alpha:A\to B$ between formal direct sums in some additive closure category $C^\oplus$.
#! The output is the defining matrix of $\alpha$.
#! @Arguments alpha
#! @Returns a list of lists the morphisms in $C$
DeclareAttribute( "MorphismMatrix",
                  IsAdditiveClosureMorphism );

#! @Description
#! The argument is a morphism $\alpha:A\to B$ between formal direct sums. The output is the number of summands of the the source.
#! @Arguments alpha
#! @Returns a non-negative integer
DeclareAttribute( "NrRows",
                  IsAdditiveClosureMorphism );

#! @Description
#! The argument is a morphism $\alpha:A\to B$ between formal direct sums. The output is the number of summands of the the range.
#! @Arguments alpha
#! @Returns a non-negative integer
DeclareAttribute( "NrColumns",
                  IsAdditiveClosureMorphism );

####################################
##
#! @Section Operators
##
####################################

#! @Description
#! The arguments are a formal direct sum $A$ in some additive category $C^\oplus$ and an integers $i$.
#! The output is the $i$'th entry in <C>ObjectList</C>($A$).
#! @Arguments A, i
#! @Returns an object in $C$
DeclareOperation( "\[\]",
                  [ IsAdditiveClosureObject, IsInt ] );


#! @Description
#! The arguments are morphism $\alpha:A\to B$ between formal direct sums in some additive category $C^\oplus$ and an integer $i$.
#! The output is the $i$'th entry in <C>MorphismMatrix</C>($\alpha$).
#! @Arguments alpha, i
#! @Returns a list of morphisms in $C$
DeclareOperation( "\[\]",
                  [ IsAdditiveClosureMorphism, IsInt ] );

#! @Description
#! The arguments are a morphism $\alpha:A\to B$ between formal direct sums in some additive category $C^\oplus$ and two integers $i,j$.
#! The output is the $(i,j)$'th entry in <C>MorphismMatrix</C>($\alpha$).
#! @Arguments alpha, i, j
#! @Returns a morphism $C$
DeclareOperation( "\[\]",
                  [ IsAdditiveClosureMorphism, IsInt, IsInt ] );

#! @Description
#! The input is either a list of objects or list of lists of morphisms. The method delegates to
#! either <C>AdditiveClosureObject</C> or <C>AdditiveClosureMorphism</C>.
DeclareOperation( "\/",
                  [ IsList, IsAdditiveClosureCategory ] );

#! @Description
#! This is a convenience method for
#! <C>AsAdditiveClosureObject</C> and <C>AsAdditiveClosureMorphism</C>.
DeclareOperation( "\/",
                  [ IsCapCategoryCell, IsAdditiveClosureCategory ] );
