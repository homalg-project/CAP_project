#! @Chapter Examples and Tests

#! @Section Cokernel image closure 

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );

#! @Example
R := HomalgFieldOfRationalsInSingular() * "x,y,z";
RowsR := CategoryOfRows( R );
m := AsCategoryOfRowsMorphism( 
    HomalgMatrix( "[[x],[y],[z]]", 3, 1, R )
);
mu := AsCokernelImageClosureMorphism( m );
#! @EndExample