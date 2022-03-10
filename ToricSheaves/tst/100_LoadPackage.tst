# SPDX-License-Identifier: GPL-2.0-or-later
# ToricSheaves: Toric sheaves as Serre quotients
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "ToricSheaves", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "ToricSheaves" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
