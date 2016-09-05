LoadPackage( "ActionsForCAP" );

G := SymmetricGroup( 4 );

RepG := RepresentationCategoryZGraded( G );

irr := Irr( G );

v := RepresentationCategoryZGradedObject( -1, irr[2], RepG );

cat := InternalExteriorAlgebraModuleCategory( v );
