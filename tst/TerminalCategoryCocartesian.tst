###############################################################
# Test the cartesian closed structure of
# the terminal category with multiple objects
###############################################################

gap> START_TEST("TerminalCategoryCocartesian.tst");

gap> LoadPackage("CartesianCategories", false);
true
gap> LoadPackage("MonoidalCategories", false);
true

gap> T := TerminalCategoryWithMultipleObjects( );;

##############################################
# CocartesianCategoriesTest
##############################################

gap> a := "a" / T;;
gap> b := "b" / T;;
gap> c := "c" / T;;
gap> d := "d" / T;;

gap> alpha := MorphismConstructor( a, "f_ab", b );;
gap> beta := MorphismConstructor( c, "f_cd", d );;

gap> CocartesianCategoriesTest( T, a, b, c, alpha, beta );;
gap> CocartesianCategoriesTest( T, a, b, c, alpha, beta : only_primitive_operations := true );;

gap> z := ZeroObject( T );;

gap> alpha := UniversalMorphismFromZeroObject( a );;
gap> beta := UniversalMorphismIntoZeroObject( a );;

gap> CocartesianCategoriesTest( T, z, a, a, alpha, beta );;
gap> CocartesianCategoriesTest( T, z, a, a, alpha, beta : only_primitive_operations := true );;

gap> CocartesianCategoriesTest( T, a, z, z, beta, alpha );;
gap> CocartesianCategoriesTest( T, a, z, z, beta, alpha : only_primitive_operations := true );;

##############################################
# CodistributiveCocartesianCategoriesTest
##############################################

gap> a := "a" / T;;
gap> L := [ "b" / T, "c" / T, "d" / T ];;

gap> CodistributiveCocartesianCategoriesTest( T, a, L );;
gap> CodistributiveCocartesianCategoriesTest( T, a, L : only_primitive_operations := true );;

##############################################
# BraidedCocartesianCategoriesTest
##############################################

gap> a := "a" / T;;
gap> b := "b" / T;;

gap> BraidedCocartesianCategoriesTest( T, a, b );;
gap> BraidedCocartesianCategoriesTest( T, a, b : only_primitive_operations := true );;

gap> BraidedCocartesianCategoriesTest( T, b, a );;
gap> BraidedCocartesianCategoriesTest( T, b, a : only_primitive_operations := true );;

gap> z := ZeroObject( T );;

gap> BraidedCocartesianCategoriesTest( T, z, a );;
gap> BraidedCocartesianCategoriesTest( T, z, a : only_primitive_operations := true );;

gap> BraidedCocartesianCategoriesTest( T, a, z );;
gap> BraidedCocartesianCategoriesTest( T, a, z : only_primitive_operations := true );;

##############################################
# CocartesianCoclosedCategoriesTest
##############################################

gap> a := "a" / T;;
gap> b := "b" / T;;
gap> c := "c" / T;;
gap> d := "d" / T;;

gap> u := TensorUnit( T );;

gap> a_product_b := TensorProduct( a, b );;
gap> c_product_d := TensorProduct( c, d );;

gap> hom_ab := InternalHom( a, b );;
gap> hom_cd := InternalHom( c, d );;

gap> alpha := MorphismConstructor( a, "f_ab", b );;
gap> beta := MorphismConstructor( c, "f_cd", d );;
gap> gamma := MorphismConstructor( a_product_b, "f_abu", u );;
gap> delta := MorphismConstructor( c_product_d, "f_cdu", u );;
gap> epsilon := MorphismConstructor( u, "f_uhomab", hom_ab );;
gap> zeta := MorphismConstructor( u, "f_uhomcd", hom_cd );;

gap> CocartesianCoclosedCategoriesTest( T, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> CocartesianCoclosedCategoriesTest( T, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta : only_primitive_operations := true );;

gap> z := ZeroObject( T );;

gap> z_product_a := TensorProduct( z, a );;
gap> a_product_z := TensorProduct( a, z );;

gap> hom_za := InternalHom( z, a );;
gap> hom_az := InternalHom( a, z );;

gap> alpha := MorphismConstructor( z, "f_za", a );;
gap> beta := MorphismConstructor( a, "f_az", z );;
gap> gamma := MorphismConstructor( z_product_a, "f_zau", u );;
gap> delta := MorphismConstructor( a_product_z, "f_azu", u );;
gap> epsilon := MorphismConstructor( u, "f_uhomza", hom_za );;
gap> zeta := MorphismConstructor( u, "f_uhomaz", hom_az );;

gap> CocartesianCoclosedCategoriesTest( T, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );;
gap> CocartesianCoclosedCategoriesTest( T, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta : only_primitive_operations := true );;

##############################################

gap> STOP_TEST("TerminalCategoryCocartesian.tst", 1);
