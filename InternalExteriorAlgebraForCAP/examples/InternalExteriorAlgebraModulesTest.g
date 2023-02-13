#! @Chapter Examples and Tests

#! @Section Basic Commands

#! @Example
LoadPackage( "InternalExteriorAlgebraForCAP" );
#! true
LoadPackage( "HomologicalAlgebraForCAP" ); # needed for computing spectral sequences
#! true
RepG := RepresentationCategoryZGraded( SymmetricGroup( 4 ) );
#! The skeletal Z-graded representation category of SymmetricGroup( [ 1 .. 4 ] )
G := UnderlyingGroupForRepresentationCategory( RepG );
#! Sym( [ 1 .. 4 ] )
irr := Irr( G );
#! [ Character( CharacterTable( Sym( [ 1 .. 4 ] ) ), [ 1, -1, 1, 1, -1 ] ),
#!   Character( CharacterTable( Sym( [ 1 .. 4 ] ) ), [ 3, -1, -1, 0, 1 ] ),
#!   Character( CharacterTable( Sym( [ 1 .. 4 ] ) ), [ 2, 0, 2, -1, 0 ] ),
#!   Character( CharacterTable( Sym( [ 1 .. 4 ] ) ), [ 3, 1, -1, 0, -1 ] ),
#!   Character( CharacterTable( Sym( [ 1 .. 4 ] ) ), [ 1, 1, 1, 1, 1 ] ) ]
v := RepresentationCategoryZGradedObject( -1, irr[2], RepG );
#! 1*(x_[-1, 2])
cat := EModuleActionCategory( v );
#! Module category of the internal exterior algebra modeled
#! via right actions of 1*(x_[-1, 2])
h := RepresentationCategoryZGradedObject( 3, irr[2], RepG );
#! 1*(x_[3, 2])
F := FreeEModule( h, cat );
#! <An object in Module category of the internal exterior algebra modeled
#!  via right actions of 1*(x_[-1, 2])>
chi := Support( ActionDomain( F ) )[8];
#! <x_[2, 4]>
c := ComponentInclusionMorphism( ActionDomain( F ), chi );
#! <A morphism in The skeletal Z-graded representation category of
#!  SymmetricGroup( [ 1 .. 4 ] )>
u := UniversalMorphismFromFreeModule( F, c );
#! <A morphism in Module category of the internal exterior algebra
#!  modeled via right actions of 1*(x_[-1, 2])>
t := FilteredTateResolution( u );
#! <An object in Cocomplex category of Descending filtered object category of
#!  The skeletal Z-graded representation category of SymmetricGroup( [ 1 .. 4 ] )>
s := SpectralSequenceEntryOfDescendingFilteredCocomplex( t, 2, 0, 1 );
#! <A morphism in Generalized morphism category of
#!  The skeletal Z-graded representation category of SymmetricGroup( [ 1 .. 4 ] )>
Display( UnderlyingHonestObject( Source( s ) ) );
#! 1*(x_[2, 3]) + 1*(x_[2, 5])
#! @EndExample
