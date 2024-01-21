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
#! The output is the natural morphism $\mathrm{IsomorphismFromInternalCoHomToTensorProductWithCoDualObjectWithGivenObjects}_{a,b}: \mathrm{\underline{coHom}}(a,b) \rightarrow b_{\vee} \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,b), b_{\vee} \otimes a )$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromInternalCoHomToTensorProductWithCoDualObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{IsomorphismFromInternalCoHomToTensorProductWithCoDualObject}$, namely
#! $\mathrm{IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom}_{a,b}: a_{\vee} \otimes b \rightarrow \mathrm{\underline{coHom}}(b,a)$.
#! @Returns a morphism in $\mathrm{Hom}( a_{\vee} \otimes b, \mathrm{\underline{coHom}}(b,a)$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{MorphismFromInternalCoHomToTensorProductWithGivenObjects}$, namely
#! $\mathrm{MorphismFromTensorProductToInternalCoHomWithGivenObjects}_{a,b}: a_{\vee} \otimes b \rightarrow \mathrm{\underline{coHom}}(b,a)$.
#! @Returns a morphism in $\mathrm{Hom}( a_{\vee} \otimes b, \mathrm{\underline{coHom}}(b,a) )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s_{\vee} = a \otimes b$,
#! two objects $a,b$,
#! and an object $r = \mathrm{\underline{coHom}}(b,a)$.
#! The output is the inverse of $\mathrm{MorphismFromInternalCoHomToTensorProductWithGivenObjects}$, namely
#! $\mathrm{MorphismFromTensorProductToInternalCoHomWithGivenObjects}_{a,b}: a_{\vee} \otimes b \rightarrow \mathrm{\underline{coHom}}(b,a)$.
#! @Returns a morphism in $\mathrm{Hom}( a_{\vee} \otimes b, \mathrm{\underline{coHom}}(b,a)$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromTensorProductToInternalCoHomWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

## The four objects are given as a list because otherwise the WithGiven operation would
## exceed the maximal number of arguments for an operation (6)
#! @Description
#! The argument is a list of four objects $[ a, a', b, b' ]$.
#! The output is the natural morphism
#! $\mathrm{InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(a',b') \rightarrow \mathrm{\underline{coHom}}(a \otimes a', b \otimes b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(a',b'), \mathrm{\underline{coHom}}(a \otimes a', b \otimes b' )$.
#! @Arguments list
DeclareOperation( "InternalCoHomTensorProductCompatibilityMorphismInverse",
                  [ IsList ] );

#! @Description
#! The arguments are a list of four objects $[ a, a', b, b' ]$,
#! and two objects $s = \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(a',b')$ and $r = \mathrm{\underline{coHom}}(a \otimes a', b \otimes b')$.
#! The output is the natural morphism
#! $\mathrm{InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(a',b') \rightarrow \mathrm{\underline{coHom}}(a \otimes a', b \otimes b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(a',b'), \mathrm{\underline{coHom}}(a \otimes a', b \otimes b' )$.
#! @Arguments s, list, r
DeclareOperation( "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a}: a \otimes a_{\vee} \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes a_{\vee}, 1)$.
#! @Arguments a
DeclareAttribute( "CoclosedCoevaluationForCoDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $s = a \otimes a_{\vee}$,
#! an object $a$,
#! and an object $r = 1$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a}: a \otimes a_{\vee} \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes a_{\vee}, 1)$.
#! @Arguments s,a,r
DeclareOperation( "CoclosedCoevaluationForCoDualWithGivenTensorProduct",
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
DeclareAttribute( "MorphismToCoBidual",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $r = (a_{\vee})_{\vee}$.
#! The output is the inverse of the morphism from the cobidual $a \rightarrow (a_{\vee})_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a,(a_{\vee})_{\vee})$.
#! @Arguments a, r
DeclareOperation( "MorphismToCoBidualWithGivenCoBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );
