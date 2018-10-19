#! @Chapter Examples and Tests

#! @Section Basic Commands

LoadPackage( "LinearAlgebraForCAP" );;

#! @Example
Q := HomalgFieldOfRationals();;
a := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
b := VectorSpaceObject( 4, Q );
#! <A vector space object over Q of dimension 4>
homalg_matrix := HomalgMatrix( [ [ 1, 0, 0, 0 ],
                                  [ 0, 1, 0, -1 ],
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );
#! <A 3 x 4 matrix over an internal ring>
alpha := VectorSpaceMorphism( a, homalg_matrix, b );
#! <A morphism in Category of matrices over Q>
Display( alpha );
#! [ [   1,   0,   0,   0 ],
#!   [   0,   1,   0,  -1 ],
#!   [  -1,   0,   2,   1 ] ]
#! 
#! A morphism in Category of matrices over Q
homalg_matrix := HomalgMatrix( [ [ 1, 1, 0, 0 ],
                                  [ 0, 1, 0, -1 ],
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );
#! <A 3 x 4 matrix over an internal ring>
beta := VectorSpaceMorphism( a, homalg_matrix, b );
#! <A morphism in Category of matrices over Q>
CokernelObject( alpha );
#! <A vector space object over Q of dimension 1>
c := CokernelProjection( alpha );;
Display( c );
#! [ [     0 ],
#!   [     1 ],
#!   [  -1/2 ],
#!   [     1 ] ]
#!
#! A split epimorphism in Category of matrices over Q
gamma := UniversalMorphismIntoDirectSum( [ c, c ] );;
Display( gamma );
#! [ [     0,     0 ],
#!   [     1,     1 ],
#!   [  -1/2,  -1/2 ],
#!   [     1,     1 ] ]
#! 
#! A morphism in Category of matrices over Q
colift := CokernelColift( alpha, gamma );;
IsEqualForMorphisms( PreCompose( c, colift ), gamma );
#! true
FiberProduct( alpha, beta );
#! <A vector space object over Q of dimension 2>
F := FiberProduct( alpha, beta );
#! <A vector space object over Q of dimension 2>
p1 := ProjectionInFactorOfFiberProduct( [ alpha, beta ], 1 );
#! <A morphism in Category of matrices over Q>
Display( PreCompose( p1, alpha ) );
#! [ [   0,   1,   0,  -1 ],
#!   [  -1,   0,   2,   1 ] ]
#! 
#! A morphism in Category of matrices over Q
Pushout( alpha, beta );
#! <A vector space object over Q of dimension 5>
i1 := InjectionOfCofactorOfPushout( [ alpha, beta ], 1 );
#! <A morphism in Category of matrices over Q>
i2 := InjectionOfCofactorOfPushout( [ alpha, beta ], 2 );
#! <A morphism in Category of matrices over Q>
u := UniversalMorphismFromDirectSum( [ b, b ], [ i1, i2 ] );
#! <A morphism in Category of matrices over Q>
Display( u );
#! [ [     0,     1,     1,     0,     0 ],
#!   [     1,     0,     1,     0,    -1 ],
#!   [  -1/2,     0,   1/2,     1,   1/2 ],
#!   [     1,     0,     0,     0,     0 ],
#!   [     0,     1,     0,     0,     0 ],
#!   [     0,     0,     1,     0,     0 ],
#!   [     0,     0,     0,     1,     0 ],
#!   [     0,     0,     0,     0,     1 ] ]
#! 
#! A morphism in Category of matrices over Q
KernelObjectFunctorial( u, IdentityMorphism( Source( u ) ), u ) = IdentityMorphism( VectorSpaceObject( 3, Q ) );
#! true
IsZero( CokernelObjectFunctorial( u, IdentityMorphism( Range( u ) ), u ) );
#! true
DirectProductFunctorial( [ u, u ] ) = DirectSumFunctorial( [ u, u ] );
#! true
CoproductFunctorial( [ u, u ] ) = DirectSumFunctorial( [ u, u ] );
#! true
IsOne( FiberProductFunctorial( [ u, u ], [ IdentityMorphism( Source( u ) ), IdentityMorphism( Source( u ) ) ], [ u, u ] ) );
#! true
IsOne( PushoutFunctorial( [ u, u ], [ IdentityMorphism( Range( u ) ), IdentityMorphism( Range( u ) ) ], [ u, u ] ) );
#! true
IsCongruentForMorphisms( (1/2) * alpha, alpha * (1/2) );
#! true
Dimension( HomomorphismStructureOnObjects( a, b ) ) = Dimension( a ) * Dimension( b );
#! true
IsCongruentForMorphisms(
    PreCompose( [ u, DualOnMorphisms( i1 ), DualOnMorphisms( alpha ) ] ),
    InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( Source( u ), Source( alpha ),
         PreCompose(
             InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( DualOnMorphisms( i1 ) ),
             HomomorphismStructureOnMorphisms( u, DualOnMorphisms( alpha ) )
         )
    )
);
#! true
vec := CapCategory( alpha );;
t := TensorUnit( vec );;
z := ZeroObject( vec );;
IsCongruentForMorphisms(
    ZeroObjectFunctorial( vec ),
    InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( z, z, ZeroMorphism( t, z ) )
);
#! true
IsCongruentForMorphisms(
    ZeroObjectFunctorial( vec ),
    InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism(
        z, z,
        InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( ZeroObjectFunctorial( vec ) )
    )
);
#! true
right_side := PreCompose( [ i1, DualOnMorphisms( u ), u ] );;
x := SolveLinearSystemInAbCategory( [ [ i1 ] ], [ [ u ] ], [ right_side ] )[1];;
IsCongruentForMorphisms( PreCompose( [ i1, x, u ] ), right_side );
#! true
#! @EndExample
