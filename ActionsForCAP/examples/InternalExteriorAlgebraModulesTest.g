LoadPackage( "ActionsForCAP" );

RepG := RepresentationCategoryZGraded( SymmetricGroup( 4 ) );

G := UnderlyingGroupForRepresentationCategory( RepG );

irr := Irr( G );

v := RepresentationCategoryZGradedObject( -1, irr[2], RepG );

cat := InternalExteriorAlgebraModuleCategory( v );
