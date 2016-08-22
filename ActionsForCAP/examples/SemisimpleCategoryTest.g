LoadPackage( "ActionsForCAP" );
Q := HomalgFieldOfRationals();

membership_function := IsInt;

semisimple_cat := SemisimpleCategory( Q, membership_function );

s := SemisimpleCategoryObject( [ [ 3, 9 ], [ 4, 9 ], [ 10, 8 ], [ 2, 9 ] ], semisimple_cat );

SemisimpleCategoryObjectList( s );
#! [ [ 10, 8 ], [ 9, 9 ] ]

a := SemisimpleCategoryObject( [ [ 1, 0 ], [ 1, 1 ] ], semisimple_cat );

b := SemisimpleCategoryObject( [ [ 2, 1 ], [ 2, 3 ] ], semisimple_cat );

c := SemisimpleCategoryObject( [ [ 4, 0 ], [ 1, 1 ], [ 4, 2 ] ], semisimple_cat );

## creation of mor
alpha := VectorSpaceMorphism( VectorSpaceObject( 1, Q ), HomalgMatrix( [ [ 1, -1 ] ] ,1, 2, Q ), VectorSpaceObject( 2, Q ) );

zero1_0 := UniversalMorphismIntoZeroObject( VectorSpaceObject( 1, Q ) );

zero0_2 := UniversalMorphismFromZeroObject( VectorSpaceObject( 2, Q ) );

mor := SemisimpleCategoryMorphism( a, [ [ zero1_0, 0 ], [ alpha, 1 ], [ zero0_2, 3 ] ], b );

## creation of mor2
beta := VectorSpaceMorphism( VectorSpaceObject( 2, Q ), HomalgMatrix( [ [ 2 ], [ 3 ] ], 2, 1, Q ), VectorSpaceObject( 1, Q ) );

zero0_4 := UniversalMorphismFromZeroObject( VectorSpaceObject( 4, Q ) );

zero2_0 := UniversalMorphismIntoZeroObject( VectorSpaceObject( 2, Q ) );

mor2 := SemisimpleCategoryMorphism( b, [ [ zero0_4, 0 ], [ beta, 1 ], [ zero0_4, 2 ], [ zero2_0, 3 ] ], c );
