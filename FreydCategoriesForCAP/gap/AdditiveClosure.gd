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
DeclareCategory( "IsAdditiveClosureCategory",
                 IsCapCategory );

#! @Description
#! The GAP category of objects in additive closures of Ab-categories.
#! @Arguments object
DeclareCategory( "IsAdditiveClosureObject",
                 IsCapCategoryObject );

#! @Description
#! The GAP category of morphisms in additive closures of Ab-categories.
#! @Arguments object
DeclareCategory( "IsAdditiveClosureMorphism",
                 IsCapCategoryMorphism );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_ADDITIVE_CLOSURE" );

####################################
##
#! @Section Constructors
##
####################################


#! @Description
#! The input is an Ab-category $C$. The output is its additive closure $C^\oplus$.
#! @Arguments C
#! @Returns a CapCategory
DeclareAttribute( "AdditiveClosure",
                  IsCapCategory );

#! @Description
#! The input is a list of objects $L=[A_1,\dots,A_n]$ in an Ab-category $C$. The output is the formal direct sum
#! $A_1\oplus\dots\oplus A_n$ in the additive closure $C^\oplus$.
#! @Arguments L, C^\oplus
#! @Returns a CapCategoryObject
DeclareOperation( "AdditiveClosureObject",
                  [ IsList, IsAdditiveClosureCategory ] );

#! @Description
#! The input is an object $A$ in an Ab-category $C$. The output is the image of $A$ under the inclusion functor $\iota:C\to C^\oplus$.
#! @Arguments A
#! @Returns a CapCategoryObject
DeclareAttribute( "AsAdditiveClosureObject",
                  IsCapCategoryObject );

#! @Description
#! The input is a formal direct sums $A=A_1\oplus\dots\oplus A_m$, $B=B_1\oplus\dots\oplus B_n$ and 
#! an $m\times n$ matrix $M :=(\alpha_{ij}:A_i\to B_j)_{ij}$ for $i=1,\dots,m,j=1,\dots,n$.
#! The output is the formal morphism between $A$ and $B$ that is defined by $M$.
#! @Arguments A, M, B
#! @Returns a CapCategoryMorphism
DeclareOperation( "AdditiveClosureMorphism",
                  [ IsAdditiveClosureObject, IsList, IsAdditiveClosureObject ] );

#! @Description
#! The input is a morphism $\alpha$ in an Ab-category $C$. The output is the image of $\alpha$ under the inclusion functor $\iota:C\to C^\oplus$.
#! @Arguments alpha
#! @Returns a CapCategoryMorphism
DeclareAttribute( "AsAdditiveClosureMorphism",
                  IsCapCategoryMorphism );

#! @Description
#! The input is an Ab-category $C$. The output is the inclusion functor $\iota:C\to C^\oplus$.
#! @Arguments C
#! @Returns a CapFunctor
DeclareAttribute( "InclusionFunctorInAdditiveClosure",
                  IsCapCategory );

#! @Description
#! The input is a functor $F:C\to D$, and the output is the extension functor
#! $F^\oplus:C^\oplus \to D^\oplus$.
#! @Arguments F
#! @Returns a CapFunctor
DeclareAttribute( "ExtendFunctorToAdditiveClosures",
                  IsCapFunctor );

#! @Description
#! The input is a functor $F:C\to D$, where $D$ is an additive category. The output is the extension functor
#! $F^\oplus:C^\oplus \to D$.
#! @Arguments F
#! @Returns a CapFunctor
DeclareAttribute( "ExtendFunctorWithAdditiveRangeToFunctorFromAdditiveClosureOfSource",
                  IsCapFunctor );

#! @Description
#! The input is a functor $F:C\to D$. If $D$ is not known to be an additive category, then return
#! <C>ExtendFunctorToAdditiveClosures</C>(<A>F</A>), otherwise return
#! <C>ExtendFunctorWithAdditiveRangeToFunctorFromAdditiveClosureOfSource</C>(<A>F</A>).
#! @Arguments F
#! @Returns a CapFunctor
DeclareAttribute( "ExtendFunctorToAdditiveClosureOfSource",
                  IsCapFunctor );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The input is some additive closure category $C^\oplus$. The output is $C$.
#! @Arguments C^\oplus
#! @Returns a CapCategory
DeclareAttribute( "UnderlyingCategory",
                  IsAdditiveClosureCategory );

#! @Description
#! The input is a formal direct sum $A_1\oplus\dots\oplus A_m$. The output is the list $[A_1,\dots,A_m]$.
#! @Arguments A
#! @Returns IsList
DeclareAttribute( "ObjectList",
                  IsAdditiveClosureObject );

#! @Description
#! The input is a morphism $\alpha:A\to B$ between formal direct sums. The output is the defining matrix of $\alpha$.
#! @Arguments alpha
#! @Returns IsList
DeclareAttribute( "MorphismMatrix",
                  IsAdditiveClosureMorphism );

#! @Description
#! The input is a morphism $\alpha:A\to B$ between formal direct sums. The output is the number of summands of the the source.
#! @Arguments alpha
#! @Returns IsInt
DeclareAttribute( "NrRows",
                  IsAdditiveClosureMorphism );

#! @Description
#! The input is a morphism $\alpha:A\to B$ between formal direct sums. The output is the number of summands of the the range.
#! @Arguments alpha
#! @Returns IsInt
DeclareAttribute( "NrColumns",
                  IsAdditiveClosureMorphism );

####################################
##
#! @Section Operators
##
####################################

DeclareOperation( "\[\]",
                  [ IsAdditiveClosureMorphism, IsInt ] );

