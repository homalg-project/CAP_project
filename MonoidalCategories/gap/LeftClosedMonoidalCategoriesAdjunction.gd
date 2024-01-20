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
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: a \rightarrow \mathrm{\underline{Hom}_\ell}(b, a \otimes b)$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{\underline{Hom}_\ell}(b, a \otimes b) )$.
#! @Arguments a, b
DeclareOperation( "LeftClosedMonoidalCoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{\underline{Hom}_\ell}(b, a \otimes b)$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: a \rightarrow \mathrm{\underline{Hom}_\ell}(b, a \otimes b)$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, r )$.
#! @Arguments a, b, r
DeclareOperation( "LeftClosedMonoidalCoevaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and a morphism $f: a \otimes b \rightarrow c$.
#! The output is a morphism $g: a \rightarrow \mathrm{\underline{Hom}_\ell}(b,c)$
#! corresponding to $f$ under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{\underline{Hom}_\ell}(b,c) )$.
#! @Arguments a, b, f
DeclareOperation( "TensorProductToLeftInternalHomAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $a,b$, a morphism $f: a \otimes b \rightarrow c$ and an object $i = \mathrm{\underline{Hom}_\ell}(b,c)$.
#! The output is a morphism $g: a \rightarrow \mathrm{\underline{Hom}_\ell}(b,c)$
#! corresponding to $f$ under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, i )$.
#! @Arguments a, b, f, i
DeclareOperation( "TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $b,c$ and a morphism $g: a \rightarrow \mathrm{\underline{Hom}_\ell}(b,c)$.
#! The output is a morphism $f: a \otimes b \rightarrow c$ corresponding to $g$ under the
#! tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes b, c)$.
#! @Arguments b, c, g
DeclareOperation( "LeftInternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $b,c$, a morphism $g: a \rightarrow \mathrm{\underline{Hom}_\ell}(b,c)$ and an object $t = a \otimes b$.
#! The output is a morphism $f: a \otimes b \rightarrow c$ corresponding to $g$ under the
#! tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(t, c)$.
#! @Arguments b, c, g, t
DeclareOperation( "LeftInternalHomToTensorProductAdjunctionMapWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );
