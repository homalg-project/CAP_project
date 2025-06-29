# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# tests without precompiled code need AdditiveClosuresForCAP
#@if ValueOption( "no_precompiled_code" ) = true
gap> PushOptions( rec( OnlyNeeded := true ) );
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "AdditiveClosuresForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "AdditiveClosuresForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
#@fi
