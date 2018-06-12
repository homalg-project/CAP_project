LoadPackage( "ComplexesAndFilteredObjectsForCAP" );
LoadPackage( "GradedModulePresentations" );

S := GradedRing( HomalgFieldOfRationalsInSingular( )*"x,y,z" );
SetWeightsOfIndeterminates( S, [ 1, 1, 0 ] );

M := GradedFreeRightPresentation( 3, S, [ 3, 1, 2 ] );
N := GradedFreeRightPresentation( 2, S, [ 1, 0] );

m := HomalgMatrix( "[ [ 2*x^2+4*x*y, 0, 4*x ], [ -2*x^3-x^2*y+x*y^2+2*y^3, 2*x+y, 4*x^2-2*x*y+2*y^2 ] ]", 2, 3, S );
f := GradedPresentationMorphism( M, m, N );

IsWellDefined( f );
IsMonomorphism( f );
IsEpimorphism( f );

T := AsGradedRightPresentation( m, [ 1, 0 ] );
IsWellDefined( T );
