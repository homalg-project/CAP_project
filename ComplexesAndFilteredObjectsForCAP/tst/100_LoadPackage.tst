# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesAndFilteredObjectsForCAP: Implementation of complexes, cocomplexes and filtered objects for CAP
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "ComplexesAndFilteredObjectsForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "ComplexesAndFilteredObjectsForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
