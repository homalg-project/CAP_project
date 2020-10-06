# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "CAP", false );
true
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> LoadPackage( "GaussForHomalg", false );
true
gap> LoadPackage( "ModulePresentationsForCAP", false );
true
gap> LoadPackage( "LinearAlgebraForCAP", false );
true
gap> LoadPackage( "RingsForHomalg", false );
true
gap> LoadPackage( "HomologicalAlgebraForCAP", false );
true
gap> LoadPackage( "DeductiveSystemForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "CAP" );
true
gap> LoadPackage( "IO_ForHomalg" );
true
gap> LoadPackage( "GaussForHomalg" );
true
gap> LoadPackage( "ModulePresentationsForCAP" );
true
gap> LoadPackage( "LinearAlgebraForCAP" );
true
gap> LoadPackage( "RingsForHomalg" );
true
gap> LoadPackage( "HomologicalAlgebraForCAP" );
true
gap> LoadPackage( "DeductiveSystemForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
gap> HOMALG_IO.show_banners := false;;
