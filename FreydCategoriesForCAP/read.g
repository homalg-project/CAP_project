# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Reading the implementation part of the package.
#
ReadPackage( "FreydCategoriesForCAP", "gap/FreydCategoriesForCAP.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfRows.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfRowsAsAdditiveClosureOfRingAsCategory.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfColumns.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfColumnsAsOppositeOfCategoryOfRows.gi" );

# include the packages for graded rows and columns
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/GradedRowOrColumn.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/GradedRowOrColumnMorphism.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/CategoryOfGradedRows.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/CategoryOfGradedColumns.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/Tools.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/FreydCategoriesDerivedMethods.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/FreydCategory.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/HomStructureForAlgebroids.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/AdditiveClosure.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/CokernelImageClosure.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/AdelmanCategory.gi" );

if IsPackageMarkedForLoading( "QPA", ">= 2.0" ) then
    ReadPackage( "FreydCategoriesForCAP", "gap/QuiverRows.gi" );
fi;

ReadPackage( "FreydCategoriesForCAP", "gap/GradedModulePresentationsByFreyd/GradedModulePresentationsByFreyd.gi" );

if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2019.09.20" ) then
    ReadPackage( "FreydCategoriesForCAP", "gap/GroupsAsCats.gi" );
    
    ReadPackage( "FreydCategoriesForCAP", "gap/LinearClosure.gi" );
    
    ReadPackage( "FreydCategoriesForCAP", "gap/ProSetsAsCats.gi" );
    
fi;

ReadPackage( "FreydCategoriesForCAP", "gap/RingsAsAbCats.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/GradeFiltration.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/SerreSubcategoryFunctions.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/Relations.gi" );
