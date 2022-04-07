# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



####################################
##
#! @Chapter Cocartesian Categories
##
#! @Section Cocartesian Categories
##
####################################

DeclareGlobalVariable( "BRAIDED_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD" );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the braiding $ B_{a,b}: a \sqcup b \rightarrow b \sqcup a$.
#! @Returns a morphism in $\mathrm{Hom}( a \sqcup b, b \sqcup a )$.
#! @Arguments a,b
DeclareOperation( "CocartesianBraiding",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a \sqcup b$, 
#! two objects $a,b$,
#! and an object $r = b \sqcup a$.
#! The output is the braiding $ B_{a,b}: a \sqcup b \rightarrow b \sqcup a$.
#! @Returns a morphism in $\mathrm{Hom}( a \sqcup b, b \sqcup a )$.
#! @Arguments s,a,b,r
DeclareOperation( "CocartesianBraidingWithGivenCoproducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse braiding $ B_{a,b}^{-1}: b \sqcup a \rightarrow a \sqcup b$.
#! @Returns a morphism in $\mathrm{Hom}( b \sqcup a, a \sqcup b )$.
#! @Arguments a,b
DeclareOperation( "CocartesianBraidingInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = b \sqcup a$, 
#! two objects $a,b$,
#! and an object $r = a \sqcup b$.
#! The output is the inverse braiding $ B_{a,b}^{-1}: b \sqcup a \rightarrow a \sqcup b$.
#! @Returns a morphism in $\mathrm{Hom}( b \sqcup a, a \sqcup b )$.
#! @Arguments s,a,b,r
DeclareOperation( "CocartesianBraidingInverseWithGivenCoproducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "CheckCocartesianBraiding",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );
