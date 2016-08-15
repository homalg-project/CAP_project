LoadPackage( "ToricSheaves" );

H7 := HirzebruchSurface( 7 );

CohH7 := CategoryOfToricSheaves( H7 );

S := CoxRing( H7 );

Mirr := HomalgMatrix( "[x_3*x_4,x_1*x_4,x_1*x_2,x_2*x_3]",1,4,S );

gen_degs := DegreesOfGenerators( IrrelevantIdeal( H7 ) );

Irrel := AsGradedLeftPresentation( Mirr, -gen_degs );

SheafIrrel := AsSerreQuotientCategoryObject( CohH7, Irrel );
