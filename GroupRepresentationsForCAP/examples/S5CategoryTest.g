LoadPackage( "GroupRepresentationsForCAP" );

RepG := RepresentationCategory( SymmetricGroup( 5 ) );

G := UnderlyingGroupForRepresentationCategory( RepG );

irr := Irr( G );

v1 := RepresentationCategoryObject( irr[1], RepG );

v2 := RepresentationCategoryObject( irr[2], RepG );

v3 := RepresentationCategoryObject( irr[3], RepG );

v4 := RepresentationCategoryObject( irr[4], RepG );

v5 := RepresentationCategoryObject( irr[5], RepG );

v6 := RepresentationCategoryObject( irr[6], RepG );

v7 := RepresentationCategoryObject( irr[7], RepG );

L := [ v1, v2, v3, v4, v5, v6, v7 ];