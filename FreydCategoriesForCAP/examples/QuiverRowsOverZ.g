#! @Chapter Examples and Tests

#! @Section Quiver rows over the integers
LoadPackage( "FreydCategoriesForCAP" );;

#! Well-defined morphisms

#! @Example
QQ := HomalgFieldOfRationals();;
snake_quiver := RightQuiver( "Q(4)[a:1->2,b:2->3,c:3->4]" );;
vertices := Vertices( snake_quiver );;
A := PathAlgebra( QQ, snake_quiver );;
A := QuotientOfPathAlgebra( A, [ A.abc ] );;
QRowsA := QuiverRowsDescentToZDefinedByBasisPaths( A );;
v1 := AsQuiverRowsObject( vertices[1], QRowsA );;
v2 := AsQuiverRowsObject( vertices[2], QRowsA );;
mat := [ [ 1/2*A.a ] ];;
x := QuiverRowsMorphism( v1, mat, v2 );;
IsWellDefined( x );
#! false
mat := [ [ 2*A.a ] ];;
x := QuiverRowsMorphism( v1, mat, v2 );;
IsWellDefined( x );
#! true
#! @EndExample

#! Snake lemma over the integers

#! @Example
a := AsQuiverRowsMorphism( A.a, QRowsA );;
b := AsQuiverRowsMorphism( A.b, QRowsA );;
c := AsQuiverRowsMorphism( A.c, QRowsA );;
aa := AsAdelmanCategoryMorphism( a );;
bb := AsAdelmanCategoryMorphism( b );;
cc := AsAdelmanCategoryMorphism( c );;
dd := CokernelProjection( aa );;
ee := CokernelColift( aa, PreCompose( bb, cc ) );;
ff := KernelEmbedding( ee );;
gg := KernelEmbedding( cc );;
hh := KernelLift( cc, PreCompose( aa, bb ) );;
ii := CokernelProjection( hh );;
fff := AsGeneralizedMorphism( ff );;
ddd := AsGeneralizedMorphism( dd );;
bbb := AsGeneralizedMorphism( bb );;
ggg := AsGeneralizedMorphism( gg );;
iii := AsGeneralizedMorphism( ii );;
p := PreCompose( [ fff, PseudoInverse( ddd ), bbb, PseudoInverse( ggg ), iii ] );;
IsHonest( p );
#! true
jj := KernelObjectFunctorial( bb, dd, ee );;
kk := CokernelObjectFunctorial( hh, gg, bb );;
pp := HonestRepresentative( p );;
comp := PreCompose( jj, pp );;
IsZero( comp );
#! true
comp := PreCompose( pp, kk );;
IsZero( comp );
#! true
homology := function( alpha, beta ) return CokernelObject( LiftAlongMonomorphism( KernelEmbedding( beta ), ImageEmbedding( alpha ) ) ); end;;
IsZero( homology( jj, pp ) );
#! true
IsZero( homology( pp, kk ) );
#! true
# @EndExample

#! Phenomena over the integers

#! @Example
quiver := RightQuiver( "Q(2)[a:1->2]" );;
vertices := Vertices( quiver );;
B := PathAlgebra( QQ, quiver );;
QRowsB := QuiverRows( B );;
QRowsB_overZ := QuiverRowsDescentToZDefinedByBasisPaths( B );;
a := AsQuiverRowsMorphism( B.a, QRowsB );;
a_Z := AsQuiverRowsMorphism( B.a, QRowsB_overZ );;
aa := AsAdelmanCategoryMorphism( a );;
aa_Z := AsAdelmanCategoryMorphism( a_Z );;
bb := aa + aa;;
bb_Z := aa_Z + aa_Z;;
K1 := KernelEmbedding( bb );;
K2 := KernelEmbedding( aa );;
IsEqualAsSubobjects( K1, K2 );
#! true
K1_Z := KernelEmbedding( bb_Z );;
K2_Z := KernelEmbedding( aa_Z );;
IsEqualAsSubobjects( K1_Z, K2_Z );
#! false
#! @EndExample