LoadPackage( "ActionsForCAP" );
LoadPackage( "RingsForHomalg" );
field := HomalgCyclotomicFieldInMAGMA( 3, "eps" );
eps := HomalgRingElement( "eps", field );

G := AlternatingGroup( 4 );

irr := Irr( G );

## G category

membership_function := IsGIrreducibleObject;

chi_1 := GIrreducibleObject( irr[1] );

chi_2 := GIrreducibleObject( irr[2] );

chi_3 := GIrreducibleObject( irr[3] );

chi_4 := GIrreducibleObject( irr[4] );

semisimple_cat := SemisimpleCategory( field, membership_function, chi_1, "A4Associator.g" );

ob1 := SemisimpleCategoryObject( [ [ 1, chi_1 ] ], semisimple_cat );

ob2 := SemisimpleCategoryObject( [ [ 1, chi_2 ] ], semisimple_cat );

ob3 := SemisimpleCategoryObject( [ [ 1, chi_3 ] ], semisimple_cat );

ob4 := SemisimpleCategoryObject( [ [ 1, chi_4 ] ], semisimple_cat );

L := [ ob1, ob2, ob3, ob4 ];

