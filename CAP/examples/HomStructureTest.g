#! @Chapter Examples and Tests

#! @Section Homomorphism structure

#! @Example
ReadPackage( "CAP", "examples/FieldAsCategory.g" );;
Q := HomalgFieldOfRationals();;
Qoid := FieldAsCategory( Q );;
a := FieldAsCategoryMorphism( Qoid, 1/2 );;
b := FieldAsCategoryMorphism( Qoid, -2/3 );;
u := FieldAsCategoryUniqueObject( Qoid );;
IsCongruentForMorphisms( a,
    InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
        u,u,
        InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure(
            a
        )
    )
);
#! true
a = HomStructure( u, u, HomStructure( a ) );
#! true
IsEqualForObjects( HomStructure( Qoid ), DistinguishedObjectOfHomomorphismStructure( Qoid ) );
#! true
c := FieldAsCategoryMorphism( Qoid, 3 );;
d := FieldAsCategoryMorphism( Qoid, 0 );;
left_coeffs := [ [ a, b ], [ c, d ] ];;
right_coeffs := [ [ PreCompose( a, b ), PreCompose( b, c ) ], [ c, PreCompose( a, a ) ] ];;
right_side := [ a, b ];;
MereExistenceOfSolutionOfLinearSystemInAbCategory( left_coeffs, right_coeffs, right_side );
#! true
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

IsLiftable( c, d );
#! false
LiftOrFail( c, d );
#! fail
IsLiftable( d, c );
#! true
LiftOrFail( d, c );
#! 0
Lift( d, c );
#! 0

IsColiftable( c, d );
#! true
ColiftOrFail( c, d );
#! 0
Colift( c, d );
#! 0
IsColiftable( d, c );
#! false
ColiftOrFail( d, c );
#! fail

#! @EndExample
