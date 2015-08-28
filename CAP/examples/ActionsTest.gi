LoadPackage( "ActionsForCAP" );

LoadPackage( "LinearAlgebraForCAP" );

Q := HomalgFieldOfRationals( );

category := MatrixCategory( Q );

u := TensorUnit( category );

a := VectorSpaceObject( 2, Q );

structure_morphism := VectorSpaceMorphism( TensorProductOnObjects( u, a ), 
                                           HomalgMatrix( [ [ 0, 1 ], [ -1, 0 ] ], 2, 2, Q ),
                                           a );

act_a := LeftActionObject( structure_morphism, u );

coact_a := RightCoactionObject( (-1) * RightUnitorInverse( a ), u );

mor_1 := ActionMorphism( act_a, IdentityMorphism( a ), act_a );
