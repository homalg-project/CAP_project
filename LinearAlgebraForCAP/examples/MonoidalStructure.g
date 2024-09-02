#! @Chapter Examples and Tests

#! @Section Monoidal structure

#! @Example
LoadPackage( "LinearAlgebraForCAP", false );
#! true
Q := HomalgFieldOfRationals();;
vec := MatrixCategory( Q );;
a := MatrixCategoryObject( vec, 1 );
#! <A vector space object over Q of dimension 1>
b := MatrixCategoryObject( vec, 2 );
#! <A vector space object over Q of dimension 2>
c := MatrixCategoryObject( vec, 3 );
#! <A vector space object over Q of dimension 3>
z := ZeroObject( vec );
#! <A vector space object over Q of dimension 0>
alpha := VectorSpaceMorphism( a, [ [ 1, 0 ] ], b );
#! <A morphism in Category of matrices over Q>
beta := VectorSpaceMorphism( b,
                [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], c );
#! <A morphism in Category of matrices over Q>
gamma := VectorSpaceMorphism( c,
                 [ [ 0, 1, 1 ], [ 1, 0, 1 ], [ 1, 1, 0 ] ], c );
#! <A morphism in Category of matrices over Q>
IsCongruentForMorphisms(
    TensorProductOnMorphisms( alpha, beta ),
    TensorProductOnMorphisms( beta, alpha )
);
#! false
IsCongruentForMorphisms(
    AssociatorRightToLeft( a, b, c ),
    IdentityMorphism( TensorProductOnObjects( a, TensorProductOnObjects( b, c ) ) )
);
#! true
IsCongruentForMorphisms(
    gamma,
    LambdaElimination( c, c, LambdaIntroduction( gamma ) )
);
#! true
IsZeroForMorphisms( TraceMap( gamma ) );
#! true
IsCongruentForMorphisms(
    RankMorphism( DirectSum( a, b ) ),
    RankMorphism( c )
);
#! true
IsCongruentForMorphisms(
    Braiding( b, c ),
    IdentityMorphism( TensorProductOnObjects( b, c ) )
);
#! false
IsCongruentForMorphisms(
    PreCompose( Braiding( b, c ), Braiding( c, b ) ),
    IdentityMorphism( TensorProductOnObjects( b, c ) )
);
#! true
#! @EndExample
