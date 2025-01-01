###############################################################
# Test the symmetric rigid (co)closed correspondences between
# the terminal category with multiple objects and its opposite.
###############################################################

gap> START_TEST( "TerminalCategoryMonoidal" );

#
gap> LoadPackage( "MonoidalCategories", false );
true

#
gap> T := TerminalCategoryWithMultipleObjects( );;
gap> opposite := Opposite( T, "Opposite with all operations" );;
gap> opposite_primitive := Opposite( T, "Opposite with primitive operations" : only_primitive_operations := true );;

#
##############################################
# MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest
##############################################
#
gap> a := "a" / T;;
gap> b := "b" / T;;

#
gap> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( T, opposite, a, b );;
gap> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( T, opposite_primitive, a, b );;

#
gap> z := ZeroObject( T );;

#
gap> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( T, opposite, z, b );;
gap> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( T, opposite_primitive, z, b );;

#
gap> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( T, opposite, a, z );;
gap> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( T, opposite_primitive, a, z );;

#
##############################################
# MonoidalCategoriesTest
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
gap> MonoidalCategoriesTest( T, opposite, a, b, c, alpha, beta );;
gap> MonoidalCategoriesTest( T, opposite_primitive, a, b, c, alpha, beta );;

#
gap> z := ZeroObject( T );;

#
gap> alpha := UniversalMorphismFromZeroObject( a );;
gap> beta := UniversalMorphismIntoZeroObject( a );;

#
gap> MonoidalCategoriesTest( T, opposite, z, a, a, alpha, beta );;
gap> MonoidalCategoriesTest( T, opposite_primitive, z, a, a, alpha, beta );;

#
gap> MonoidalCategoriesTest( T, opposite, a, z, z, beta, alpha );;
gap> MonoidalCategoriesTest( T, opposite_primitive, a, z, z, beta, alpha );;

#
##############################################
# AdditiveMonoidalCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> L := [ "b" / T, "c" / T, "d" / T ];;

#
gap> AdditiveMonoidalCategoriesTest( T, opposite, a, L );;
gap> AdditiveMonoidalCategoriesTest( T, opposite_primitive, a, L );;

#
##############################################
# BraidedMonoidalCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> b := "b" / T;;

#
gap> BraidedMonoidalCategoriesTest( T, opposite, a, b );;
gap> BraidedMonoidalCategoriesTest( T, opposite_primitive, a, b );;

#
gap> BraidedMonoidalCategoriesTest( T, opposite, b, a );;
gap> BraidedMonoidalCategoriesTest( T, opposite_primitive, b, a );;

#
gap> z := ZeroObject( T );;

#
gap> BraidedMonoidalCategoriesTest( T, opposite, z, a );;
gap> BraidedMonoidalCategoriesTest( T, opposite_primitive, z, a );;

#
gap> BraidedMonoidalCategoriesTest( T, opposite, a, z );;
gap> BraidedMonoidalCategoriesTest( T, opposite_primitive, a, z );;

#
##############################################
# LeftClosedMonoidalCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> b := "b" / T;;
gap> c := "c" / T;;
gap> d := "d" / T;;

#
gap> u := TensorUnit( T );;

#
gap> a_product_b := TensorProduct( a, b );;
gap> c_product_d := TensorProduct( c, d );;

#
gap> hom_ab := InternalHom( a, b );;
gap> hom_cd := InternalHom( c, d );;

#
gap> alpha := MorphismConstructor( a, "f_ab", b );;
gap> beta := MorphismConstructor( c, "f_cd", d );;
gap> gamma := MorphismConstructor( a_product_b, "f_abu", u );;
gap> delta := MorphismConstructor( c_product_d, "f_cdu", u );;
gap> epsilon := MorphismConstructor( u, "f_uhomab", hom_ab );;
gap> zeta := MorphismConstructor( u, "f_uhomcd", hom_cd );;

#
gap> LeftClosedMonoidalCategoriesTest( T, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> LeftClosedMonoidalCategoriesTest( T, opposite_primitive, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;

#
gap> LeftClosedMonoidalCategoriesTestWithGiven( T, opposite, a, b, c, d, alpha, beta );;
gap> LeftClosedMonoidalCategoriesTestWithGiven( T, opposite_primitive, a, b, c, d, alpha, beta );;

#
gap> z := ZeroObject( T );;

#
gap> z_product_a := TensorProduct( z, a );;
gap> a_product_z := TensorProduct( a, z );;

#
gap> hom_za := InternalHom( z, a );;
gap> hom_az := InternalHom( a, z );;

#
gap> alpha := MorphismConstructor( z, "f_za", a );;
gap> beta := MorphismConstructor( a, "f_az", z );;
gap> gamma := MorphismConstructor( z_product_a, "f_zau", u );;
gap> delta := MorphismConstructor( a_product_z, "f_azu", u );;
gap> epsilon := MorphismConstructor( u, "f_uhomza", hom_za );;
gap> zeta := MorphismConstructor( u, "f_uhomaz", hom_az );;

#
gap> LeftClosedMonoidalCategoriesTest( T, opposite, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );;
gap> LeftClosedMonoidalCategoriesTest( T, opposite_primitive, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );;

#
gap> LeftClosedMonoidalCategoriesTestWithGiven( T, opposite, z, a, a, z, alpha, beta );;
gap> LeftClosedMonoidalCategoriesTestWithGiven( T, opposite_primitive, z, a, a, z, alpha, beta );;

#
##############################################
# LeftCoclosedMonoidalCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> b := "b" / T;;
gap> c := "c" / T;;
gap> d := "d" / T;;

#
gap> u := TensorUnit( T );;

#
gap> a_product_b := TensorProduct( a, b );;
gap> c_product_d := TensorProduct( c, d );;

#
gap> cohom_ab := InternalCoHom( a, b );;
gap> cohom_cd := InternalCoHom( c, d );;

#
gap> alpha := MorphismConstructor( a, "f_ab", b );;
gap> beta := MorphismConstructor( c, "f_cd", d );;
gap> gamma := MorphismConstructor( u, "f_uab", a_product_b );;
gap> delta := MorphismConstructor( u, "f_ucd", c_product_d );;
gap> epsilon := MorphismConstructor( cohom_ab, "f_cohomabu", u );;
gap> zeta := MorphismConstructor( cohom_cd, "f_cohomcdu", u );;

#
gap> LeftCoclosedMonoidalCategoriesTest( T, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> LeftCoclosedMonoidalCategoriesTest( T, opposite_primitive, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;

#
gap> LeftCoclosedMonoidalCategoriesTestWithGiven( T, opposite, a, b, c, d, alpha, beta );;
gap> LeftCoclosedMonoidalCategoriesTestWithGiven( T, opposite_primitive, a, b, c, d, alpha, beta );;

#
gap> z := ZeroObject( T );;

#
gap> z_product_a := TensorProduct( z, a );;
gap> a_product_z := TensorProduct( a, z );;

#
gap> cohom_za := InternalCoHom( z, a );;
gap> cohom_az := InternalCoHom( a, z );;

#
gap> alpha := MorphismConstructor( z, "f_za", a );;
gap> beta := MorphismConstructor( a, "f_az", z );;
gap> gamma := MorphismConstructor( u, "f_uza", z_product_a );;
gap> delta := MorphismConstructor( u, "f_uaz", a_product_z );;
gap> epsilon := MorphismConstructor( cohom_za, "f_cohomzau", u );;
gap> zeta := MorphismConstructor( cohom_az, "cohomazu", u );;

#
gap> LeftCoclosedMonoidalCategoriesTest( T, opposite, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );;
gap> LeftCoclosedMonoidalCategoriesTest( T, opposite_primitive, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );;

#
gap> LeftCoclosedMonoidalCategoriesTestWithGiven( T, opposite, z, a, a, z, alpha, beta );;
gap> LeftCoclosedMonoidalCategoriesTestWithGiven( T, opposite_primitive, z, a, a, z, alpha, beta );;

#
##############################################
# RigidSymmetricClosedMonoidalCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> b := "b" / T;;
gap> c := "c" / T;;
gap> d := "d" / T;;

#
gap> alpha := IdentityMorphism( a );;

#
gap> RigidSymmetricClosedMonoidalCategoriesTest( T, opposite, a, b, c, d, alpha );;
gap> RigidSymmetricClosedMonoidalCategoriesTest( T, opposite_primitive, a, b, c, d, alpha );;

#
gap> z := ZeroObject( T );;

#
gap> alpha := IdentityMorphism( a );;

#
gap> RigidSymmetricClosedMonoidalCategoriesTest( T, opposite, z, b, c, z, alpha );;
gap> RigidSymmetricClosedMonoidalCategoriesTest( T, opposite_primitive, z, b, c, z, alpha );;

#
##############################################
# RigidSymmetricCoclosedMonoidalCategoriesTest
##############################################
#
gap> a := "a" / T;;
gap> b := "b" / T;;
gap> c := "c" / T;;
gap> d := "d" / T;;

#
gap> alpha := IdentityMorphism( a );;

#
gap> RigidSymmetricCoclosedMonoidalCategoriesTest( T, opposite, a, b, c, d, alpha );;
gap> RigidSymmetricCoclosedMonoidalCategoriesTest( T, opposite_primitive, a, b, c, d, alpha );;

#
gap> z := ZeroObject( T );;

#
gap> alpha := IdentityMorphism( a );;

#
gap> RigidSymmetricCoclosedMonoidalCategoriesTest( T, opposite, a, b, c, d, alpha );;
gap> RigidSymmetricCoclosedMonoidalCategoriesTest( T, opposite_primitive, a, b, c, d, alpha );;

#
##############################################
#
gap> STOP_TEST( "TerminalCategoryMonoidal" );
