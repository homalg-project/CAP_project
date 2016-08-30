LoadPackage( "ActionsForCAP" );

G := SymmetricGroup( 3 );

RepG := RepresentationCategory( G );

irr := Irr( G );

v1 := RepresentationCategoryObject( irr[1], RepG );

v2 := RepresentationCategoryObject( irr[2], RepG );

v3 := RepresentationCategoryObject( irr[3], RepG );

L := [ v1, v2, v3 ];
