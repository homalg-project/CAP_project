LoadPackage( "ActionsForCAP" );

G := SymmetricGroup( 3 );

RepG := RepresentationCategory( G );

irr := Irr( G );

v1 := RepresentationCategoryObject( irr[1] );

v2 := RepresentationCategoryObject( irr[2] );

v3 := RepresentationCategoryObject( irr[3] );

L := [ v1, v2, v3 ];
