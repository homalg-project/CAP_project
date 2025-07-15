# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Reading the implementation part of the package.
#
## the CAP core

# ToolsForCategories.gi is already loaded in init.g
#ReadPackage( "CAP", "gap/ToolsForCategories.gi" );

ReadPackage( "CAP", "gap/CAP.gi" );

ReadPackage( "CAP", "gap/Derivations.gi" );

ReadPackage( "CAP", "gap/Finalize.gi" );

ReadPackage( "CAP", "gap/MethodRecordTools.gi" );

ReadPackage( "CAP", "gap/CategoryObjects.gi" );

ReadPackage( "CAP", "gap/CategoryMorphisms.gi" );

ReadPackage( "CAP", "gap/CategoryTwoCells.gi" );

ReadPackage( "CAP", "gap/LimitConvenience.gi" );

ReadPackage( "CAP", "gap/InstallAdds.gi" );

#= comment for Julia
ReadPackage( "CAP", "gap/TheoremParser.gi" );
# =#

ReadPackage( "CAP", "gap/LogicForCAP.gi" );

ReadPackage( "CAP", "gap/ConstructiveCategoriesRecord.gi" );

ReadPackage( "CAP", "gap/PrintingFunctions.gi" );

ReadPackage( "CAP", "gap/PrepareFunctionsTools.gi" );

## the CAP library

## pre-defined CAP operations
ReadPackage( "CAP", "gap/CategoryObjectsOperations.gi" );

ReadPackage( "CAP", "gap/CategoryMorphismsOperations.gi" );

ReadPackage( "CAP", "gap/CategoryTwoCellsOperations.gi" );

ReadPackage( "CAP", "gap/UniversalObjects.gi" );

ReadPackage( "CAP", "gap/MethodRecord.gi" );

ReadPackage( "CAP", "gap/MethodRecordInstallations.autogen.gi" );

ReadPackage( "CAP", "gap/PrepareFunctions.gi" );

ReadPackage( "CAP", "gap/DerivedMethods.gi" );

ReadPackage( "CAP", "gap/LimitConvenienceOutput.gi" );

ReadPackage( "CAP", "gap/DerivedMethods.autogen.gi" );

## pre-defined category constructors
ReadPackage( "CAP", "gap/OppositeCategory.gi" );

ReadPackage( "CAP", "gap/ProductCategory.gi" );

ReadPackage( "CAP", "gap/CategoriesCategory.gi" );

ReadPackage( "CAP", "gap/CategoryConstructor.gi" );

ReadPackage( "CAP", "gap/TerminalCategory.gi" );

ReadPackage( "CAP", "gap/FiniteSkeletalDiscreteCategory.gi" );

ReadPackage( "CAP", "gap/ReinterpretationOfCategory.gi" );

ReadPackage( "CAP", "gap/WrapperCategory.gi" );

ReadPackage( "CAP", "gap/DummyImplementations.gi" );

## init
ReadPackage( "CAP", "gap/init.gi" );
