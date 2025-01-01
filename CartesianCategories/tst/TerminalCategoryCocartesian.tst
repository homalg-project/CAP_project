###############################################################
# Test the cartesian closed structure of
# the terminal category with multiple objects
###############################################################

gap> START_TEST( "TerminalCategoryCocartesian" );

#
gap> LoadPackage( "CartesianCategories", false );
true

#
gap> T := TerminalCategoryWithMultipleObjects( );;
gap> opposite := Opposite( T, "Opposite with all operations" );;
gap> opposite_primitive := Opposite( T, "Opposite with primitive operations" : only_primitive_operations := true );;

#
##############################################
# CocartesianCategoriesTest
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
gap> CocartesianCategoriesTest( T, opposite, a, b, c, alpha, beta );;
gap> CocartesianCategoriesTest( T, opposite_primitive, a, b, c, alpha, beta );;

#
gap> z := ZeroObject( T );;

#
gap> alpha := UniversalMorphismFromZeroObject( a );;
gap> beta := UniversalMorphismIntoZeroObject( a );;

#
gap> CocartesianCategoriesTest( T, opposite, z, a, a, alpha, beta );;
gap> CocartesianCategoriesTest( T, opposite_primitive, z, a, a, alpha, beta );;

#
gap> CocartesianCategoriesTest( T, opposite, a, z, z, beta, alpha );;
gap> CocartesianCategoriesTest( T, opposite_primitive, a, z, z, beta, alpha );;

#
##############################################
# CodistributiveCocartesianCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> L := [ "b" / T, "c" / T, "d" / T ];;

#
gap> CodistributiveCocartesianCategoriesTest( T, opposite, a, L );;
gap> CodistributiveCocartesianCategoriesTest( T, opposite_primitive, a, L );;

#
##############################################
# BraidedCocartesianCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> b := "b" / T;;

#
gap> BraidedCocartesianCategoriesTest( T, opposite, a, b );;
gap> BraidedCocartesianCategoriesTest( T, opposite_primitive, a, b );;

#
gap> BraidedCocartesianCategoriesTest( T, opposite, b, a );;
gap> BraidedCocartesianCategoriesTest( T, opposite_primitive, b, a );;

#
gap> z := ZeroObject( T );;

#
gap> BraidedCocartesianCategoriesTest( T, opposite, z, a );;
gap> BraidedCocartesianCategoriesTest( T, opposite_primitive, z, a );;

#
gap> BraidedCocartesianCategoriesTest( T, opposite, a, z );;
gap> BraidedCocartesianCategoriesTest( T, opposite_primitive, a, z );;

#
##############################################
# CocartesianCoclosedCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> b := "b" / T;;
gap> c := "c" / T;;
gap> d := "d" / T;;

#
gap> u := InitialObject( T );;

#
gap> a_coproduct_b := Coproduct( a, b );;
gap> c_coproduct_d := Coproduct( c, d );;

#
gap> cohom_ab := CoexponentialOnObjects( a, b );;
gap> cohom_cd := CoexponentialOnObjects( c, d );;

#
gap> alpha := MorphismConstructor( a, "f_ab", b );;
gap> beta := MorphismConstructor( c, "f_cd", d );;
gap> gamma := MorphismConstructor( u, "f_abu", a_coproduct_b );;
gap> delta := MorphismConstructor( u, "f_cdu", c_coproduct_d );;
gap> epsilon := MorphismConstructor( cohom_ab, "f_uhomab", u );;
gap> zeta := MorphismConstructor( cohom_cd, "f_uhomcd", u );;

#
gap> CocartesianCoclosedCategoriesTest( T, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> CocartesianCoclosedCategoriesTest( T, opposite_primitive, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;

#
gap> z := ZeroObject( T );;

#
gap> z_coproduct_a := Coproduct( z, a );;
gap> a_coproduct_z := Coproduct( a, z );;

#
gap> cohom_za := CoexponentialOnObjects( z, a );;
gap> cohom_az := CoexponentialOnObjects( a, z );;

#
gap> alpha := MorphismConstructor( z, "f_za", a );;
gap> beta := MorphismConstructor( a, "f_az", z );;
gap> gamma := MorphismConstructor( u, "f_zau", z_coproduct_a );;
gap> delta := MorphismConstructor( u, "f_azu", a_coproduct_z );;
gap> epsilon := MorphismConstructor( cohom_za, "f_uhomza", u );;
gap> zeta := MorphismConstructor( cohom_az, "f_uhomaz", u );;

#
gap> CocartesianCoclosedCategoriesTest( T, opposite, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );;
gap> CocartesianCoclosedCategoriesTest( T, opposite_primitive, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );;

#
##############################################
#
gap> STOP_TEST( "TerminalCategoryCocartesian" );
