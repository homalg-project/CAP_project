## Create the category of rational vector spaces

if not IsBound( VectorSpacesConstructorsLoaded ) then

  ReadPackage( "CategoriesForHomalg", "examples/testfiles/VectorSpacesConstructors.gi" );;

fi;

vecspaces := CreateHomalgCategory( "vecspaces" );
ReadPackage( "CategoriesForHomalg", "examples/testfiles/VectorSpacesAllMethods.gi" );

## create example input

A := QVectorSpace( 3 );
B := QVectorSpace( 2 );
alpha := VectorSpaceMorphism( A, [ [ 1, 1 ], [ 1, -1 ], [ 1, 2 ] ], B );
A := InDeductiveSystem( A );
B := InDeductiveSystem( B );
alpha := InDeductiveSystem( alpha );

## operations

k := KernelEmb( alpha );

P := DirectProduct( A, A );

pi := ProjectionInFactor( P, 1 );

F := FiberProduct( k, pi );

pr := ProjectionInFactor( F, 2 );

k2 := KernelObject( pr );

P2 := DirectProduct( k2, k2, k2 );

HasIsZero( P2 );
