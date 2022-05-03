# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# This file tests if the package can be loaded without errors or warnings.
#
# do not load suggested dependencies automatically
gap> PushOptions( rec( OnlyNeeded := true ) );
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "LinearAlgebraForCAP", false );
true
gap> LoadPackage( "GeneralizedMorphismsForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "LinearAlgebraForCAP" );
true
gap> LoadPackage( "GeneralizedMorphismsForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
