LoadPackage( "HomologicalAlgebraForCAP" );

LoadPackage( "LinearAlgebraForCAP" );

Q := HomalgFieldOfRationals();

A := VectorSpaceObject( 2, Q );

CA := AsPointedCocomplex( A, 0 );

SetIsAbelianCategory( CapCategory( CA ), true );

CAA := AsPointedCocomplex( CA, 0 );

S := SpectralSequenceDifferential( CAA, 2, 0, 0 );
