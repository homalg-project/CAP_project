LoadPackage( "ActionsForCAP" );

G := SymmetricGroup( 3 );

RepG := RepresentationCategoryZGraded( G );

irr := Irr( G );

v1 := RepresentationCategoryZGradedObject( 2, irr[1], RepG );

v2 := RepresentationCategoryZGradedObject( 3, irr[2], RepG );

v3 := RepresentationCategoryZGradedObject( -1, irr[3], RepG );

v := RepresentationCategoryZGradedObject( -1, irr[2], RepG );

L := [ v1, v2, v3 ];
