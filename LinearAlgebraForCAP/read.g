# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Reading the implementation part of the package.
#
ReadPackage( "LinearAlgebraForCAP", "gap/precompiled_categories/MatrixCategoryPrecompiled.gi" );

ReadPackage( "LinearAlgebraForCAP", "gap/LinearAlgebraForCAP.gi" );

ReadPackage( "LinearAlgebraForCAP", "gap/MatrixCategoryObject.gi" );

ReadPackage( "LinearAlgebraForCAP", "gap/MatrixCategoryMorphism.gi" );

if IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2022.10-14" ) then
    
    ReadPackage( "LinearAlgebraForCAP", "gap/MatrixCategoryAsCategoryOfRows.gi" );
    
fi;
