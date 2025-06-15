gap> START_TEST("HomogeneousLinearSystems.tst");
#@if ValueOption( "no_precompiled_code" ) <> true
gap> LoadPackage( "LinearAlgebraForCAP", false );
true
gap> QQ := HomalgFieldOfRationals();;
gap> QQ_mat := MatrixCategory( QQ );
Category of matrices over Q
gap> t := TensorUnit( QQ_mat );
<A vector space object over Q of dimension 1>
gap> id_t := IdentityMorphism( t );
<An identity morphism in Category of matrices over Q>
gap> 1*(11)*7 + 2*(12)*8 + 3*(13)*9;
620
gap> 4*(11)*3 + 5*(12)*4 + 6*(13)*1;
450
gap> alpha :=  [ [ 1/QQ * id_t, 2/QQ * id_t, 3/QQ * id_t ], [ 4/QQ * id_t, 5/QQ * id_t, 6/QQ * id_t ] ];;
gap> beta := [ [ 7/QQ * id_t, 8/QQ * id_t, 9/QQ * id_t ], [ 3/QQ * id_t, 4/QQ * id_t, 1/QQ * id_t ] ];;
gap> gamma := [ 620/QQ * id_t, 450/QQ * id_t ];;
gap> QQ_mat!.cached_precompiled_functions.MereExistenceOfSolutionOfLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma );
true
gap> QQ_mat!.cached_precompiled_functions.MereExistenceOfUniqueSolutionOfLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma );
false
gap> x := QQ_mat!.cached_precompiled_functions.SolveLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma );;
gap> (1*7)/QQ * x[1] + (2*8)/QQ * x[2] + (3*9)/QQ * x[3] = gamma[1];
true
gap> (4*3)/QQ * x[1] + (5*4)/QQ * x[2] + (6*1)/QQ * x[3] = gamma[2];
true
gap> QQ_mat!.cached_precompiled_functions.MereExistenceOfUniqueSolutionOfHomogeneousLinearSystemInAbCategory( QQ_mat, alpha, beta );
false
gap> B := QQ_mat!.cached_precompiled_functions.BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory( QQ_mat, alpha, beta );;
gap> Length( B );
1
gap> (1*7)/QQ * B[1][1] + (2*8)/QQ * B[1][2] + (3*9)/QQ * B[1][3] = 0/QQ * id_t;
true
gap> (4*3)/QQ * B[1][1] + (5*4)/QQ * B[1][2] + (6*1)/QQ * B[1][3] = 0/QQ * id_t;
true
gap> 2*(11)*5 + 3*(12)*7 + 9*(13)*2;
596
gap> Add( alpha, [ 2/QQ * id_t, 3/QQ * id_t, 9/QQ * id_t ] );;
gap> Add( beta, [ 5/QQ * id_t, 7/QQ * id_t, 2/QQ * id_t ] );;
gap> Add( gamma, 596/QQ * id_t );;
gap> QQ_mat!.cached_precompiled_functions.MereExistenceOfSolutionOfLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma );
true
gap> QQ_mat!.cached_precompiled_functions.MereExistenceOfUniqueSolutionOfLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma );
true
gap> x := QQ_mat!.cached_precompiled_functions.SolveLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma );;
gap> (1*7)/QQ * x[1] + (2*8)/QQ * x[2] + (3*9)/QQ * x[3] = gamma[1];
true
gap> (4*3)/QQ * x[1] + (5*4)/QQ * x[2] + (6*1)/QQ * x[3] = gamma[2];
true
gap> (2*5)/QQ * x[1] + (3*7)/QQ * x[2] + (9*2)/QQ * x[3] = gamma[3];
true
gap> QQ_mat!.cached_precompiled_functions.MereExistenceOfUniqueSolutionOfHomogeneousLinearSystemInAbCategory( QQ_mat, alpha, beta );
true
gap> B := QQ_mat!.cached_precompiled_functions.BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory( QQ_mat, alpha, beta );;
gap> Length( B );
0
gap> alpha := [ [ 2/QQ * id_t, 3/QQ * id_t ] ];;
gap> beta := [ [ 1/QQ * id_t, 1/QQ * id_t ] ];;
gap> gamma := [ [ 1/QQ * id_t, 1/QQ * id_t ] ];;
gap> delta := [ [ 3/QQ * id_t, 3/QQ * id_t ] ];;
gap> B := QQ_mat!.cached_precompiled_functions.BasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory( QQ_mat, alpha, beta, gamma, delta );;
gap> Length( B );
1
gap> mor1 := PreCompose( alpha[1][1], B[1][1] ) + PreCompose( alpha[1][2], B[1][2] );
<A morphism in Category of matrices over Q>
gap> mor2 := PreCompose( B[1][1], delta[1][1] ) + PreCompose( B[1][2], delta[1][2] );
<A morphism in Category of matrices over Q>
gap> mor1 = mor2;
true
#@fi
gap> STOP_TEST("HomogeneousLinearSystems.tst", 1);
