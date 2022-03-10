# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "GeneralizedMorphismsForCAP", false );
true
gap> LoadPackage( "LinearAlgebraForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "GeneralizedMorphismsForCAP" );
true
gap> LoadPackage( "LinearAlgebraForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
