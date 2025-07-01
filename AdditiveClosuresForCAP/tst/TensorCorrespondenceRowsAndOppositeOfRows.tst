###################################################################################################
# Test the correspondences of the tensor stuructures between the category of rows and its opposite
###################################################################################################

gap> START_TEST( "TensorCorrespondenceRowsAndOppositeOfRows.tst" );

gap> LoadPackage( "AdditiveClosuresForCAP", false );
true

gap> Q := HomalgFieldOfRationals();;
gap> rows := CategoryOfRows( Q );;
gap> opposite := Opposite( rows );;

##############################################
# MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest
##############################################

gap> a := 2 / rows;;
gap> b := 3 / rows;;

gap> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( rows, opposite, a, b );;

gap> a := 0 / rows;;
gap> b := 2 / rows;;

gap> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( rows, opposite, a, b );;

gap> a := 3 / rows;;
gap> b := 0 / rows;;

gap> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( rows, opposite, a, b );;

##############################################
# MonoidalCategoriesTest
##############################################

gap> a := 2 / rows;;
gap> b := 3 / rows;;
gap> c := 6 / rows;;
gap> d := 4 / rows;;

gap> alpha := CategoryOfRowsMorphism( a, HomalgMatrix( [ 2 .. 7 ], RankOfObject( a ), RankOfObject( b ), Q ), b );;
gap> beta := CategoryOfRowsMorphism( c, HomalgMatrix( [ 8 .. 31 ], RankOfObject( c ), RankOfObject( d ), Q ), d );;

gap> MonoidalCategoriesTest( rows, opposite, a, b, c, alpha, beta );;

gap> a := 0 / rows;;
gap> b := 3 / rows;;

gap> alpha := ZeroMorphism( a, b );;

gap> MonoidalCategoriesTest( rows, opposite, a, b, c, alpha, beta );;

gap> a := 3 / rows;;
gap> b := 0 / rows;;

gap> alpha := ZeroMorphism( a, b );;

gap> MonoidalCategoriesTest( rows, opposite, a, b, c, alpha, beta );;

##############################################
# AdditiveMonoidalCategoriesTest
##############################################

gap> a := 2 / rows;;
gap> L := [ 3 / rows, 4 / rows, 5 / rows ];;

gap> AdditiveMonoidalCategoriesTest( rows, opposite, a, L );;

gap> a := 0 / rows;;
gap> L := [ 3 / rows, 4 / rows, 5 / rows ];;

gap> AdditiveMonoidalCategoriesTest( rows, opposite, a, L );;

gap> a := 2 / rows;;
gap> L := [ 3 / rows, 0 / rows, 5 / rows ];;

gap> AdditiveMonoidalCategoriesTest( rows, opposite, a, L );;

##############################################
# BraidedMonoidalCategoriesTest
##############################################

gap> a := 2 / rows;;
gap> b := 3 / rows;;

gap> BraidedMonoidalCategoriesTest( rows, opposite, a, b );;

gap> a := 0 / rows;;
gap> b := 2 / rows;;

gap> BraidedMonoidalCategoriesTest( rows, opposite, a, b );;

gap> a := 2 / rows;;
gap> b := 0 / rows;;

gap> BraidedMonoidalCategoriesTest( rows, opposite, a, b );;

##############################################
# ClosedMonoidalCategoriesTest
##############################################

gap> u := TensorUnit( rows );;

gap> a := 2 / rows;;
gap> b := 3 / rows;;
gap> c := 6 / rows;;
gap> d := 4 / rows;;

gap> a_tensor_b := TensorProduct( a, b );;
gap> c_tensor_d := TensorProduct( c, d );;

gap> hom_ab := InternalHom( a, b );;
gap> hom_cd := InternalHom( c, d );;

gap> alpha := CategoryOfRowsMorphism( a, HomalgMatrix( [ 2 .. 7 ], RankOfObject( a ), RankOfObject( b ), Q ), b );;
gap> beta := CategoryOfRowsMorphism( c, HomalgMatrix( [ 8 .. 31 ], RankOfObject( c ), RankOfObject( d ), Q ), d );;
gap> gamma := CategoryOfRowsMorphism( a_tensor_b, HomalgMatrix( [ 2 .. 7 ], RankOfObject( a_tensor_b ), RankOfObject( u ), Q ), u );;
gap> delta := CategoryOfRowsMorphism( c_tensor_d, HomalgMatrix( [ 8 .. 31 ], RankOfObject( c_tensor_d ), RankOfObject( u ), Q ), u );;
gap> epsilon := CategoryOfRowsMorphism( u, HomalgMatrix( [ 2 .. 7 ], RankOfObject( u ), RankOfObject( hom_ab ), Q ), hom_ab );;
gap> zeta := CategoryOfRowsMorphism( u, HomalgMatrix( [ 8 .. 31 ], RankOfObject( u ), RankOfObject( hom_cd ), Q ), hom_cd );;

gap> ClosedMonoidalCategoriesTest( rows, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;

gap> a = 0 / rows;;
gap> d = 0 / rows;;

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

gap> ClosedMonoidalCategoriesTest( rows, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;

##############################################
# CoclosedMonoidalCategoriesTest
##############################################

gap> u := TensorUnit( rows );;

gap> a := 2 / rows;;
gap> b := 3 / rows;;
gap> c := 6 / rows;;
gap> d := 4 / rows;;

gap> a_tensor_b := TensorProduct( a, b );;
gap> c_tensor_d := TensorProduct( c, d );;

gap> cohom_ab := InternalCoHom( a, b );;
gap> cohom_cd := InternalCoHom( c, d );;

gap> alpha := CategoryOfRowsMorphism( a, HomalgMatrix( [ 2 .. 7 ], RankOfObject( a ), RankOfObject( b ), Q ), b );;
gap> beta := CategoryOfRowsMorphism( c, HomalgMatrix( [ 8 .. 31 ], RankOfObject( c ), RankOfObject( d ), Q ), d );;
gap> gamma := CategoryOfRowsMorphism( u, HomalgMatrix( [ 2 .. 7 ], RankOfObject( u ), RankOfObject( a_tensor_b ), Q ), a_tensor_b );;
gap> delta := CategoryOfRowsMorphism( u, HomalgMatrix( [ 8 .. 31 ], RankOfObject( u ), RankOfObject( c_tensor_d ), Q ), c_tensor_d );;
gap> epsilon := CategoryOfRowsMorphism( cohom_ab, HomalgMatrix( [ 2 .. 7 ], RankOfObject( cohom_ab ), RankOfObject( u ), Q ), u );;
gap> zeta := CategoryOfRowsMorphism( cohom_cd, HomalgMatrix( [ 8 .. 31 ], RankOfObject( cohom_cd ), RankOfObject( u ), Q ), u );;

gap> CoclosedMonoidalCategoriesTest( rows, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;

gap> a = 0 / rows;;
gap> d = 0 / rows;;

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

gap> CoclosedMonoidalCategoriesTest( rows, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );;

##############################################
# RigidSymmetricClosedMonoidalCategoriesTest
##############################################

gap> a := 2 / rows;;
gap> b := 3 / rows;;
gap> c := 6 / rows;;
gap> d := 4 / rows;;

gap> alpha := IdentityMorphism( a );;

gap> RigidSymmetricClosedMonoidalCategoriesTest( rows, opposite, a, b, c, d, alpha );;

gap> a := 0 / rows;;
gap> d := 0 / rows;;

gap> alpha := IdentityMorphism( a );;

gap> RigidSymmetricClosedMonoidalCategoriesTest( rows, opposite, a, b, c, d, alpha );;

##############################################
# RigidSymmetricCoclosedMonoidalCategoriesTest
##############################################

gap> a := 2 / rows;;
gap> b := 3 / rows;;
gap> c := 6 / rows;;
gap> d := 4 / rows;;

gap> alpha := IdentityMorphism( a );;

gap> RigidSymmetricCoclosedMonoidalCategoriesTest( rows, opposite, a, b, a, b, alpha );;

gap> a := 0 / rows;;
gap> d := 0 / rows;;

gap> alpha := IdentityMorphism( a );;

gap> RigidSymmetricCoclosedMonoidalCategoriesTest( rows, opposite, a, b, a, b, alpha );;

##############################################

gap> STOP_TEST( "TensorCorrespondenceRowsAndOppositeOfRows.tst", 1 );
