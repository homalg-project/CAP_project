# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Reading the declaration part of the package.
#

if IsBound( WriteFileForMonoidalStructure ) then
ReadPackage( "Toposes", "gap/Tools.gd");
fi;

## Cartesian
ReadPackage( "Toposes", "gap/CartesianCategoriesProperties.gd" );
ReadPackage( "Toposes", "gap/CartesianCategories.gd" );
ReadPackage( "Toposes", "gap/CartesianCategories.autogen.gd" );

ReadPackage( "Toposes", "gap/DistributiveCartesianCategories.gd" );
ReadPackage( "Toposes", "gap/DistributiveCartesianCategories.autogen.gd" );

ReadPackage( "Toposes", "gap/BraidedCartesianCategories.gd" );
ReadPackage( "Toposes", "gap/BraidedCartesianCategories.autogen.gd" );

## Cartesian Closed
ReadPackage( "Toposes", "gap/CartesianClosedCategoriesProperties.gd" );
ReadPackage( "Toposes", "gap/CartesianClosedCategories.gd" );
ReadPackage( "Toposes", "gap/CartesianClosedCategories.autogen.gd" );

## Cocartesian
ReadPackage( "Toposes", "gap/CocartesianCategoriesProperties.gd" );
ReadPackage( "Toposes", "gap/CocartesianCategories.gd" );
ReadPackage( "Toposes", "gap/CocartesianCategories.autogen.gd" );

ReadPackage( "Toposes", "gap/DistributiveCocartesianCategories.gd" );
ReadPackage( "Toposes", "gap/DistributiveCocartesianCategories.autogen.gd" );

ReadPackage( "Toposes", "gap/BraidedCocartesianCategories.gd" );
ReadPackage( "Toposes", "gap/BraidedCocartesianCategories.autogen.gd" );

## Cocartesian Coclosed
ReadPackage( "Toposes", "gap/CocartesianCoclosedCategoriesProperties.gd" );
ReadPackage( "Toposes", "gap/CocartesianCoclosedCategories.gd" );
ReadPackage( "Toposes", "gap/CocartesianCoclosedCategories.autogen.gd" );

## Topos
ReadPackage( "Toposes", "gap/Topos.gd");
ReadPackage( "Toposes", "gap/Topos.autogen.gd");
