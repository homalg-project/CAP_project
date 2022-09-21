# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Reading the declaration part of the package.
#

## Monoidal
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductOnObjectsAndUnitObject.gd" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategories.autogen.gd" );

## Additive Monoidal

ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategories.autogen.gd" );

## Braided Monoidal

ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategories.autogen.gd" );

## Symmetric Monoidal

ReadPackage( "MonoidalCategories", "gap/SymmetricMonoidalCategoriesProperties.gd" );

## (Co)Closed Monoidal

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesProperties.gd" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategories.gd" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategories.autogen.gd" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategories.autogen.gd" );

## Symmetric (Co)Closed Monoidal

ReadPackage( "MonoidalCategories", "gap/SymmetricClosedMonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/SymmetricCoclosedMonoidalCategoriesProperties.gd" );

## Rigid Symmetric (Co)Closed Monoidal

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesProperties.gd" );

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategories.gd" );

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategories.autogen.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategories.autogen.gd" );

## Create files for monoidal categories
ReadPackage( "MonoidalCategories", "gap/CreateMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/CreateClosedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/CreateCoclosedMonoidalCategories.gd" );

## Test methods

ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductAndUnitTest.gd" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesTest.gd" );
