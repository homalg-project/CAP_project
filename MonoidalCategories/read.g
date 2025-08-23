# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Reading the implementation part of the package.
#

## Monoidal

ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductOnObjectsAndTensorUnitMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductOnObjectsAndTensorUnit.gi" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductOnObjectsAndTensorUnitMethodRecordInstallations.autogen.gi" );

ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesMethodRecordInstallations.autogen.gi" );

## Additive Monoidal

ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesProperties.gi" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesMethodRecordInstallations.autogen.gi" );

## Braided Monoidal

ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesProperties.gi" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesMethodRecordInstallations.autogen.gi" );

## Symmetric Monoidal

ReadPackage( "MonoidalCategories", "gap/SymmetricMonoidalCategoriesProperties.gi" );

## (Co)Closed Monoidal

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesProperties.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesProperties.gi" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesMethodRecord.gi" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategories.gi" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesMethodRecordInstallations.autogen.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesMethodRecordInstallations.autogen.gi" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesProperties.gi" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesProperties.gi" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesMethodRecord.gi" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategories.gi" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesMethodRecordInstallations.autogen.gi" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesMethodRecordInstallations.autogen.gi" );

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

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesMethodRecordInstallations.autogen.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesMethodRecordInstallations.autogen.gi" );

## Derived Methods

ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/SymmetricMonoidalCategoriesDerivedMethods.gi" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesDerivedMethods.gi" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesDerivedMethods_extra.gi" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesDerivedMethods.gi" );

ReadPackage( "MonoidalCategories", "gap/SymmetricClosedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/SymmetricCoclosedMonoidalCategoriesDerivedMethods.gi" );

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesDerivedMethods.gi" );

## Homomorphism Structure from Closed Monoidal Structure

ReadPackage( "MonoidalCategories", "gap/HomomorphismStructureDerivedMethods.gi" );

## Create files for monoidal categories

ReadPackage( "MonoidalCategories", "gap/CreateMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/CreateLeftClosedMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/CreateLeftCoclosedMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/CreateClosedMonoidalCategories.gi" );
ReadPackage( "MonoidalCategories", "gap/CreateCoclosedMonoidalCategories.gi" );

## Synonyms

#= comment for Julia
ReadPackage( "MonoidalCategories", "gap/Synonyms.gi" );
# =#

## Test methods

ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest.gi" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesTest.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesTest.gi" );

## WithGiven test methods

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesTestWithGiven.gi" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesTestWithGiven.gi" );
ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesTestWithGiven.gi" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesTestWithGiven.gi" );
