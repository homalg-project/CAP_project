LoadPackage( "GradedModulePresentationsForCAP" );
LoadPackage( "HomologicalAlgebraForCAP" );

Q := HomalgFieldOfRationalsInSingular();
R := Q["x,y"];
S := GradedRing( R );
weights := WeightsOfIndeterminates( S );
eins := weights[1];
M := HomalgMatrix( "[x^2,xy,y^2]", 3, 1, S );
XX := GradedFreeLeftPresentation( 1, S );
S0 := GradedFreeLeftPresentation( 1, S );
S1 := GradedFreeLeftPresentation( 3, S, [ 2*eins, 2*eins, 2*eins ] );
alpha := GradedPresentationMorphism( S1, M, S0 );
M := CokernelObject( alpha );

SetIsAdditiveCategory( CocomplexCategory( CapCategory( S0 ) ), true );
SetIsAdditiveCategory( ComplexCategory( CapCategory( S0 ) ), true );

M := DirectSum( [ M, S0 ] );

res := FreeResolutionComplex( M );
res := res[ 1 ];
homres := DualOnComplex( res );
CE := CartanEilenbergResolution( homres, FreeResolutionCocomplex );
homCE := DualOnCocomplexCocomplex( CE );
