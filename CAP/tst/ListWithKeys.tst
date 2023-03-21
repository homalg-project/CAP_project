gap> START_TEST( "ListWithKeys" );

#
gap> LoadPackage( "CAP", false );
true

#
gap> ListWithKeys( [ 9, 8, 7 ], { key, value } -> [ key, value ] ) = [ [ 1, 9 ], [ 2, 8 ], [ 3, 7 ] ];
true
gap> SumWithKeys( [ ], { key, value } -> key + value );
0
gap> SumWithKeys( [ 9, 8, 7 ], { key, value } -> key + value );
30
gap> ProductWithKeys( [ ], { key, value } -> key * value );
1
gap> ProductWithKeys( [ 9, 8, 7 ], { key, value } -> key * value );
3024
gap> ForAllWithKeys( [ 9, 8, 7 ], { key, value } -> [ 9, 8, 7 ][key] = value );
true
gap> ForAllWithKeys( [ 9, 8, 7 ], { key, value } -> key = 1 or value = 8 );
false
gap> ForAnyWithKeys( [ 9, 8, 7 ], { key, value } -> [ 9, 8, 7 ][key] <> value );
false
gap> ForAnyWithKeys( [ 9, 8, 7 ], { key, value } -> key = 3 and value = 7 );
true
gap> NumberWithKeys( [ 9, 8, 7 ], { key, value } -> key = 1 or value = 8 );
2
gap> FilteredWithKeys( [ 9, 8, 7 ], { key, value } -> key = 1 or value = 8 ) = [ 9, 8 ];
true
gap> FirstWithKeys( [ 9, 8, 7 ], { key, value } -> key = 1 and value = 7 );
fail
gap> FirstWithKeys( [ 9, 8, 7 ], { key, value } -> key = 3 and value = 7 );
7
gap> LastWithKeys( [ 9, 8, 7 ], { key, value } -> key = 3 and value = 9 );
fail
gap> LastWithKeys( [ 9, 8, 7 ], { key, value } -> key = 1 and value = 9 );
9

#
gap> STOP_TEST( "ListWithKeys" );
