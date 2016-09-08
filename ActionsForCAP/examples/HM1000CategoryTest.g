LoadPackage( "ActionsForCAP" );

RepG := RepresentationCategory( 1000, 93 );

G := UnderlyingGroupForRepresentationCategory( RepG );

irr := Irr( G );

v5 := RepresentationCategoryObject( irr[5], RepG );

v18 := RepresentationCategoryObject( irr[18], RepG );
