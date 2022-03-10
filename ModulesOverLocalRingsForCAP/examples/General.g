#! @Chapter Examples and Tests

#! @Section Gauss
LoadPackage( "ModulesOverLocalRingsForCAP" );

LoadPackage( "RingsForHomalg" );
#! @Example
Q := HomalgFieldOfRationalsInSingular();;
R := Q * "x,y";;
R := R / "x^2 - y";;
SetIsIntegralDomain( R, true );;
matrix := HomalgMatrix( "[x,0,0,0,y,0,0,0,x^2-y]", 3, 3, R );;
REFIndicesForMatricesOverIntegralDomain( matrix );
#! [ 1,2 ]
matrix := HomalgMatrix( "[1,1,1,1,1,1,1,1,1]", 3, 3, R );;
REFIndicesForMatricesOverIntegralDomain( matrix );
#! [ 1 ]
matrix := HomalgMatrix( "[0,0,0,0,0,0,0,0,0,0,0,0]", 3, 4, R );;
REFIndicesForMatricesOverIntegralDomain( matrix );
#! []
matrix := HomalgZeroMatrix( 0, 4, R );;
REFIndicesForMatricesOverIntegralDomain( matrix );
#! []
matrix := HomalgZeroMatrix( 4, 0, R );;
REFIndicesForMatricesOverIntegralDomain( matrix );
#! []
matrix := HomalgZeroMatrix( 0, 0, R );;
REFIndicesForMatricesOverIntegralDomain( matrix );
#! []
matrix := HomalgMatrix( "[x,y,x,y,y,x,x,x,x^2-y]", 3, 3, R );;
REFIndicesForMatricesOverIntegralDomain( matrix );
#! [ 1, 2, 3 ]
matrix := HomalgIdentityMatrix( 9, R );;
REFIndicesForMatricesOverIntegralDomain( matrix );
#! [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
#! @EndExample
