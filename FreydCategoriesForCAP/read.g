#
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Reading the implementation part of the package.
#
ReadPackage( "FreydCategoriesForCAP", "gap/FreydCategoriesForCAP.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfRows.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/CategoryOfColumns.gi" );

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

ReadPackage( "FreydCategoriesForCAP", "gap/QuiverRows.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/GradedModulePresentationsByFreyd/GradedModulePresentationsByFreyd.gi" );
