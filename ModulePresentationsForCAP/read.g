# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Reading the implementation part of the package.
#

ReadPackage( "ModulePresentationsForCAP", "gap/precompiled_categories/LeftPresentationsAsFreydCategoryOfCategoryOfRowsOfFieldPrecompiled.gi" );
ReadPackage( "ModulePresentationsForCAP", "gap/precompiled_categories/LeftPresentationsAsFreydCategoryOfCategoryOfRowsOfCommutativeRingPrecompiled.gi" );
ReadPackage( "ModulePresentationsForCAP", "gap/precompiled_categories/LeftPresentationsAsFreydCategoryOfCategoryOfRowsOfArbitraryRingPrecompiled.gi" );

ReadPackage( "ModulePresentationsForCAP", "gap/precompiled_categories/RightPresentationsAsFreydCategoryOfCategoryOfColumnsOfFieldPrecompiled.gi" );
ReadPackage( "ModulePresentationsForCAP", "gap/precompiled_categories/RightPresentationsAsFreydCategoryOfCategoryOfColumnsOfCommutativeRingPrecompiled.gi" );
ReadPackage( "ModulePresentationsForCAP", "gap/precompiled_categories/RightPresentationsAsFreydCategoryOfCategoryOfColumnsOfArbitraryRingPrecompiled.gi" );

ReadPackage( "ModulePresentationsForCAP", "gap/ModulePresentationsForCAP.gi" );

ReadPackage( "ModulePresentationsForCAP", "gap/ModulePresentationObject.gi" );

ReadPackage( "ModulePresentationsForCAP", "gap/ModulePresentationMorphism.gi" );

ReadPackage( "ModulePresentationsForCAP", "gap/ModulePresentationFunctors.gi" );

ReadPackage( "ModulePresentationsForCAP", "gap/ModulePresentationNaturalTransformations.gi" );

ReadPackage( "ModulePresentationsForCAP", "gap/Tools.gi" );

if IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2021.12-04" ) then
    
    ReadPackage( "ModulePresentationsForCAP", "gap/ModulePresentationsAsFreydCategoryOfCategoryOfRowsOrColumns.gi" );
    
fi;
