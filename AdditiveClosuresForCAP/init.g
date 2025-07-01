# SPDX-License-Identifier: GPL-2.0-or-later
# AdditiveClosuresForCAP: Additive closures for pre-abelian categories
#
# Reading the declaration part of the package.
#

ReadPackage( "AdditiveClosuresForCAP", "gap/MethodRecordDeclarations.autogen.gd" );
ReadPackage( "AdditiveClosuresForCAP", "gap/AdditiveClosureMethodRecord.gd" );

ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfRows.gd" );
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfRows_as_AdditiveClosure_RingAsCategory.gd" );

ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfColumns.gd" );
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfColumns_as_Opposite_CategoryOfRows.gd" );

# include the packages for graded rows and columns
#= comment for Julia
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfGradedRowsAndColumns/GradedRowOrColumn.gd" );
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfGradedRowsAndColumns/GradedRowOrColumnMorphism.gd" );
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfGradedRowsAndColumns/CategoryOfGradedRows.gd" );
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfGradedRowsAndColumns/CategoryOfGradedColumns.gd" );
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfGradedRowsAndColumns/Tools.gd" );
# =#

ReadPackage( "AdditiveClosuresForCAP", "gap/AdditiveClosure.gd" );

ReadPackage( "AdditiveClosuresForCAP", "gap/RingsAsAbCats.gd" );
