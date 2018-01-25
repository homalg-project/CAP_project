#! @Chapter Examples and Tests

#! @Section Basics

LoadPackage( "FreydCategoriesForCAP" );;
snake_quiver := RightQuiver( "Q(6)[a:1->2,b:2->3,c:1->4,d:2->5,e:3->6,f:4->5,g:5->6]" );
kQ := PathAlgebra( HomalgFieldOfRationals(), snake_quiver );
Aoid := Algebroid( kQ, [ kQ.ad - kQ.cf, kQ.dg - kQ.be, kQ.ab, kQ.fg ] );
SetIsAbCategory( Aoid, true );
INSTALL_HOMOMORPHISM_STRUCTURE_FOR_BIALGEBROID( Aoid );
m := SetOfGeneratingMorphisms( Aoid );
a := m[1];
b := m[2];
c := m[3];
d := m[4];
e := m[5];
f := m[6];
g := m[7];

af := AsMorphismInFreeAbelianCategory( m[1] );
bf := AsMorphismInFreeAbelianCategory( m[2] );
cf := AsMorphismInFreeAbelianCategory( m[3] );
df := AsMorphismInFreeAbelianCategory( m[4] );
ef := AsMorphismInFreeAbelianCategory( m[5] );
ff := AsMorphismInFreeAbelianCategory( m[6] );
gf := AsMorphismInFreeAbelianCategory( m[7] );
