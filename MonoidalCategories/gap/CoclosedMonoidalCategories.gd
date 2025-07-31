# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Coclosed Monoidal Categories
##
####################################

DeclareGlobalVariable( "COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCoclosedMonoidalCategory :=
  Concatenation(
          ListOfDefiningOperations( "IsMonoidalCategory" ),
          [ "InternalCoHomOnObjects",
            "InternalCoHomOnMorphisms",
            "CoclosedMonoidalRightEvaluationMorphism",
            "CoclosedMonoidalRightCoevaluationMorphism",
            "CoclosedMonoidalLeftEvaluationMorphism",
            "CoclosedMonoidalLeftCoevaluationMorphism"
            ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the internal cohom object $\mathrm{\underline{coHom}}(a,b)$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "InternalCoHomOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the internal cohom morphism
#! $\mathrm{\underline{coHom}}(\alpha,\beta): \mathrm{\underline{coHom}}(a,b') \rightarrow \mathrm{\underline{coHom}}(a',b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,b'), \mathrm{\underline{coHom}}(a',b) )$
#! @Arguments alpha, beta
DeclareOperation( "InternalCoHomOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{\underline{coHom}}(a,b')$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = \mathrm{\underline{coHom}}(a',b)$.
#! The output is the internal cohom morphism
#! $\mathrm{\underline{coHom}}(\alpha,\beta): \mathrm{\underline{coHom}}(a,b') \rightarrow \mathrm{\underline{coHom}}(a',b)$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, alpha, beta, r
DeclareOperation( "InternalCoHomOnMorphismsWithGivenInternalCoHoms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the coclosed right evaluation morphism $\mathrm{coclev}_{a,b}: b \rightarrow a \otimes \mathrm{\underline{coHom}}(b,a)$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, a \otimes \mathrm{\underline{coHom}}(b,a) )$.
#! @Arguments a, b
DeclareOperation( "CoclosedMonoidalRightEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $r = a \otimes \mathrm{\underline{coHom}}(b,a)$.
#! The output is the coclosed right evaluation morphism $\mathrm{coclev}_{a,b}: b \rightarrow a \otimes \mathrm{\underline{coHom}}(b,a)$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, r )$.
#! @Arguments a, b, r
DeclareOperation( "CoclosedMonoidalRightEvaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the coclosed right coevaluation morphism $\mathrm{coclcoev}_{a,b}: \mathrm{\underline{coHom}}(a \otimes b, a) \rightarrow b$, i.e.,
#! the counit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a \otimes b, a), b )$.
#! @Arguments a, b
DeclareOperation( "CoclosedMonoidalRightCoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{\underline{coHom}}(a \otimes b, a)$.
#! The output is the coclosed right coevaluation morphism $\mathrm{coclcoev}_{a,b}: \mathrm{\underline{coHom}}(a \otimes b, a) \rightarrow b$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( s, b )$.
#! @Arguments a, b, s
DeclareOperation( "CoclosedMonoidalRightCoevaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $b,c$ and a morphism $g: a \rightarrow b \otimes c$.
#! The output is a morphism $f: \mathrm{\underline{coHom}}(a,b) \rightarrow c$
#! corresponding to $g$ under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,b), c )$.
#! @Arguments b, c, g
DeclareOperation( "TensorProductToInternalCoHomRightAdjunctMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $b,c$, a morphism $g: a \rightarrow b \otimes c$ and an object $i = \mathrm{\underline{coHom}}(a,b)$.
#! The output is a morphism $f: \mathrm{\underline{coHom}}(a,b) \rightarrow c$
#! corresponding to $g$ under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( i, c )$.
#! @Arguments b, c, g, i
DeclareOperation( "TensorProductToInternalCoHomRightAdjunctMorphismWithGivenInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and a morphism $f: \mathrm{\underline{coHom}}(a,b) \rightarrow c$.
#! The output is a morphism $g: a \rightarrow b \otimes c$ corresponding to $f$ under the
#! cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a, b \otimes c)$.
#! @Arguments a, b, f
DeclareOperation( "InternalCoHomToTensorProductRightAdjunctMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $a,b$, a morphism $f: \mathrm{\underline{coHom}}(a,b) \rightarrow c$ and an object $t = b \otimes c$.
#! The output is a morphism $g: a \rightarrow t$ corresponding to $f$ under the
#! cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, t )$.
#! @Arguments a, b, f, t
DeclareOperation( "InternalCoHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the coclosed left evaluation morphism $\mathrm{coclev}_{a,b}: b \rightarrow \mathrm{\underline{coHom}}(b,a) \otimes a$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, \mathrm{\underline{coHom}}(b,a) \otimes a )$.
#! @Arguments a, b
DeclareOperation( "CoclosedMonoidalLeftEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{\underline{coHom}}(b,a) \otimes a$.
#! The output is the coclosed left evaluation morphism $\mathrm{coclev}_{a,b}: b \rightarrow \mathrm{\underline{coHom}}(b,a) \otimes a$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, r )$.
#! @Arguments a, b, r
DeclareOperation( "CoclosedMonoidalLeftEvaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the coclosed left coevaluation morphism $\mathrm{coclcoev}_{a,b}: \mathrm{\underline{coHom}}(b \otimes a, a) \rightarrow b$, i.e.,
#! the counit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(b \otimes a, a), b )$.
#! @Arguments a, b
DeclareOperation( "CoclosedMonoidalLeftCoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{\underline{coHom}}(b \otimes a, a)$.
#! The output is the coclosed left coevaluation morphism $\mathrm{coclcoev}_{a,b}: \mathrm{\underline{coHom}}(b \otimes a, a) \rightarrow b$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( s, b )$.
#! @Arguments a, b, s
DeclareOperation( "CoclosedMonoidalLeftCoevaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $b,c$ and a morphism $g: a \rightarrow b \otimes c$.
#! The output is a morphism $f: \mathrm{\underline{coHom}}(a,c) \rightarrow b$
#! corresponding to $g$ under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,c), b )$.
#! @Arguments b, c, g
DeclareOperation( "TensorProductToInternalCoHomLeftAdjunctMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $b,c$, a morphism $g: a \rightarrow b \otimes c$ and an object $i = \mathrm{\underline{coHom}}(a,c)$.
#! The output is a morphism $f: \mathrm{\underline{coHom}}(a,c) \rightarrow b$
#! corresponding to $g$ under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( i, b )$.
#! @Arguments b, c, g, i
DeclareOperation( "TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,c$ and a morphism $f: \mathrm{\underline{coHom}}(a,c) \rightarrow b$.
#! The output is a morphism $g: a \rightarrow b \otimes c$ corresponding to $f$ under the
#! cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a, b \otimes c)$.
#! @Arguments a, c, f
DeclareOperation( "InternalCoHomToTensorProductLeftAdjunctMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $a,c$, a morphism $f: \mathrm{\underline{coHom}}(a,c) \rightarrow b$ and an object $t = b \otimes c$.
#! The output is a morphism $g: a \rightarrow t$ corresponding to $f$ under the
#! cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, t )$.
#! @Arguments a, c, f, t
DeclareOperation( "InternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the precocomposition morphism
#! $\mathrm{MonoidalPreCoComposeMorphism}_{a,b,c}: \mathrm{\underline{coHom}}(a,c) \rightarrow \mathrm{\underline{coHom}}(b,c) \otimes \mathrm{\underline{coHom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,c), \mathrm{\underline{coHom}}(b,c) \otimes \mathrm{\underline{coHom}}(a,b) )$.
#! @Arguments a,b,c
DeclareOperation( "MonoidalPreCoComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{\underline{coHom}}(a,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(b,c)$.
#! The output is the precocomposition morphism
#! $\mathrm{MonoidalPreCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{coHom}}(a,c) \rightarrow \mathrm{\underline{coHom}}(b,c) \otimes \mathrm{\underline{coHom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "MonoidalPreCoComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the postcocomposition morphism
#! $\mathrm{MonoidalPostCoComposeMorphism}_{a,b,c}: \mathrm{\underline{coHom}}(a,c) \rightarrow \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(b,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,c), \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(b,c) )$.
#! @Arguments a,b,c
DeclareOperation( "MonoidalPostCoComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{\underline{coHom}}(a,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{\underline{coHom}}(b,c) \otimes \mathrm{\underline{coHom}}(a,b)$.
#! The output is the postcocomposition morphism
#! $\mathrm{MonoidalPostCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{coHom}}(a,c) \rightarrow \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(b,c)$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "MonoidalPostCoComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is its codual object $a_{\vee}$.
#! @Returns an object
#! @Arguments a
DeclareAttribute( "CoDualOnObjects",
                  IsCapCategoryObject );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its codual morphism $\alpha_{\vee}: b_{\vee} \rightarrow a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b_{\vee}, a_{\vee} )$.
#! @Arguments alpha
DeclareAttribute( "CoDualOnMorphisms",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $s = b_{\vee}$,
#! a morphism $\alpha: a \rightarrow b$,
#! and an object $r = a_{\vee}$.
#! The output is the dual morphism $\alpha_{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,alpha,r
DeclareOperation( "CoDualOnMorphismsWithGivenCoDuals",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a}: 1 \rightarrow a_{\vee} \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( 1, a_{\vee} \otimes a )$.
#! @Arguments a
DeclareAttribute( "CoclosedEvaluationForCoDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $s = 1$,
#! an object $a$,
#! and an object $r = a_{\vee} \otimes a$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a}: 1 \rightarrow a_{\vee} \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,r
DeclareOperation( "CoclosedEvaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the morphism from the cobidual $(a_{\vee})_{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a_{\vee})_{\vee}, a)$.
#! @Arguments a
DeclareAttribute( "MorphismFromCoBidual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$,
#! and an object $s = (a_{\vee})_{\vee}$.
#! The output is the morphism from the cobidual $(a_{\vee})_{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(s, a)$.
#! @Arguments a, s
DeclareOperation( "MorphismFromCoBidualWithGivenCoBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## The four objects are given as a list because otherwise the WithGiven operation would
## exceed the maximal number of arguments for an operation (6)
#! @Description
#! The argument is a list of four objects $[ a, a', b, b' ]$.
#! The output is the natural morphism
#! $\mathrm{InternalCoHomTensorProductCompatibilityMorphism}_{a,a',b,b'}: \mathrm{\underline{coHom}}(a \otimes a', b \otimes b') \rightarrow \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(a',b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a \otimes a', b \otimes b'), \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(a',b'))$.
#! @Arguments list
DeclareOperation( "InternalCoHomTensorProductCompatibilityMorphism",
                  [ IsList ] );

#! @Description
#! The arguments are a list of four objects $[ a, a', b, b' ]$,
#! and two objects $s = \mathrm{\underline{coHom}}(a \otimes a', b \otimes b')$ and $r = \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(a',b')$.
#! The output is the natural morphism
#! $\mathrm{InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{coHom}}(a \otimes a', b \otimes b') \rightarrow \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(a',b')$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s, list, r
DeclareOperation( "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism
#! $\mathrm{CoDualityTensorProductCompatibilityMorphism}: (a \otimes b)_{\vee} \rightarrow a_{\vee} \otimes b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( (a \otimes b)_{\vee}, a_{\vee} \otimes b_{\vee} )$.
#! @Arguments a,b
DeclareOperation( "CoDualityTensorProductCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (a \otimes b)_{\vee}$,
#! two objects $a,b$,
#! and an object $r = a_{\vee} \otimes b_{\vee}$.
#! The output is the natural morphism
#! $\mathrm{CoDualityTensorProductCompatibilityMorphismWithGivenObjects}_{a,b}: (a \otimes b)_{\vee} \rightarrow a_{\vee} \otimes b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,r
DeclareOperation( "CoDualityTensorProductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{MorphismFromInternalCoHomToTensorProduct}_{a,b}: \mathrm{\underline{coHom}}(a,b) \rightarrow b_{\vee} \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,b), b_{\vee} \otimes a )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromInternalCoHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = \mathrm{\underline{coHom}}(a,b)$,
#! two objects $a,b$,
#! and an object $r = b_{\vee} \otimes a$.
#! The output is the natural morphism $\mathrm{MorphismFromInternalCoHomToTensorProductWithGivenObjects}_{a,b}: \mathrm{\underline{coHom}}(a,b) \rightarrow a \otimes b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromInternalCoHomToTensorProductWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit}_{a}: a_{\vee} \rightarrow \mathrm{\underline{coHom}}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee}, \mathrm{\underline{coHom}}(1,a))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject}_{a}: \mathrm{\underline{coHom}}(1,a) \rightarrow a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{\underline{coHom}}(1,a), a_{\vee})$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject",
                  IsCapCategoryObject );

#! @Description
#! The arguments are two objects $t,a$,
#! and a morphism $\alpha: 1 \rightarrow t \otimes a$.
#! The output is the morphism $a_{\vee} \rightarrow t$
#! given by the universal property of $a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee}, t)$.
#! @Arguments t, a, alpha
DeclareOperation( "UniversalPropertyOfCoDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is the corresponding morphism $ \mathrm{\underline{coHom}}(a,b) \rightarrow 1$
#! under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,b), 1 )$.
#! @Arguments alpha
DeclareAttribute( "CoLambdaIntroduction",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are two objects $a,b$,
#! and a morphism $\alpha: \mathrm{\underline{coHom}}(a,b) \rightarrow 1$.
#! The output is a morphism $a \rightarrow b$ corresponding to $\alpha$
#! under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$.
#! @Arguments a,b,alpha
DeclareOperation( "CoLambdaElimination",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{\underline{coHom}}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{\underline{coHom}}(a,1))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromObjectToInternalCoHom",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $r = \mathrm{\underline{coHom}}(a,1)$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{\underline{coHom}}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a, r)$.
#! @Arguments a,r
DeclareOperation( "IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $\mathrm{\underline{coHom}}(a,1) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{\underline{coHom}}(a,1), a)$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromInternalCoHomToObject",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $s = \mathrm{\underline{coHom}}(a,1)$.
#! The output is the natural isomorphism $\mathrm{\underline{coHom}}(a,1) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(s, a)$.
#! @Arguments a,s
DeclareOperation( "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom",
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
#! The output is the internal cohom cell.
#! If $a,b$ are two CAP objects the output is the internal cohom object
#! $\mathrm{\underline{coHom}}(a,b)$.
#! If at least one of the arguments is a CAP morphism the output is a CAP morphism,
#! namely the internal cohom on morphisms, where any object is replaced by its identity morphism.
#! @Returns a cell
#! @Arguments a, b
DeclareOperation( "InternalCoHom",
                  [ IsCapCategoryCell, IsCapCategoryCell ] );
