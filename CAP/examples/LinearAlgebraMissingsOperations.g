LoadPackage( "LinearAlgebraForCAP" );

Q := HomalgFieldOfRationals( );

V := VectorSpaceObject( 1, Q );

W := VectorSpaceObject( 2, Q );

alpha := VectorSpaceMorphism( V, HomalgMatrix( [ [ 1, 0 ] ], Q ), W );

vecspaces := CapCategory( V );
