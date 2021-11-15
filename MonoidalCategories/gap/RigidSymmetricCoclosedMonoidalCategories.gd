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

DeclareGlobalVariable( "RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{IsomorphismFromInternalCoHomToTensorProductWithGivenObjects}_{a,b}: \mathrm{\underline{coHom}}(a,b) \rightarrow a \otimes b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,b), a \otimes b_{\vee} )$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromInternalCoHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{MorphismFromInternalCoHomToTensorProductWithGivenObjects}$, namely
#! $\mathrm{MorphismFromTensorProductToInternalCoHomWithGivenObjects}_{a,b}: a \otimes b_{\vee} \rightarrow \mathrm{\underline{coHom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes b_{\vee}, \mathrm{\underline{coHom}}(a,b) )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a \otimes b_{\vee}$,
#! two objects $a,b$,
#! and an object $r = \mathrm{\underline{coHom}}(a,b)$.
#! The output is the inverse of $\mathrm{MorphismFromInternalCoHomToTensorProductWithGivenObjects}$, namely
#! $\mathrm{MorphismFromTensorProductToInternalCoHomWithGivenObjects}_{a,b}: a \otimes b_{\vee} \rightarrow \mathrm{\underline{coHom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes b_{\vee}, \mathrm{\underline{coHom}}(a,b)$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromTensorProductToInternalCoHomWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{IsomorphismFromInternalCoHomToTensorProduct}$, namely
#! $\mathrm{IsomorphismFromTensorProductToInternalCoHom}_{a,b}: a \otimes b_{\vee} \rightarrow \mathrm{\underline{coHom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes b_{\vee}, \mathrm{\underline{coHom}}(a,b)$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## The four objects are given are given as a list because otherwise the WithGiven operation would
## exceed the maximal number of arguments for an operation (6)
#! @Description
#! The argument is a list of four objects $[ a, a', b, b' ]$.
#! The output is the natural morphism
#! $\mathrm{InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{coHom}}(a_1, a_2) \otimes \mathrm{\underline{coHom}}(b_1, b_2) \rightarrow \mathrm{\underline{coHom}}(a_1 \otimes b_1, a_2 \otimes b_2)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a_1, a_2) \otimes \mathrm{\underline{coHom}}(b_1, b_2), \mathrm{\underline{coHom}}(a_1 \otimes b_1, a_2 \otimes b_2)$.
#! @Arguments list
DeclareOperation( "InternalCoHomTensorProductCompatibilityMorphismInverse",
                  [ IsList ] );

#! @Description
#! The arguments are a list of four objects $[ a, a', b, b' ]$,
#! and two objects $s = \mathrm{\underline{coHom}}(a_1, a_2) \otimes \mathrm{\underline{coHom}}(b_1, b_2)$ and $r = \mathrm{\underline{coHom}}(a_1 \otimes b_1, a_2 \otimes b_2)$.
#! The output is the natural morphism
#! $\mathrm{InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{coHom}}(a_1, a_2) \otimes \mathrm{\underline{coHom}}(b_1, b_2) \rightarrow \mathrm{\underline{coHom}}(a_1 \otimes b_1, a_2 \otimes b_2)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a_1, a_2) \otimes \mathrm{\underline{coHom}}(b_1, b_2), \mathrm{\underline{coHom}}(a_1 \otimes b_1, a_2 \otimes b_2) )$.
#! @Arguments s, list, r
DeclareOperation( "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a}: a_{\vee} \otimes a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee} \otimes a, 1)$.
#! @Arguments a
DeclareAttribute( "CoclosedCoevaluationForCoDual",
                  IsCapCategoryObject );


#! @Description
#! The arguments are an object $s = a_{\vee} \otimes a$,
#! an object $a$,
#! and an object $r = 1$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a}: a_{\vee} \otimes a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee} \otimes a, 1)$.
#! @Arguments s,a,r
DeclareOperation( "CoclosedCoevaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an endomorphism $\alpha: A \rightarrow A$.
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
