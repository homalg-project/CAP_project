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
#!  The property of the category <A>C</A> being symmetric monoidal by its cartesian structure.
#! @Arguments C
DeclareProperty( "IsSymmetricMonoidalCategoryStructureGivenByDirectProduct", IsCapCategory );

AddCategoricalProperty( [ "IsSymmetricMonoidalCategoryStructureGivenByDirectProduct", "IsSymmetricMonoidalCategoryStructureGivenByCoproduct" ] );

#! @Description
#!  The arguments are an object $a$ and an integer $n \geq 0$.
#!  The output is the diagonal morphism from $a$ to the $n$-fold cartesian power $a^{\times n}$.
#!  If the category does not support empty limits, $n$ must be not be 0.
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

#! @Description
#!  The argument $C$ is a cartesian category.
#!  The operation equips $C$ with the symmetric monodial structure defined by the direct product.
#! @Returns nothing
#! @Arguments C
DeclareOperation( "SetTensorProductToDirectProduct",
                  [ IsCapCategory ] );
