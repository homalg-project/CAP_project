LoadPackage( "GroupRepresentationsForCAP" );
LoadPackage( "RingsForHomalg" );

Q := HomalgFieldOfRationalsInSingular();

G := SymmetricGroup( 3 );

irr := Irr( G );

## G category

membership_function := IsGIrreducibleObject;

chi_1 := GIrreducibleObject( irr[1] );
chi_2 := GIrreducibleObject( irr[2] );
chi_3 := GIrreducibleObject( irr[3] );

semisimple_cat := SemisimpleCategory( Q, membership_function, chi_3, "S3Ass.g", true );

ob1 := SemisimpleCategoryObject( [ [ 1, chi_1 ] ], semisimple_cat );
ob2 := SemisimpleCategoryObject( [ [ 1, chi_2 ] ], semisimple_cat );
ob3 := SemisimpleCategoryObject( [ [ 1, chi_3 ] ], semisimple_cat );

Qmat := UnderlyingCategoryForSemisimpleCategory( semisimple_cat );

a := SemisimpleCategoryObject( [ [ 1, chi_1 ], [ 2, chi_2 ], [ 3, chi_3 ] ], semisimple_cat );
b := SemisimpleCategoryObject( [ [ 1, chi_2 ], [ 2, chi_3 ] ], semisimple_cat );

M1 := MatrixCategoryObject( Qmat, 1 );
M2 := MatrixCategoryObject( Qmat, 2 );
M3 := MatrixCategoryObject( Qmat, 3 );

matrix_1 := HomalgMatrix( [ [ 1 ], [ -1 ] ], 2, 1, Q );
matrix_2 := HomalgMatrix( [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ], 3, 2, Q );

alpha := VectorSpaceMorphism( M2, matrix_1, M1 );
beta := VectorSpaceMorphism( M3, matrix_2, M2 );

mor := SemisimpleCategoryMorphism( a, [ [ MorphismIntoZeroObject( M1 ), chi_1 ], [ alpha, chi_2 ], [ beta, chi_3 ] ], b  );

#AssociatorLeftToRight( b, b, b );

L := [ ob1, ob2, ob3 ];
