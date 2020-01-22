#! @Chapter Examples and Tests

#! @Section Adelman 5 lemma

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "GeneralizedMorphisms");;

#! @Example
quiver := RightQuiver( "Q(8)[a:1->2,b:2->3,c:3->4,d:3->5,e:4->6,f:5->6,g:6->7,h:7->8]" );;
QQ := HomalgFieldOfRationals();;
A := PathAlgebra( QQ, quiver );;
B := QuotientOfPathAlgebra( A,
[ 
    A.ce - A.df,
    A.abd,
    A.egh,
    A.bc,
    A.fg,
    A.ab #since d is supposed to be a mono 
] );;
QRowsB := QuiverRowsDescentToZDefinedByBasisPaths( B );;
Adel := AdelmanCategory( QRowsB );;
a := B.a/QRowsB/Adel;;
b := B.b/QRowsB/Adel;;
c := B.c/QRowsB/Adel;;
d := B.d/QRowsB/Adel;;
e := B.e/QRowsB/Adel;;
f := B.f/QRowsB/Adel;;
g := B.g/QRowsB/Adel;;
h := B.h/QRowsB/Adel;;
l := CokernelProjection( a );;
k := CokernelColift( a, PreCompose( b, d ) );;
i := KernelEmbedding( h );;
j := KernelLift( h, PreCompose( e, g ) );;
Kd := KernelObject( d );;
Hbc := HomologyObject( b, c );;
Hcj := HomologyObject( c, j );;
Hkf := HomologyObject( k, f );;
Hfg := HomologyObject( f, g );;
L := [ Kd, Hbc, Hcj, Hkf, Hfg ];;
K := KernelObject( e );;
test_func := MembershipFunctionSerreSubcategoryGeneratedByObjects( L, Adel );;
#! Warning: the provided function returns either true or fail!
C := FullSubcategoryByMembershipFunction( Adel, test_func );;
Serre := Adel/C;;
K := K/Serre;;
IsZero( K );
#! true
# @EndExample