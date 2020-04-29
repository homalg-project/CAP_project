LoadPackage( "ToricSheaves" );

H7 := HirzebruchSurface( 7 );

CohH7 := CategoryOfToricSheaves( H7 );

S := CoxRing( H7 );

gen_degs := DegreesOfGenerators( IrrelevantIdeal( H7 ) );

## A module supported on the irrelevant locus
Mirr := AsGradedLeftPresentation( HomalgMatrix( "[x_1*x_2, x_1*x_3, x_2*x_4, x_3*x_4]", 4, 1, S ) );

SheafMirr := AsSerreQuotientCategoryObject( CohH7, Mirr );

Assert( 0, IsZero( SheafMirr ) );

MS := GradedFreeLeftPresentation( 1, S );

SheafS := AsSerreQuotientCategoryObject( CohH7, MS );
