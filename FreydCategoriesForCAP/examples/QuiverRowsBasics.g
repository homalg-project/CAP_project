#! @Chapter Examples and Tests

#! @Section Quiver rows bascis

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );
LoadPackage( "Bialgebroids" );

#! @Example

## quiver without relations
QQ := HomalgFieldOfRationals();;
quiver := RightQuiver( "Q(3)[a:1->2,b:1->2,c:2->3]" );;
Av := Vertices( quiver );;
A := PathAlgebra( QQ, quiver );;
a := BasisPaths( CanonicalBasis( A ) );;
a := List( a, p -> PathAsAlgebraElement( A, p ) );;
zA := Zero( A );;
QRowsA := QuiverRows( A );;
mat := [ [ a[1], zA ], [ zA, a[6] ], [ a[1], zA ] ];;
obj1 := QuiverRowsObject( [ [ Av[1], 1 ], [ Av[2], 1 ], [ Av[1], 1 ] ], QRowsA );;
obj2 := QuiverRowsObject( [ [ Av[1], 1 ], [ Av[3], 1 ] ], QRowsA );;
alpha := QuiverRowsMorphism( obj1, mat, obj2 );;
obj3 := QuiverRowsObject( [ [ Av[2], 1 ] ], QRowsA );;
mat := [ [ a[4] ], [ zA ] ];;
beta := QuiverRowsMorphism( obj2, mat, obj3 );;
pre := PreCompose( alpha, beta );;
IsWellDefined( PreCompose( alpha, beta ) );
#! true
IsZeroForMorphisms( pre );
#! false
ze := ZeroMorphism( Source( pre ), Range( pre ) );;
IsCongruentForMorphisms( pre + ze, pre );
#! true
IsCongruentForMorphisms( pre + pre, pre );
#! false
IsZeroForMorphisms( pre - pre );
#! true
IsCongruentForMorphisms(
    PreCompose(
        UniversalMorphismFromZeroObject( obj1 ),
        UniversalMorphismIntoZeroObject( obj1 )
    ),
    IdentityMorphism( ZeroObject( QRowsA ) )
);
#! true
NrSummands( DirectSum( List( [ 1 .. 1000 ], i -> obj1 ) ) ) = 1000 * NrSummands( obj1 );
#! true
L := [ obj1, obj2, obj3 ];;
pi := List( [ 1,2,3 ], i -> ProjectionInFactorOfDirectSum( L, i ) );;
iota := List( [ 1,2,3 ], i -> InjectionOfCofactorOfDirectSum( L, i ) );;
ForAll( [1,2,3], i ->
    IsCongruentForMorphisms( 
        PreCompose( iota[i], pi[i] ),
        IdentityMorphism( L[i] )
    )
);
#! true
IsZeroForMorphisms( PreCompose( iota[2], pi[1] ) );
#! true
IsCongruentForMorphisms( 
    UniversalMorphismIntoDirectSum( L, pi ),
    IdentityMorphism( DirectSum( L ) )
);
#! true
IsCongruentForMorphisms( 
    UniversalMorphismFromDirectSum( L, iota ),
    IdentityMorphism( DirectSum( L ) )
);
#! true
IsCongruentForMorphisms(
    InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( obj1, obj2, 
        InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( alpha )
    ),
    alpha
);
#! true

## quiver with relations
quiver := RightQuiver( 
"Q(8)[a:1->5,b:2->6,c:3->7,d:4->8,e:1->2,f:2->3,g:3->4,h:5->6,i:6->7,j:7->8]" 
);;
Bv := Vertices( quiver );;
QQ := HomalgFieldOfRationals();;
kQ := PathAlgebra( QQ, quiver );;
B := QuotientOfPathAlgebra( kQ,
[ 
    kQ.e * kQ.f, kQ.f * kQ.g,
    kQ.h * kQ.i, kQ.i * kQ.j,
    kQ.e * kQ.b - kQ.a * kQ.h,
    kQ.f * kQ.c - kQ.b * kQ.i,
    kQ.g * kQ.d - kQ.c * kQ.j ] 
);;
b := BasisPaths( CanonicalBasis( B ) );;
QRowsB := QuiverRows( B );;
obj := QuiverRowsObject( [ [ Bv[1], 2 ], [ Bv[1], 4 ], [ Bv[1], 4 ], [ Bv[1], 6 ] ], QRowsB );;
IsWellDefined( obj );
#! true
IdentityMorphism( obj );;
#! @EndExample