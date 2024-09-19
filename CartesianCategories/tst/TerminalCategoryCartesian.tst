###############################################################
# Test the cocartesian coclosed structure of
# the terminal category with multiple objects
###############################################################

gap> START_TEST( "TerminalCategoryCartesian" );

#
gap> LoadPackage( "CartesianCategories", false );
true

#
gap> T := TerminalCategoryWithMultipleObjects( );;
gap> opposite := Opposite( T, "Opposite with all operations" );;
gap> opposite_primitive := Opposite( T, "Opposite with primitive operations" : only_primitive_operations := true );;

#
gap> DeactivateCachingOfCategory( T );
gap> DeactivateCachingOfCategory( opposite );
gap> DeactivateCachingOfCategory( opposite_primitive );

#
##############################################
# CartesianCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> b := "b" / T;;
gap> c := "c" / T;;
gap> d := "d" / T;;

#
gap> alpha := MorphismConstructor( a, "f_ab", b );;
gap> beta := MorphismConstructor( c, "f_cd", d );;

#
gap> CartesianCategoriesTest( T, opposite, a, b, c, alpha, beta );;
gap> CartesianCategoriesTest( T, opposite_primitive, a, b, c, alpha, beta );;

#
gap> z := ZeroObject( T );;

#
gap> alpha := UniversalMorphismFromZeroObject( a );;
gap> beta := UniversalMorphismIntoZeroObject( a );;

#
gap> CartesianCategoriesTest( T, opposite, z, a, a, alpha, beta );;
gap> CartesianCategoriesTest( T, opposite_primitive, z, a, a, alpha, beta );;

#
gap> CartesianCategoriesTest( T, opposite, a, z, z, beta, alpha );;
gap> CartesianCategoriesTest( T, opposite_primitive, a, z, z, beta, alpha );;

#
##############################################
# DistributiveCartesianCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> L := [ "b" / T, "c" / T, "d" / T ];;

#
gap> DistributiveCartesianCategoriesTest( T, opposite, a, L );;
gap> DistributiveCartesianCategoriesTest( T, opposite_primitive, a, L );;

#
##############################################
# BraidedCartesianCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> b := "b" / T;;

#
gap> BraidedCartesianCategoriesTest( T, opposite, a, b );;
gap> BraidedCartesianCategoriesTest( T, opposite_primitive, a, b );;

#
gap> BraidedCartesianCategoriesTest( T, opposite, b, a );;
gap> BraidedCartesianCategoriesTest( T, opposite_primitive, b, a );;

#
gap> z := ZeroObject( T );;

#
gap> BraidedCartesianCategoriesTest( T, opposite, z, a );;
gap> BraidedCartesianCategoriesTest( T, opposite_primitive, z, a );;

#
gap> BraidedCartesianCategoriesTest( T, opposite, a, z );;
gap> BraidedCartesianCategoriesTest( T, opposite_primitive, a, z );;

#
##############################################
# CartesianClosedCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> b := "b" / T;;
gap> c := "c" / T;;
gap> d := "d" / T;;

#
gap> u := TerminalObject( T );;

#
gap> a_product_b := DirectProduct( a, b );;
gap> c_product_d := DirectProduct( c, d );;

#
gap> hom_ab := ExponentialOnObjects( a, b );;
gap> hom_cd := ExponentialOnObjects( c, d );;

#
gap> alpha := MorphismConstructor( a, "f_ab", b );;
gap> beta := MorphismConstructor( c, "f_cd", d );;
gap> gamma := MorphismConstructor( a_product_b, "f_abu", u );;
gap> delta := MorphismConstructor( c_product_d, "f_cdu", u );;
gap> epsilon := MorphismConstructor( u, "f_uhomab", hom_ab );;
gap> zeta := MorphismConstructor( u, "f_uhomcd", hom_cd );;

#
gap> CartesianClosedCategoriesTest( T, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> CartesianClosedCategoriesTest( T, opposite_primitive, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;

#
gap> z := ZeroObject( T );;

#
gap> z_product_a := DirectProduct( z, a );;
gap> a_product_z := DirectProduct( a, z );;

#
gap> hom_za := ExponentialOnObjects( z, a );;
gap> hom_az := ExponentialOnObjects( a, z );;

#
gap> alpha := MorphismConstructor( z, "f_za", a );;
gap> beta := MorphismConstructor( a, "f_az", z );;
gap> gamma := MorphismConstructor( z_product_a, "f_zau", u );;
gap> delta := MorphismConstructor( a_product_z, "f_azu", u );;
gap> epsilon := MorphismConstructor( u, "f_uhomza", hom_za );;
gap> zeta := MorphismConstructor( u, "f_uhomaz", hom_az );;

#
gap> CartesianClosedCategoriesTest( T, opposite, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );;
gap> CartesianClosedCategoriesTest( T, opposite_primitive, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );;

#
##############################################
#
gap> STOP_TEST( "TerminalCategoryCartesian" );
