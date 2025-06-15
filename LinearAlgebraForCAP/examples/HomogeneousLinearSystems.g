#! @Chapter Examples and Tests

#! @Section Solving (Homogeneous) Linear Systems

#! @Example
LoadPackage( "LinearAlgebraForCAP", false );
#! true
QQ := HomalgFieldOfRationals();;
QQ_mat := MatrixCategory( QQ );
#! Category of matrices over Q
t := TensorUnit( QQ_mat );
#! <A vector space object over Q of dimension 1>
id_t := IdentityMorphism( t );
#! <An identity morphism in Category of matrices over Q>
1*(11)*7 + 2*(12)*8 + 3*(13)*9;
#! 620
4*(11)*3 + 5*(12)*4 + 6*(13)*1;
#! 450
alpha :=  [ [ 1/QQ * id_t, 2/QQ * id_t, 3/QQ * id_t ], [ 4/QQ * id_t, 5/QQ * id_t, 6/QQ * id_t ] ];;
beta := [ [ 7/QQ * id_t, 8/QQ * id_t, 9/QQ * id_t ], [ 3/QQ * id_t, 4/QQ * id_t, 1/QQ * id_t ] ];;
gamma := [ 620/QQ * id_t, 450/QQ * id_t ];;
MereExistenceOfSolutionOfLinearSystemInAbCategory(
                                  QQ_mat, alpha, beta, gamma );
#! true
MereExistenceOfUniqueSolutionOfLinearSystemInAbCategory(
                                  QQ_mat, alpha, beta, gamma );
#! false
x := SolveLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma );;
(1*7)/QQ * x[1] + (2*8)/QQ * x[2] + (3*9)/QQ * x[3] = gamma[1];
#! true
(4*3)/QQ * x[1] + (5*4)/QQ * x[2] + (6*1)/QQ * x[3] = gamma[2];
#! true
MereExistenceOfUniqueSolutionOfHomogeneousLinearSystemInAbCategory(
                                  QQ_mat, alpha, beta );
#! false
B := BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory(
                                  QQ_mat, alpha, beta );;
Length( B );
#! 1
(1*7)/QQ * B[1][1] + (2*8)/QQ * B[1][2] + (3*9)/QQ * B[1][3] = 0/QQ * id_t;
#! true
(4*3)/QQ * B[1][1] + (5*4)/QQ * B[1][2] + (6*1)/QQ * B[1][3] = 0/QQ * id_t;
#! true
2*(11)*5 + 3*(12)*7 + 9*(13)*2;
#! 596
Add( alpha, [ 2/QQ * id_t, 3/QQ * id_t, 9/QQ * id_t ] );;
Add( beta, [ 5/QQ * id_t, 7/QQ * id_t, 2/QQ * id_t ] );;
Add( gamma, 596/QQ * id_t );;
MereExistenceOfSolutionOfLinearSystemInAbCategory(
                                  QQ_mat, alpha, beta, gamma );
#! true
MereExistenceOfUniqueSolutionOfLinearSystemInAbCategory(
                                  QQ_mat, alpha, beta, gamma );
#! true
x := SolveLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma );;
(1*7)/QQ * x[1] + (2*8)/QQ * x[2] + (3*9)/QQ * x[3] = gamma[1];
#! true
(4*3)/QQ * x[1] + (5*4)/QQ * x[2] + (6*1)/QQ * x[3] = gamma[2];
#! true
(2*5)/QQ * x[1] + (3*7)/QQ * x[2] + (9*2)/QQ * x[3] = gamma[3];
#! true
MereExistenceOfUniqueSolutionOfHomogeneousLinearSystemInAbCategory(
                                  QQ_mat, alpha, beta );
#! true
B := BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory(
                                  QQ_mat, alpha, beta );;
Length( B );
#! 0
alpha := [ [ 2/QQ * id_t, 3/QQ * id_t ] ];;
delta := [ [ 3/QQ * id_t, 3/QQ * id_t ] ];;
B := BasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory( alpha, delta );;
Length( B );
#! 1
mor1 := PreCompose( alpha[1][1], B[1][1] ) + PreCompose( alpha[1][2], B[1][2] );
#! <A morphism in Category of matrices over Q>
mor2 := PreCompose( B[1][1], delta[1][1] ) + PreCompose( B[1][2], delta[1][2] );
#! <A morphism in Category of matrices over Q>
mor1 = mor2;
#! true
#! @EndExample
