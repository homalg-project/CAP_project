#
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Reading the declaration part of the package.
#

ReadPackage( "FreydCategoriesForCAP", "gap/FreydCategoriesForCAP.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfRows.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfColumns.gd" );

# include the packages for graded rows and columns
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/GradedRowOrColumn.gd" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/GradedRowOrColumnMorphism.gd" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/CategoryOfGradedRows.gd" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/CategoryOfGradedColumns.gd" );
ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfGradedRowsAndColumns/Tools.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/FreydCategory.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/HomStructureForAlgebroids.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/AdditiveClosure.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/CokernelImageClosure.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/AdelmanCategory.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/QuiverRows.gd" );

ReadPackage( "FreydCategoriesForCAP", "gap/GradedModulePresentationsByFreyd/GradedModulePresentationsByFreyd.gd" );
