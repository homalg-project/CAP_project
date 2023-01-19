# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#

####################################
##
#! @Chapter Cartesian Categories
##
#! @Section Cartesian Categories
##
####################################

#! @Description
#!  The arguments are an object $a$ and an integer $n$.
#!  The output is the diagonal morphism from $a$ to the $n$-fold cartesian power $a^{\times n}$.
#! @Returns a morphism in $\mathrm{Hom}(a, a^{\times n})$.
#! @Arguments a, n
DeclareOperation( "CartesianDiagonal",
                  [ IsCapCategoryObject, IsInt ] );

#! @Description
#!  The arguments are an object $a$, an integer $n$, and an object $b$ equal to the $n$-fold cartesian power $a^{\times n}$ of $a$.
#!  The output is the diagonal morphism from $a$ to $b$.
#! @Returns a morphism in $\mathrm{Hom}(a, b)$
#! @Arguments a, n, b
DeclareOperation( "CartesianDiagonalWithGivenCartesianPower",
                  [ IsCapCategoryObject, IsInt, IsCapCategoryObject ] );
