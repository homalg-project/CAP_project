###############################################################
# Test the symmetric rigid (co)closed correspondences between
# the terminal category with multiple objects and its opposite.
###############################################################

gap> START_TEST("TerminalCategoryMonoidal.tst");

gap> LoadPackage("MonoidalCategories", false);
true

gap> T := TerminalCategoryWithMultipleObjects( );;

##############################################
# MonoidalCategoriesTensorProductAndUnitTest
##############################################

gap> a := "a" / T;;
gap> b := "b" / T;;

gap> MonoidalCategoriesTensorProductAndUnitTest( T, a, b );;
gap> MonoidalCategoriesTensorProductAndUnitTest( T, a, b : only_primitive_operations := true );;

gap> z := ZeroObject( T );;

gap> MonoidalCategoriesTensorProductAndUnitTest( T, z, b );;
gap> MonoidalCategoriesTensorProductAndUnitTest( T, z, b : only_primitive_operations := true );;

gap> MonoidalCategoriesTensorProductAndUnitTest( T, a, z );;
gap> MonoidalCategoriesTensorProductAndUnitTest( T, a, z : only_primitive_operations := true );;

##############################################
# MonoidalCategoriesTest
##############################################

gap> a := "a" / T;;
gap> b := "b" / T;;
gap> c := "c" / T;;
gap> d := "d" / T;;

gap> alpha := MorphismConstructor( a, "f_ab", b );;
gap> beta := MorphismConstructor( c, "f_cd", d );;

gap> MonoidalCategoriesTest( T, a, b, c, alpha, beta );;
gap> MonoidalCategoriesTest( T, a, b, c, alpha, beta : only_primitive_operations := true );;

gap> z := ZeroObject( T );;

gap> alpha := UniversalMorphismFromZeroObject( a );;
gap> beta := UniversalMorphismIntoZeroObject( a );;

gap> MonoidalCategoriesTest( T, z, a, a, alpha, beta );;
gap> MonoidalCategoriesTest( T, z, a, a, alpha, beta : only_primitive_operations := true );;

gap> MonoidalCategoriesTest( T, a, z, z, beta, alpha );;
gap> MonoidalCategoriesTest( T, a, z, z, beta, alpha : only_primitive_operations := true );;

##############################################
# AdditiveMonoidalCategoriesTest
##############################################

gap> a := "a" / T;;
gap> L := [ "b" / T, "c" / T, "d" / T ];;

gap> AdditiveMonoidalCategoriesTest( T, a, L );;
gap> AdditiveMonoidalCategoriesTest( T, a, L : only_primitive_operations := true );;

##############################################
# BraidedMonoidalCategoriesTest
##############################################

gap> a := "a" / T;;
gap> b := "b" / T;;

gap> BraidedMonoidalCategoriesTest( T, a, b );;
gap> BraidedMonoidalCategoriesTest( T, a, b : only_primitive_operations := true );;

gap> BraidedMonoidalCategoriesTest( T, b, a );;
gap> BraidedMonoidalCategoriesTest( T, b, a : only_primitive_operations := true );;

gap> z := ZeroObject( T );;

gap> BraidedMonoidalCategoriesTest( T, z, a );;
gap> BraidedMonoidalCategoriesTest( T, z, a : only_primitive_operations := true );;

gap> BraidedMonoidalCategoriesTest( T, a, z );;
gap> BraidedMonoidalCategoriesTest( T, a, z : only_primitive_operations := true );;

##############################################
# ClosedMonoidalCategoriesTest
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

gap> ClosedMonoidalCategoriesTest( T, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> ClosedMonoidalCategoriesTest( T, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta : only_primitive_operations := true );;

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

gap> ClosedMonoidalCategoriesTest( T, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );;
gap> ClosedMonoidalCategoriesTest( T, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta : only_primitive_operations := true );;

##############################################
# CoclosedMonoidalCategoriesTest
##############################################

gap> a := "a" / T;;
gap> b := "b" / T;;
gap> c := "c" / T;;
gap> d := "d" / T;;

gap> u := TensorUnit( T );;

gap> a_product_b := TensorProduct( a, b );;
gap> c_product_d := TensorProduct( c, d );;

gap> cohom_ab := InternalCoHom( a, b );;
gap> cohom_cd := InternalCoHom( c, d );;

gap> alpha := MorphismConstructor( a, "f_ab", b );;
gap> beta := MorphismConstructor( c, "f_cd", d );;
gap> gamma := MorphismConstructor( u, "f_uab", a_product_b );;
gap> delta := MorphismConstructor( u, "f_ucd", c_product_d );;
gap> epsilon := MorphismConstructor( cohom_ab, "f_cohomabu", u );;
gap> zeta := MorphismConstructor( cohom_cd, "f_cohomcdu", u);;

gap> CoclosedMonoidalCategoriesTest( T, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> CoclosedMonoidalCategoriesTest( T, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta : only_primitive_operations := true );;

gap> z := ZeroObject( T );;

gap> z_product_a := TensorProduct( z, a );;
gap> a_product_z := TensorProduct( a, z );;

gap> cohom_za := InternalCoHom( z, a );;
gap> cohom_az := InternalCoHom( a, z );;

gap> alpha := MorphismConstructor( z, "f_za", a );;
gap> beta := MorphismConstructor( a, "f_az", z );;
gap> gamma := MorphismConstructor( u, "f_uza", z_product_a );;
gap> delta := MorphismConstructor( u, "f_uaz", a_product_z );;
gap> epsilon := MorphismConstructor( cohom_za, "f_cohomzau", u );;
gap> zeta := MorphismConstructor( cohom_az, "cohomazu", u );;

gap> CoclosedMonoidalCategoriesTest( T, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );;
gap> CoclosedMonoidalCategoriesTest( T, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta : only_primitive_operations := true );;

##############################################
# RigidSymmetricClosedMonoidalCategoriesTest
##############################################

gap> a := "a" / T;;
gap> b := "b" / T;;
gap> c := "c" / T;;
gap> d := "d" / T;;

gap> alpha := IdentityMorphism( a );;

gap> RigidSymmetricClosedMonoidalCategoriesTest( T, a, b, c, d, alpha );;
gap> RigidSymmetricClosedMonoidalCategoriesTest( T, a, b, c, d, alpha : only_primitive_operations := true );;

gap> z := ZeroObject( T );;

gap> alpha := IdentityMorphism( a );;

gap> RigidSymmetricClosedMonoidalCategoriesTest( T, z, b, c, z, alpha );;
gap> RigidSymmetricClosedMonoidalCategoriesTest( T, z, b, c, z, alpha : only_primitive_operations := true );;

##############################################
# RigidSymmetricCoclosedMonoidalCategoriesTest
##############################################

gap> a := "a" / T;;
gap> b := "b" / T;;
gap> c := "c" / T;;
gap> d := "d" / T;;

gap> alpha := IdentityMorphism( a );;

gap> RigidSymmetricCoclosedMonoidalCategoriesTest( T, a, b, c, d, alpha );;
gap> RigidSymmetricCoclosedMonoidalCategoriesTest( T, a, b, c, d, alpha : only_primitive_operations := true );;

gap> z := ZeroObject( T );;

gap> alpha := IdentityMorphism( a );;

gap> RigidSymmetricCoclosedMonoidalCategoriesTest( T, a, b, c, d, alpha );;
gap> RigidSymmetricCoclosedMonoidalCategoriesTest( T, a, b, c, d, alpha : only_primitive_operations := true );;

##############################################

gap> STOP_TEST("TerminalCategoryMonoidal.tst", 1);
