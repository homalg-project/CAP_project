# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# HACK:
# FreydCategoriesForCAP depends on LinearAlgebraForCAP which in turn suggests FreydCategoriesForCAP.
# The packages are only loaded in the proper order if GAP takes the suggestion into account.
# 100_LoadPackages.tst disables loading suggested dependencies, so we must load
# FreydCategoriesForCAP manually here.
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "FreydCategoriesForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "FreydCategoriesForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
