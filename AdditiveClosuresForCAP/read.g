# SPDX-License-Identifier: GPL-2.0-or-later
# AdditiveClosuresForCAP: Additive closures for pre-abelian categories
#
# Reading the implementation part of the package.
#

ReadPackage( "AdditiveClosuresForCAP", "gap/AdditiveClosureMethodRecord.gi" );
ReadPackage( "AdditiveClosuresForCAP", "gap/MethodRecordInstallations.autogen.gi" );

ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfRows.gi" );
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfRows_as_AdditiveClosure_RingAsCategory.gi" );

ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfColumns.gi" );
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfColumns_as_Opposite_CategoryOfRows.gi" );

# include the packages for graded rows and columns
#= comment for Julia
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfGradedRowsAndColumns/GradedRowOrColumn.gi" );
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfGradedRowsAndColumns/GradedRowOrColumnMorphism.gi" );
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfGradedRowsAndColumns/CategoryOfGradedRows.gi" );
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfGradedRowsAndColumns/CategoryOfGradedColumns.gi" );
ReadPackage( "AdditiveClosuresForCAP", "gap/CategoryOfGradedRowsAndColumns/Tools.gi" );
# =#

ReadPackage( "AdditiveClosuresForCAP", "gap/AdditiveClosure.gi" );
ReadPackage( "AdditiveClosuresForCAP", "gap/AdditiveClosureDerivedMethods.gi" );

ReadPackage( "AdditiveClosuresForCAP", "gap/RingsAsAbCats.gi" );
