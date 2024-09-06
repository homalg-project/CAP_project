# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Reading the declaration part of the package.
#

## Monoidal

ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductOnObjectsAndTensorUnit.gd" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductOnObjectsAndTensorUnitMethodRecordDeclarations.autogen.gd" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesMethodRecordDeclarations.autogen.gd" );

## Additive Monoidal

ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesMethodRecordDeclarations.autogen.gd" );

## Braided Monoidal

ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesMethodRecordDeclarations.autogen.gd" );

## Symmetric Monoidal

ReadPackage( "MonoidalCategories", "gap/SymmetricMonoidalCategoriesProperties.gd" );

## C(oc)losed Monoidal

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesProperties.gd" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategories.gd" );

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesMethodRecordDeclarations.autogen.gd" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesMethodRecordDeclarations.autogen.gd" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesProperties.gd" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategories.gd" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesMethodRecordDeclarations.autogen.gd" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesMethodRecordDeclarations.autogen.gd" );

## Symmetric C(oc)losed Monoidal

ReadPackage( "MonoidalCategories", "gap/SymmetricClosedMonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/SymmetricCoclosedMonoidalCategoriesProperties.gd" );

## Rigid Symmetric C(oc)losed Monoidal

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesProperties.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesProperties.gd" );

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategories.gd" );

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesMethodRecordDeclarations.autogen.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesMethodRecordDeclarations.autogen.gd" );

## Create files for monoidal categories

ReadPackage( "MonoidalCategories", "gap/CreateMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/CreateLeftClosedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/CreateLeftCoclosedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/CreateClosedMonoidalCategories.gd" );
ReadPackage( "MonoidalCategories", "gap/CreateCoclosedMonoidalCategories.gd" );

## Synonyms

#= comment for Julia
ReadPackage( "MonoidalCategories", "gap/Synonyms.gd" );
# =#

## Test methods

ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest.gd" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesTest.gd" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricCoclosedMonoidalCategoriesTest.gd" );

## WithGiven test methods

ReadPackage( "MonoidalCategories", "gap/LeftClosedMonoidalCategoriesTestWithGiven.gd" );
ReadPackage( "MonoidalCategories", "gap/LeftCoclosedMonoidalCategoriesTestWithGiven.gd" );
ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesTestWithGiven.gd" );
ReadPackage( "MonoidalCategories", "gap/CoclosedMonoidalCategoriesTestWithGiven.gd" );
