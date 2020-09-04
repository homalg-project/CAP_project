LoadPackage( "LinearAlgebraForCAP" );

Q := HomalgFieldOfRationals( );

a := VectorSpaceObject( 3, Q );

b := VectorSpaceObject( 4, Q );

homalg_matrix := HomalgMatrix( [ [ 1, 0, 0, 0 ], [ 0, 1, 0, -1 ], [ -1, 0, 2, 1 ] ], 3, 4, Q );

alpha := VectorSpaceMorphism( a, homalg_matrix, b );

homalg_matrix := HomalgMatrix( [ [ 1, 1, 0, 0 ], [ 0, 1, 0, -1 ], [ -1, 0, 2, 1 ] ], 3, 4, Q );

beta := VectorSpaceMorphism( a, homalg_matrix, b );
