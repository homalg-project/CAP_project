LoadPackage( "ComplexesAndFilteredObjectsForCAP" );
LoadPackage( "GradedModulePresentations" );

S := GradedRing( HomalgFieldOfRationalsInSingular( )*"x,y,z" );
SetWeightsOfIndeterminates( S, [ 1, 1, 0 ] );

M := GradedFreeLeftPresentation( 2, S, [ 1, 2 ] );
N := GradedFreeLeftPresentation( 3, S, [ 0, -1, -2 ] );

m := HomalgMatrix( "[ [ x, x*y-y^2, x^3-y^3 ], [ -x^2-2*x*y, x*y^2-y^3, 3*x*y^3 ] ]", 2, 3, S );
f := GradedPresentationMorphism( M, m, N );

IsWellDefined( f );
IsMonomorphism( f );
IsEpimorphism( f );

T := AsGradedLeftPresentation( m, [ 0, -1, -2 ] );
GeneratorDegrees( T );
IsWellDefined( T );
