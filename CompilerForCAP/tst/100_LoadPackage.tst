# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "CompilerForCAP", false );
true
gap> LoadPackage( "LinearAlgebraForCAP", false );
true
gap> LoadPackage( "RingsForHomalg", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "CompilerForCAP" );
true
gap> LoadPackage( "LinearAlgebraForCAP" );
true
gap> LoadPackage( "RingsForHomalg" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
