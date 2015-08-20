LoadPackage( "ActionsForCAP" );

LoadPackage( "LinearAlgebraForCAP" );

Q := HomalgFieldOfRationals( );

category := MatrixCategory( Q );

u := TensorUnit( category );

a := VectorSpaceObject( 2, Q );

structure_morphism := LeftUnitor( a );

act_a := LeftActionObject( structure_morphism, u );

coact_a := RightCoactionObject( (-1) * RightUnitorInverse( a ), u );
