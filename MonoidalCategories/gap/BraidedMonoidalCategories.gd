# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Braided Monoidal Categories
##
####################################

DeclareGlobalVariable( "BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the braiding $ B_{a,b}: a \otimes b \rightarrow b \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes b, b \otimes a )$.
#! @Arguments a,b
DeclareOperation( "Braiding",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a \otimes b$, 
#! two objects $a,b$,
#! and an object $r = b \otimes a$.
#! The output is the braiding $ B_{a,b}: a \otimes b \rightarrow b \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes b, b \otimes a )$.
#! @Arguments s,a,b,r
DeclareOperation( "BraidingWithGivenTensorProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse braiding $ B_{a,b}^{-1}: b \otimes a \rightarrow a \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( b \otimes a, a \otimes b )$.
#! @Arguments a,b
DeclareOperation( "BraidingInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = b \otimes a$, 
#! two objects $a,b$,
#! and an object $r = a \otimes b$.
#! The output is the inverse braiding $ B_{a,b}^{-1}: b \otimes a \rightarrow a \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( b \otimes a, a \otimes b )$.
#! @Arguments s,a,b,r
DeclareOperation( "BraidingInverseWithGivenTensorProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );
