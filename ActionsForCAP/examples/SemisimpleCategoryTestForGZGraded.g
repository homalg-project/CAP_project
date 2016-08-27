LoadPackage( "ActionsForCAP" );
LoadPackage( "RingsForHomalg" );
Q := HomalgFieldOfRationalsInSingular();

G := SymmetricGroup( 3 );

irr := Irr( G );

## G category

membership_function := IsGZGradedIrreducibleObject;

chi_1_2 := GZGradedIrreducibleObject( irr[1], 2 );

chi_2_1 := GZGradedIrreducibleObject( irr[2], 1 );

unit := GZGradedIrreducibleObject( irr[3], 0 );

semisimple_cat := SemisimpleCategory( Q, membership_function, unit, "S3Associator.g" );

a := SemisimpleCategoryObject( [ [ 2, chi_1_2 ], [ 3, chi_2_1 ] ], semisimple_cat );
