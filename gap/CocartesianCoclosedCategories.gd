# THIS FILE WAS AUTOMATICALLY GENERATED
# FROM MonoidalCategories v2021.12-07
# USING CategoryConstructor v2021.12-05

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

####################################
##
#! @Chapter Cocartesian Categories
##
#! @Section Cocartesian Coclosed Categories
##
####################################

DeclareGlobalVariable( "COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD" );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCoclosedCategory  := Concatenation( [
"CoexponentialOnObjects",
"CoexponentialOnMorphismsWithGivenCoexponentials",
"CocartesianEvaluationMorphismWithGivenRange",
"CocartesianCoevaluationMorphismWithGivenSource"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the internal cohom object $\mathrm{Coexponential}(a,b)$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "CoexponentialOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the internal cohom morphism
#! $\mathrm{Coexponential}(\alpha,\beta): \mathrm{Coexponential}(a,b') \rightarrow \mathrm{Coexponential}(a',b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b'), \mathrm{Coexponential}(a',b) )$
#! @Arguments alpha, beta
DeclareOperation( "CoexponentialOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{Coexponential}(a,b')$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = \mathrm{Coexponential}(a',b)$.
#! The output is the internal cohom morphism
#! $\mathrm{Coexponential}(\alpha,\beta): \mathrm{Coexponential}(a,b') \rightarrow \mathrm{Coexponential}(a',b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b'), \mathrm{Coexponential}(a',b) )$
#! @Arguments s, alpha, beta, r
DeclareOperation( "CoexponentialOnMorphismsWithGivenCoexponentials",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a,b}: a \rightarrow \mathrm{Coexponential}(a,b) \sqcup b$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{Coexponential}(a,b) \sqcup b )$.
#! @Arguments a, b
DeclareOperation( "CocartesianEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{Coexponential}(a,b) \sqcup b$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a,b}: a \rightarrow \mathrm{Coexponential}(a,b) \sqcup b$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{Coexponential}(a,b) \sqcup b )$.
#! @Arguments a, b, r
DeclareOperation( "CocartesianEvaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a,b}: \mathrm{Coexponential}(a \sqcup b, b) \rightarrow a$, i.e.,
#! the counit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a \sqcup b, b), a )$.
#! @Arguments a, b
DeclareOperation( "CocartesianCoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{Coexponential(a \sqcup b, b)}$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a,b}: \mathrm{Coexponential}(a \sqcup b, b) \rightarrow a$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a \sqcup b, b), b )$.
#! @Arguments a, b, s
DeclareOperation( "CocartesianCoevaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are objects $c,b$ and a morphism $g: a \rightarrow c \sqcup b$.
#! The output is a morphism $f: \mathrm{Coexponential}(a,b) \rightarrow c$
#! corresponding to $g$ under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b), c )$.
#! @Arguments c, b, g
DeclareOperation( "CoproductToCoexponentialAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are objects $a,b$ and a morphism $f: \mathrm{Coexponential}(a,b) \rightarrow c$.
#! The output is a morphism $g: a \rightarrow c \sqcup b$ corresponding to $f$ under the
#! cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a, c \sqcup b)$.
#! @Arguments a, b, f
DeclareOperation( "CoexponentialToCoproductAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the precocomposition morphism
#! $\mathrm{CocartesianPreCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Coexponential}(a,c) \rightarrow \mathrm{Coexponential}(b,c) \sqcup \mathrm{Coexponential}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,c), \mathrm{Coexponential}(b,c) \sqcup \mathrm{Coexponential}(a,b) )$.
#! @Arguments a,b,c
DeclareOperation( "CocartesianPreCoComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{Coexponential}(a,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(b,c)$.
#! The output is the precocomposition morphism
#! $\mathrm{CocartesianPreCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Coexponential}(a,c) \rightarrow \mathrm{Coexponential}(b,c) \sqcup \mathrm{Coexponential}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,c), \mathrm{Coexponential}(b,c) \sqcup \mathrm{Coexponential}(a,b) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "CocartesianPreCoComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the postcocomposition morphism
#! $\mathrm{CocartesianPostCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Coexponential}(a,c) \rightarrow \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(b,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,c), \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(b,c) )$.
#! @Arguments a,b,c
DeclareOperation( "CocartesianPostCoComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{Coexponential}(a,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{Coexponential}(b,c) \sqcup \mathrm{Coexponential}(a,b)$.
#! The output is the postcocomposition morphism
#! $\mathrm{CocartesianPostCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Coexponential}(a,c) \rightarrow \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(b,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,c), \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(b,c) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "CocartesianPostCoComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is its codual object $a_{\vee}$.
#! @Returns an object
#! @Arguments a
DeclareAttribute( "CocartesianDualOnObjects",
                  IsCapCategoryObject );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its codual morphism $\alpha_{\vee}: b_{\vee} \rightarrow a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b_{\vee}, a_{\vee} )$.
#! @Arguments alpha
DeclareAttribute( "CocartesianDualOnMorphisms",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $s = b_{\vee}$,
#! a morphism $\alpha: a \rightarrow b$,
#! and an object $r = a_{\vee}$.
#! The output is the dual morphism $\alpha_{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b_{\vee}, a_{\vee} )$.
#! @Arguments s,alpha,r
DeclareOperation( "CocartesianDualOnMorphismsWithGivenCocartesianDuals",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a}: 1 \rightarrow a_{\vee} \sqcup a$.
#! @Returns a morphism in $\mathrm{Hom}( 1, a_{\vee} \sqcup a )$.
#! @Arguments a
DeclareAttribute( "CocartesianEvaluationForCocartesianDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $s = 1$,
#! an object $a$,
#! and an object $r = a_{\vee} \sqcup a$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a}: 1 \rightarrow a_{\vee} \sqcup a$.
#! @Returns a morphism in $\mathrm{Hom}( 1, a_{\vee} \sqcup a )$.
#! @Arguments s,a,r
DeclareOperation( "CocartesianEvaluationForCocartesianDualWithGivenCoproduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the morphism from the cobidual $(a_{\vee})_{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a_{\vee})_{\vee}, a)$.
#! @Arguments a
DeclareAttribute( "MorphismFromCocartesianBidual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$,
#! and an object $s = (a_{\vee})_{\vee}$.
#! The output is the morphism from the cobidual $(a_{\vee})_{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a_{\vee})_{\vee}, a)$.
#! @Arguments a, s
DeclareOperation( "MorphismFromCocartesianBidualWithGivenCocartesianBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## The four objects are given as a list because otherwise the WithGiven operation would
## exceed the maximal number of arguments for an operation (6)
#! @Description
#! The argument is a list of four objects $[ a, a', b, b' ]$.
#! The output is the natural morphism
#! $\mathrm{CoexponentialCoproductCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{Coexponential}(a \sqcup a', b \sqcup b') \rightarrow \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(a',b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a \sqcup a', b \sqcup b'), \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(a',b'))$.
#! @Arguments list
DeclareOperation( "CoexponentialCoproductCompatibilityMorphism",
                  [ IsList ] );

#! @Description
#! The arguments are a list of four objects $[ a, a', b, b' ]$,
#! and two objects $s = \mathrm{Coexponential}(a \sqcup a', b \sqcup b')$ and $r = \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(a',b')$.
#! The output is the natural morphism
#! $\mathrm{CoexponentialCoproductCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{Coexponential}(a \sqcup a', b \sqcup b') \rightarrow \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(a',b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a \sqcup a', b \sqcup b'), \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(a',b') )$.
#! @Arguments s, list, r
DeclareOperation( "CoexponentialCoproductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism
#! $\mathrm{CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects}: (a \sqcup b)_{\vee} \rightarrow a_{\vee} \sqcup b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( (a \sqcup b)_{\vee}, a_{\vee} \sqcup b_{\vee} )$.
#! @Arguments a,b
DeclareOperation( "CocartesianDualityCoproductCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (a \sqcup b)_{\vee}$,
#! two objects $a,b$,
#! and an object $r = a_{\vee} \sqcup b_{\vee}$.
#! The output is the natural morphism
#! $\mathrm{CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects}_{a,b}: (a \sqcup b)_{\vee} \rightarrow a_{\vee} \sqcup b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( (a \sqcup b)_{\vee}, a_{\vee} \sqcup b_{\vee} )$.
#! @Arguments s,a,b,r
DeclareOperation( "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{MorphismFromCoexponentialToCoproductWithGivenObjects}_{a,b}: \mathrm{Coexponential}(a,b) \rightarrow b_{\vee} \sqcup a$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b), b_{\vee} \sqcup a )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromCoexponentialToCoproduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = \mathrm{Coexponential}(a,b)$,
#! two objects $a,b$,
#! and an object $r = b_{\vee} \sqcup a$.
#! The output is the natural morphism $\mathrm{MorphismFromCoexponentialToCoproductWithGivenObjects}_{a,b}: \mathrm{Coexponential}(a,b) \rightarrow a \sqcup b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b), a \sqcup b_{\vee} )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromCoexponentialToCoproductWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromCocartesianDualToCoexponential}_{a}: a_{\vee} \rightarrow \mathrm{Coexponential}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee}, \mathrm{Coexponential}(1,a))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromCocartesianDualToCoexponential",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromCoexponentialToCocartesianDual}_{a}: \mathrm{Coexponential}(1,a) \rightarrow a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Coexponential}(1,a), a_{\vee})$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromCoexponentialToCocartesianDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are two objects $t,a$,
#! and a morphism $\alpha: 1 \rightarrow t \sqcup a$.
#! The output is the morphism $a_{\vee} \rightarrow t$
#! given by the universal property of $a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee}, t)$.
#! @Arguments t, a, alpha
DeclareOperation( "UniversalPropertyOfCocartesianDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is the corresponding morphism $ \mathrm{Coexponential}(a,b) \rightarrow 1$
#! under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b), 1 )$.
#! @Arguments alpha
DeclareAttribute( "CocartesianLambdaIntroduction",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are two objects $a,b$,
#! and a morphism $\alpha: \mathrm{Coexponential}(a,b) \rightarrow 1$.
#! The output is a morphism $a \rightarrow b$ corresponding to $\alpha$
#! under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$.
#! @Arguments a,b,alpha
DeclareOperation( "CocartesianLambdaElimination",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{Coexponential}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{Coexponential}(a,1))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromObjectToCoexponential",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $r = \mathrm{Coexponential}(a,1)$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{Coexponential}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{Coexponential}(a,1))$.
#! @Arguments a,r
DeclareOperation( "IsomorphismFromObjectToCoexponentialWithGivenCoexponential",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $\mathrm{Coexponential}(a,1) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Coexponential}(a,1), a)$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromCoexponentialToObject",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $s = \mathrm{Coexponential}(a,1)$.
#! The output is the natural isomorphism $\mathrm{Coexponential}(a,1) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Coexponential}(a,1), a)$.
#! @Arguments a,s
DeclareOperation( "IsomorphismFromCoexponentialToObjectWithGivenCoexponential",
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
#! $\mathrm{Coexponential}(a,b)$.
#! If at least one of the arguments is a CAP morphism the output is a CAP morphism,
#! namely the internal cohom on morphisms, where any object is replaced by its identity morphism.
#! @Returns a cell
#! @Arguments a, b
DeclareOperation( "Coexponential",
                  [ IsCapCategoryCell, IsCapCategoryCell ] );
