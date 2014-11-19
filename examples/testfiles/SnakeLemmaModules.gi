LoadPackage( "ModulePresentationsForHomalg" );

LoadPackage( "RingsForHomalg" );

## Initialisation

ZZ := HomalgRingOfIntegersInSingular( );

F := FreeLeftPresentation( 2, ZZ );

alpha := PresentationMorphism( F, HomalgMatrix( [ [ 1, 1 ], [ 1, -1 ] ], ZZ ), F );

c := SnakeLemmaConnectingHomomorphism( alpha, alpha, alpha );