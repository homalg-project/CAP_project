LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "GeneralizedMorphismsForCAP" );
LoadPackage( "RingsForHomalg" );

## Initialisation

ZZ := HomalgRingOfIntegersInSingular( );

C1 := FreeLeftPresentation( 1, ZZ );

C2 := FreeLeftPresentation( 2, ZZ );

C3 := FreeLeftPresentation( 3, ZZ );

C4 := FreeLeftPresentation( 3, ZZ );

C5 := FreeLeftPresentation( 2, ZZ );

C6 := FreeLeftPresentation( 1, ZZ );

delta1 := PresentationMorphism( C1, HomalgMatrix( [ [ 1, 0 ] ], ZZ ), C2 );

delta2 := PresentationMorphism( C3, HomalgMatrix( [ [ 0, 0 ], [ 1,  0 ], [ 0, 1 ] ], ZZ ), C2 );

delta3 := PresentationMorphism( C3, HomalgMatrix( [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], ZZ ), C4 );

delta4 := PresentationMorphism( C5, HomalgMatrix( [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], ZZ ), C4 );

delta5 := PresentationMorphism( C5, HomalgMatrix( [ [ 0 ], [ 1 ] ], ZZ ), C6 );

cospan1 := GeneralizedMorphismWithRangeAid( delta1, delta2 );

cospan2 := GeneralizedMorphismWithRangeAid( delta3, delta4 );

delta5_generalized := AsGeneralizedMorphism( delta5 );

connecting_morphism := PreCompose( cospan1, cospan2 );

connecting_morphism := PreCompose( connecting_morphism, delta5_generalized );

c := AssociatedMorphism( connecting_morphism );

c := Evaluation( c );

c_less_generators := ApplyFunctor( FunctorLessGeneratorsLeft( ZZ ), c );

Display( UnderlyingMatrix( c_less_generators ) );

QUIT;

