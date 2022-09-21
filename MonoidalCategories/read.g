# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Reading the implementation part of the package.
#

## Monoidal
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductAndUnitMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductOnObjectsAndUnitObject.gi" );

ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategories.gi" );

## Additive Monoidal

ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategories.gi" );

## Braided Monoidal

ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesProperties.gi" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategories.gi" );

## Symmetric Monoidal

ReadPackage( "MonoidalCategories", "gap/SymmetricMonoidalCategoriesProperties.gi" );

## (Co)Closed Monoidal

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesProperties.gi" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesProperties.gi" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesMethodRecord.gi" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategories.gi" );

## Symmetric (Co)Closed Monoidal

ReadPackage( "MonoidalCategories", "gap/SymmetricClosedMonoidalCategoriesProperties.gi" );
ReadPackage( "MonoidalCategories", "gap/SymmetricCoclosedMonoidalCategoriesProperties.gi" );

## Rigid Symmetric (Co)Closed Monoidal

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesProperties.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesProperties.gi" );

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesMethodRecord.gi" );

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategories.gi" );

## Derived Methods

ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/SymmetricMonoidalCategoriesDerivedMethods.gi" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesDerivedMethods.gi" );

ReadPackage( "MonoidalCategories", "gap/SymmetricClosedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/SymmetricCoclosedMonoidalCategoriesDerivedMethods.gi" );

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesDerivedMethods.gi" );

## Homomorphism Structure from Closed Monoidal Structure

ReadPackage( "MonoidalCategories", "gap/HomomorphismStructureDerivedMethods.gi" );

## Create files for monoidal categories

ReadPackage( "MonoidalCategories", "gap/CreateMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/CreateClosedMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/CreateCoclosedMonoidalCategories.gi" );

## Test methods

ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductAndUnitTest.gi" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesTest.gi" );
