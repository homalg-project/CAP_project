LoadPackage( "ActionsForCAP" );
Q := HomalgFieldOfRationals();

membership_function := IsInt;

equality_function := function( a, b ) return a = b; end;

lower_equal_function := function( a, b ) return a <= b; end;

semisimple_cat := SemisimpleCategory( Q, membership_function, lower_equal_function, equality_function );

s := SemisimpleCategoryObject( [ [ 3, 9 ], [ 4, 9 ], [ 10, 8 ], [ 2, 9 ] ], semisimple_cat );

SemisimpleObjectList( s );
#! [ [ 10, 8 ], [ 9, 9 ] ]
