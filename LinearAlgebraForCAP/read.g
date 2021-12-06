# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Reading the implementation part of the package.
#
ReadPackage( "LinearAlgebraForCAP", "gap/precompiled_categories/MatrixCategoryPrecompiled.gi" );

ReadPackage( "LinearAlgebraForCAP", "gap/LinearAlgebraForCAP.gi" );

ReadPackage( "LinearAlgebraForCAP", "gap/MatrixCategoryObject.gi" );

ReadPackage( "LinearAlgebraForCAP", "gap/MatrixCategoryMorphism.gi" );

if IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2021.12-01" ) then
    
    ReadPackage( "LinearAlgebraForCAP", "gap/MatrixCategoryAsAdditiveClosureOfRingAsCategory.gi" );
    
fi;

ReadPackage( "LinearAlgebraForCAP", "gap/DerivedMethodsForMatrixCategories.gi" );
