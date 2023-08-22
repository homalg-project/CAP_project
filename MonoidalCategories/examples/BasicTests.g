#! @Chapter Examples and Tests

#! @Section Basics

#! @Example
LoadPackage( "MonoidalCategories", false );
#! true
LoadPackage( "LinearAlgebraForCAP", false );
#! true
Q := HomalgFieldOfRationals();
#! Q
a := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
b := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
c := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
z := ZeroObject( CapCategory( a ) );
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
        TensorProductOnMorphisms( beta, alpha ) );
#! false
IsOne( AssociatorRightToLeft( a, b, c ) );
#! true
IsCongruentForMorphisms(
        gamma, LambdaElimination( c, c, LambdaIntroduction( gamma ) ) );
#! true
IsZero( TraceMap( gamma ) );
#! true
IsCongruentForMorphisms(
        RankMorphism( DirectSum( a, b ) ), RankMorphism( c ) );
#! true
IsOne( Braiding( b, c ) );
#! false
IsOne( PreCompose( Braiding( b, c ), Braiding( c, b ) ) );
#! true
#! @EndExample
