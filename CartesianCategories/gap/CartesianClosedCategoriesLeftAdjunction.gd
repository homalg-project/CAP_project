# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



####################################
##
#! @Chapter Cartesian Categories
##
#! @Section Cartesian Closed Categories
##
####################################

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the evaluation morphism $\mathrm{ev}_{a,b}: \mathrm{Exponential}(a,b) \times a \rightarrow b$, i.e.,
#! the counit of the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a,b) \times a, b )$.
#! @Arguments a, b
DeclareOperation( "CartesianEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{Exponential}(a,b) \times a$.
#! The output is the evaluation morphism $\mathrm{ev}_{a,b}: \mathrm{Exponential}(a,b) \times a \rightarrow b$, i.e.,
#! the counit of the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( s, b )$.
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

#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{Exponential}(b, a \times b)$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: a \rightarrow \mathrm{Exponential}(b, a \times b)$, i.e.,
#! the unit of the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, r )$.
#! @Arguments a, b, r
DeclareOperation( "CartesianCoevaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and a morphism $f: a \times b \rightarrow c$.
#! The output is a morphism $g: a \rightarrow \mathrm{Exponential}(b,c)$
#! corresponding to $f$ under the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{Exponential}(b,c) )$.
#! @Arguments a, b, f
DeclareOperation( "DirectProductToExponentialAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $a,b$, a morphism $f: a \times b \rightarrow c$ and an object $i = \mathrm{Exponential}(b,c)$.
#! The output is a morphism $g: a \rightarrow \mathrm{Exponential}(b,c)$
#! corresponding to $f$ under the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, i )$.
#! @Arguments a, b, f, i
DeclareOperation( "DirectProductToExponentialAdjunctionMapWithGivenExponential",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $b,c$ and a morphism $g: a \rightarrow \mathrm{Exponential}(b,c)$.
#! The output is a morphism $f: a \times b \rightarrow c$ corresponding to $g$ under the
#! direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a \times b, c)$.
#! @Arguments b, c, g
DeclareOperation( "ExponentialToDirectProductAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $b,c$, a morphism $g: a \rightarrow \mathrm{Exponential}(b,c)$ and an object $t = a \times b$.
#! The output is a morphism $f: a \times b \rightarrow c$ corresponding to $g$ under the
#! direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}(t, c)$.
#! @Arguments b, c, g, t
DeclareOperation( "ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );
