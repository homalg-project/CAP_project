LoadPackage( "ModulePresentationsForHomalg" );

LoadPackage( "RingsForHomalg" );

## Initialisation

ZZ := HomalgRingOfIntegersInSingular( );

A1 := FreeLeftPresentation( 1, ZZ );

A2 := FreeLeftPresentation( 3, ZZ );

A3 := FreeLeftPresentation( 2, ZZ );

B1 := FreeLeftPresentation( 2, ZZ );

B2 := FreeLeftPresentation( 3, ZZ );

B3 := FreeLeftPresentation( 1, ZZ );

alpha1 := InDeductiveSystem( PresentationMorphism( A1, HomalgMatrix( [ [ 1, 0, 0 ] ], ZZ ), A2 ) );

alpha2 := InDeductiveSystem( PresentationMorphism( A2, HomalgMatrix( [ [ 0, 0 ], [ 1,  0 ], [ 0, 1 ] ], ZZ ), A3 ) );

beta1 := InDeductiveSystem( PresentationMorphism( B1, HomalgMatrix( [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], ZZ ), B2 ) );

beta2 := InDeductiveSystem( PresentationMorphism( B2, HomalgMatrix( [ [ 0 ], [ 0 ], [ 1 ] ], ZZ ), B3 ) );

gamma1 := InDeductiveSystem( PresentationMorphism( A1, HomalgMatrix( [ [ 1 , 0 ] ], ZZ ), B1 ) );

gamma2 := InDeductiveSystem( PresentationMorphism( A2, HomalgMatrix( [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], ZZ ), B2 ) );

gamma3 := InDeductiveSystem( PresentationMorphism( A3, HomalgMatrix( [ [ 0 ], [ 1 ] ], ZZ ), B3 ) );

SetIsAbelianCategory( HomalgCategory( alpha1 ), true );

c := SnakeLemmaConnectingHomomorphism( alpha2, gamma1, gamma2, gamma3, beta1 );

c_eval := Eval( c );

cl := ApplyFunctor( FunctorLessGeneratorsLeft( ZZ ), c_eval );


PrintHistory( c );

Display( cl );