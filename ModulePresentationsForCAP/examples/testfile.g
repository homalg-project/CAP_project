LoadPackage( "ModulePresentationsForCAP" );
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


#########################
##
## Cokernel
##
#########################

A := AsLeftPresentation( HomalgZeroMatrix( 0, 1, ZZ ) );
phi := HomalgMatrix( [ [ 4 ] ], ZZ );

phi := PresentationMorphism( A, phi, A );

epsilon := CokernelProjection( phi );

tau := HomalgMatrix( [ [ 2 ] ], ZZ );
B := AsLeftPresentation( HomalgMatrix( [ [ 8 ] ], ZZ ) );
tau := PresentationMorphism( A, tau, B );



