# SPDX-License-Identifier: GPL-2.0-or-later
# WrapperCategories: Construct an equivalent wrapper category out of a CAP category
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "WrapperCategories", false );
true
gap> LoadPackage( "LinearAlgebraForCAP", false );
true
gap> LoadPackage( "GeneralizedMorphismsForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "WrapperCategories" );
true
gap> LoadPackage( "LinearAlgebraForCAP" );
true
gap> LoadPackage( "GeneralizedMorphismsForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
