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
gap> CartesianCategoriesTest( T, a, b, c, alpha, beta );;
gap> CartesianCategoriesTest( T, a, b, c, alpha, beta : only_primitive_operations := true );;

#
gap> z := ZeroObject( T );;

#
gap> alpha := UniversalMorphismFromZeroObject( a );;
gap> beta := UniversalMorphismIntoZeroObject( a );;

#
gap> CartesianCategoriesTest( T, z, a, a, alpha, beta );;
gap> CartesianCategoriesTest( T, z, a, a, alpha, beta : only_primitive_operations := true );;

#
gap> CartesianCategoriesTest( T, a, z, z, beta, alpha );;
gap> CartesianCategoriesTest( T, a, z, z, beta, alpha : only_primitive_operations := true );;

#
##############################################
# DistributiveCartesianCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> L := [ "b" / T, "c" / T, "d" / T ];;

#
gap> DistributiveCartesianCategoriesTest( T, a, L );;
gap> DistributiveCartesianCategoriesTest( T, a, L : only_primitive_operations := true );;

#
##############################################
# BraidedCartesianCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> b := "b" / T;;

#
gap> BraidedCartesianCategoriesTest( T, a, b );;
gap> BraidedCartesianCategoriesTest( T, a, b : only_primitive_operations := true );;

#
gap> BraidedCartesianCategoriesTest( T, b, a );;
gap> BraidedCartesianCategoriesTest( T, b, a : only_primitive_operations := true );;

#
gap> z := ZeroObject( T );;

#
gap> BraidedCartesianCategoriesTest( T, z, a );;
gap> BraidedCartesianCategoriesTest( T, z, a : only_primitive_operations := true );;

#
gap> BraidedCartesianCategoriesTest( T, a, z );;
gap> BraidedCartesianCategoriesTest( T, a, z : only_primitive_operations := true );;

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
gap> CartesianClosedCategoriesTest( T, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> CartesianClosedCategoriesTest( T, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta : only_primitive_operations := true );;

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
gap> CartesianClosedCategoriesTest( T, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );;
gap> CartesianClosedCategoriesTest( T, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta : only_primitive_operations := true );;

#
##############################################
#
gap> STOP_TEST( "TerminalCategoryCartesian" );
