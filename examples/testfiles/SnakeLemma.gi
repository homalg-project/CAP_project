## Create the category of rational vector spaces

if not IsBound( VectorSpacesConstructorsLoaded ) then

  ReadPackage( "CategoriesForHomalg", "examples/testfiles/VectorSpacesConstructors.gi" );;

fi;

vecspaces := CreateHomalgCategory( "vecspaces" );
ReadPackage( "CategoriesForHomalg", "examples/testfiles/VectorSpacesAllMethods.gi" );

## create example input

A1 := QVectorSpace( 1 );

A2 := QVectorSpace( 2 );

B := QVectorSpace( 3 );

alpha1 := VectorSpaceMorphism( A1, [ 1, 0, 0 ], B );

alpha2 := VectorSpaceMorphism( A2, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], B );

alpha1 := InDeductiveSystem( alpha1 );

alpha2 := InDeductiveSystem( alpha2 );

B := InDeductiveSystem( B );

SetIsAbelianCategory( HomalgCategory( alpha1 ), true );

##

cokernel_proj_1 := CokernelProj( alpha1 );

identity_B := IdentityMorphism( B );

c := SnakeLemmaConnectingHomomorphism( cokernel_proj_1, identity_B, alpha2 );