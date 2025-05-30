# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Reading the declaration part of the package.
#

ReadPackage( "CartesianCategories", "gap/Tools.gd" );

## Initial category

ReadPackage( "CartesianCategories", "gap/InitialCategory.gd" );
ReadPackage( "CartesianCategories", "gap/InitialCategoryProperties.gd" );

## Cartesian and Cocartesian

ReadPackage( "CartesianCategories", "gap/CartesianCategories.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategories.gd" );

ReadPackage( "CartesianCategories", "gap/CartesianCategories_extra.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategories_extra.gd" );

ReadPackage( "CartesianCategories", "gap/CartesianCategoriesProperties.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategoriesProperties.gd" );

ReadPackage( "CartesianCategories", "gap/CartesianCategoriesMethodRecordDeclarations.autogen.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategoriesMethodRecordDeclarations.autogen.gd" );

ReadPackage( "CartesianCategories", "gap/BraidedCartesianCategories.gd" );
ReadPackage( "CartesianCategories", "gap/BraidedCocartesianCategories.gd" );

ReadPackage( "CartesianCategories", "gap/BraidedCartesianCategoriesMethodRecordDeclarations.autogen.gd" );
ReadPackage( "CartesianCategories", "gap/BraidedCocartesianCategoriesMethodRecordDeclarations.autogen.gd" );

## Cartesian Closed and Cocartesian Coclosed

ReadPackage( "CartesianCategories", "gap/CartesianClosedCategoriesProperties.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategoriesProperties.gd" );

ReadPackage( "CartesianCategories", "gap/CartesianClosedCategories.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategories.gd" );

ReadPackage( "CartesianCategories", "gap/CartesianClosedCategoriesMethodRecordDeclarations.autogen.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategoriesMethodRecordDeclarations.autogen.gd" );

## Bicartesian, distributive, and codistributive categories

ReadPackage( "CartesianCategories", "gap/BicartesianCategories.gd" );

ReadPackage( "CartesianCategories", "gap/DistributiveCartesianCategories.gd" );
ReadPackage( "CartesianCategories", "gap/CodistributiveCocartesianCategories.gd" );

ReadPackage( "CartesianCategories", "gap/DistributiveCartesianCategoriesProperties.gd" );
ReadPackage( "CartesianCategories", "gap/CodistributiveCocartesianCategoriesProperties.gd" );

ReadPackage( "CartesianCategories", "gap/DistributiveCartesianCategoriesMethodRecordDeclarations.autogen.gd" );
ReadPackage( "CartesianCategories", "gap/CodistributiveCocartesianCategoriesMethodRecordDeclarations.autogen.gd" );

## Synonyms

#= comment for Julia
ReadPackage( "CartesianCategories", "gap/Synonyms.gd" );
# =#

## Test methods

ReadPackage( "CartesianCategories", "gap/CartesianCategoriesTest.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategoriesTest.gd" );

ReadPackage( "CartesianCategories", "gap/DistributiveCartesianCategoriesTest.gd" );
ReadPackage( "CartesianCategories", "gap/CodistributiveCocartesianCategoriesTest.gd" );

ReadPackage( "CartesianCategories", "gap/BraidedCartesianCategoriesTest.gd" );
ReadPackage( "CartesianCategories", "gap/BraidedCocartesianCategoriesTest.gd" );

ReadPackage( "CartesianCategories", "gap/CartesianClosedCategoriesTest.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategoriesTest.gd" );
