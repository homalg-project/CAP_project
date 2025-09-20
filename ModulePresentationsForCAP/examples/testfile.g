LoadPackage( "ModulePresentationsForCAP" );
zz := HOMALG_MATRICES.ZZ;
LeftPresentations( zz );
RightPresentations( zz );
A := HomalgMatrix( [ [ 1, 2 ], [ 2, 3 ] ], zz );
Aleft := AsLeftPresentation( A );
Aright := AsRightPresentation( A );
B := HomalgMatrix( [ [ 1, 2 ] ], zz );
Bleft := AsLeftPresentation( B );
Bright := AsRightPresentation( B );
tau := HomalgMatrix( [ [ 1, 0 ], [ 0, 1 ] ], zz );


#########################
##
## Cokernel
##
#########################

A := AsLeftPresentation( HomalgZeroMatrix( 0, 1, zz ) );
phi := HomalgMatrix( [ [ 4 ] ], zz );

phi := PresentationMorphism( A, phi, A );

epsilon := CokernelProjection( phi );

tau := HomalgMatrix( [ [ 2 ] ], zz );
B := AsLeftPresentation( HomalgMatrix( [ [ 8 ] ], zz ) );
tau := PresentationMorphism( A, tau, B );



