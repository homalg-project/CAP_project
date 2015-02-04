LoadPackage( "ModulePresentationsForHomalg" );

LoadPackage( "RingsForHomalg" );

## Initialisation

ZZ := HomalgRingOfIntegersInSingular( );

C1 := FreeLeftPresentation( 1, ZZ );

C2 := FreeLeftPresentation( 2, ZZ );

C3 := FreeLeftPresentation( 3, ZZ );

C4 := FreeLeftPresentation( 3, ZZ );

C5 := FreeLeftPresentation( 2, ZZ );

C6 := FreeLeftPresentation( 1, ZZ );

delta1_eval := PresentationMorphism( C1, HomalgMatrix( [ [ 1, 0 ] ], ZZ ), C2 );
delta1 := InDeductiveSystem( delta1_eval );

delta2_eval := PresentationMorphism( C3, HomalgMatrix( [ [ 0, 0 ], [ 1,  0 ], [ 0, 1 ] ], ZZ ), C2 );
delta2 := InDeductiveSystem( delta2_eval );

delta3_eval := PresentationMorphism( C3, HomalgMatrix( [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], ZZ ), C4 );
delta3 := InDeductiveSystem( delta3_eval );

delta4_eval := PresentationMorphism( C5, HomalgMatrix( [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], ZZ ), C4 );
delta4 := InDeductiveSystem( delta4_eval );

delta5_eval := PresentationMorphism( C5, HomalgMatrix( [ [ 0 ], [ 1 ] ], ZZ ), C6 );
delta5 := InDeductiveSystem( delta5_eval );


SetIsAbelianCategory( CapCategory( delta1 ), true );



cospan1 := GeneralizedMorphismWithRangeAid( delta1, delta2 );

cospan2 := GeneralizedMorphismWithRangeAid( delta3, delta4 );

delta5 := AsGeneralizedMorphism( delta5 );

connecting_morphism := PreCompose( cospan1, cospan2 );

connecting_morphism := PreCompose( connecting_morphism, delta5 );

c := AssociatedMorphism( connecting_morphism );

c_eval := Evaluation( c );

c_eval_less_generators := ApplyFunctor( FunctorLessGeneratorsLeft( ZZ ), c_eval );

Display( UnderlyingMatrix( c_eval_less_generators ) );

