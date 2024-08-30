LoadPackage( "LinearAlgebraForCAP" );

Q := HomalgFieldOfRationals( );

vec := MatrixCategory( Q );

V := MatrixCategoryObject( vec, 1 );

W := MatrixCategoryObject( vec, 2 );

alpha := VectorSpaceMorphism( V, HomalgMatrix( [ [ 1, 0 ] ], Q ), W );

vecspaces := CapCategory( V );
