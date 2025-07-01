#! @Chapter Example on category of rows

LoadPackage( "RingsForHomalg" );
LoadPackage( "AdditiveClosuresForCAP" );;

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
pi2 := PreCompose(
    SimplifySource_IsoFromInputObject( alpha, infinity ),
    SimplifySource( alpha, infinity )
);;
IsCongruentForMorphisms( pi2, alpha );
#! true
IsOne( PreCompose( SimplifySource_IsoFromInputObject( alpha, infinity ), SimplifySource_IsoToInputObject( alpha, infinity ) ) );
#! true
pi3 := PreCompose(
    SimplifyRange( alpha, infinity ),
    SimplifyRange_IsoToInputObject( alpha, infinity )
);;
IsCongruentForMorphisms( pi3, alpha );
#! true
IsOne( PreCompose( SimplifyRange_IsoFromInputObject( alpha, infinity ), SimplifyRange_IsoToInputObject( alpha, infinity ) ) );
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
pi2 := PreCompose(
    SimplifySource_IsoFromInputObject( alpha, infinity ),
    SimplifySource( alpha, infinity )
);;
IsCongruentForMorphisms( pi2, alpha );
#! true
IsOne( PreCompose( SimplifySource_IsoFromInputObject( alpha, infinity ), SimplifySource_IsoToInputObject( alpha, infinity ) ) );
#! true
pi3 := PreCompose(
    SimplifyRange( alpha, infinity ),
    SimplifyRange_IsoToInputObject( alpha, infinity )
);;
IsCongruentForMorphisms( pi3, alpha );
#! true
IsOne( PreCompose( SimplifyRange_IsoFromInputObject( alpha, infinity ), SimplifyRange_IsoToInputObject( alpha, infinity ) ) );
#! true
#! @EndExample

