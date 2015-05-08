if not IsBound( VectorSpacesConstructorsLoaded ) then

  ReadPackage( "CAP", "examples/testfiles/VectorSpacesConstructors.gi" );;

fi;


vecspaces := CreateCapCategory( "VectorSpacesForSpectralSequenceTest" );

ReadPackage( "CAP", "examples/testfiles/VectorSpacesAllMethods.gi" );

LoadPackage( "HomologicalAlgebraForCAP" );

A := QVectorSpace( 2 );

CA := AsPointedCocomplex( A, 0 );

SetIsAbelianCategory( CapCategory( CA ), true );

CAA := AsPointedCocomplex( CA, 0 );

S := SpectralSequenceDifferential( CAA, 2, 0, 0 );