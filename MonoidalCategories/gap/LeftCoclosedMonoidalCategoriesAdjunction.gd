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

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a,b}: a \rightarrow \mathrm{\underline{coHom}_\ell}(a,b) \otimes b$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{\underline{coHom}_\ell}(a,b) \otimes b )$.
#! @Arguments a, b
DeclareOperation( "LeftCoclosedMonoidalEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{\underline{coHom}_\ell}(a,b) \otimes b$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a,b}: a \rightarrow \mathrm{\underline{coHom}_\ell}(a,b) \otimes b$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, r )$.
#! @Arguments a, b, r
DeclareOperation( "LeftCoclosedMonoidalEvaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a,b}: \mathrm{\underline{coHom}_\ell}(a \otimes b, b) \rightarrow a$, i.e.,
#! the counit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}_\ell}(a \otimes b, b), a )$.
#! @Arguments a, b
DeclareOperation( "LeftCoclosedMonoidalCoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{\underline{coHom}_\ell}(a \otimes b, b)$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a,b}: \mathrm{\underline{coHom}_\ell}(a \otimes b, b) \rightarrow a$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( s, a )$.
#! @Arguments a, b, s
DeclareOperation( "LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $c,b$ and a morphism $g: a \rightarrow c \otimes b$.
#! The output is a morphism $f: \mathrm{\underline{coHom}_\ell}(a,b) \rightarrow c$
#! corresponding to $g$ under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}_\ell}(a,b), c )$.
#! @Arguments c, b, g
DeclareOperation( "TensorProductToLeftInternalCoHomAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $c,b$, a morphism $g: a \rightarrow c \otimes b$ and an object $i = \mathrm{\underline{coHom}_\ell}(a,b)$.
#! The output is a morphism $f: \mathrm{\underline{coHom}_\ell}(a,b) \rightarrow c$
#! corresponding to $g$ under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( i, c )$.
#! @Arguments c, b, g, i
DeclareOperation( "TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and a morphism $f: \mathrm{\underline{coHom}_\ell}(a,b) \rightarrow c$.
#! The output is a morphism $g: a \rightarrow c \otimes b$ corresponding to $f$ under the
#! cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a, c \otimes b)$.
#! @Arguments a, b, f
DeclareOperation( "LeftInternalCoHomToTensorProductAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $a,b$, a morphism $f: \mathrm{\underline{coHom}_\ell}(a,b) \rightarrow c$ and an object $t = c \otimes b$.
#! The output is a morphism $g: a \rightarrow c \otimes b$ corresponding to $f$ under the
#! cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, t )$.
#! @Arguments a, b, f, t
DeclareOperation( "LeftInternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );
