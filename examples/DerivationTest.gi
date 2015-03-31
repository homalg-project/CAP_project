LoadPackage("CAP");

h := StringMinHeap();
Add( h, "a", 5 );
Add( h, "b", 3 );
Add( h, "c", 12 );
Add( h, "d", 8 );
Add( h, "e", 2 );


DeclareOperation( "A", [ IsObject ] );
DeclareOperation( "B", [ IsObject ] );
DeclareOperation( "C", [ IsObject ] );
DeclareOperation( "D", [ IsObject ] );

G := MakeDerivationGraph( [ "A", "B", "C", "D" ] );
f := function(x) return x; end;
AddDerivation( G, MakeDerivation( "foo", A,
                                  [ [ B, 2 ], [ C, 1 ] ],
                                  1, f ) );
AddDerivation( G, MakeDerivation( "bar", B,
                                  [ [ D, 1 ] ],
                                  1, f ) );
AddDerivation( G, MakeDerivation( "baz", D,
                                  [ [ B, 1 ] ],
                                  1, f ) );
AddDerivation( G, MakeDerivation( "quux", C,
                                  [ [ A, 3 ], [ D, 5 ] ],
                                  7, f ) );
AddDerivation( G, MakeDerivation( "quuux", C,
                                  [ [ B, 8 ], [ D, 5 ] ],
                                  2, f ) );

owl := MakeOperationWeightList( CapCat, G );
AddPrimitiveOperation( owl, "A", 2 );
AddPrimitiveOperation( owl, "B", 2 );
