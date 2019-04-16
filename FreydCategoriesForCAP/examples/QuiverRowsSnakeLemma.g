#! @Chapter Examples and Tests

#! @Section Adelman snake lemma

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "GeneralizedMorphismsForCAP" );;
LoadPackage( "Bialgebroids" );

#! @Example
SwitchGeneralizedMorphismStandard( "cospan" );;
snake_quiver := RightQuiver( "Q(6)[a:1->2,b:2->3,c:3->4]" );;
QQ := HomalgFieldOfRationals();;
A := PathAlgebra( QQ, snake_quiver );;
A := QuotientOfPathAlgebra( A, [ A.abc ] );;
QRowsA := QuiverRows( A );;
SetIsProjective( DistinguishedObjectOfHomomorphismStructure( QRowsA ), true );;

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