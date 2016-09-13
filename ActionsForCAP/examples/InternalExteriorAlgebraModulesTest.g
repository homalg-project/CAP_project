LoadPackage( "ActionsForCAP" );

RepG := RepresentationCategoryZGraded( SymmetricGroup( 4 ) );

G := UnderlyingGroupForRepresentationCategory( RepG );

irr := Irr( G );

v := RepresentationCategoryZGradedObject( -1, irr[2], RepG );

cat := EModuleActionCategory( v );

F := FreeEModule( v, cat );

chi := Support( ActionDomain( F ) )[8];

c := ComponentInclusionMorphism( ActionDomain( F ), chi );

u := UniversalMorphismFromFreeModule( F, c );