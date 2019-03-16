#! @Chapter Examples and Tests

#! @Section Homomorphism structure

#! @Example
ReadPackage( "CAP", "examples/testfiles/FieldAsCategory.gi" );;
Q := HomalgFieldOfRationals();;
Qoid := FieldAsCategory( Q );;
a := FieldAsCategoryMorphism( 1/2, Qoid );;
b := FieldAsCategoryMorphism( -2/3, Qoid );;
u := FieldAsCategoryUniqueObject( Qoid );;
IsCongruentForMorphisms( a,
    InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism(
        u,u,
        InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( 
            a
        )
    )
);
#! true
c := FieldAsCategoryMorphism( 3, Qoid );;
d := FieldAsCategoryMorphism( 0, Qoid );;
left_coeffs := [ [ a, b ], [ c, d ] ];;
right_coeffs := [ [ PreCompose( a, b ), PreCompose( b, c ) ], [ c, PreCompose( a, a ) ] ];;
right_side := [ a, b ];;
solution := 
    SolveLinearSystemInAbCategory(
    left_coeffs,
    right_coeffs,
    right_side
);;
ForAll( [ 1, 2 ], i ->
    IsCongruentForMorphisms(
        Sum( List( [ 1, 2 ], j -> PreCompose( [ left_coeffs[i][j], solution[j], right_coeffs[i][j] ] ) ) ),
        right_side[i]
    )
);
#! true
Lift( c, d );
#! fail
Lift( d, c );
#! 0
Colift( c, d );
#! 0
Colift( d, c );
#! fail
#! @EndExample
