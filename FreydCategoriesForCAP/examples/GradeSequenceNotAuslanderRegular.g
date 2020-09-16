#! @Chapter Examples and Tests

LoadPackage( "RingsForHomalg" );
LoadPackage( "FreydCategoriesForCAP" );;

#####################################
#! @Section Grade filtration
#####################################

#! The sequence of modules computed via satellites behaves in a way that is not understood
#! in the case when the ring is not Auslander regular.

#! @Example
R := HomalgFieldOfRationalsInSingular() * "x,y";;
R := R/"x*y"/"x^2";;
RowsR := CategoryOfRows( R );;
Freyd := FreydCategory( RowsR );;
mat := HomalgMatrix( "[x,y]", 1, 2, R );;
M := mat/Freyd;;
mu1 := GradeFiltrationNthMonomorphism( M, 1 );;
IsMonomorphism( mu1 );
#! true
IsZero( mu1 );
#! false
IsEpimorphism( mu1 );
#! false
mu2 := GradeFiltrationNthMonomorphism( M, 2 );;
IsIsomorphism( mu2 );
#! true
IsZero( mu2 );
#! false
mu3 := GradeFiltrationNthMonomorphism( M, 3 );;
IsIsomorphism( mu3 );
#! true
IsZero( mu3 );
#! false
mu4 := GradeFiltrationNthMonomorphism( M, 4 );;
IsMonomorphism( mu4 );
#! false
IsEpimorphism( mu4 );
#! true
IsZero( mu4 );
#! false
#! @EndExample
