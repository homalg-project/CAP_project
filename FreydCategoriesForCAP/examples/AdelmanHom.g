#! @Chapter Examples and Tests

#! @Section Adelman category basics

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "Bialgebroids");
#! @Example
quiver := RightQuiver( "Q(3)[a:1->2,b:1->2,c:2->3]" );;
kQ := PathAlgebra( HomalgFieldOfRationals(), quiver );;
Aoid := Algebroid( kQ );;
SetIsProjective( DistinguishedObjectOfHomomorphismStructure( Aoid ), true );;
mm := SetOfGeneratingMorphisms( Aoid );;
CapCategorySwitchLogicOff( Aoid );;
Acat := AdditiveClosure( Aoid );;
a := AsAdditiveClosureMorphism( mm[1] );;
b := AsAdditiveClosureMorphism( mm[2] );;
c := AsAdditiveClosureMorphism( mm[3] );;
a := AsAdelmanCategoryMorphism( a );;
b := AsAdelmanCategoryMorphism( b );;
c := AsAdelmanCategoryMorphism( c );;
A := Source( a );;
B := Range( a );;
C := Range( c );;
HomomorphismStructureOnObjects( A, C );;
HomomorphismStructureOnMorphisms( IdentityMorphism( A ), c );;
mor := InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( a );;
int := InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( A, B, mor );;
IsCongruentForMorphisms( int, a );
#! true
#! @EndExample