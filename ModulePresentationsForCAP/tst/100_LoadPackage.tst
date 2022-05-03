# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# This file tests if the package can be loaded without errors or warnings.
#
# do not load suggested dependencies automatically
gap> PushOptions( rec( OnlyNeeded := true ) );
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> LoadPackage( "RingsForHomalg", false );
true
gap> LoadPackage( "GaussForHomalg", false );
true
gap> LoadPackage( "ModulePresentationsForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "IO_ForHomalg" );
true
gap> LoadPackage( "RingsForHomalg" );
true
gap> LoadPackage( "GaussForHomalg" );
true
gap> LoadPackage( "ModulePresentationsForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
gap> HOMALG_IO.show_banners := false;;
