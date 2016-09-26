LoadPackage( "ToricSheaves" );

F := Fan( [ [ 0, 1 ], [ 1, 0 ], [ -1, -2 ] ], [ [ 1, 2 ], [ 2, 3 ], [ 1, 3 ] ] );

P112 := ToricVariety( F );

CohP112 := CategoryOfToricSheaves( P112 );

S := CoxRing( P112 );

M := HomalgMatrix( "[ x_2, x_3 ]", 2, 1, S );

M := AsGradedLeftPresentation( M, [ - GeneratingElements( DegreeGroup( S ) )[ 1 ] ] );

SheafM := AsSerreQuotientCategoryObject( CohP112, M );
