#! @Chapter Examples and Tests

#! @Section Snake lemma second proof

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "GeneralizedMorphismsForCAP" );;
LoadPackage( "Bialgebroids" );;

#! @Example
SwitchGeneralizedMorphismStandard( "cospan" );;
snake_quiver := RightQuiver( "Q(6)[a:1->2,b:2->3,c:3->4]" );;
kQ := PathAlgebra( HomalgFieldOfRationals(), snake_quiver );;
Aoid := Algebroid( kQ, [ kQ.abc ] );;
SetIsAbCategory( Aoid, true );;
m := SetOfGeneratingMorphisms( Aoid );;

a := m[1];;
b := m[2];;
c := m[3];;

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

a := AsMorphismInFreeAbelianCategory( a );;
b := AsMorphismInFreeAbelianCategory( b );;
c := AsMorphismInFreeAbelianCategory( c );;

coker_a := CokernelProjection( a );;
colift := CokernelColift( a, PreCompose( b, c ) );;

ker_c := KernelEmbedding( c );;
lift := KernelLift( c, PreCompose( a, b ) );;

p := PreCompose( [
  AsGeneralizedMorphism( KernelEmbedding( colift ) ), 
  GeneralizedInverse( coker_a ),
  AsGeneralizedMorphism( b ),
  GeneralizedInverse( ker_c ),
  AsGeneralizedMorphism( CokernelProjection( lift ) )
] );;

IsHonest( p );
#! true
#! @EndExample