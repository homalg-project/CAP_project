# THIS FILE WAS AUTOMATICALLY GENERATED

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

####################################
##
#! @Chapter Cartesian Categories
##
#! @Section Cartesian Closed Categories
##
####################################

DeclareGlobalVariable( "CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD" );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianClosedCategory  := Concatenation( [
"ExponentialOnObjects",
"ExponentialOnMorphismsWithGivenExponentials",
"CartesianEvaluationMorphismWithGivenSource",
"CartesianCoevaluationMorphismWithGivenRange"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianCategory );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the internal hom object $\mathrm{Exponential}(a,b)$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "ExponentialOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the internal hom morphism
#! $\mathrm{Exponential}(\alpha,\beta): \mathrm{Exponential}(a',b) \rightarrow \mathrm{Exponential}(a,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a',b), \mathrm{Exponential}(a,b') )$
#! @Arguments alpha, beta
DeclareOperation( "ExponentialOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{Exponential}(a',b)$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = \mathrm{Exponential}(a,b')$.
#! The output is the internal hom morphism
#! $\mathrm{Exponential}(\alpha,\beta): \mathrm{Exponential}(a',b) \rightarrow \mathrm{Exponential}(a,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a',b), \mathrm{Exponential}(a,b') )$
#! @Arguments s, alpha, beta, r
DeclareOperation( "ExponentialOnMorphismsWithGivenExponentials",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the evaluation morphism $\mathrm{ev}_{a,b}: \mathrm{Exponential}(a,b) \times a \rightarrow b$, i.e.,
#! the counit of the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a,b) \times a, b )$.
#! @Arguments a, b
DeclareOperation( "CartesianEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## 3rd argument is $\mathrm{Exponential}(a,b) \times a$
#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{Exponential}(a,b) \times a$.
#! The output is the evaluation morphism $\mathrm{ev}_{a,b}: \mathrm{Exponential}(a,b) \times a \rightarrow b$, i.e.,
#! the counit of the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a,b) \times a, b )$.
#! @Arguments a, b, s
DeclareOperation( "CartesianEvaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: a \rightarrow \mathrm{Exponential}(b, a \times b)$, i.e.,
#! the unit of the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{Exponential}(b, a \times b) )$.
#! @Arguments a, b
DeclareOperation( "CartesianCoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## the last argument is $\mathrm{Exponential}(b, a \times b)$
#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{Exponential}(b, a \times b)$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: a \rightarrow \mathrm{Exponential}(b, a \times b)$, i.e.,
#! the unit of the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{Exponential}(b, a \times b) )$.
#! @Arguments a, b, r
DeclareOperation( "CartesianCoevaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are objects $a,b$ and a morphism $f: a \times b \rightarrow c$.
#! The output is a morphism $g: a \rightarrow \mathrm{Exponential}(b,c)$
#! corresponding to $f$ under the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{Exponential}(b,c) )$.
#! @Arguments a, b, f
DeclareOperation( "DirectProductToExponentialAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are objects $b,c$ and a morphism $g: a \rightarrow \mathrm{Exponential}(b,c)$.
#! The output is a morphism $f: a \times b \rightarrow c$ corresponding to $g$ under the
#! direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a \times b, c)$.
#! @Arguments b, c, g
DeclareOperation( "ExponentialToDirectProductAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the precomposition morphism
#! $\mathrm{CartesianPreComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Exponential}(a,b) \times \mathrm{Exponential}(b,c) \rightarrow \mathrm{Exponential}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a,b) \times \mathrm{Exponential}(b,c), \mathrm{Exponential}(a,c) )$.
#! @Arguments a,b,c
DeclareOperation( "CartesianPreComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{Exponential}(a,b) \times \mathrm{Exponential}(b,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{Exponential}(a,c)$.
#! The output is the precomposition morphism
#! $\mathrm{CartesianPreComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Exponential}(a,b) \times \mathrm{Exponential}(b,c) \rightarrow \mathrm{Exponential}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a,b) \times \mathrm{Exponential}(b,c), \mathrm{Exponential}(a,c) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "CartesianPreComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the postcomposition morphism
#! $\mathrm{CartesianPostComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Exponential}(b,c) \times \mathrm{Exponential}(a,b) \rightarrow \mathrm{Exponential}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(b,c) \times \mathrm{Exponential}(a,b), \mathrm{Exponential}(a,c) )$.
#! @Arguments a,b,c
DeclareOperation( "CartesianPostComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{Exponential}(b,c) \times \mathrm{Exponential}(a,b)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{Exponential}(a,c)$.
#! The output is the postcomposition morphism
#! $\mathrm{CartesianPostComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Exponential}(b,c) \times \mathrm{Exponential}(a,b) \rightarrow \mathrm{Exponential}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(b,c) \times \mathrm{Exponential}(a,b), \mathrm{Exponential}(a,c) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "CartesianPostComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is its dual object $a^{\vee}$.
#! @Returns an object
#! @Arguments a
DeclareAttribute( "CartesianDualOnObjects",
                  IsCapCategoryObject );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its dual morphism $\alpha^{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b^{\vee}, a^{\vee} )$.
#! @Arguments alpha
DeclareAttribute( "CartesianDualOnMorphisms",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $s = b^{\vee}$,
#! a morphism $\alpha: a \rightarrow b$,
#! and an object $r = a^{\vee}$.
#! The output is the dual morphism $\alpha^{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b^{\vee}, a^{\vee} )$.
#! @Arguments s,alpha,r
DeclareOperation( "CartesianDualOnMorphismsWithGivenCartesianDuals",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the evaluation morphism $\mathrm{ev}_{a}: a^{\vee} \times a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \times a, 1 )$.
#! @Arguments a
DeclareAttribute( "CartesianEvaluationForCartesianDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $s = a^{\vee} \times a$,
#! an object $a$,
#! and an object $r = 1$.
#! The output is the evaluation morphism $\mathrm{ev}_{a}: a^{\vee} \times a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \times a, 1 )$.
#! @Arguments s,a,r
DeclareOperation( "CartesianEvaluationForCartesianDualWithGivenDirectProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the morphism to the bidual $a \rightarrow (a^{\vee})^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a, (a^{\vee})^{\vee})$.
#! @Arguments a
DeclareAttribute( "MorphismToCartesianBidual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$,
#! and an object $r = (a^{\vee})^{\vee}$.
#! The output is the morphism to the bidual $a \rightarrow (a^{\vee})^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a, (a^{\vee})^{\vee})$.
#! @Arguments a, r
DeclareOperation( "MorphismToCartesianBidualWithGivenCartesianBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## The four objects are given as a list because otherwise the WithGiven operation would
## exceed the maximal number of arguments for an operation (6)
#! @Description
#! The argument is a list of four objects $[ a, a', b, b' ]$.
#! The output is the natural morphism
#! $\mathrm{DirectProductExponentialCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{Exponential}(a,a') \times \mathrm{Exponential}(b,b') \rightarrow \mathrm{Exponential}(a \times b,a' \times b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a,a') \times \mathrm{Exponential}(b,b'), \mathrm{Exponential}(a \times b,a' \times b'))$.
#! @Arguments list
DeclareOperation( "DirectProductExponentialCompatibilityMorphism",
                  [ IsList ] );

##
#! @Description
#! The arguments are a list of four objects $[ a, a', b, b' ]$,
#! and two objects $s = \mathrm{Exponential}(a,a') \times \mathrm{Exponential}(b,b')$ and $r = \mathrm{Exponential}(a \times b,a' \times b')$.
#! The output is the natural morphism
#! $\mathrm{DirectProductExponentialCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{Exponential}(a,a') \times \mathrm{Exponential}(b,b') \rightarrow \mathrm{Exponential}(a \times b,a' \times b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a,a') \times \mathrm{Exponential}(b,b'), \mathrm{Exponential}(a \times b,a' \times b'))$.
#! @Arguments s, list, r
DeclareOperation( "DirectProductExponentialCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism
#! $\mathrm{DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects}: a^{\vee} \times b^{\vee} \rightarrow (a \times b)^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \times b^{\vee}, (a \times b)^{\vee} )$.
#! @Arguments a,b
DeclareOperation( "DirectProductCartesianDualityCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a^{\vee} \times b^{\vee}$,
#! two objects $a,b$,
#! and an object $r = (a \times b)^{\vee}$.
#! The output is the natural morphism
#! $\mathrm{DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects}_{a,b}: a^{\vee} \times b^{\vee} \rightarrow (a \times b)^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \times b^{\vee}, (a \times b)^{\vee} )$.
#! @Arguments s,a,b,r
DeclareOperation( "DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{MorphismFromDirectProductToExponentialWithGivenObjects}_{a,b}: a^{\vee} \times b \rightarrow \mathrm{Exponential}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \times b, \mathrm{Exponential}(a,b) )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromDirectProductToExponential",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a^{\vee} \times b$,
#! two objects $a,b$,
#! and an object $r = \mathrm{Exponential}(a,b)$.
#! The output is the natural morphism $\mathrm{MorphismFromDirectProductToExponentialWithGivenObjects}_{a,b}: a^{\vee} \times b \rightarrow \mathrm{Exponential}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \times b, \mathrm{Exponential}(a,b) )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromDirectProductToExponentialWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromCartesianDualToExponential}_{a}: a^{\vee} \rightarrow \mathrm{Exponential}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a^{\vee}, \mathrm{Exponential}(a,1))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromCartesianDualToExponential",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromExponentialToCartesianDual}_{a}: \mathrm{Exponential}(a,1) \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Exponential}(a,1), a^{\vee})$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromExponentialToCartesianDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are two objects $t,a$,
#! and a morphism $\alpha: t \times a \rightarrow 1$.
#! The output is the morphism $t \rightarrow a^{\vee}$
#! given by the universal property of $a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(t, a^{\vee})$.
#! @Arguments t, a, alpha
DeclareOperation( "UniversalPropertyOfCartesianDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is the corresponding morphism $1 \rightarrow \mathrm{Exponential}(a,b)$
#! under the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( 1, \mathrm{Exponential}(a,b) )$.
#! @Arguments alpha
DeclareAttribute( "CartesianLambdaIntroduction",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are two objects $a,b$,
#! and a morphism $\alpha: 1 \rightarrow \mathrm{Exponential}(a,b)$.
#! The output is a morphism $a \rightarrow b$ corresponding to $\alpha$
#! under the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$.
#! @Arguments a,b,alpha
DeclareOperation( "CartesianLambdaElimination",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{Exponential}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{Exponential}(1,a))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromObjectToExponential",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $r = \mathrm{Exponential}(1,a)$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{Exponential}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{Exponential}(1,a))$.
#! @Arguments a,r
DeclareOperation( "IsomorphismFromObjectToExponentialWithGivenExponential",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $\mathrm{Exponential}(1,a) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Exponential}(1,a),a)$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromExponentialToObject",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $s = \mathrm{Exponential}(1,a)$.
#! The output is the natural isomorphism $\mathrm{Exponential}(1,a) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Exponential}(1,a),a)$.
#! @Arguments a,s
DeclareOperation( "IsomorphismFromExponentialToObjectWithGivenExponential",
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
#! $\mathrm{Exponential}(a,b)$.
#! If at least one of the arguments is a CAP morphism the output is a CAP morphism,
#! namely the internal hom on morphisms, where any object is replaced by its identity morphism.
#! @Returns a cell
#! @Arguments a, b
DeclareOperation( "Exponential",
                  [ IsCapCategoryCell, IsCapCategoryCell ] );
