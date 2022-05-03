# SPDX-License-Identifier: GPL-2.0-or-later
# AttributeCategoryForCAP: Automatic enhancement with attributes of a CAP category
#
# This file tests if the package can be loaded without errors or warnings.
#
# do not load suggested dependencies automatically
gap> PushOptions( rec( OnlyNeeded := true ) );
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "AttributeCategoryForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "AttributeCategoryForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
