#! @Chapter Examples and Tests

#! @Section Adelman category basics for category of rows

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );
LoadPackage( "Bialgebroids" );

#! @Example
R := HomalgRingOfIntegers();;
rows := CategoryOfRows( R );;
adelman := AdelmanCategory( rows );;
obj1 := CategoryOfRowsObject( 1, rows );;
obj2 := CategoryOfRowsObject( 2, rows );;
id := IdentityMorphism( obj2 );;
alpha := CategoryOfRowsMorphism( obj1, HomalgMatrix( [ [ 1, 2 ] ], 1, 2, R ), obj2 );;
beta := CategoryOfRowsMorphism( obj2, HomalgMatrix( [ [ 1, 2 ], [ 3, 4 ] ], 2, 2, R ), obj2 );;
gamma := CategoryOfRowsMorphism( obj2, HomalgMatrix( [ [ 1, 3 ], [ 3, 4 ] ], 2, 2, R ), obj2 );;
obj1_a := AsAdelmanCategoryObject( obj1 );;
obj2_a := AsAdelmanCategoryObject( obj2 );;
m := AsAdelmanCategoryMorphism( beta );;
n := AsAdelmanCategoryMorphism( gamma );;
IsWellDefined( m );
#! true
IsCongruentForMorphisms( PreCompose( m, n ), PreCompose( n, m ) );
#! false
IsCongruentForMorphisms( SubtractionForMorphisms( m, m ), ZeroMorphism( obj2_a, obj2_a ) );
#! true
IsCongruentForMorphisms( ZeroObjectFunctorial( adelman ),
                         PreCompose( UniversalMorphismFromZeroObject( obj1_a), UniversalMorphismIntoZeroObject( obj1_a ) ) 
                        );
#! true
d := [ obj1_a, obj2_a ];;
pi1 := ProjectionInFactorOfDirectSum( d, 1 );;
pi2 := ProjectionInFactorOfDirectSum( d, 2 );;
id := IdentityMorphism( DirectSum( d ) );;
iota1 := InjectionOfCofactorOfDirectSum( d, 1 );;
iota2 := InjectionOfCofactorOfDirectSum( d, 2 );;
IsCongruentForMorphisms( PreCompose( pi1, iota1 ) + PreCompose( pi2, iota2 ), id );
#! true
IsCongruentForMorphisms( UniversalMorphismIntoDirectSum( d, [ pi1, pi2 ] ), id );
#! true
IsCongruentForMorphisms( UniversalMorphismFromDirectSum( d, [ iota1, iota2 ] ), id );
#! true
c := CokernelProjection( m );;
c2 := CokernelProjection( c );;
IsCongruentForMorphisms( c2, ZeroMorphism( Source( c2 ), Range( c2 ) ) );
#! true
IsWellDefined( CokernelProjection( m ) );
#! true
IsCongruentForMorphisms( CokernelColift( m, CokernelProjection( m ) ), IdentityMorphism( CokernelObject( m ) ) );
#! true
k := KernelEmbedding( c );;
IsZeroForMorphisms( PreCompose( k, c ) );
#! true
IsCongruentForMorphisms( KernelLift( m, KernelEmbedding( m ) ), IdentityMorphism( KernelObject( m ) ) );
#! true
#! @EndExample

#! @Section Adelman category basics for for additive closure of algebroids

#! @Example
quiver := RightQuiver( "Q(9)[a:1->2,b:2->3,c:1->4,d:2->5,e:3->6,f:4->5,g:5->6,h:4->7,i:5->8,j:6->9,k:7->8,l:8->9,m:2->7,n:3->8]" );;
kQ := PathAlgebra( HomalgFieldOfRationals(), quiver );;
Aoid := Algebroid( kQ, [ kQ.ad - kQ.cf, 
                         kQ.dg - kQ.be, 
                         kQ.("fi") - kQ.hk,
                         kQ.gj - kQ.il,
                         kQ.mk + kQ.bn - kQ.di ] );;
mm := SetOfGeneratingMorphisms( Aoid );;
CapCategorySwitchLogicOff( Aoid );;
Acat := AdditiveClosure( Aoid );;
a := AsAdditiveClosureMorphism( mm[1] );;
b := AsAdditiveClosureMorphism( mm[2] );;
c := AsAdditiveClosureMorphism( mm[3] );;
d := AsAdditiveClosureMorphism( mm[4] );;
e := AsAdditiveClosureMorphism( mm[5] );;
f := AsAdditiveClosureMorphism( mm[6] );;
g := AsAdditiveClosureMorphism( mm[7] );;
h := AsAdditiveClosureMorphism( mm[8] );;
i := AsAdditiveClosureMorphism( mm[9] );;
j := AsAdditiveClosureMorphism( mm[10] );;
k := AsAdditiveClosureMorphism( mm[11] );;
l := AsAdditiveClosureMorphism( mm[12] );;
m := AsAdditiveClosureMorphism( mm[13] );;
n := AsAdditiveClosureMorphism( mm[14] );;
Adel := AdelmanCategory( Acat );;
A := AdelmanCategoryObject( a, b );;
B := AdelmanCategoryObject( f, g );;
alpha := AdelmanCategoryMorphism( A, d, B );;
IsWellDefined( alpha );
#! true
IsWellDefined( KernelEmbedding( alpha ) );
#! true
IsWellDefined( CokernelProjection( alpha ) );
#! true
T := AdelmanCategoryObject( k, l );;
tau := AdelmanCategoryMorphism( B, i, T );;
IsZeroForMorphisms( PreCompose( alpha, tau ) );
#! true
colift := CokernelColift( alpha, tau );;
IsWellDefined( colift );
#! true
IsCongruentForMorphisms( PreCompose( CokernelProjection( alpha ), colift ), tau );
#! true
lift := KernelLift( tau, alpha );;
IsWellDefined( lift );
#! true
IsCongruentForMorphisms( PreCompose( lift, KernelEmbedding( tau ) ), alpha );
#! true
IsCongruentForMorphisms( ColiftAlongEpimorphism( CokernelProjection( alpha ), tau ), colift );
#! true
IsCongruentForMorphisms( LiftAlongMonomorphism( KernelEmbedding( tau ), alpha ), lift );
#! true
#! @EndExample

#! @Section Adelman category basics for category of columns

#! @Example
R := HomalgRingOfIntegers();;
cols := CategoryOfColumns( R );;
adelman := AdelmanCategory( cols );;
obj1 := CategoryOfColumnsObject( 1, cols );;
obj2 := CategoryOfColumnsObject( 2, cols );;
id := IdentityMorphism( obj2 );;
alpha := CategoryOfColumnsMorphism( obj1, HomalgMatrix( [ [ 1 ], [ 2 ] ], 1, 2, R ), obj2 );;
beta := CategoryOfColumnsMorphism( obj2, HomalgMatrix( [ [ 1, 3 ], [ 2, 4 ] ], 2, 2, R ), obj2 );;
gamma := CategoryOfColumnsMorphism( obj2, HomalgMatrix( [ [ 1, 3 ], [ 3, 4 ] ], 2, 2, R ), obj2 );;
obj1_a := AsAdelmanCategoryObject( obj1 );;
obj2_a := AsAdelmanCategoryObject( obj2 );;
m := AsAdelmanCategoryMorphism( beta );;
n := AsAdelmanCategoryMorphism( gamma );;
IsWellDefined( m );
#! true
IsCongruentForMorphisms( PreCompose( m, n ), PreCompose( n, m ) );
#! false
IsCongruentForMorphisms( SubtractionForMorphisms( m, m ), ZeroMorphism( obj2_a, obj2_a ) );
#! true
IsCongruentForMorphisms( ZeroObjectFunctorial( adelman ),
                         PreCompose( UniversalMorphismFromZeroObject( obj1_a), UniversalMorphismIntoZeroObject( obj1_a ) ) 
                        );
#! true
d := [ obj1_a, obj2_a ];;
pi1 := ProjectionInFactorOfDirectSum( d, 1 );;
pi2 := ProjectionInFactorOfDirectSum( d, 2 );;
id := IdentityMorphism( DirectSum( d ) );;
iota1 := InjectionOfCofactorOfDirectSum( d, 1 );;
iota2 := InjectionOfCofactorOfDirectSum( d, 2 );;
IsCongruentForMorphisms( PreCompose( pi1, iota1 ) + PreCompose( pi2, iota2 ), id );
#! true
IsCongruentForMorphisms( UniversalMorphismIntoDirectSum( d, [ pi1, pi2 ] ), id );
#! true
IsCongruentForMorphisms( UniversalMorphismFromDirectSum( d, [ iota1, iota2 ] ), id );
#! true
c := CokernelProjection( m );;
c2 := CokernelProjection( c );;
IsCongruentForMorphisms( c2, ZeroMorphism( Source( c2 ), Range( c2 ) ) );
#! true
IsWellDefined( CokernelProjection( m ) );
#! true
IsCongruentForMorphisms( CokernelColift( m, CokernelProjection( m ) ), IdentityMorphism( CokernelObject( m ) ) );
#! true
k := KernelEmbedding( c );;
IsZeroForMorphisms( PreCompose( k, c ) );
#! true
IsCongruentForMorphisms( KernelLift( m, KernelEmbedding( m ) ), IdentityMorphism( KernelObject( m ) ) );
#! true
#! @EndExample
