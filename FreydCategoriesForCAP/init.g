# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Reading the declaration part of the package.
#

ReadPackage( "FreydCategoriesForCAP", "gap/FreydCategoriesForCAP.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/AddFunctions.autogen.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfRows.gd" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfRows_as_AdditiveClosure_RingAsCategory.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfColumns.gd" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfColumns_as_Opposite_CategoryOfRows.gd" );

# include the packages for graded rows and columns
#= comment for Julia
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/GradedRowOrColumn.gd" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/GradedRowOrColumnMorphism.gd" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/CategoryOfGradedRows.gd" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/CategoryOfGradedColumns.gd" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/Tools.gd" );
# =#

ReadPackage( "FreydCategoriesForCAP", "gap/FreydCategory.gd" );
ReadPackage( "FreydCategoriesForCAP", "gap/CoFreydCategory.gd" );
ReadPackage( "FreydCategoriesForCAP", "gap/CoFreydCategory_as_Opposite_FreydCategory_Opposite.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/AdditiveClosure.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/CokernelImageClosure.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/AdelmanCategory.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/GradedModulePresentationsByFreyd/GradedModulePresentationsByFreyd.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/LinearClosure.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/ProSetsAsCats.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/GroupsAsCats.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/RingsAsAbCats.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/GradeFiltration.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/SerreSubcategoryFunctions.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/Relations.gd" );
