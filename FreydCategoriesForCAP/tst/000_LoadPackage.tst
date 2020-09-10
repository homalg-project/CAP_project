#
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "FreydCategoriesForCAP", false );
#I  method installed for / matches more than one declaration
#I  method installed for IsInjective matches more than one declaration
true
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> LoadPackage( "RingsForHomalg", false );
true
gap> LoadPackage( "GaussForHomalg", false );
true
gap> LoadPackage( "GeneralizedMorphismsForCAP", false );
true
gap> LoadPackage( "Algebroids", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "FreydCategoriesForCAP" );
true
gap> LoadPackage( "IO_ForHomalg" );
true
gap> LoadPackage( "RingsForHomalg" );
true
gap> LoadPackage( "GaussForHomalg" );
true
gap> LoadPackage( "GeneralizedMorphismsForCAP" );
true
gap> LoadPackage( "Algebroids" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
gap> HOMALG_IO.show_banners := false;;
