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
                                  1, [ f, [] ], IsCapCategory ) );
AddDerivation( G, MakeDerivation( "bar", B,
                                  [ [ D, 1 ] ],
                                  1, [ f, [] ], IsCapCategory ) );
AddDerivation( G, MakeDerivation( "baz", D,
                                  [ [ B, 1 ] ],
                                  1, [ f, [] ], IsCapCategory ) );
AddDerivation( G, MakeDerivation( "quux", C,
                                  [ [ A, 3 ], [ D, 5 ] ],
                                  7, [ f, [] ], IsAbelianCategory ) );
AddDerivation( G, MakeDerivation( "quuux", C,
                                  [ [ B, 8 ], [ D, 5 ] ],
                                  2, [ f, [] ], IsCapCategory ) );

cat := CreateCapCategory( "test category" );
owl := MakeOperationWeightList( cat, G );
Print( "Adding A with weight 2\n" );
AddPrimitiveOperation( owl, "A", 2 );
Print( "Adding B with weight 2\n" );
AddPrimitiveOperation( owl, "B", 2 );
Print( "Set abelian=true\n" );
SetIsAbelianCategory( cat, true );
Print( "Reevaluate\n" );
Reevaluate( owl );
