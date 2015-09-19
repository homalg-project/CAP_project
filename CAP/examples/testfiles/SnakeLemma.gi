## Create the category of rational vector spaces

if not IsBound( VectorSpacesConstructorsLoaded ) then

  ReadPackage( "CAP", "examples/testfiles/VectorSpacesConstructors.gi" );;

fi;

vecspaces := CreateCapCategory( "vecspaces" );
ReadPackage( "CAP", "examples/testfiles/VectorSpacesAllMethods.gi" );

LoadPackage( "HomologicalAlgebraForCAP" );

## create example input

A1_eval := QVectorSpace( 1 );

A2_eval := QVectorSpace( 2 );

B_eval := QVectorSpace( 3 );

alpha1_eval := VectorSpaceMorphism( A1_eval, [ 1, 0, 0 ], B_eval );

alpha2_eval := VectorSpaceMorphism( A2_eval, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], B_eval );

alpha1 := InDeductiveSystem( alpha1_eval );

alpha2 := InDeductiveSystem( alpha2_eval );

B := InDeductiveSystem( B_eval );

SetIsAbelianCategory( CapCategory( alpha1 ), true );

##

cokernel_proj_1 := CokernelProjection( alpha1 );

identity_B := IdentityMorphism( B );

c := SnakeLemmaConnectingHomomorphismWithKernelAndCokernel( cokernel_proj_1, identity_B, alpha2 );