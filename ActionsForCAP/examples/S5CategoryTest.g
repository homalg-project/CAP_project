LoadPackage( "ActionsForCAP" );

G := SymmetricGroup( 5 );

RepG := RepresentationCategory( G );

irr := Irr( G );

v1 := RepresentationCategoryObject( irr[1] );

v2 := RepresentationCategoryObject( irr[2] );

v3 := RepresentationCategoryObject( irr[3] );

v4 := RepresentationCategoryObject( irr[4] );

v5 := RepresentationCategoryObject( irr[5] );

v6 := RepresentationCategoryObject( irr[6] );

v7 := RepresentationCategoryObject( irr[7] );

L := [ v1, v2, v3, v4, v5, v6, v7 ];