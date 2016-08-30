LoadPackage( "ActionsForCAP" );

G := SmallGroup( 1000, 93 );

StructureDescription( G );

RepG := RepresentationCategory( G );

irr := Irr( G );

v5 := RepresentationCategoryObject( irr[5] );

v18 := RepresentationCategoryObject( irr[18] );
