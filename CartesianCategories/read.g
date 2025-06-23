# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Reading the implementation part of the package.
#

## Initial category

ReadPackage( "CartesianCategories", "gap/InitialCategory.gi" );

## Cartesian and Cocartesian

ReadPackage( "CartesianCategories", "gap/CartesianCategoriesProperties.gi" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategoriesProperties.gi" );

ReadPackage( "CartesianCategories", "gap/CartesianCategoriesMethodRecord.gi" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategoriesMethodRecord.gi" );

ReadPackage( "CartesianCategories", "gap/CartesianCategories.gi" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategories.gi" );

ReadPackage( "CartesianCategories", "gap/CartesianCategoriesMethodRecordInstallations.autogen.gi" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategoriesMethodRecordInstallations.autogen.gi" );

ReadPackage( "CartesianCategories", "gap/DistributiveCartesianCategoriesMethodRecord.gi" );
ReadPackage( "CartesianCategories", "gap/CodistributiveCocartesianCategoriesMethodRecord.gi" );

ReadPackage( "CartesianCategories", "gap/BraidedCartesianCategoriesMethodRecord.gi" );
ReadPackage( "CartesianCategories", "gap/BraidedCocartesianCategoriesMethodRecord.gi" );

ReadPackage( "CartesianCategories", "gap/BraidedCartesianCategories.gi" );
ReadPackage( "CartesianCategories", "gap/BraidedCocartesianCategories.gi" );

ReadPackage( "CartesianCategories", "gap/BraidedCartesianCategoriesMethodRecordInstallations.autogen.gi" );
ReadPackage( "CartesianCategories", "gap/BraidedCocartesianCategoriesMethodRecordInstallations.autogen.gi" );

## Cartesian Closed and Cocartesian Coclosed

ReadPackage( "CartesianCategories", "gap/CartesianClosedCategoriesProperties.gi" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategoriesProperties.gi" );

ReadPackage( "CartesianCategories", "gap/CartesianClosedCategoriesMethodRecord.gi" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategoriesMethodRecord.gi" );

ReadPackage( "CartesianCategories", "gap/CartesianClosedCategories.gi" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategories.gi" );

ReadPackage( "CartesianCategories", "gap/CartesianClosedCategoriesMethodRecordInstallations.autogen.gi" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategoriesMethodRecordInstallations.autogen.gi" );

## Bicartesian, distributive, and codistributive categories

ReadPackage( "CartesianCategories", "gap/BicartesianCategories.gi" );

ReadPackage( "CartesianCategories", "gap/DistributiveCartesianCategories.gi" );
ReadPackage( "CartesianCategories", "gap/CodistributiveCocartesianCategories.gi" );

ReadPackage( "CartesianCategories", "gap/DistributiveCartesianCategoriesMethodRecordInstallations.autogen.gi" );
ReadPackage( "CartesianCategories", "gap/CodistributiveCocartesianCategoriesMethodRecordInstallations.autogen.gi" );

## Derived methods

ReadPackage( "CartesianCategories", "gap/CartesianCategoriesDerivedMethods.gi" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategoriesDerivedMethods.gi" );

ReadPackage( "CartesianCategories", "gap/BraidedCartesianCategoriesDerivedMethods.gi" );
ReadPackage( "CartesianCategories", "gap/BraidedCocartesianCategoriesDerivedMethods.gi" );

ReadPackage( "CartesianCategories", "gap/SymmetricCartesianCategoriesDerivedMethods.gi" );
ReadPackage( "CartesianCategories", "gap/SymmetricCocartesianCategoriesDerivedMethods.gi" );

ReadPackage( "CartesianCategories", "gap/SymmetricCartesianCategoriesDerivedMethods_extra.gi" );
ReadPackage( "CartesianCategories", "gap/SymmetricCocartesianCategoriesDerivedMethods_extra.gi" );



ReadPackage( "CartesianCategories", "gap/CartesianClosedCategoriesDerivedMethods.gi" );
ReadPackage( "CartesianCategories", "gap/CartesianClosedCategoriesDerivedMethods_extra.gi" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategoriesDerivedMethods.gi" );

ReadPackage( "CartesianCategories", "gap/SymmetricCartesianClosedCategoriesDerivedMethods.gi" );
ReadPackage( "CartesianCategories", "gap/SymmetricCocartesianCoclosedCategoriesDerivedMethods.gi" );

ReadPackage( "CartesianCategories", "gap/CartesianCategoriesDerivedMethods_extra.gi" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategoriesDerivedMethods_extra.gi" );

## Synonyms

#= comment for Julia
ReadPackage( "CartesianCategories", "gap/Synonyms.gi" );
# =#

## Test methods

ReadPackage( "CartesianCategories", "gap/CartesianCategoriesTest.gi" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategoriesTest.gi" );

ReadPackage( "CartesianCategories", "gap/DistributiveCartesianCategoriesTest.gi" );
ReadPackage( "CartesianCategories", "gap/CodistributiveCocartesianCategoriesTest.gi" );

ReadPackage( "CartesianCategories", "gap/BraidedCartesianCategoriesTest.gi" );
ReadPackage( "CartesianCategories", "gap/BraidedCocartesianCategoriesTest.gi" );

ReadPackage( "CartesianCategories", "gap/CartesianClosedCategoriesTest.gi" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategoriesTest.gi" );

## Homomorphism structure

ReadPackage( "CartesianCategories", "gap/HomomorphismStructureDerivedMethods.gi" );
