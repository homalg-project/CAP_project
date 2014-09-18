LoadPackage( "ModulePresentationsForHomalg" );
ZZ := HOMALG_MATRICES.ZZ;
LeftPresentations( ZZ );
RightPresentations( ZZ );
A := HomalgMatrix( [ [ 1, 2 ], [ 2, 3 ] ], ZZ );
Aleft := AsLeftPresentation( A );
Aright := AsRightPresentation( A );
B := HomalgMatrix( [ [ 1, 2 ] ], ZZ );
Bleft := AsLeftPresentation( B );
Bright := AsRightPresentation( B );
tau := HomalgMatrix( [ [ 1, 0 ], [ 0, 1 ] ], ZZ );


