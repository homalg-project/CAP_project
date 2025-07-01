#! @Chapter Examples and Tests

#! @Section Tests

#! @Example
LoadPackage( "AdditiveClosuresForCAP", false );
#! true
R := HomalgRingOfIntegers( ) ;;
cat := CategoryOfColumns( R );;
A := RandomObjectByInteger( cat, 2 );;
B := RandomObjectByInteger( cat, 2 );;
mor1 := RandomMorphismByInteger( cat, 2 );;
mor2 := RandomMorphismWithFixedSourceByInteger( cat, CategoryOfColumnsObject( cat, 3 ), 2 );;
mor3 := RandomMorphismWithFixedRangeByInteger( cat, CategoryOfColumnsObject( cat, 3 ), 2 );;
mor4 := RandomMorphismWithFixedSourceAndRangeByInteger( cat, CategoryOfColumnsObject( cat, 3 ), CategoryOfColumnsObject( cat, 4 ), 2 );;
RankOfObject( Source( mor2 ) ) = 3;
#! true
RankOfObject( Range( mor3 ) ) = 3;
#! true
RankOfObject( Source( mor4 ) ) = 3;
#! true
RankOfObject( Range( mor4 ) ) = 4;
#! true

#! @EndExample
