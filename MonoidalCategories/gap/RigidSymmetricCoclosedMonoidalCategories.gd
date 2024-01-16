# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Rigid Symmetric Coclosed Monoidal Categories
##
####################################

DeclareGlobalVariable( "RIGID_SYMMETRIC_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObjectWithGivenObjects}_{a,b}: \mathrm{\underline{coHom}_\ell}(a,b) \rightarrow b_{\vee} \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}_\ell}(a,b), b_{\vee} \otimes a )$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject}$, namely
#! $\mathrm{IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom}_{a,b}: a_{\vee} \otimes b \rightarrow \mathrm{\underline{coHom}_\ell}(b,a)$.
#! @Returns a morphism in $\mathrm{Hom}( a_{\vee} \otimes b, \mathrm{\underline{coHom}_\ell}(b,a)$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects}$, namely
#! $\mathrm{MorphismFromTensorProductToLeftInternalCoHomWithGivenObjects}_{a,b}: a_{\vee} \otimes b \rightarrow \mathrm{\underline{coHom}_\ell}(b,a)$.
#! @Returns a morphism in $\mathrm{Hom}( a_{\vee} \otimes b, \mathrm{\underline{coHom}_\ell}(b,a) )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromTensorProductToLeftInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s_{\vee} = a \otimes b$,
#! two objects $a,b$,
#! and an object $r = \mathrm{\underline{coHom}_\ell}(b,a)$.
#! The output is the inverse of $\mathrm{MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects}$, namely
#! $\mathrm{MorphismFromTensorProductToLeftInternalCoHomWithGivenObjects}_{a,b}: a_{\vee} \otimes b \rightarrow \mathrm{\underline{coHom}_\ell}(b,a)$.
#! @Returns a morphism in $\mathrm{Hom}( a_{\vee} \otimes b, \mathrm{\underline{coHom}_\ell}(b,a)$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromTensorProductToLeftInternalCoHomWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

## The four objects are given as a list because otherwise the WithGiven operation would
## exceed the maximal number of arguments for an operation (6)
#! @Description
#! The argument is a list of four objects $[ a, a', b, b' ]$.
#! The output is the natural morphism
#! $\mathrm{LeftInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{coHom}_\ell}(a,b) \otimes \mathrm{\underline{coHom}_\ell}(a',b') \rightarrow \mathrm{\underline{coHom}_\ell}(a \otimes a', b \otimes b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}_\ell}(a,b) \otimes \mathrm{\underline{coHom}_\ell}(a',b'), \mathrm{\underline{coHom}_\ell}(a \otimes a', b \otimes b' )$.
#! @Arguments list
DeclareOperation( "LeftInternalCoHomTensorProductCompatibilityMorphismInverse",
                  [ IsList ] );

#! @Description
#! The arguments are a list of four objects $[ a, a', b, b' ]$,
#! and two objects $s = \mathrm{\underline{coHom}_\ell}(a,b) \otimes \mathrm{\underline{coHom}_\ell}(a',b')$ and $r = \mathrm{\underline{coHom}_\ell}(a \otimes a', b \otimes b')$.
#! The output is the natural morphism
#! $\mathrm{LeftInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{coHom}_\ell}(a,b) \otimes \mathrm{\underline{coHom}_\ell}(a',b') \rightarrow \mathrm{\underline{coHom}_\ell}(a \otimes a', b \otimes b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}_\ell}(a,b) \otimes \mathrm{\underline{coHom}_\ell}(a',b'), \mathrm{\underline{coHom}_\ell}(a \otimes a', b \otimes b' )$.
#! @Arguments s, list, r
DeclareOperation( "LeftInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a}: a \otimes a_{\vee} \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes a_{\vee}, 1)$.
#! @Arguments a
DeclareAttribute( "LeftCoclosedMonoidalCoevaluationForLeftCoDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $s = a \otimes a_{\vee}$,
#! an object $a$,
#! and an object $r = 1$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a}: a \otimes a_{\vee} \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes a_{\vee}, 1)$.
#! @Arguments s,a,r
DeclareOperation( "LeftCoclosedMonoidalCoevaluationForLeftCoDualWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an endomorphism $\alpha: a \rightarrow a$.
#! The output is the cotrace morphism $\mathrm{cotrace}_{\alpha}: 1 \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(1,1)$.
#! @Arguments alpha
DeclareAttribute( "CoTraceMap",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $a$.
#! The output is the corank morphism $\mathrm{corank}_a: 1 \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(1,1)$.
#! @Arguments a
DeclareAttribute( "CoRankMorphism",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the morphism from the cobidual $a \rightarrow (a_{\vee})_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a, (a_{\vee})_{\vee})$.
#! @Arguments a
DeclareAttribute( "MorphismToLeftCoBidual",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $r = (a_{\vee})_{\vee}$.
#! The output is the inverse of the morphism from the cobidual $a \rightarrow (a_{\vee})_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a,(a_{\vee})_{\vee})$.
#! @Arguments a, r
DeclareOperation( "MorphismToLeftCoBidualWithGivenLeftCoBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );
