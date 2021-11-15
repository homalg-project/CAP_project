#! @Chapter Examples and Tests

#! @Section Basics

#! @Example
LoadPackage( "MonoidalCategories" );
#! true
vecspaces := CreateCapCategory( "VectorSpaces" );
#! VectorSpaces
ReadPackage( "MonoidalCategories",
        "examples/VectorSpacesMonoidalCategory.gi" );
#! true
z := ZeroObject( vecspaces );
#! <A rational vector space of dimension 0>
a := QVectorSpace( 1 );
#! <A rational vector space of dimension 1>
b := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
c := QVectorSpace( 3 );
#! <A rational vector space of dimension 3>
alpha := VectorSpaceMorphism( a, [ [ 1, 0 ] ], b );
#! A rational vector space homomorphism with matrix:
#! [ [  1,  0 ] ]
beta := VectorSpaceMorphism( b,
                [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], c );
#! A rational vector space homomorphism with matrix:
#! [ [  1,  0,  0 ],
#!   [  0,  1,  0 ] ]
gamma := VectorSpaceMorphism( c,
                 [ [ 0, 1, 1 ], [ 1, 0, 1 ], [ 1, 1, 0 ] ], c );
#! A rational vector space homomorphism with matrix:
#! [ [  0,  1,  1 ],
#!   [  1,  0,  1 ],
#!   [  1,  1,  0 ] ]
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
