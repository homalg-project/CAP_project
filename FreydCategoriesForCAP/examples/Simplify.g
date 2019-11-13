#! @Chapter Example on category of rows

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );

#####################################
#! @Section Simplifications
#####################################

#! @Example
R := HomalgRingOfIntegers();;
rows := CategoryOfRows( R );;
M := HomalgMatrix( [ [ 2, 2, 2 ], [ 3, 3, 3 ] ], 2, 3, R );;
alpha := AsCategoryOfRowsMorphism( M, rows );;
pi := PreCompose( [
    SimplifySourceAndRange_IsoFromInputSource( alpha, infinity ),
    SimplifySourceAndRange( alpha, infinity ),
    SimplifySourceAndRange_IsoToInputRange( alpha, infinity ) ] );;
IsCongruentForMorphisms( pi, alpha );
#! true
IsOne(
    PreCompose( SimplifySourceAndRange_IsoFromInputSource( alpha, infinity ), SimplifySourceAndRange_IsoToInputSource( alpha, infinity ) )
);
#! true
IsOne(
    PreCompose( SimplifySourceAndRange_IsoFromInputRange( alpha, infinity ), SimplifySourceAndRange_IsoToInputRange( alpha, infinity ) )
);
#! true
#! @EndExample

#! @Example
R := HomalgRingOfIntegers();;
cols := CategoryOfColumns( R );;
M := HomalgMatrix( [ [ 2, 2, 2 ], [ 3, 3, 3 ] ], 2, 3, R );;
alpha := AsCategoryOfColumnsMorphism( M, cols );;
pi := PreCompose( [
    SimplifySourceAndRange_IsoFromInputSource( alpha, infinity ),
    SimplifySourceAndRange( alpha, infinity ), 
    SimplifySourceAndRange_IsoToInputRange( alpha, infinity ) ] );;
IsCongruentForMorphisms( pi, alpha );
#! true
IsOne( 
    PreCompose( SimplifySourceAndRange_IsoFromInputSource( alpha, infinity ), SimplifySourceAndRange_IsoToInputSource( alpha, infinity ) )
);
#! true
IsOne( 
    PreCompose( SimplifySourceAndRange_IsoFromInputRange( alpha, infinity ), SimplifySourceAndRange_IsoToInputRange( alpha, infinity ) )
);
#! true
#! @EndExample