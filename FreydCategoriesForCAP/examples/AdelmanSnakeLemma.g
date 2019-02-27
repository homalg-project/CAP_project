#! @Chapter Examples and Tests

#! @Section Adelman snake lemma

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "GeneralizedMorphismsForCAP" );;
LoadPackage( "Bialgebroids" );

#! @Example
SwitchGeneralizedMorphismStandard( "span" );;
snake_quiver := RightQuiver( "Q(6)[a:1->2,b:2->3,c:3->4]" );;
kQ := PathAlgebra( HomalgFieldOfRationals(), snake_quiver );;
Aoid := Algebroid( kQ, [ kQ.abc ] );;
CapCategorySwitchLogicOff( Aoid );;
m := SetOfGeneratingMorphisms( Aoid );;
a := m[1];;
b := m[2];;
c := m[3];;
add := AdditiveClosure( Aoid );;
adelman := AdelmanCategory( add );;
a := AsAdditiveClosureMorphism( a );;
b := AsAdditiveClosureMorphism( b );;
c := AsAdditiveClosureMorphism( c );;
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
pp := HonestRepresentative( p );;
comp := PreCompose( jj, pp );;
IsZero( comp );
#! true
# @EndExample