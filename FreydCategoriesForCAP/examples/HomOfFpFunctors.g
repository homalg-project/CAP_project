LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );;
R := HomalgFieldOfRationalsInSingular() * "x,y,z";
Rows_R := CategoryOfRows( R );
R1 := CategoryOfRowsObject( 1, Rows_R );
R3 := CategoryOfRowsObject( 3, Rows_R );
alpha := CategoryOfRowsMorphism( R3, HomalgMatrix( "[x,y,z]", 3, 1, R ), R1 );
M := FreydCategoryObject( alpha );

c0 := CovariantExtAsFreydCategoryObject( M, 0 );
c1 := CovariantExtAsFreydCategoryObject( M, 1 );
c2 := CovariantExtAsFreydCategoryObject( M, 2 );

HomomorphismStructureOnObjects( c0, c2 );
# = Ext^2( M, M )