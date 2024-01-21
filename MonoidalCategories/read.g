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

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesProperties.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesProperties.gi" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesMethodRecord.gi" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesAdjunctionMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesAdjunctionMethodRecord.gi" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategories.gi" );

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

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesDerivedMethods.gi" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesAdjunctionDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesAdjunctionDerivedMethods.gi" );

ReadPackage( "MonoidalCategories", "gap/SymmetricClosedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/SymmetricCoclosedMonoidalCategoriesDerivedMethods.gi" );

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesDerivedMethods.gi" );

## Homomorphism Structure from Closed Monoidal Structure

ReadPackage( "MonoidalCategories", "gap/HomomorphismStructureDerivedMethods.gi" );

## Create files for monoidal categories

ReadPackage( "MonoidalCategories", "gap/CreateMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/CreateLeftClosedMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/CreateLeftClosedMonoidalCategoriesAdjunction.gi" );
ReadPackage( "MonoidalCategories", "gap/CreateLeftCoclosedMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/CreateLeftCoclosedMonoidalCategoriesAdjunction.gi" );

## Synonyms

ReadPackage( "MonoidalCategories", "gap/Synonyms.gi" );

## Test methods

ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductAndUnitTest.gi" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesTest.gi" );
