LoadPackage( "ActionsForCAP" );
Q := HomalgFieldOfRationals();

membership_function := IsInt;

equality_function := function( a, b ) return a = b; end;

lower_equal_function := function( a, b ) return a <= b; end;

semisimple_cat := SemisimpleCategory( Q, membership_function, lower_equal_function, equality_function );

s := SemisimpleCategoryObject( [ [ 3, 9 ], [ 4, 9 ], [ 10, 8 ], [ 2, 9 ] ], semisimple_cat );

SemisimpleCategoryObjectList( s );
#! [ [ 10, 8 ], [ 9, 9 ] ]

a := SemisimpleCategoryObject( [ [ 1, 0 ] ], semisimple_cat );

b := SemisimpleCategoryObject( [ [ 2, 0 ] ], semisimple_cat );

alpha := VectorSpaceMorphism( VectorSpaceObject( 1, Q ), HomalgMatrix( [ [ 1, -1 ] ] ,1, 2, Q ), VectorSpaceObject( 2, Q ) );

mor := SemisimpleCategoryMorphism( a, [ [ alpha, 0 ] ], b );