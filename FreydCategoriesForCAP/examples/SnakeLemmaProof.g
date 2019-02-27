#! @Chapter Examples and Tests

#! @Section Snake lemma first proof

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "GeneralizedMorphismsForCAP" );;
LoadPackage( "Bialgebroids" );

#! @Example
SwitchGeneralizedMorphismStandard( "cospan" );;
snake_quiver := RightQuiver( "Q(6)[a:1->2,b:2->3,c:1->4,d:2->5,e:3->6,f:4->5,g:5->6]" );;
kQ := PathAlgebra( HomalgFieldOfRationals(), snake_quiver );;
Aoid := Algebroid( kQ, [ kQ.ad - kQ.cf, kQ.dg - kQ.be, kQ.ab, kQ.fg ] );;
SetIsAbCategory( Aoid, true );;
m := SetOfGeneratingMorphisms( Aoid );;

a := m[1];;
b := m[2];;
c := m[3];;
d := m[4];;
e := m[5];;
f := m[6];;
g := m[7];;


cat := Aoid;;
CapCategorySwitchLogicOff( cat );;
cat := AdditiveClosure( cat );;
cat := Opposite( cat );;
CapCategorySwitchLogicOff( cat );;
CapCategorySwitchLogicOff( Opposite( cat ) );;
cat := FreydCategory( cat );;
CapCategorySwitchLogicOff( cat );;
cat := Opposite( cat );;
CapCategorySwitchLogicOff( cat );;

af := AsMorphismInFreeAbelianCategory( m[1] );;
bf := AsMorphismInFreeAbelianCategory( m[2] );;
cf := AsMorphismInFreeAbelianCategory( m[3] );;
df := AsMorphismInFreeAbelianCategory( m[4] );;
ef := AsMorphismInFreeAbelianCategory( m[5] );;
ff := AsMorphismInFreeAbelianCategory( m[6] );;
gf := AsMorphismInFreeAbelianCategory( m[7] );;

bn := CokernelProjection( af );;
en := CokernelColift( af, PreCompose( df, gf ) );;
fn := KernelEmbedding( gf );;
cn := KernelLift( gf, PreCompose( af, df ) );;

ke := KernelEmbedding( en );;
co := CokernelProjection( cn );;

gk := AsGeneralizedMorphism( ke );;
gb := AsGeneralizedMorphism( bn );;
gd := AsGeneralizedMorphism( df );;
gf := AsGeneralizedMorphism( fn );;
gc := AsGeneralizedMorphism( co );;

DirectSumFunctorial( [ af, af ] );;
IsZero( PreCompose( ke, en ));;
timestart := Runtimes().user_time;;
p := PreCompose( [ gk, PseudoInverse( gb ) ] );;
p2 := PreCompose( p, gd );;
p3:= PreCompose( p2, PseudoInverse( gf ) );;
p4:= PreCompose( p3, gc );;
IsHonest( p );
#! false
IsHonest( p2 );
#! false
IsHonest( p3 );
#! false
IsHonest( p4 );
#! true
timeend := Runtimes().user_time - timestart;;
h := HonestRepresentative( p4 );;
#! @EndExample