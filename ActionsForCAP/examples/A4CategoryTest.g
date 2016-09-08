LoadPackage( "ActionsForCAP" );

RepG := RepresentationCategory( AlternatingGroup( 4 ) );

G := UnderlyingGroupForRepresentationCategory( RepG );

irr := Irr( G );

v1 := RepresentationCategoryObject( irr[1], RepG );

v2 := RepresentationCategoryObject( irr[2], RepG );

v3 := RepresentationCategoryObject( irr[3], RepG );

v4 := RepresentationCategoryObject( irr[4], RepG );

L := [ v1, v2, v3, v4 ];

