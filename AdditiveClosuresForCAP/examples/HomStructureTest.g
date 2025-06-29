#! @Chapter Examples and Tests

#! @Section Homomorphism structure

#! @Example
LoadPackage( "RingsForHomalg", false );
#! true
LoadPackage( "AdditiveClosuresForCAP", false );
#! true
EEE := KoszulDualRing( HomalgFieldOfRationalsInSingular( ) * "x,y" );;
Eoid := RingAsCategory( EEE );;
a := RingAsCategoryMorphism( Eoid, 1/2 );;
b := RingAsCategoryMorphism( Eoid, -2/3 );;
u := RingAsCategoryUniqueObject( Eoid );;
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
IsEqualForObjects( HomStructure( Eoid ), DistinguishedObjectOfHomomorphismStructure( Eoid ) );
#! true
c := RingAsCategoryMorphism( Eoid, 3 );;
d := RingAsCategoryMorphism( Eoid, 0 );;
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
#! <0>
Lift( d, c );
#! <0>

IsColiftable( c, d );
#! true
ColiftOrFail( c, d );
#! <0>
Colift( c, d );
#! <0>
IsColiftable( d, c );
#! false
ColiftOrFail( d, c );
#! fail

#! @EndExample
