LoadPackage( "InternalExteriorAlgebraForCAP" );

LoadPackage( "HomologicalAlgebraForCAP" ); # necessary for computing spectral sequences

RepG := RepresentationCategoryZGraded( SymmetricGroup( 4 ) );

G := UnderlyingGroupForRepresentationCategory( RepG );

irr := Irr( G );

v := RepresentationCategoryZGradedObject( -1, irr[2], RepG );

cat := EModuleActionCategory( v );

h := RepresentationCategoryZGradedObject( 3, irr[2], RepG );

F := FreeEModule( h, cat );

chi := Support( ActionDomain( F ) )[8];

c := ComponentInclusionMorphism( ActionDomain( F ), chi );

u := UniversalMorphismFromFreeModule( F, c );

t := FilteredTateResolution( u );

s := SpectralSequenceEntryOfDescendingFilteredCocomplex( t, 2, 0, 1 );

# Display( UnderlyingHonestObject( Source( s ) ) );
# 1*(χ_[2, 3]) + 1*(χ_[2, 5])
