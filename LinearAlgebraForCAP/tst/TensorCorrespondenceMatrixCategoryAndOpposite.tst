#######################################################################################################
# Test the correspondences of the tensor stuructures between the category of matrices and its opposite
#######################################################################################################

gap> START_TEST( "TensorCorrespondenceMatrixCategoryAndOpposite.tst" );

gap> LoadPackage( "LinearAlgebraForCAP", false );
true

gap> Q := HomalgFieldOfRationals();;
gap> mc := MatrixCategory( Q );;
gap> opposite := Opposite( mc );;

##############################################
# MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest
##############################################

gap> a := 2 / mc;;
gap> b := 3 / mc;;

gap> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( mc, opposite, a, b );;

gap> a := 0 / mc;;
gap> b := 2 / mc;;

gap> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( mc, opposite, a, b );;

gap> a := 3 / mc;;
gap> b := 0 / mc;;

gap> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( mc, opposite, a, b );;

##############################################
# MonoidalCategoriesTest
##############################################

gap> a := 2 / mc;;
gap> b := 3 / mc;;
gap> c := 6 / mc;;
gap> d := 4 / mc;;

gap> alpha := VectorSpaceMorphism( a, HomalgMatrix( [ 2 .. 7 ], Dimension( a ), Dimension( b ), Q ), b );;
gap> beta := VectorSpaceMorphism( c, HomalgMatrix( [ 8 .. 31 ], Dimension( c ), Dimension( d ), Q ), d );;

gap> MonoidalCategoriesTest( mc, opposite, a, b, c, alpha, beta );;

gap> a := 0 / mc;;
gap> b := 3 / mc;;

gap> alpha := ZeroMorphism( a, b );;

gap> MonoidalCategoriesTest( mc, opposite, a, b, c, alpha, beta );;

gap> a := 3 / mc;;
gap> b := 0 / mc;;

gap> alpha := ZeroMorphism( a, b );;

gap> MonoidalCategoriesTest( mc, opposite, a, b, c, alpha, beta );;

##############################################
# AdditiveMonoidalCategoriesTest
##############################################

gap> a := 2 / mc;;
gap> L := [ 3 / mc, 4 / mc, 5 / mc ];;

gap> AdditiveMonoidalCategoriesTest( mc, opposite, a, L );;

gap> a := 0 / mc;;
gap> L := [ 3 / mc, 4 / mc, 5 / mc ];;

gap> AdditiveMonoidalCategoriesTest( mc, opposite, a, L );;

gap> a := 2 / mc;;
gap> L := [ 3 / mc, 0 / mc, 5 / mc ];;

gap> AdditiveMonoidalCategoriesTest( mc, opposite, a, L );;

##############################################
# BraidedMonoidalCategoriesTest
##############################################

gap> a := 2 / mc;;
gap> b := 3 / mc;;

gap> BraidedMonoidalCategoriesTest( mc, opposite, a, b );;

gap> a := 0 / mc;;
gap> b := 2 / mc;;

gap> BraidedMonoidalCategoriesTest( mc, opposite, a, b );;

gap> a := 2 / mc;;
gap> b := 0 / mc;;

gap> BraidedMonoidalCategoriesTest( mc, opposite, a, b );;

##############################################
# ClosedMonoidalCategoriesTest
##############################################

gap> u := TensorUnit( mc );;

gap> a := 2 / mc;;
gap> b := 3 / mc;;
gap> c := 6 / mc;;
gap> d := 4 / mc;;

gap> a_tensor_b := TensorProduct( a, b );;
gap> c_tensor_d := TensorProduct( c, d );;

gap> hom_ab := InternalHom( a, b );;
gap> hom_cd := InternalHom( c, d );;

gap> alpha := VectorSpaceMorphism( a, HomalgMatrix( [ 2 .. 7 ], Dimension( a ), Dimension( b ), Q ), b );;
gap> beta := VectorSpaceMorphism( c, HomalgMatrix( [ 8 .. 31 ], Dimension( c ), Dimension( d ), Q ), d );;
gap> gamma := VectorSpaceMorphism( a_tensor_b, HomalgMatrix( [ 2 .. 7 ], Dimension( a_tensor_b ), Dimension( u ), Q ), u );;
gap> delta := VectorSpaceMorphism( c_tensor_d, HomalgMatrix( [ 8 .. 31 ], Dimension( c_tensor_d ), Dimension( u ), Q ), u );;
gap> epsilon := VectorSpaceMorphism( u, HomalgMatrix( [ 2 .. 7 ], Dimension( u ), Dimension( hom_ab ), Q ), hom_ab );;
gap> zeta := VectorSpaceMorphism( u, HomalgMatrix( [ 8 .. 31 ], Dimension( u ), Dimension( hom_cd ), Q ), hom_cd );;

gap> ClosedMonoidalCategoriesTest( mc, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> ClosedMonoidalCategoriesTestWithGiven( mc, opposite, a, b, c, d, alpha, beta) ;;

gap> a = 0 / mc;;
gap> d = 0 / mc;;

gap> a_tensor_b := TensorProduct( a, b );;
gap> c_tensor_d := TensorProduct( c, d );;

gap> hom_ab := InternalHom( a, b );;
gap> hom_cd := InternalHom( c, d );;

gap> alpha := ZeroMorphism( a, b );;
gap> beta := ZeroMorphism( c, d );;
gap> gamma := ZeroMorphism( a_tensor_b, u );;
gap> delta := ZeroMorphism( c_tensor_d, u );;
gap> epsilon := ZeroMorphism( u, hom_ab );;
gap> zeta := ZeroMorphism( u, hom_cd );;

gap> ClosedMonoidalCategoriesTest( mc, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> ClosedMonoidalCategoriesTestWithGiven( mc, opposite, a, b, c, d, alpha, beta );;

##############################################
# LeftClosedMonoidalCategoriesTest
##############################################

gap> u := TensorUnit( mc );;

gap> a := 2 / mc;;
gap> b := 3 / mc;;
gap> c := 6 / mc;;
gap> d := 4 / mc;;

gap> a_tensor_b := TensorProduct( a, b );;
gap> c_tensor_d := TensorProduct( c, d );;

gap> hom_ab := InternalHom( a, b );;
gap> hom_cd := InternalHom( c, d );;

gap> alpha := VectorSpaceMorphism( a, HomalgMatrix( [ 2 .. 7 ], Dimension( a ), Dimension( b ), Q ), b );;
gap> beta := VectorSpaceMorphism( c, HomalgMatrix( [ 8 .. 31 ], Dimension( c ), Dimension( d ), Q ), d );;
gap> gamma := VectorSpaceMorphism( a_tensor_b, HomalgMatrix( [ 2 .. 7 ], Dimension( a_tensor_b ), Dimension( u ), Q ), u );;
gap> delta := VectorSpaceMorphism( c_tensor_d, HomalgMatrix( [ 8 .. 31 ], Dimension( c_tensor_d ), Dimension( u ), Q ), u );;
gap> epsilon := VectorSpaceMorphism( u, HomalgMatrix( [ 2 .. 7 ], Dimension( u ), Dimension( hom_ab ), Q ), hom_ab );;
gap> zeta := VectorSpaceMorphism( u, HomalgMatrix( [ 8 .. 31 ], Dimension( u ), Dimension( hom_cd ), Q ), hom_cd );;

gap> LeftClosedMonoidalCategoriesTest( mc, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> LeftClosedMonoidalCategoriesTestWithGiven( mc, opposite, a, b, c, d, alpha, beta) ;;

gap> a = 0 / mc;;
gap> d = 0 / mc;;

gap> a_tensor_b := TensorProduct( a, b );;
gap> c_tensor_d := TensorProduct( c, d );;

gap> hom_ab := InternalHom( a, b );;
gap> hom_cd := InternalHom( c, d );;

gap> alpha := ZeroMorphism( a, b );;
gap> beta := ZeroMorphism( c, d );;
gap> gamma := ZeroMorphism( a_tensor_b, u );;
gap> delta := ZeroMorphism( c_tensor_d, u );;
gap> epsilon := ZeroMorphism( u, hom_ab );;
gap> zeta := ZeroMorphism( u, hom_cd );;

gap> LeftClosedMonoidalCategoriesTest( mc, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> LeftClosedMonoidalCategoriesTestWithGiven( mc, opposite, a, b, c, d, alpha, beta );;

##############################################
# CoclosedMonoidalCategoriesTest
##############################################

gap> u := TensorUnit( mc );;

gap> a := 2 / mc;;
gap> b := 3 / mc;;
gap> c := 6 / mc;;
gap> d := 4 / mc;;

gap> a_tensor_b := TensorProduct( a, b );;
gap> c_tensor_d := TensorProduct( c, d );;

gap> cohom_ab := InternalCoHom( a, b );;
gap> cohom_cd := InternalCoHom( c, d );;

gap> alpha :=  VectorSpaceMorphism( a, HomalgMatrix( [ 2 .. 7 ], Dimension( a ), Dimension( b ), Q ), b );;
gap> beta := VectorSpaceMorphism( c, HomalgMatrix( [ 8 .. 31 ], Dimension( c ), Dimension( d ), Q ), d );;
gap> gamma := VectorSpaceMorphism( u, HomalgMatrix( [ 2 .. 7 ], Dimension( u ), Dimension( a_tensor_b ), Q ), a_tensor_b );;
gap> delta := VectorSpaceMorphism( u, HomalgMatrix( [ 8 .. 31 ], Dimension( u ), Dimension( c_tensor_d ), Q ), c_tensor_d );;
gap> epsilon := VectorSpaceMorphism( cohom_ab, HomalgMatrix( [ 2 .. 7 ], Dimension( cohom_ab ), Dimension( u ), Q ), u );;
gap> zeta := VectorSpaceMorphism( cohom_cd, HomalgMatrix( [ 8 .. 31 ], Dimension( cohom_cd ), Dimension( u ), Q ), u );;

gap> CoclosedMonoidalCategoriesTest( mc, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> CoclosedMonoidalCategoriesTestWithGiven( mc, opposite, a, b, c, d, alpha, beta );;

gap> a = 0 / mc;;
gap> d = 0 / mc;;

gap> a_tensor_b := TensorProduct( a, b );;
gap> c_tensor_d := TensorProduct( c, d );;

gap> cohom_ab := InternalCoHom( a, b );;
gap> cohom_cd := InternalCoHom( c, d );;

gap> alpha := ZeroMorphism( a, b );;
gap> beta := ZeroMorphism( c, d );;
gap> gamma := ZeroMorphism( u, a_tensor_b );;
gap> delta := ZeroMorphism( u, c_tensor_d );;
gap> epsilon := ZeroMorphism( cohom_ab, u );;
gap> zeta := ZeroMorphism( cohom_cd, u );;

gap> CoclosedMonoidalCategoriesTest( mc, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> CoclosedMonoidalCategoriesTestWithGiven( mc, opposite, a, b, c, d, alpha, beta );;

##############################################
# LeftCoclosedMonoidalCategoriesTest
##############################################

gap> u := TensorUnit( mc );;

gap> a := 2 / mc;;
gap> b := 3 / mc;;
gap> c := 6 / mc;;
gap> d := 4 / mc;;

gap> a_tensor_b := TensorProduct( a, b );;
gap> c_tensor_d := TensorProduct( c, d );;

gap> cohom_ab := InternalCoHom( a, b );;
gap> cohom_cd := InternalCoHom( c, d );;

gap> alpha :=  VectorSpaceMorphism( a, HomalgMatrix( [ 2 .. 7 ], Dimension( a ), Dimension( b ), Q ), b );;
gap> beta := VectorSpaceMorphism( c, HomalgMatrix( [ 8 .. 31 ], Dimension( c ), Dimension( d ), Q ), d );;
gap> gamma := VectorSpaceMorphism( u, HomalgMatrix( [ 2 .. 7 ], Dimension( u ), Dimension( a_tensor_b ), Q ), a_tensor_b );;
gap> delta := VectorSpaceMorphism( u, HomalgMatrix( [ 8 .. 31 ], Dimension( u ), Dimension( c_tensor_d ), Q ), c_tensor_d );;
gap> epsilon := VectorSpaceMorphism( cohom_ab, HomalgMatrix( [ 2 .. 7 ], Dimension( cohom_ab ), Dimension( u ), Q ), u );;
gap> zeta := VectorSpaceMorphism( cohom_cd, HomalgMatrix( [ 8 .. 31 ], Dimension( cohom_cd ), Dimension( u ), Q ), u );;

gap> LeftCoclosedMonoidalCategoriesTest( mc, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> LeftCoclosedMonoidalCategoriesTestWithGiven( mc, opposite, a, b, c, d, alpha, beta );;

gap> a = 0 / mc;;
gap> d = 0 / mc;;

gap> a_tensor_b := TensorProduct( a, b );;
gap> c_tensor_d := TensorProduct( c, d );;

gap> cohom_ab := InternalCoHom( a, b );;
gap> cohom_cd := InternalCoHom( c, d );;

gap> alpha := ZeroMorphism( a, b );;
gap> beta := ZeroMorphism( c, d );;
gap> gamma := ZeroMorphism( u, a_tensor_b );;
gap> delta := ZeroMorphism( u, c_tensor_d );;
gap> epsilon := ZeroMorphism( cohom_ab, u );;
gap> zeta := ZeroMorphism( cohom_cd, u );;

gap> LeftCoclosedMonoidalCategoriesTest( mc, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;
gap> LeftCoclosedMonoidalCategoriesTestWithGiven( mc, opposite, a, b, c, d, alpha, beta );;

##############################################
# RigidSymmetricClosedMonoidalCategoriesTest
##############################################

gap> a := 2 / mc;;
gap> b := 3 / mc;;
gap> c := 6 / mc;;
gap> d := 4 / mc;;

gap> alpha := IdentityMorphism( a );;

gap> RigidSymmetricClosedMonoidalCategoriesTest( mc, opposite, a, b, c, d, alpha );;

gap> a := 0 / mc;;
gap> d := 0 / mc;;

gap> alpha := IdentityMorphism( a );;

gap> RigidSymmetricClosedMonoidalCategoriesTest( mc, opposite, a, b, c, d, alpha );;

##############################################
# RigidSymmetricCoclosedMonoidalCategoriesTest
##############################################

gap> a := 2 / mc;;
gap> b := 3 / mc;;
gap> c := 6 / mc;;
gap> d := 4 / mc;;

gap> alpha := IdentityMorphism( a );;

gap> RigidSymmetricCoclosedMonoidalCategoriesTest( mc, opposite, a, b, a, b, alpha );;

gap> a := 0 / mc;;
gap> d := 0 / mc;;

gap> alpha := IdentityMorphism( a );;

gap> RigidSymmetricCoclosedMonoidalCategoriesTest( mc, opposite, a, b, a, b, alpha );;

##############################################

gap> STOP_TEST( "TensorCorrespondenceMatrixCategoryAndOpposite.tst", 1 );
