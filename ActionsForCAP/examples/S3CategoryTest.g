LoadPackage( "ActionsForCAP" );
LoadPackage( "RingsForHomalg" );
Q := HomalgFieldOfRationalsInSingular();

G := SymmetricGroup( 3 );

irr := Irr( G );

## G category

membership_function := IsGIrreducibleObject;

chi_1 := GIrreducibleObject( irr[1] );

chi_2 := GIrreducibleObject( irr[2] );

chi_3 := GIrreducibleObject( irr[3] );

semisimple_cat := SemisimpleCategory( Q, membership_function, chi_3 );

a := SemisimpleCategoryObject( [ [ 1, chi_1 ], [ 2, chi_2 ], [ 3, chi_3 ] ], semisimple_cat );

b := SemisimpleCategoryObject( [ [ 1, chi_2 ], [ 2, chi_3 ] ], semisimple_cat );

alpha := VectorSpaceMorphism( VectorSpaceObject( 2, Q ), HomalgMatrix( [ [ 1 ], [ -1 ] ], 2, 1, Q ), VectorSpaceObject( 1, Q ) );

beta := VectorSpaceMorphism( VectorSpaceObject( 3, Q ), HomalgMatrix( [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ], 3, 2, Q ), VectorSpaceObject( 2, Q ) );

mor := SemisimpleCategoryMorphism( a, [ [ MorphismIntoZeroObject( VectorSpaceObject( 1, Q ) ), chi_1 ], [ alpha, chi_2 ], [ beta, chi_3 ] ], b  );


