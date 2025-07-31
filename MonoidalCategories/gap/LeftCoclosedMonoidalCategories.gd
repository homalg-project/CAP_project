# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Left Coclosed Monoidal Categories
##
####################################

DeclareGlobalVariable( "LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsLeftCoclosedMonoidalCategory :=
  Concatenation(
          ListOfDefiningOperations( "IsMonoidalCategory" ),
          [ "LeftInternalCoHomOnObjects",
            "LeftInternalCoHomOnMorphisms",
            "LeftCoclosedMonoidalEvaluationMorphism",
            "LeftCoclosedMonoidalCoevaluationMorphism"
            ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the internal cohom object $\mathrm{\underline{coHom}_\ell}(a,b)$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "LeftInternalCoHomOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the internal cohom morphism
#! $\mathrm{\underline{coHom}_\ell}(\alpha,\beta): \mathrm{\underline{coHom}_\ell}(a,b') \rightarrow \mathrm{\underline{coHom}_\ell}(a',b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}_\ell}(a,b'), \mathrm{\underline{coHom}_\ell}(a',b) )$
#! @Arguments alpha, beta
DeclareOperation( "LeftInternalCoHomOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{\underline{coHom}_\ell}(a,b')$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = \mathrm{\underline{coHom}_\ell}(a',b)$.
#! The output is the internal cohom morphism
#! $\mathrm{\underline{coHom}_\ell}(\alpha,\beta): \mathrm{\underline{coHom}_\ell}(a,b') \rightarrow \mathrm{\underline{coHom}_\ell}(a',b)$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, alpha, beta, r
DeclareOperation( "LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a,b}: b \rightarrow \mathrm{\underline{coHom}_\ell}(b,a) \otimes a$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, \mathrm{\underline{coHom}_\ell}(b,a) \otimes a )$.
#! @Arguments a, b
DeclareOperation( "LeftCoclosedMonoidalEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{\underline{coHom}_\ell}(b,a) \otimes a$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a,b}: b \rightarrow \mathrm{\underline{coHom}_\ell}(b,a) \otimes a$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, r )$.
#! @Arguments a, b, r
DeclareOperation( "LeftCoclosedMonoidalEvaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a,b}: \mathrm{\underline{coHom}_\ell}(b \otimes a, a) \rightarrow b$, i.e.,
#! the counit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}_\ell}(b \otimes a, a), b )$.
#! @Arguments a, b
DeclareOperation( "LeftCoclosedMonoidalCoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{\underline{coHom}_\ell}(b \otimes a, a)$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a,b}: \mathrm{\underline{coHom}_\ell}(b \otimes a, a) \rightarrow b$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( s, b )$.
#! @Arguments a, b, s
DeclareOperation( "LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $b,c$ and a morphism $g: a \rightarrow b \otimes c$.
#! The output is a morphism $f: \mathrm{\underline{coHom}_\ell}(a,c) \rightarrow b$
#! corresponding to $g$ under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}_\ell}(a,c), b )$.
#! @Arguments b, c, g
DeclareOperation( "TensorProductToLeftInternalCoHomAdjunctMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $b,c$, a morphism $g: a \rightarrow b \otimes c$ and an object $i = \mathrm{\underline{coHom}_\ell}(a,c)$.
#! The output is a morphism $f: \mathrm{\underline{coHom}_\ell}(a,c) \rightarrow b$
#! corresponding to $g$ under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( i, b )$.
#! @Arguments b, c, g, i
DeclareOperation( "TensorProductToLeftInternalCoHomAdjunctMorphismWithGivenLeftInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,c$ and a morphism $f: \mathrm{\underline{coHom}_\ell}(a,c) \rightarrow b$.
#! The output is a morphism $g: a \rightarrow b \otimes c$ corresponding to $f$ under the
#! cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a, b \otimes c)$.
#! @Arguments a, c, f
DeclareOperation( "LeftInternalCoHomToTensorProductAdjunctMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $a,c$, a morphism $f: \mathrm{\underline{coHom}_\ell}(a,c) \rightarrow b$ and an object $t = b \otimes c$.
#! The output is a morphism $g: a \rightarrow b \otimes c$ corresponding to $f$ under the
#! cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, t )$.
#! @Arguments a, c, f, t
DeclareOperation( "LeftInternalCoHomToTensorProductAdjunctMorphismWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the precocomposition morphism
#! $\mathrm{LeftCoclosedMonoidalPreCoComposeMorphism}_{a,b,c}: \mathrm{\underline{coHom}_\ell}(a,c) \rightarrow \mathrm{\underline{coHom}_\ell}(b,c) \otimes \mathrm{\underline{coHom}_\ell}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}_\ell}(a,c), \mathrm{\underline{coHom}_\ell}(b,c) \otimes \mathrm{\underline{coHom}_\ell}(a,b) )$.
#! @Arguments a,b,c
DeclareOperation( "LeftCoclosedMonoidalPreCoComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{\underline{coHom}_\ell}(a,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{\underline{coHom}_\ell}(a,b) \otimes \mathrm{\underline{coHom}_\ell}(b,c)$.
#! The output is the precocomposition morphism
#! $\mathrm{LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{coHom}_\ell}(a,c) \rightarrow \mathrm{\underline{coHom}_\ell}(b,c) \otimes \mathrm{\underline{coHom}_\ell}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the postcocomposition morphism
#! $\mathrm{LeftCoclosedMonoidalPostCoComposeMorphism}_{a,b,c}: \mathrm{\underline{coHom}_\ell}(a,c) \rightarrow \mathrm{\underline{coHom}_\ell}(a,b) \otimes \mathrm{\underline{coHom}_\ell}(b,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}_\ell}(a,c), \mathrm{\underline{coHom}_\ell}(a,b) \otimes \mathrm{\underline{coHom}_\ell}(b,c) )$.
#! @Arguments a,b,c
DeclareOperation( "LeftCoclosedMonoidalPostCoComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{\underline{coHom}_\ell}(a,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{\underline{coHom}_\ell}(b,c) \otimes \mathrm{\underline{coHom}_\ell}(a,b)$.
#! The output is the postcocomposition morphism
#! $\mathrm{LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{coHom}_\ell}(a,c) \rightarrow \mathrm{\underline{coHom}_\ell}(a,b) \otimes \mathrm{\underline{coHom}_\ell}(b,c)$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is its codual object $a_{\vee}$.
#! @Returns an object
#! @Arguments a
DeclareAttribute( "LeftCoDualOnObjects",
                  IsCapCategoryObject );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its codual morphism $\alpha_{\vee}: b_{\vee} \rightarrow a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b_{\vee}, a_{\vee} )$.
#! @Arguments alpha
DeclareAttribute( "LeftCoDualOnMorphisms",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $s = b_{\vee}$,
#! a morphism $\alpha: a \rightarrow b$,
#! and an object $r = a_{\vee}$.
#! The output is the dual morphism $\alpha_{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,alpha,r
DeclareOperation( "LeftCoDualOnMorphismsWithGivenLeftCoDuals",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a}: 1 \rightarrow a_{\vee} \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( 1, a_{\vee} \otimes a )$.
#! @Arguments a
DeclareAttribute( "LeftCoclosedMonoidalEvaluationForLeftCoDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $s = 1$,
#! an object $a$,
#! and an object $r = a_{\vee} \otimes a$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a}: 1 \rightarrow a_{\vee} \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,r
DeclareOperation( "LeftCoclosedMonoidalEvaluationForLeftCoDualWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the morphism from the cobidual $(a_{\vee})_{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a_{\vee})_{\vee}, a)$.
#! @Arguments a
DeclareAttribute( "MorphismFromLeftCoBidual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$,
#! and an object $s = (a_{\vee})_{\vee}$.
#! The output is the morphism from the cobidual $(a_{\vee})_{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(s, a)$.
#! @Arguments a, s
DeclareOperation( "MorphismFromLeftCoBidualWithGivenLeftCoBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## The four objects are given as a list because otherwise the WithGiven operation would
## exceed the maximal number of arguments for an operation (6)
#! @Description
#! The argument is a list of four objects $[ a, a', b, b' ]$.
#! The output is the natural morphism
#! $\mathrm{LeftInternalCoHomTensorProductCompatibilityMorphism}_{a,a',b,b'}: \mathrm{\underline{coHom}_\ell}(a \otimes a', b \otimes b') \rightarrow \mathrm{\underline{coHom}_\ell}(a,b) \otimes \mathrm{\underline{coHom}_\ell}(a',b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}_\ell}(a \otimes a', b \otimes b'), \mathrm{\underline{coHom}_\ell}(a,b) \otimes \mathrm{\underline{coHom}_\ell}(a',b'))$.
#! @Arguments list
DeclareOperation( "LeftInternalCoHomTensorProductCompatibilityMorphism",
                  [ IsList ] );

#! @Description
#! The arguments are a list of four objects $[ a, a', b, b' ]$,
#! and two objects $s = \mathrm{\underline{coHom}_\ell}(a \otimes a', b \otimes b')$ and $r = \mathrm{\underline{coHom}_\ell}(a,b) \otimes \mathrm{\underline{coHom}_\ell}(a',b')$.
#! The output is the natural morphism
#! $\mathrm{LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{coHom}_\ell}(a \otimes a', b \otimes b') \rightarrow \mathrm{\underline{coHom}_\ell}(a,b) \otimes \mathrm{\underline{coHom}_\ell}(a',b')$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s, list, r
DeclareOperation( "LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism
#! $\mathrm{LeftCoDualityTensorProductCompatibilityMorphism}: (a \otimes b)_{\vee} \rightarrow a_{\vee} \otimes b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( (a \otimes b)_{\vee}, a_{\vee} \otimes b_{\vee} )$.
#! @Arguments a,b
DeclareOperation( "LeftCoDualityTensorProductCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (a \otimes b)_{\vee}$,
#! two objects $a,b$,
#! and an object $r = a_{\vee} \otimes b_{\vee}$.
#! The output is the natural morphism
#! $\mathrm{LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects}_{a,b}: (a \otimes b)_{\vee} \rightarrow a_{\vee} \otimes b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,r
DeclareOperation( "LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{MorphismFromLeftInternalCoHomToTensorProduct}_{a,b}: \mathrm{\underline{coHom}_\ell}(a,b) \rightarrow b_{\vee} \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}_\ell}(a,b), b_{\vee} \otimes a )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromLeftInternalCoHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = \mathrm{\underline{coHom}_\ell}(a,b)$,
#! two objects $a,b$,
#! and an object $r = b_{\vee} \otimes a$.
#! The output is the natural morphism $\mathrm{MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects}_{a,b}: \mathrm{\underline{coHom}_\ell}(a,b) \rightarrow a \otimes b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit}_{a}: a_{\vee} \rightarrow \mathrm{\underline{coHom}_\ell}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee}, \mathrm{\underline{coHom}_\ell}(1,a))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject}_{a}: \mathrm{\underline{coHom}_\ell}(1,a) \rightarrow a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{\underline{coHom}_\ell}(1,a), a_{\vee})$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject",
                  IsCapCategoryObject );

#! @Description
#! The arguments are two objects $t,a$,
#! and a morphism $\alpha: 1 \rightarrow t \otimes a$.
#! The output is the morphism $a_{\vee} \rightarrow t$
#! given by the universal property of $a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee}, t)$.
#! @Arguments t, a, alpha
DeclareOperation( "UniversalPropertyOfLeftCoDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is the corresponding morphism $ \mathrm{\underline{coHom}_\ell}(a,b) \rightarrow 1$
#! under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}_\ell}(a,b), 1 )$.
#! @Arguments alpha
DeclareAttribute( "LeftCoclosedMonoidalLambdaIntroduction",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are two objects $a,b$,
#! and a morphism $\alpha: \mathrm{\underline{coHom}_\ell}(a,b) \rightarrow 1$.
#! The output is a morphism $a \rightarrow b$ corresponding to $\alpha$
#! under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$.
#! @Arguments a,b,alpha
DeclareOperation( "LeftCoclosedMonoidalLambdaElimination",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{\underline{coHom}_\ell}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{\underline{coHom}_\ell}(a,1))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromObjectToLeftInternalCoHom",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $r = \mathrm{\underline{coHom}_\ell}(a,1)$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{\underline{coHom}_\ell}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a, r)$.
#! @Arguments a,r
DeclareOperation( "IsomorphismFromObjectToLeftInternalCoHomWithGivenLeftInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $\mathrm{\underline{coHom}_\ell}(a,1) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{\underline{coHom}_\ell}(a,1), a)$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromLeftInternalCoHomToObject",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $s = \mathrm{\underline{coHom}_\ell}(a,1)$.
#! The output is the natural isomorphism $\mathrm{\underline{coHom}_\ell}(a,1) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(s, a)$.
#! @Arguments a,s
DeclareOperation( "IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom",
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
#! $\mathrm{\underline{coHom}_\ell}(a,b)$.
#! If at least one of the arguments is a CAP morphism the output is a CAP morphism,
#! namely the internal cohom on morphisms, where any object is replaced by its identity morphism.
#! @Returns a cell
#! @Arguments a, b
DeclareOperation( "LeftInternalCoHom",
                  [ IsCapCategoryCell, IsCapCategoryCell ] );
