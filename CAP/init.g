# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Reading the declaration part of the package.
#
## the CAP core
ReadPackage( "CAP", "gap/ToolsForCategories.gd" );

ReadPackage( "CAP", "gap/CAP.gd" );

ReadPackage( "CAP", "gap/Derivations.gd" );

ReadPackage( "CAP", "gap/Finalize.gd" );

ReadPackage( "CAP", "gap/MethodRecordTools.gd" );

ReadPackage( "CAP", "gap/CategoryObjects.gd" );

ReadPackage( "CAP", "gap/CategoryMorphisms.gd" );

ReadPackage( "CAP", "gap/CategoryTwoCells.gd" );

ReadPackage( "CAP", "gap/LimitConvenience.gd" );

ReadPackage( "CAP", "gap/InstallAdds.gd" );

#= comment for Julia
ReadPackage( "CAP", "gap/TheoremParser.gd" );
# =#

ReadPackage( "CAP", "gap/LogicForCAP.gd" );

ReadPackage( "CAP", "gap/ConstructiveCategoriesRecord.gd" );

ReadPackage( "CAP", "gap/PrintingFunctions.gd" );

ReadPackage( "CAP", "gap/PrepareFunctionsTools.gd" );

# load tools required for the CAP library
ReadPackage( "CAP", "gap/ToolsForCategories.gi" );

## the CAP library

## pre-defined CAP operations
ReadPackage( "CAP", "gap/CategoryObjectsOperations.gd" );

ReadPackage( "CAP", "gap/CategoryMorphismsOperations.gd" );

ReadPackage( "CAP", "gap/CategoryTwoCellsOperations.gd" );

ReadPackage( "CAP", "gap/UniversalObjects.gd" );

ReadPackage( "CAP", "gap/MethodRecordDeclarations.autogen.gd" );

## pre-defined category constructors
ReadPackage( "CAP", "gap/OppositeCategory.gd" );

ReadPackage( "CAP", "gap/ProductCategory.gd" );

ReadPackage( "CAP", "gap/CategoriesCategory.gd" );

ReadPackage( "CAP", "gap/CategoryConstructor.gd" );

ReadPackage( "CAP", "gap/TerminalCategory.gd" );

ReadPackage( "CAP", "gap/FiniteSkeletalDiscreteCategory.gd" );

ReadPackage( "CAP", "gap/ReinterpretationOfCategory.gd" );

ReadPackage( "CAP", "gap/WrapperCategory.gd" );

ReadPackage( "CAP", "gap/DummyImplementations.gd" );
