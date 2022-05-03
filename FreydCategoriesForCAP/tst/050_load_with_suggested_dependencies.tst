# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# We want to execute the tests with QPA and FinSetsForCAP if available as long as this does
# not cause any problems. Thus, we load FreydCategoriesForCAP including suggested dependencies here.
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "FreydCategoriesForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "FreydCategoriesForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
gap> HOMALG_IO.show_banners := false;;
