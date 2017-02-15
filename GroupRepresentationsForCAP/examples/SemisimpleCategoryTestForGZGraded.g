LoadPackage( "GroupRepresentationsForCAP" );
LoadPackage( "RingsForHomalg" );
Q := HomalgFieldOfRationalsInSingular();

G := SymmetricGroup( 3 );

irr := Irr( G );

## G category

membership_function := IsGZGradedIrreducibleObject;

chi_1_2 := GZGradedIrreducibleObject( 2, irr[1] );

chi_2_1 := GZGradedIrreducibleObject( 1, irr[2] );

unit := GZGradedIrreducibleObject( 0, irr[3] );

semisimple_cat := SemisimpleCategory( Q, membership_function, unit, "S3Ass.g", true );

a := SemisimpleCategoryObject( [ [ 2, chi_1_2 ], [ 3, chi_2_1 ] ], semisimple_cat );

b := SemisimpleCategoryObject( [ [ 1, chi_1_2 ], [ 1, chi_2_1 ] ], semisimple_cat );
