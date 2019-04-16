#! @Chapter Examples and Tests

#! @Section Homomorphisms between f.p. functors based on category of rows

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );;

#! @Example
R := HomalgFieldOfRationalsInSingular() * "x,y,z";;
Rows_R := CategoryOfRows( R );;
R1 := CategoryOfRowsObject( 1, Rows_R );;
R3 := CategoryOfRowsObject( 3, Rows_R );;
alpha := CategoryOfRowsMorphism( R3, HomalgMatrix( "[x,y,z]", 3, 1, R ), R1 );;
M := FreydCategoryObject( alpha );;
c0 := CovariantExtAsFreydCategoryObject( M, 0 );;
c1 := CovariantExtAsFreydCategoryObject( M, 1 );;
c2 := CovariantExtAsFreydCategoryObject( M, 2 );;
IsZeroForObjects( HomomorphismStructureOnObjects( c0, c2 ) ); # = Ext^2( M, M )
#! false
#! @EndExample

#! @Section Homomorphisms between f.p. functors based on category of columns

#! @Example
R := HomalgFieldOfRationalsInSingular() * "x,y,z";;
Cols_R := CategoryOfColumns( R );;
R1 := CategoryOfColumnsObject( 1, Cols_R );;
R3 := CategoryOfColumnsObject( 3, Cols_R );;
alpha := CategoryOfColumnsMorphism( R3, HomalgMatrix( "[x,y,z]", 1, 3, R ), R1 );;
M := FreydCategoryObject( alpha );;
c0 := CovariantExtAsFreydCategoryObject( M, 0 );;
c1 := CovariantExtAsFreydCategoryObject( M, 1 );;
c2 := CovariantExtAsFreydCategoryObject( M, 2 );;
IsZeroForObjects( HomomorphismStructureOnObjects( c0, c2 ) ); # = Ext^2( M, M )
#! false
#! @EndExample
