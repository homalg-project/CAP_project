# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Rigid Symmetric Closed Monoidal Categories
##
####################################

DeclareGlobalVariable( "RIGID_SYMMETRIC_LEFT_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom}_{a,b}: a^{\vee} \otimes b \rightarrow \mathrm{\underline{Hom}_\ell}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b, \mathrm{\underline{Hom}_\ell}(a,b) )$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom}$, namely
#! $\mathrm{IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject}_{a,b}: \mathrm{\underline{Hom}_\ell}(a,b) \rightarrow a^{\vee} \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}_\ell}(a,b), a^{\vee} \otimes b )$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{MorphismFromTensorProductToLeftInternalHomWithGivenObjects}$, namely
#! $\mathrm{MorphismFromLeftInternalHomToTensorProductWithGivenObjects}_{a,b}: \mathrm{\underline{Hom}_\ell}(a,b) \rightarrow a^{\vee} \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}_\ell}(a,b), a^{\vee} \otimes b )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromLeftInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = \mathrm{\underline{Hom}_\ell}(a,b)$,
#! two objects $a,b$,
#! and an object $r = a^{\vee} \otimes b$.
#! The output is the inverse of $\mathrm{MorphismFromTensorProductToLeftInternalHomWithGivenObjects}$, namely
#! $\mathrm{MorphismFromLeftInternalHomToTensorProductWithGivenObjects}_{a,b}: \mathrm{\underline{Hom}_\ell}(a,b) \rightarrow a^{\vee} \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}_\ell}(a,b), a^{\vee} \otimes b )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromLeftInternalHomToTensorProductWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

## The four objects are given as a list because otherwise the WithGiven operation would
## exceed the maximal number of arguments for an operation (6)
#! @Description
#! The argument is a list of four objects $[ a, a', b, b' ]$.
#! The output is the natural morphism
#! $\mathrm{TensorProductLeftInternalHomCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{Hom}_\ell}(a \otimes b,a' \otimes b') \rightarrow \mathrm{\underline{Hom}_\ell}(a,a') \otimes \mathrm{\underline{Hom}_\ell}(b,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}_\ell}(a \otimes b,a' \otimes b'), \mathrm{\underline{Hom}_\ell}(a,a') \otimes \mathrm{\underline{Hom}_\ell}(b,b') )$.
#! @Arguments list
DeclareOperation( "TensorProductLeftInternalHomCompatibilityMorphismInverse",
                  [ IsList ] );

#! @Description
#! The arguments are a list of four objects $[ a, a', b, b' ]$,
#! and two objects $s = \mathrm{\underline{Hom}_\ell}(a \otimes b,a' \otimes b')$ and $r = \mathrm{\underline{Hom}_\ell}(a,a') \otimes \mathrm{\underline{Hom}_\ell}(b,b')$.
#! The output is the natural morphism
#! $\mathrm{TensorProductLeftInternalHomCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{Hom}_\ell}(a \otimes b,a' \otimes b') \rightarrow \mathrm{\underline{Hom}_\ell}(a,a') \otimes \mathrm{\underline{Hom}_\ell}(b,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}_\ell}(a \otimes b,a' \otimes b'), \mathrm{\underline{Hom}_\ell}(a,a') \otimes \mathrm{\underline{Hom}_\ell}(b,b') )$.
#! @Arguments s, list, r
DeclareOperation( "TensorProductLeftInternalHomCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a}:1 \rightarrow a \otimes a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(1,a \otimes a^{\vee})$.
#! @Arguments a
DeclareAttribute( "CoevaluationForLeftDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $s = 1$,
#! an object $a$,
#! and an object $r = a \otimes a^{\vee}$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a}:1 \rightarrow a \otimes a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(1,a \otimes a^{\vee})$.
#! @Arguments s,a,r
DeclareOperation( "CoevaluationForLeftDualWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an endomorphism $\alpha: a \rightarrow a$.
#! The output is the trace morphism $\mathrm{trace}_{\alpha}: 1 \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(1,1)$.
#! @Arguments alpha
DeclareAttribute( "TraceMap",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $a$.
#! The output is the rank morphism $\mathrm{rank}_a: 1 \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(1,1)$.
#! @Arguments a
DeclareAttribute( "RankMorphism",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the morphism to the bidual $(a^{\vee})^{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a^{\vee})^{\vee},a)$.
#! @Arguments a
DeclareAttribute( "MorphismFromLeftBidual",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $s = (a^{\vee})^{\vee}$.
#! The output is the inverse of the morphism to the bidual $(a^{\vee})^{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a^{\vee})^{\vee},a)$.
#! @Arguments a, s
DeclareOperation( "MorphismFromLeftBidualWithGivenLeftBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );
