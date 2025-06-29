# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Reading the implementation part of the package.
#

ReadPackage( "FreydCategoriesForCAP", "gap/FreydCategoriesMethodRecord.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/MethodRecordInstallations.autogen.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/FreydCategoriesDerivedMethods.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/FreydCategory.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/CoFreydCategory.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/CoFreydCategory_as_Opposite_FreydCategory_Opposite.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/CokernelImageClosure.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/AdelmanCategory.gi" );

#= comment for Julia
ReadPackage( "FreydCategoriesForCAP", "gap/GradedModulePresentationsByFreyd/GradedModulePresentationsByFreyd.gi" );
# =#

ReadPackage( "FreydCategoriesForCAP", "gap/GradeFiltration.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/SerreSubcategoryFunctions.gi" );

ReadPackage( "FreydCategoriesForCAP", "gap/Relations.gi" );
