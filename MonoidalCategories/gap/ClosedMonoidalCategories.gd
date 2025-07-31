# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Closed Monoidal Categories
##
####################################

DeclareGlobalVariable( "CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsClosedMonoidalCategory :=
  Concatenation(
          ListOfDefiningOperations( "IsMonoidalCategory" ),
          [ "InternalHomOnObjects",
            "InternalHomOnMorphisms",
            "ClosedMonoidalRightEvaluationMorphism",
            "ClosedMonoidalRightCoevaluationMorphism",
            "ClosedMonoidalLeftEvaluationMorphism",
            "ClosedMonoidalLeftCoevaluationMorphism"
            ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the internal hom object $\mathrm{\underline{Hom}}(a,b)$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "InternalHomOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the internal hom morphism
#! $\mathrm{\underline{Hom}}(\alpha,\beta): \mathrm{\underline{Hom}}(a',b) \rightarrow \mathrm{\underline{Hom}}(a,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a',b), \mathrm{\underline{Hom}}(a,b') )$
#! @Arguments alpha, beta
DeclareOperation( "InternalHomOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{\underline{Hom}}(a',b)$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = \mathrm{\underline{Hom}}(a,b')$.
#! The output is the internal hom morphism
#! $\mathrm{\underline{Hom}}(\alpha,\beta): \mathrm{\underline{Hom}}(a',b) \rightarrow \mathrm{\underline{Hom}}(a,b')$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, alpha, beta, r
DeclareOperation( "InternalHomOnMorphismsWithGivenInternalHoms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the right evaluation morphism $\mathrm{ev}_{a,b}:a \otimes \mathrm{\underline{Hom}}(a,b) \rightarrow b$, i.e.,
#! the counit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes \mathrm{\underline{Hom}}(a,b), b )$.
#! @Arguments a, b
DeclareOperation( "ClosedMonoidalRightEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $s = a \otimes \mathrm{\underline{Hom}}(a,b)$.
#! The output is the right evaluation morphism $\mathrm{ev}_{a,b}: a \otimes \mathrm{\underline{Hom}}(a,b) \rightarrow b$, i.e.,
#! the counit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( s, b )$.
#! @Arguments a, b, s
DeclareOperation( "ClosedMonoidalRightEvaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the right coevaluation morphism $\mathrm{coev}_{a,b}: b \rightarrow \mathrm{\underline{Hom}}(a, a \otimes b)$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, \mathrm{\underline{Hom}}(a, a \otimes b) )$.
#! @Arguments a, b
DeclareOperation( "ClosedMonoidalRightCoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{\underline{Hom}}(a, a \otimes b)$.
#! The output is the right coevaluation morphism $\mathrm{coev}_{a,b}: b \rightarrow \mathrm{\underline{Hom}}(a, a \otimes b)$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, r )$.
#! @Arguments a, b, r
DeclareOperation( "ClosedMonoidalRightCoevaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and a morphism $f: a \otimes b \rightarrow c$.
#! The output is a morphism $g: b \rightarrow \mathrm{\underline{Hom}}(a,c)$
#! corresponding to $f$ under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, \mathrm{\underline{Hom}}(a,c) )$.
#! @Arguments a, b, f
DeclareOperation( "TensorProductToInternalHomRightAdjunctMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $a,b$, a morphism $f: a \otimes b \rightarrow c$ and an object $i = \mathrm{\underline{Hom}}(a,c)$.
#! The output is a morphism $g: b \rightarrow i$
#! corresponding to $f$ under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, i )$.
#! @Arguments a, b, f, i
DeclareOperation( "TensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the tri-natural isomorphism
#! $H(a \otimes b, c) \to H(b, \mathrm{\underline{Hom}}(a,c))$
#! in the range category of the homomorphism structure $H$.
#! @Returns a morphism in $\mathrm{Hom}( H(a \otimes b, c), H(b, \mathrm{\underline{Hom}}(a,c)) )$.
#! @Arguments a, b, c
DeclareOperation( "TensorProductToInternalHomRightAdjunctionIsomorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are fives objects $s,a,b,c,r$
#! where $s = H(a \otimes b, c)$ and $r = H(b, \mathrm{\underline{Hom}}(a,c))$.
#! The output is the tri-natural isomorphism $s \to r$
#! in the range category of the homomorphism structure $H$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "TensorProductToInternalHomRightAdjunctionIsomorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,c$ and a morphism $g: b \rightarrow \mathrm{\underline{Hom}}(a,c)$.
#! The output is a morphism $f: a \otimes b \rightarrow c$ corresponding to $g$ under the
#! tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes b, c)$.
#! @Arguments a, c, g
DeclareOperation( "InternalHomToTensorProductRightAdjunctMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $a,c$, a morphism $g: b \rightarrow \mathrm{\underline{Hom}}(a,c)$ and an object $s = a \otimes b$.
#! The output is a morphism $f: s \rightarrow c$ corresponding to $g$ under the
#! tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(s, c)$.
#! @Arguments a, c, g, s
DeclareOperation( "InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the tri-natural isomorphism
#! $H(b, \mathrm{\underline{Hom}}(a,c)) \to H(a \otimes b, c)$
#! in the range category of the homomorphism structure $H$.
#! @Returns a morphism in $\mathrm{Hom}( H(b, \mathrm{\underline{Hom}}(a,c)), H(a \otimes b, c) )$.
#! @Arguments a, b, c
DeclareOperation( "InternalHomToTensorProductRightAdjunctionIsomorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are fives objects $s,a,b,c,r$
#! where $s = H(b, \mathrm{\underline{Hom}}(a,c))$ and $r = H(a \otimes b, c)$.
#! The output is the tri-natural isomorphism $s \to r$
#! in the range category of the homomorphism structure $H$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "InternalHomToTensorProductRightAdjunctionIsomorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the left evaluation morphism $\mathrm{ev}_{a,b}: \mathrm{\underline{Hom}}(a,b) \otimes a \rightarrow b$, i.e.,
#! the counit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b) \otimes a, b )$.
#! @Arguments a, b
DeclareOperation( "ClosedMonoidalLeftEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{\underline{Hom}}(a,b) \otimes a$.
#! The output is the left evaluation morphism $\mathrm{ev}_{a,b}: \mathrm{\underline{Hom}}(a,b) \otimes a \rightarrow b$, i.e.,
#! the counit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( s, b )$.
#! @Arguments a, b, s
DeclareOperation( "ClosedMonoidalLeftEvaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the left coevaluation morphism $\mathrm{coev}_{a,b}: b \rightarrow \mathrm{\underline{Hom}}(a, b \otimes a)$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, \mathrm{\underline{Hom}}(a, b \otimes a) )$.
#! @Arguments a, b
DeclareOperation( "ClosedMonoidalLeftCoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{\underline{Hom}}(a, b \otimes a)$.
#! The output is the left coevaluation morphism $\mathrm{coev}_{a,b}: b \rightarrow \mathrm{\underline{Hom}}(a, b \otimes a)$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, r )$.
#! @Arguments a, b, r
DeclareOperation( "ClosedMonoidalLeftCoevaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and a morphism $f: a \otimes b \rightarrow c$.
#! The output is a morphism $g: a \rightarrow \mathrm{\underline{Hom}}(b,c)$
#! corresponding to $f$ under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{\underline{Hom}}(b,c) )$.
#! @Arguments a, b, f
DeclareOperation( "TensorProductToInternalHomLeftAdjunctMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $a,b$, a morphism $f: a \otimes b \rightarrow c$ and an object $i = \mathrm{\underline{Hom}}(b,c)$.
#! The output is a morphism $g: a \rightarrow i$
#! corresponding to $f$ under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, i )$.
#! @Arguments a, b, f, i
DeclareOperation( "TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the tri-natural isomorphism
#! $H(a \otimes b, c) \to H(a, \mathrm{\underline{Hom}}(b,c))$
#! in the range category of the homomorphism structure $H$.
#! @Returns a morphism in $\mathrm{Hom}( H(a \otimes b, c), H(a, \mathrm{\underline{Hom}}(b,c)) )$.
#! @Arguments a, b, c
DeclareOperation( "TensorProductToInternalHomLeftAdjunctionIsomorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are fives objects $s,a,b,c,r$
#! where $s = H(a \otimes b, c)$ and $r = H(a, \mathrm{\underline{Hom}}(b,c))$.
#! The output is the tri-natural isomorphism $s \to r$
#! in the range category of the homomorphism structure $H$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "TensorProductToInternalHomLeftAdjunctionIsomorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $b,c$ and a morphism $g: a \rightarrow \mathrm{\underline{Hom}}(b,c)$.
#! The output is a morphism $f: a \otimes b \rightarrow c$ corresponding to $g$ under the
#! tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes b, c)$.
#! @Arguments b, c, g
DeclareOperation( "InternalHomToTensorProductLeftAdjunctMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $b,c$, a morphism $g: a \rightarrow \mathrm{\underline{Hom}}(b,c)$ and an object $s = a \otimes b$.
#! The output is a morphism $f: s \rightarrow c$ corresponding to $g$ under the
#! tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(s, c)$.
#! @Arguments b, c, g, s
DeclareOperation( "InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the tri-natural isomorphism
#! $H(a, \mathrm{\underline{Hom}}(b,c)) \to H(a \otimes b, c)$
#! in the range category of the homomorphism structure $H$.
#! @Returns a morphism in $\mathrm{Hom}( H(a, \mathrm{\underline{Hom}}(b,c)), H(a \otimes b, c) )$.
#! @Arguments a, b, c
DeclareOperation( "InternalHomToTensorProductLeftAdjunctionIsomorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are fives objects $s,a,b,c,r$
#! where $s = H(a, \mathrm{\underline{Hom}}(b,c))$ and $r = H(a \otimes b, c)$.
#! The output is the tri-natural isomorphism $s \to r$
#! in the range category of the homomorphism structure $H$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "InternalHomToTensorProductLeftAdjunctionIsomorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the precomposition morphism
#! $\mathrm{MonoidalPreComposeMorphism}_{a,b,c}: \mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c) \rightarrow \mathrm{\underline{Hom}}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c), \mathrm{\underline{Hom}}(a,c) )$.
#! @Arguments a,b,c
DeclareOperation( "MonoidalPreComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{\underline{Hom}}(a,c)$.
#! The output is the precomposition morphism
#! $\mathrm{MonoidalPreComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c) \rightarrow \mathrm{\underline{Hom}}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "MonoidalPreComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the postcomposition morphism
#! $\mathrm{MonoidalPostComposeMorphism}_{a,b,c}: \mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b) \rightarrow \mathrm{\underline{Hom}}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b), \mathrm{\underline{Hom}}(a,c) )$.
#! @Arguments a,b,c
DeclareOperation( "MonoidalPostComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{\underline{Hom}}(a,c)$.
#! The output is the postcomposition morphism
#! $\mathrm{MonoidalPostComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b) \rightarrow \mathrm{\underline{Hom}}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "MonoidalPostComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is its dual object $a^{\vee}$.
#! @Returns an object
#! @Arguments a
DeclareAttribute( "DualOnObjects",
                  IsCapCategoryObject );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its dual morphism $\alpha^{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b^{\vee}, a^{\vee} )$.
#! @Arguments alpha
DeclareAttribute( "DualOnMorphisms",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $s = b^{\vee}$,
#! a morphism $\alpha: a \rightarrow b$,
#! and an object $r = a^{\vee}$.
#! The output is the dual morphism $\alpha^{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,alpha,r
DeclareOperation( "DualOnMorphismsWithGivenDuals",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the evaluation morphism $\mathrm{ev}_{a}: a^{\vee} \otimes a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes a, 1 )$.
#! @Arguments a
DeclareAttribute( "EvaluationForDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $s = a^{\vee} \otimes a$,
#! an object $a$,
#! and an object $r = 1$.
#! The output is the evaluation morphism $\mathrm{ev}_{a}: a^{\vee} \otimes a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,r
DeclareOperation( "EvaluationForDualWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the morphism to the bidual $a \rightarrow (a^{\vee})^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a, (a^{\vee})^{\vee})$.
#! @Arguments a
DeclareAttribute( "MorphismToBidual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$,
#! and an object $r = (a^{\vee})^{\vee}$.
#! The output is the morphism to the bidual $a \rightarrow (a^{\vee})^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a, r)$.
#! @Arguments a, r
DeclareOperation( "MorphismToBidualWithGivenBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## The four objects are given as a list because otherwise the WithGiven operation would
## exceed the maximal number of arguments for an operation (6)
#! @Description
#! The argument is a list of four objects $[ a, a', b, b' ]$.
#! The output is the natural morphism
#! $\mathrm{TensorProductInternalHomCompatibilityMorphism}_{a,a',b,b'}: \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b') \rightarrow \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'), \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b'))$.
#! @Arguments list
DeclareOperation( "TensorProductInternalHomCompatibilityMorphism",
                  [ IsList ] );

#! @Description
#! The arguments are a list of four objects $[ a, a', b, b' ]$,
#! and two objects $s = \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b')$ and $r = \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b')$.
#! The output is the natural morphism
#! $\mathrm{TensorProductInternalHomCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b') \rightarrow \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b')$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s, list, r
DeclareOperation( "TensorProductInternalHomCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism
#! $\mathrm{TensorProductDualityCompatibilityMorphism}: a^{\vee} \otimes b^{\vee} \rightarrow (a \otimes b)^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b^{\vee}, (a \otimes b)^{\vee} )$.
#! @Arguments a,b
DeclareOperation( "TensorProductDualityCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a^{\vee} \otimes b^{\vee}$,
#! two objects $a,b$,
#! and an object $r = (a \otimes b)^{\vee}$.
#! The output is the natural morphism
#! $\mathrm{TensorProductDualityCompatibilityMorphismWithGivenObjects}_{a,b}: a^{\vee} \otimes b^{\vee} \rightarrow (a \otimes b)^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,r
DeclareOperation( "TensorProductDualityCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{MorphismFromTensorProductToInternalHom}_{a,b}: a^{\vee} \otimes b \rightarrow \mathrm{\underline{Hom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b, \mathrm{\underline{Hom}}(a,b) )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromTensorProductToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a^{\vee} \otimes b$,
#! two objects $a,b$,
#! and an object $r = \mathrm{\underline{Hom}}(a,b)$.
#! The output is the natural morphism $\mathrm{MorphismFromTensorProductToInternalHomWithGivenObjects}_{a,b}: a^{\vee} \otimes b \rightarrow \mathrm{\underline{Hom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromTensorProductToInternalHomWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromDualObjectToInternalHomIntoTensorUnit}_{a}: a^{\vee} \rightarrow \mathrm{\underline{Hom}}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a^{\vee}, \mathrm{\underline{Hom}}(a,1))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromDualObjectToInternalHomIntoTensorUnit",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromInternalHomIntoTensorUnitToDualObject}_{a}: \mathrm{\underline{Hom}}(a,1) \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{\underline{Hom}}(a,1), a^{\vee})$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromInternalHomIntoTensorUnitToDualObject",
                  IsCapCategoryObject );

#! @Description
#! The arguments are two objects $t,a$,
#! and a morphism $\alpha: t \otimes a \rightarrow 1$.
#! The output is the morphism $t \rightarrow a^{\vee}$
#! given by the universal property of $a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(t, a^{\vee})$.
#! @Arguments t, a, alpha
DeclareOperation( "UniversalPropertyOfDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is the corresponding morphism $1 \rightarrow \mathrm{\underline{Hom}}(a,b)$
#! under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( 1, \mathrm{\underline{Hom}}(a,b) )$.
#! @Arguments alpha
DeclareAttribute( "LambdaIntroduction",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are two objects $a,b$,
#! and a morphism $\alpha: 1 \rightarrow \mathrm{\underline{Hom}}(a,b)$.
#! The output is a morphism $a \rightarrow b$ corresponding to $\alpha$
#! under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$.
#! @Arguments a,b,alpha
DeclareOperation( "LambdaElimination",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{\underline{Hom}}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{\underline{Hom}}(1,a))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromObjectToInternalHom",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $r = \mathrm{\underline{Hom}}(1,a)$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{\underline{Hom}}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a, r)$.
#! @Arguments a,r
DeclareOperation( "IsomorphismFromObjectToInternalHomWithGivenInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $\mathrm{\underline{Hom}}(1,a) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{\underline{Hom}}(1,a),a)$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromInternalHomToObject",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $s = \mathrm{\underline{Hom}}(1,a)$.
#! The output is the natural isomorphism $\mathrm{\underline{Hom}}(1,a) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(s,a)$.
#! @Arguments a,s
DeclareOperation( "IsomorphismFromInternalHomToObjectWithGivenInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

####################################
##
#! @Section Convenience Methods
##
####################################

##
#! @Description
#! This is a convenience method.
#! The arguments are two cells $a,b$.
#! The output is the internal hom cell.
#! If $a,b$ are two CAP objects the output is the internal Hom object
#! $\mathrm{\underline{Hom}}(a,b)$.
#! If at least one of the arguments is a CAP morphism the output is a CAP morphism,
#! namely the internal hom on morphisms, where any object is replaced by its identity morphism.
#! @Returns a cell
#! @Arguments a, b
DeclareOperation( "InternalHom",
                  [ IsCapCategoryCell, IsCapCategoryCell ] );
