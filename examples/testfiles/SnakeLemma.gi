LoadPackage( "ModulePresentationsForHomalg" );

LoadPackage( "RingsForHomalg" );

ZZ := HomalgRingOfIntegersInSingular( );

F := FreeLeftPresentation( 1, ZZ );

mor := PresentationMorphism( F, HomalgMatrix( [ [ 1 ] ], ZZ ), F );

F := InDeductiveSystem( F );

mor := InDeductiveSystem( mor );

SetIsAbelianCategory( HomalgCategory( F ), true );

c := SnakeLemmaConnectingHomomorphism( mor, mor, mor, mor, mor );