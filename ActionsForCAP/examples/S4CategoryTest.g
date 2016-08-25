LoadPackage( "ActionsForCAP" );
LoadPackage( "RingsForHomalg" );
Q := HomalgFieldOfRationalsInSingular();

G := SymmetricGroup( 4 );

irr := Irr( G );

## G category

membership_function := IsGIrreducibleObject;

chi_1 := GIrreducibleObject( irr[1] );

chi_2 := GIrreducibleObject( irr[2] );

chi_3 := GIrreducibleObject( irr[3] );

chi_4 := GIrreducibleObject( irr[4] );

chi_5 := GIrreducibleObject( irr[5] );

semisimple_cat := SemisimpleCategory( Q, membership_function, chi_5, "S4Associator.g" );

ob1 := SemisimpleCategoryObject( [ [ 1, chi_1 ] ], semisimple_cat );

ob2 := SemisimpleCategoryObject( [ [ 1, chi_2 ] ], semisimple_cat );

ob3 := SemisimpleCategoryObject( [ [ 1, chi_3 ] ], semisimple_cat );

ob4 := SemisimpleCategoryObject( [ [ 1, chi_4 ] ], semisimple_cat );

ob5 := SemisimpleCategoryObject( [ [ 1, chi_5 ] ], semisimple_cat );

L := [ ob1, ob2, ob3, ob4, ob5 ];
