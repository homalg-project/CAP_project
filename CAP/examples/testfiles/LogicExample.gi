## Create the category of rational vector spaces

if not IsBound( VectorSpacesConstructorsLoaded ) then

  ReadPackage( "CAP", "examples/testfiles/VectorSpacesConstructors.gi" );;

fi;

vecspaces := CreateCapCategory( "vecspaces" );
ReadPackage( "CAP", "examples/testfiles/VectorSpacesAllMethods.gi" );

## create example input

A := QVectorSpace( 2 );
B := QVectorSpace( 2 );
alpha := VectorSpaceMorphism( A, [ [ 1, 1 ], [ 1, -1 ] ], A );
A := InDeductiveSystem( A );
B := InDeductiveSystem( B );
alpha := InDeductiveSystem( alpha );

## operations

# k := KernelEmbedding( alpha );

k := alpha;

P := DirectProduct( A, A );

pi := ProjectionInFactor( P, 1 );

F := FiberProduct( k, pi );

pr := ProjectionInFactor( F, 2 );

k2 := KernelObject( pr );

P2 := DirectProduct( k2, k2, k2 );

HasIsZero( P2 );
