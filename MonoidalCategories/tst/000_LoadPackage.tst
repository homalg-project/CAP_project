#
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "MonoidalCategories", false );
true
gap> LoadPackage( "MatricesForHomalg", false );
true
gap> LoadPackage( "GaussForHomalg", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "MonoidalCategories" );
true
gap> LoadPackage( "MatricesForHomalg" );
true
gap> LoadPackage( "GaussForHomalg" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
