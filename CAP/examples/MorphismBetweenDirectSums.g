LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "RingsForHomalg" );

ZZ := HomalgRingOfIntegersInSingular( );

A := FreeLeftPresentation( 2, ZZ );

B := FreeLeftPresentation( 1, ZZ );

C := FreeLeftPresentation( 2, ZZ );
 
D := AsLeftPresentation( HomalgMatrix( [ [ 1, -1 ] ], ZZ ) );

alpha := PresentationMorphism( A, HomalgMatrix( [ [ 1, -1 ], [ 0, 1 ] ], ZZ ), C );

beta := PresentationMorphism( A, HomalgMatrix( [ [ 1, 0 ], [ 0, 1 ] ], ZZ ), D );

gamma := PresentationMorphism( B, HomalgMatrix( [ [ 1, 0 ] ], ZZ ) , C );

delta := PresentationMorphism( B, HomalgMatrix( [ [ 1, -1 ] ], ZZ ), D );

Display( UnderlyingMatrix( MorphismBetweenDirectSums( [ [ alpha, beta ], [ gamma, delta ] ] ) ) );

