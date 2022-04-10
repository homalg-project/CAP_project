# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Reading the declaration part of the package.
#

if IsBound( WriteFileForMonoidalStructure ) then
ReadPackage( "Toposes", "gap/Tools.gd");
fi;

## Cartesian and Cocartesian
ReadPackage( "Toposes", "gap/CartesianCategories.gd" );
ReadPackage( "Toposes", "gap/CocartesianCategories.gd" );

ReadPackage( "Toposes", "gap/CartesianCategoriesProperties.gd" );
ReadPackage( "Toposes", "gap/CocartesianCategoriesProperties.gd" );

ReadPackage( "Toposes", "gap/CartesianCategories.autogen.gd" );
ReadPackage( "Toposes", "gap/CocartesianCategories.autogen.gd" );

ReadPackage( "Toposes", "gap/DistributiveCartesianCategories.gd" );
ReadPackage( "Toposes", "gap/CodistributiveCocartesianCategories.gd" );

ReadPackage( "Toposes", "gap/DistributiveCartesianCategories.autogen.gd" );
ReadPackage( "Toposes", "gap/CodistributiveCocartesianCategories.autogen.gd" );

ReadPackage( "Toposes", "gap/BraidedCartesianCategories.gd" );
ReadPackage( "Toposes", "gap/BraidedCocartesianCategories.gd" );

ReadPackage( "Toposes", "gap/BraidedCartesianCategories.autogen.gd" );
ReadPackage( "Toposes", "gap/BraidedCocartesianCategories.autogen.gd" );

## Cartesian Closed and Cocartesian Coclosed
ReadPackage( "Toposes", "gap/CartesianClosedCategoriesProperties.gd" );
ReadPackage( "Toposes", "gap/CocartesianCoclosedCategoriesProperties.gd" );

ReadPackage( "Toposes", "gap/CartesianClosedCategories.gd" );
ReadPackage( "Toposes", "gap/CocartesianCoclosedCategories.gd" );

ReadPackage( "Toposes", "gap/CartesianClosedCategories.autogen.gd" );
ReadPackage( "Toposes", "gap/CocartesianCoclosedCategories.autogen.gd" );

## Test methods
ReadPackage( "Toposes", "gap/CartesianCategoriesTest.gd" );
ReadPackage( "Toposes", "gap/CocartesianCategoriesTest.gd" );

ReadPackage( "Toposes", "gap/BraidedCartesianCategoriesTest.gd" );
ReadPackage( "Toposes", "gap/BraidedCocartesianCategoriesTest.gd" );

ReadPackage( "Toposes", "gap/CartesianClosedCategoriesTest.gd" );
ReadPackage( "Toposes", "gap/CocartesianCoclosedCategoriesTest.gd" );

## Topos
ReadPackage( "Toposes", "gap/Topos.gd");
ReadPackage( "Toposes", "gap/Topos.autogen.gd");

## Category of relations
ReadPackage( "Toposes", "gap/CategoryOfRelations.gd");
