LoadPackage( "ActionsForCAP" );

RepG := RepresentationCategoryZGraded( 1000, 93 );

irr := Irr( UnderlyingGroupForRepresentationCategory( RepG ) );

v := RepresentationCategoryZGradedObject( -1, irr[6], RepG );

h := RepresentationCategoryZGradedObject( 4, irr[5], RepG );

cat := EModuleActionCategory( v );

F := FreeEModule( h, cat );

chi := Support( ActionDomain( F ) )[7];

c := ComponentInclusionMorphism( ActionDomain( F ), chi );

u := UniversalMorphismFromFreeModule( F, c );
