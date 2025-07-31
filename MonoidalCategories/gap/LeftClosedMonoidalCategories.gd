# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Left Closed Monoidal Categories
##
####################################

DeclareGlobalVariable( "LEFT_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsLeftClosedMonoidalCategory :=
  Concatenation(
          ListOfDefiningOperations( "IsMonoidalCategory" ),
          [ "LeftInternalHomOnObjects",
            "LeftInternalHomOnMorphisms",
            "LeftClosedMonoidalEvaluationMorphism",
            "LeftClosedMonoidalCoevaluationMorphism"
            ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the internal hom object $\mathrm{\underline{Hom}_\ell}(a,b)$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "LeftInternalHomOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the internal hom morphism
#! $\mathrm{\underline{Hom}_\ell}(\alpha,\beta): \mathrm{\underline{Hom}_\ell}(a',b) \rightarrow \mathrm{\underline{Hom}_\ell}(a,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}_\ell}(a',b), \mathrm{\underline{Hom}_\ell}(a,b') )$
#! @Arguments alpha, beta
DeclareOperation( "LeftInternalHomOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{\underline{Hom}_\ell}(a',b)$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = \mathrm{\underline{Hom}_\ell}(a,b')$.
#! The output is the internal hom morphism
#! $\mathrm{\underline{Hom}_\ell}(\alpha,\beta): \mathrm{\underline{Hom}_\ell}(a',b) \rightarrow \mathrm{\underline{Hom}_\ell}(a,b')$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, alpha, beta, r
DeclareOperation( "LeftInternalHomOnMorphismsWithGivenLeftInternalHoms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the evaluation morphism $\mathrm{ev}_{a,b}: \mathrm{\underline{Hom}_\ell}(a,b) \otimes a \rightarrow b$, i.e.,
#! the counit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}_\ell}(a,b) \otimes a, b )$.
#! @Arguments a, b
DeclareOperation( "LeftClosedMonoidalEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{\underline{Hom}_\ell}(a,b) \otimes a$.
#! The output is the evaluation morphism $\mathrm{ev}_{a,b}: \mathrm{\underline{Hom}_\ell}(a,b) \otimes a \rightarrow b$, i.e.,
#! the counit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( s, b )$.
#! @Arguments a, b, s
DeclareOperation( "LeftClosedMonoidalEvaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: b \rightarrow \mathrm{\underline{Hom}_\ell}(a, b \otimes a)$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, \mathrm{\underline{Hom}_\ell}(a, b \otimes a) )$.
#! @Arguments a, b
DeclareOperation( "LeftClosedMonoidalCoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{\underline{Hom}_\ell}(a, b \otimes a)$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: b \rightarrow \mathrm{\underline{Hom}_\ell}(a, b \otimes a)$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( b, r )$.
#! @Arguments a, b, r
DeclareOperation( "LeftClosedMonoidalCoevaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and a morphism $f: a \otimes b \rightarrow c$.
#! The output is a morphism $g: a \rightarrow \mathrm{\underline{Hom}_\ell}(b,c)$
#! corresponding to $f$ under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{\underline{Hom}_\ell}(b,c) )$.
#! @Arguments a, b, f
DeclareOperation( "TensorProductToLeftInternalHomAdjunctMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $a,b$, a morphism $f: a \otimes b \rightarrow c$ and an object $i = \mathrm{\underline{Hom}_\ell}(b,c)$.
#! The output is a morphism $g: a \rightarrow \mathrm{\underline{Hom}_\ell}(b,c)$
#! corresponding to $f$ under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, i )$.
#! @Arguments a, b, f, i
DeclareOperation( "TensorProductToLeftInternalHomAdjunctMorphismWithGivenLeftInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $b,c$ and a morphism $g: a \rightarrow \mathrm{\underline{Hom}_\ell}(b,c)$.
#! The output is a morphism $f: a \otimes b \rightarrow c$ corresponding to $g$ under the
#! tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes b, c)$.
#! @Arguments b, c, g
DeclareOperation( "LeftInternalHomToTensorProductAdjunctMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $b,c$, a morphism $g: a \rightarrow \mathrm{\underline{Hom}_\ell}(b,c)$ and an object $t = a \otimes b$.
#! The output is a morphism $f: a \otimes b \rightarrow c$ corresponding to $g$ under the
#! tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(t, c)$.
#! @Arguments b, c, g, t
DeclareOperation( "LeftInternalHomToTensorProductAdjunctMorphismWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the precomposition morphism
#! $\mathrm{LeftClosedMonoidalPreComposeMorphism}_{a,b,c}: \mathrm{\underline{Hom}_\ell}(a,b) \otimes \mathrm{\underline{Hom}_\ell}(b,c) \rightarrow \mathrm{\underline{Hom}_\ell}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}_\ell}(a,b) \otimes \mathrm{\underline{Hom}_\ell}(b,c), \mathrm{\underline{Hom}_\ell}(a,c) )$.
#! @Arguments a,b,c
DeclareOperation( "LeftClosedMonoidalPreComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{\underline{Hom}_\ell}(a,b) \otimes \mathrm{\underline{Hom}_\ell}(b,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{\underline{Hom}_\ell}(a,c)$.
#! The output is the precomposition morphism
#! $\mathrm{LeftClosedMonoidalPreComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{Hom}_\ell}(a,b) \otimes \mathrm{\underline{Hom}_\ell}(b,c) \rightarrow \mathrm{\underline{Hom}_\ell}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "LeftClosedMonoidalPreComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the postcomposition morphism
#! $\mathrm{LeftClosedMonoidalPostComposeMorphism}_{a,b,c}: \mathrm{\underline{Hom}_\ell}(b,c) \otimes \mathrm{\underline{Hom}_\ell}(a,b) \rightarrow \mathrm{\underline{Hom}_\ell}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}_\ell}(b,c) \otimes \mathrm{\underline{Hom}_\ell}(a,b), \mathrm{\underline{Hom}_\ell}(a,c) )$.
#! @Arguments a,b,c
DeclareOperation( "LeftClosedMonoidalPostComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{\underline{Hom}_\ell}(b,c) \otimes \mathrm{\underline{Hom}_\ell}(a,b)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{\underline{Hom}_\ell}(a,c)$.
#! The output is the postcomposition morphism
#! $\mathrm{LeftClosedMonoidalPostComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{Hom}_\ell}(b,c) \otimes \mathrm{\underline{Hom}_\ell}(a,b) \rightarrow \mathrm{\underline{Hom}_\ell}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "LeftClosedMonoidalPostComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is its dual object $a^{\vee}$.
#! @Returns an object
#! @Arguments a
DeclareAttribute( "LeftDualOnObjects",
                  IsCapCategoryObject );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its dual morphism $\alpha^{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b^{\vee}, a^{\vee} )$.
#! @Arguments alpha
DeclareAttribute( "LeftDualOnMorphisms",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $s = b^{\vee}$,
#! a morphism $\alpha: a \rightarrow b$,
#! and an object $r = a^{\vee}$.
#! The output is the dual morphism $\alpha^{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,alpha,r
DeclareOperation( "LeftDualOnMorphismsWithGivenLeftDuals",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the evaluation morphism $\mathrm{ev}_{a}: a^{\vee} \otimes a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes a, 1 )$.
#! @Arguments a
DeclareAttribute( "LeftClosedMonoidalEvaluationForLeftDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $s = a^{\vee} \otimes a$,
#! an object $a$,
#! and an object $r = 1$.
#! The output is the evaluation morphism $\mathrm{ev}_{a}: a^{\vee} \otimes a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,r
DeclareOperation( "LeftClosedMonoidalEvaluationForLeftDualWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the morphism to the bidual $a \rightarrow (a^{\vee})^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a, (a^{\vee})^{\vee})$.
#! @Arguments a
DeclareAttribute( "MorphismToLeftBidual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$,
#! and an object $r = (a^{\vee})^{\vee}$.
#! The output is the morphism to the bidual $a \rightarrow (a^{\vee})^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a, r)$.
#! @Arguments a, r
DeclareOperation( "MorphismToLeftBidualWithGivenLeftBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## The four objects are given as a list because otherwise the WithGiven operation would
## exceed the maximal number of arguments for an operation (6)
#! @Description
#! The argument is a list of four objects $[ a, a', b, b' ]$.
#! The output is the natural morphism
#! $\mathrm{TensorProductLeftInternalHomCompatibilityMorphism}_{a,a',b,b'}: \mathrm{\underline{Hom}_\ell}(a,a') \otimes \mathrm{\underline{Hom}_\ell}(b,b') \rightarrow \mathrm{\underline{Hom}_\ell}(a \otimes b,a' \otimes b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}_\ell}(a,a') \otimes \mathrm{\underline{Hom}_\ell}(b,b'), \mathrm{\underline{Hom}_\ell}(a \otimes b,a' \otimes b'))$.
#! @Arguments list
DeclareOperation( "TensorProductLeftInternalHomCompatibilityMorphism",
                  [ IsList ] );

#! @Description
#! The arguments are a list of four objects $[ a, a', b, b' ]$,
#! and two objects $s = \mathrm{\underline{Hom}_\ell}(a,a') \otimes \mathrm{\underline{Hom}_\ell}(b,b')$ and $r = \mathrm{\underline{Hom}_\ell}(a \otimes b,a' \otimes b')$.
#! The output is the natural morphism
#! $\mathrm{TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{Hom}_\ell}(a,a') \otimes \mathrm{\underline{Hom}_\ell}(b,b') \rightarrow \mathrm{\underline{Hom}_\ell}(a \otimes b,a' \otimes b')$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s, list, r
DeclareOperation( "TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism
#! $\mathrm{TensorProductLeftDualityCompatibilityMorphism}: a^{\vee} \otimes b^{\vee} \rightarrow (a \otimes b)^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b^{\vee}, (a \otimes b)^{\vee} )$.
#! @Arguments a,b
DeclareOperation( "TensorProductLeftDualityCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a^{\vee} \otimes b^{\vee}$,
#! two objects $a,b$,
#! and an object $r = (a \otimes b)^{\vee}$.
#! The output is the natural morphism
#! $\mathrm{TensorProductLeftDualityCompatibilityMorphismWithGivenObjects}_{a,b}: a^{\vee} \otimes b^{\vee} \rightarrow (a \otimes b)^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,r
DeclareOperation( "TensorProductLeftDualityCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{MorphismFromTensorProductToLeftInternalHom}_{a,b}: a^{\vee} \otimes b \rightarrow \mathrm{\underline{Hom}_\ell}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b, \mathrm{\underline{Hom}_\ell}(a,b) )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromTensorProductToLeftInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a^{\vee} \otimes b$,
#! two objects $a,b$,
#! and an object $r = \mathrm{\underline{Hom}_\ell}(a,b)$.
#! The output is the natural morphism $\mathrm{MorphismFromTensorProductToLeftInternalHomWithGivenObjects}_{a,b}: a^{\vee} \otimes b \rightarrow \mathrm{\underline{Hom}_\ell}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromTensorProductToLeftInternalHomWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit}_{a}: a^{\vee} \rightarrow \mathrm{\underline{Hom}_\ell}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a^{\vee}, \mathrm{\underline{Hom}_\ell}(a,1))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject}_{a}: \mathrm{\underline{Hom}_\ell}(a,1) \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{\underline{Hom}_\ell}(a,1), a^{\vee})$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject",
                  IsCapCategoryObject );

#! @Description
#! The arguments are two objects $t,a$,
#! and a morphism $\alpha: t \otimes a \rightarrow 1$.
#! The output is the morphism $t \rightarrow a^{\vee}$
#! given by the universal property of $a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(t, a^{\vee})$.
#! @Arguments t, a, alpha
DeclareOperation( "UniversalPropertyOfLeftDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is the corresponding morphism $1 \rightarrow \mathrm{\underline{Hom}_\ell}(a,b)$
#! under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( 1, \mathrm{\underline{Hom}_\ell}(a,b) )$.
#! @Arguments alpha
DeclareAttribute( "LeftClosedMonoidalLambdaIntroduction",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are two objects $a,b$,
#! and a morphism $\alpha: 1 \rightarrow \mathrm{\underline{Hom}_\ell}(a,b)$.
#! The output is a morphism $a \rightarrow b$ corresponding to $\alpha$
#! under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$.
#! @Arguments a,b,alpha
DeclareOperation( "LeftClosedMonoidalLambdaElimination",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{\underline{Hom}_\ell}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{\underline{Hom}_\ell}(1,a))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromObjectToLeftInternalHom",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $r = \mathrm{\underline{Hom}_\ell}(1,a)$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{\underline{Hom}_\ell}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a, r)$.
#! @Arguments a,r
DeclareOperation( "IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $\mathrm{\underline{Hom}_\ell}(1,a) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{\underline{Hom}_\ell}(1,a),a)$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromLeftInternalHomToObject",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $s = \mathrm{\underline{Hom}_\ell}(1,a)$.
#! The output is the natural isomorphism $\mathrm{\underline{Hom}_\ell}(1,a) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(s,a)$.
#! @Arguments a,s
DeclareOperation( "IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom",
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
#! $\mathrm{\underline{Hom}_\ell}(a,b)$.
#! If at least one of the arguments is a CAP morphism the output is a CAP morphism,
#! namely the internal hom on morphisms, where any object is replaced by its identity morphism.
#! @Returns a cell
#! @Arguments a, b
DeclareOperation( "LeftInternalHom",
                  [ IsCapCategoryCell, IsCapCategoryCell ] );
