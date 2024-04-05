LoadPackage( "ZXCalculusForCAP", false );

cat := CategoryOfZXDiagrams( : no_precompiled_code := true ); # true or false

m := ObjectConstructor( cat, 1 ); # 1, 125, 250, 500, 1000, 2000

id := IdentityMorphism( m );

ev := EvaluationForDual( m );
coev := CoevaluationForDual( m );

StartTimer( "comp" );
comp := PreCompose( TensorProductOnMorphisms( coev, id ), TensorProductOnMorphisms( id, ev ) );
DisplayTimer( "comp" );

Assert( 0, IsEqualForMorphisms( comp, id ) );
