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

## C(oc)losed Monoidal

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesProperties.gd" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategories.gd" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategories.autogen.gd" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategories.autogen.gd" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesAdjunction.gd" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesAdjunction.gd" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesAdjunction.autogen.gd" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesAdjunction.autogen.gd" );

## Symmetric C(oc)losed Monoidal

ReadPackage( "MonoidalCategories", "gap/SymmetricClosedMonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/SymmetricCoclosedMonoidalCategoriesProperties.gd" );

## Rigid Symmetric C(oc)losed Monoidal

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesProperties.gd" );

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategories.gd" );

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategories.autogen.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategories.autogen.gd" );

## Create files for monoidal categories

ReadPackage( "MonoidalCategories", "gap/CreateMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/CreateLeftClosedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/CreateLeftClosedMonoidalCategoriesAdjunction.gd" );
ReadPackage( "MonoidalCategories", "gap/CreateLeftCoclosedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/CreateLeftCoclosedMonoidalCategoriesAdjunction.gd" );

## Synonyms

ReadPackage( "MonoidalCategories", "gap/Synonyms.gd" );

## Test methods

ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductAndUnitTest.gd" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesTest.gd" );
