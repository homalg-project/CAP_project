# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# We want to execute the tests with FreydCategoriesForCAP if available as long as this does
# not cause any problems. Thus, we load LinearAlgebraForCAP including suggested dependencies here.
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "LinearAlgebraForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "LinearAlgebraForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
