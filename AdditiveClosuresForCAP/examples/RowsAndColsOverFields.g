#! @Chapter Category of rows and columns over a field

#! @Section Abelian operations

LoadPackage( "AdditiveClosuresForCAP" );;

#! Category of rows over a field

#! @Example
Q := HomalgFieldOfRationals();;
RowsQ := CategoryOfRows( Q );;
a := 3/RowsQ;;
b := 4/RowsQ;;
IsProjective( a );
#! true
homalg_matrix := HomalgMatrix( [ [ 1, 0, 0, 0 ],
                                  [ 0, 1, 0, -1 ],
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );;
alpha := homalg_matrix/RowsQ;;
homalg_matrix := HomalgMatrix( [ [ 1, 1, 0, 0 ],
                                  [ 0, 1, 0, -1 ],
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );;
beta := homalg_matrix/RowsQ;;
IsWellDefined( CokernelObject( alpha ) );
#! true
c := CokernelProjection( alpha );;
gamma := UniversalMorphismIntoDirectSum( [ c, c ] );;
colift := CokernelColift( alpha, gamma );;
IsEqualForMorphisms( PreCompose( c, colift ), gamma );
#! true
FiberProduct( alpha, beta );;
F := FiberProduct( alpha, beta );;
IsWellDefined( F );
#! true
IsWellDefined( ProjectionInFactorOfFiberProduct( [ alpha, beta ], 1 ) );
#! true
IsWellDefined( Pushout( alpha, beta ) );
#! true
i1 := InjectionOfCofactorOfPushout( [ alpha, beta ], 1 );;
i2 := InjectionOfCofactorOfPushout( [ alpha, beta ], 2 );;
u := UniversalMorphismFromDirectSum( [ b, b ], [ i1, i2 ] );;
KernelObjectFunctorial( u, IdentityMorphism( Source( u ) ), u ) = IdentityMorphism( 3/RowsQ );
#! true
IsZeroForMorphisms( CokernelObjectFunctorial( u, IdentityMorphism( Range( u ) ), u ) );
#! true
DirectProductFunctorial( [ u, u ] ) = DirectSumFunctorial( [ u, u ] );
#! true
CoproductFunctorial( [ u, u ] ) = DirectSumFunctorial( [ u, u ] );
#! true
IsCongruentForMorphisms(
    FiberProductFunctorial( [ u, u ], [ IdentityMorphism( Source( u ) ), IdentityMorphism( Source( u ) ) ], [ u, u ] ),
    IdentityMorphism( FiberProduct( [ u, u ] ) )
);
#! true
IsCongruentForMorphisms(
    PushoutFunctorial( [ u, u ], [ IdentityMorphism( Range( u ) ), IdentityMorphism( Range( u ) ) ], [ u, u ] ),
    IdentityMorphism( Pushout( [ u, u ] ) )
);
#! true
IsCongruentForMorphisms( ((1/2) / Q) * alpha, alpha * ((1/2) / Q) );
#! true
RankOfObject( HomomorphismStructureOnObjects( a, b ) ) = RankOfObject( a ) * RankOfObject( b );
#! true
IsCongruentForMorphisms(
    PreCompose( [ u, DualOnMorphisms( i1 ), DualOnMorphisms( alpha ) ] ),
    InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( u ), Source( alpha ),
         PreCompose(
             InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( DualOnMorphisms( i1 ) ),
             HomomorphismStructureOnMorphisms( u, DualOnMorphisms( alpha ) )
         )
    )
);
#! true
#! @EndExample

#! Category of columns over a field

#! @Example
Q := HomalgFieldOfRationals();;
ColsQ := CategoryOfColumns( Q );;
a := 3/ColsQ;;
b := 4/ColsQ;;
IsProjective( a );
#! true
homalg_matrix := HomalgMatrix( [ [ 1, 0, 0, 0 ],
                                  [ 0, 1, 0, -1 ],
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );;
homalg_matrix := TransposedMatrix( homalg_matrix );;
alpha := homalg_matrix/ColsQ;;
homalg_matrix := HomalgMatrix( [ [ 1, 1, 0, 0 ],
                                  [ 0, 1, 0, -1 ],
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );;
homalg_matrix := TransposedMatrix( homalg_matrix );;
beta := homalg_matrix/ColsQ;;
IsWellDefined( CokernelObject( alpha ) );
#! true
c := CokernelProjection( alpha );;
gamma := UniversalMorphismIntoDirectSum( [ c, c ] );;
colift := CokernelColift( alpha, gamma );;
IsEqualForMorphisms( PreCompose( c, colift ), gamma );
#! true
FiberProduct( alpha, beta );;
F := FiberProduct( alpha, beta );;
IsWellDefined( F );
#! true
IsWellDefined( ProjectionInFactorOfFiberProduct( [ alpha, beta ], 1 ) );
#! true
IsWellDefined( Pushout( alpha, beta ) );
#! true
i1 := InjectionOfCofactorOfPushout( [ alpha, beta ], 1 );;
i2 := InjectionOfCofactorOfPushout( [ alpha, beta ], 2 );;
u := UniversalMorphismFromDirectSum( [ b, b ], [ i1, i2 ] );;
KernelObjectFunctorial( u, IdentityMorphism( Source( u ) ), u ) = IdentityMorphism( 3/ColsQ );
#! true
IsZeroForMorphisms( CokernelObjectFunctorial( u, IdentityMorphism( Range( u ) ), u ) );
#! true
DirectProductFunctorial( [ u, u ] ) = DirectSumFunctorial( [ u, u ] );
#! true
CoproductFunctorial( [ u, u ] ) = DirectSumFunctorial( [ u, u ] );
#! true
IsCongruentForMorphisms(
    FiberProductFunctorial( [ u, u ], [ IdentityMorphism( Source( u ) ), IdentityMorphism( Source( u ) ) ], [ u, u ] ),
    IdentityMorphism( FiberProduct( [ u, u ] ) )
);
#! true
IsCongruentForMorphisms(
    PushoutFunctorial( [ u, u ], [ IdentityMorphism( Range( u ) ), IdentityMorphism( Range( u ) ) ], [ u, u ] ),
    IdentityMorphism( Pushout( [ u, u ] ) )
);
#! true
IsCongruentForMorphisms( ((1/2) / Q) * alpha, alpha * ((1/2) / Q) );
#! true
RankOfObject( HomomorphismStructureOnObjects( a, b ) ) = RankOfObject( a ) * RankOfObject( b );
#! true
IsCongruentForMorphisms(
    PreCompose( [ u, DualOnMorphisms( i1 ), DualOnMorphisms( alpha ) ] ),
    InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( u ), Source( alpha ),
         PreCompose(
             InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( DualOnMorphisms( i1 ) ),
             HomomorphismStructureOnMorphisms( u, DualOnMorphisms( alpha ) )
         )
    )
);
#! true
#! @EndExample
