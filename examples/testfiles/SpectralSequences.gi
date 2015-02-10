if not IsBound( VectorSpacesConstructorsLoaded ) then

  ReadPackage( "CategoriesForHomalg", "examples/testfiles/VectorSpacesConstructors.gi" );;

fi;


vecspaces := CreateCapCategory( "VectorSpacesForSpectralSequenceTest" );

ReadPackage( "CategoriesForHomalg", "examples/testfiles/VectorSpacesAllMethods.gi" );

A := QVectorSpace( 2 );

CA := AsPointedCocomplex( A, 0 );

SetIsAbelianCategory( CapCategory( CA ), true );

CAA := AsPointedCocomplex( CA, 0 );

S := SpectralSequenceDifferential( CAA, 2, 0, 0 );