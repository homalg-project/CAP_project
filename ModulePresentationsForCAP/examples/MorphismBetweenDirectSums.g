LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "RingsForHomalg" );

zz := HomalgRingOfIntegersInSingular( );

A := FreeLeftPresentation( 2, zz );

B := FreeLeftPresentation( 1, zz );

C := FreeLeftPresentation( 2, zz );
 
D := AsLeftPresentation( HomalgMatrix( [ [ 1, -1 ] ], zz ) );

alpha := PresentationMorphism( A, HomalgMatrix( [ [ 1, -1 ], [ 0, 1 ] ], zz ), C );

beta := PresentationMorphism( A, HomalgMatrix( [ [ 1, 0 ], [ 0, 1 ] ], zz ), D );

gamma := PresentationMorphism( B, HomalgMatrix( [ [ 1, 0 ] ], zz ) , C );

delta := PresentationMorphism( B, HomalgMatrix( [ [ 1, -1 ] ], zz ), D );

Display( UnderlyingMatrix( MorphismBetweenDirectSums( [ [ alpha, beta ], [ gamma, delta ] ] ) ) );

