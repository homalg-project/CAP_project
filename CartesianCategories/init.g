# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Reading the declaration part of the package.
#

#= comment for Julia
if IsBound( WriteFileForMonoidalStructure ) then
ReadPackage( "CartesianCategories", "gap/Tools.gd" );
fi;
# =#

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

ReadPackage( "CartesianCategories", "gap/CartesianCategories.autogen.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategories.autogen.gd" );

ReadPackage( "CartesianCategories", "gap/DistributiveCartesianCategories.gd" );
ReadPackage( "CartesianCategories", "gap/CodistributiveCocartesianCategories.gd" );

ReadPackage( "CartesianCategories", "gap/DistributiveCartesianCategoriesProperties.gd" );
ReadPackage( "CartesianCategories", "gap/CodistributiveCocartesianCategoriesProperties.gd" );

ReadPackage( "CartesianCategories", "gap/DistributiveCartesianCategories.autogen.gd" );
ReadPackage( "CartesianCategories", "gap/CodistributiveCocartesianCategories.autogen.gd" );

ReadPackage( "CartesianCategories", "gap/BraidedCartesianCategories.gd" );
ReadPackage( "CartesianCategories", "gap/BraidedCocartesianCategories.gd" );

ReadPackage( "CartesianCategories", "gap/BraidedCartesianCategories.autogen.gd" );
ReadPackage( "CartesianCategories", "gap/BraidedCocartesianCategories.autogen.gd" );

## Cartesian Closed and Cocartesian Coclosed

ReadPackage( "CartesianCategories", "gap/CartesianClosedCategoriesProperties.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategoriesProperties.gd" );

ReadPackage( "CartesianCategories", "gap/CartesianClosedCategories.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategories.gd" );

ReadPackage( "CartesianCategories", "gap/CartesianClosedCategories.autogen.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategories.autogen.gd" );

## Bicartesian and finite (co)complete categories

ReadPackage( "CartesianCategories", "gap/BicartesianCategories.gd" );

## Test methods

ReadPackage( "CartesianCategories", "gap/CartesianCategoriesTest.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCategoriesTest.gd" );

ReadPackage( "CartesianCategories", "gap/DistributiveCartesianCategoriesTest.gd" );
ReadPackage( "CartesianCategories", "gap/CodistributiveCocartesianCategoriesTest.gd" );

ReadPackage( "CartesianCategories", "gap/BraidedCartesianCategoriesTest.gd" );
ReadPackage( "CartesianCategories", "gap/BraidedCocartesianCategoriesTest.gd" );

ReadPackage( "CartesianCategories", "gap/CartesianClosedCategoriesTest.gd" );
ReadPackage( "CartesianCategories", "gap/CocartesianCoclosedCategoriesTest.gd" );
