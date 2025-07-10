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
#! @Section Cartesian Categories
##
####################################

DeclareGlobalVariable( "BRAIDED_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD" );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the braiding $ B_{a,b}: a \times b \rightarrow b \times a$.
#! @Returns a morphism in $\mathrm{Hom}( a \times b, b \times a )$.
#! @Arguments a,b
DeclareOperation( "CartesianBraiding",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a \times b$, 
#! two objects $a,b$,
#! and an object $r = b \times a$.
#! The output is the braiding $ B_{a,b}: a \times b \rightarrow b \times a$.
#! @Returns a morphism in $\mathrm{Hom}( a \times b, b \times a )$.
#! @Arguments s,a,b,r
DeclareOperation( "CartesianBraidingWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse braiding $ B_{a,b}^{-1}: b \times a \rightarrow a \times b$.
#! @Returns a morphism in $\mathrm{Hom}( b \times a, a \times b )$.
#! @Arguments a,b
DeclareOperation( "CartesianBraidingInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = b \times a$, 
#! two objects $a,b$,
#! and an object $r = a \times b$.
#! The output is the inverse braiding $ B_{a,b}^{-1}: b \times a \rightarrow a \times b$.
#! @Returns a morphism in $\mathrm{Hom}( b \times a, a \times b )$.
#! @Arguments s,a,b,r
DeclareOperation( "CartesianBraidingInverseWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );
