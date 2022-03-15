LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "GeneralizedMorphismsForCAP" );
LoadPackage( "RingsForHomalg" );

## Initialisation

ZZ := HomalgRingOfIntegersInSingular( );

C1_eval := FreeLeftPresentation( 1, ZZ );
C1 := InDeductiveSystem( C1_eval );

C2_eval := FreeLeftPresentation( 2, ZZ );
C2 := InDeductiveSystem( C2_eval );

C3_eval := FreeLeftPresentation( 3, ZZ );
C3 := InDeductiveSystem( C3_eval );

C4_eval := FreeLeftPresentation( 3, ZZ );
C4 := InDeductiveSystem( C4_eval );

C5_eval := FreeLeftPresentation( 2, ZZ );
C5 := InDeductiveSystem( C5_eval );

C6_eval := FreeLeftPresentation( 1, ZZ );
C6 := InDeductiveSystem( C6_eval );

delta1_eval := PresentationMorphism( C1_eval, HomalgMatrix( [ [ 1, 0 ] ], ZZ ), C2_eval );
delta1 := InDeductiveSystem( delta1_eval );

delta2_eval := PresentationMorphism( C3_eval, HomalgMatrix( [ [ 0, 0 ], [ 1,  0 ], [ 0, 1 ] ], ZZ ), C2_eval );
delta2 := InDeductiveSystem( delta2_eval );

delta3_eval := PresentationMorphism( C3_eval, HomalgMatrix( [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], ZZ ), C4_eval );
delta3 := InDeductiveSystem( delta3_eval );

delta4_eval := PresentationMorphism( C5_eval, HomalgMatrix( [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], ZZ ), C4_eval );
delta4 := InDeductiveSystem( delta4_eval );

delta5_eval := PresentationMorphism( C5_eval, HomalgMatrix( [ [ 0 ], [ 1 ] ], ZZ ), C6_eval );
delta5 := InDeductiveSystem( delta5_eval );


SetIsAbelianCategory( CapCategory( delta1 ), true );


delta1_generalized := AsGeneralizedMorphism( delta1 );

delta2_generalized := AsGeneralizedMorphism( delta2 );

delta3_generalized := AsGeneralizedMorphism( delta3 );

delta4_generalized := AsGeneralizedMorphism( delta4 );

delta5_generalized := AsGeneralizedMorphism( delta5 );


connecting_morphism := delta1_generalized;

connecting_morphism := PreCompose( connecting_morphism, PseudoInverse( delta2_generalized ) );

connecting_morphism := PreCompose( connecting_morphism, delta3_generalized );

connecting_morphism := PreCompose( connecting_morphism, PseudoInverse( delta4_generalized ) );

connecting_morphism := PreCompose( connecting_morphism, delta5_generalized );

c := AssociatedMorphism( connecting_morphism );

c_eval := Evaluation( c );

c_eval_less_generators := ApplyFunctor( FunctorLessGeneratorsLeft( ZZ ), c_eval );

Display( UnderlyingMatrix( c_eval_less_generators ) );


