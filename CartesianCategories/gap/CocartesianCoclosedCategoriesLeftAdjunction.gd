# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



####################################
##
#! @Chapter Cocartesian Categories
##
#! @Section Cocartesian Coclosed Categories
##
####################################

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the cocartesian evaluation morphism $\mathrm{cocaev}_{a,b}: a \rightarrow \mathrm{Coexponential}(a,b) \sqcup b$, i.e.,
#! the unit of the coexponential-coproduct adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{Coexponential}(a,b) \sqcup b )$.
#! @Arguments a, b
DeclareOperation( "CocartesianEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{Coexponential}(a,b) \sqcup b$.
#! The output is the cocartesian evaluation morphism $\mathrm{cocaev}_{a,b}: a \rightarrow \mathrm{Coexponential}(a,b) \sqcup b$, i.e.,
#! the unit of the coexponential-coproduct adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, r )$.
#! @Arguments a, b, r
DeclareOperation( "CocartesianEvaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the cocartesian coevaluation morphism $\mathrm{cocacoev}_{a,b}: \mathrm{Coexponential}(a \sqcup b, b) \rightarrow a$, i.e.,
#! the counit of the coexponential-coproduct adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a \sqcup b, b), a )$.
#! @Arguments a, b
DeclareOperation( "CocartesianCoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{Coexponential}(a \sqcup b, b)$.
#! The output is the cocartesian coevaluation morphism $\mathrm{cocacoev}_{a,b}: \mathrm{Coexponential}(a \sqcup b, b) \rightarrow a$, i.e.,
#! the unit of the coexponential-coproduct adjunction.
#! @Returns a morphism in $\mathrm{Hom}( s, a )$.
#! @Arguments a, b, s
DeclareOperation( "CocartesianCoevaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $c,b$ and a morphism $g: a \rightarrow c \sqcup b$.
#! The output is a morphism $f: \mathrm{Coexponential}(a,b) \rightarrow c$
#! corresponding to $g$ under the coexponential-coproduct adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b), c )$.
#! @Arguments c, b, g
DeclareOperation( "CoproductToCoexponentialAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $c,b$, a morphism $g: a \rightarrow c \sqcup b$ and an object $i = \mathrm{Coexponential}(a,b)$.
#! The output is a morphism $f: \mathrm{Coexponential}(a,b) \rightarrow c$
#! corresponding to $g$ under the coexponential-coproduct adjunction.
#! @Returns a morphism in $\mathrm{Hom}( i, c )$.
#! @Arguments c, b, g, i
DeclareOperation( "CoproductToCoexponentialAdjunctionMapWithGivenCoexponential",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$ and a morphism $f: \mathrm{Coexponential}(a,b) \rightarrow c$.
#! The output is a morphism $g: a \rightarrow c \sqcup b$ corresponding to $f$ under the
#! coexponential-coproduct adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a, c \sqcup b)$.
#! @Arguments a, b, f
DeclareOperation( "CoexponentialToCoproductAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $a,b$, a morphism $f: \mathrm{Coexponential}(a,b) \rightarrow c$ and an object $t = c \sqcup b$.
#! The output is a morphism $g: a \rightarrow c \sqcup b$ corresponding to $f$ under the
#! coexponential-coproduct adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, t )$.
#! @Arguments a, b, f, t
DeclareOperation( "CoexponentialToCoproductAdjunctionMapWithGivenCoproduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );
