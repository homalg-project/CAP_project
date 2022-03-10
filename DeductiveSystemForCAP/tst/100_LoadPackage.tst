# SPDX-License-Identifier: GPL-2.0-or-later
# DeductiveSystemForCAP: Deductive system for CAP
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "DeductiveSystemForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "DeductiveSystemForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
