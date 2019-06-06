#! @Chapter Examples and Tests

#! @Section Basics

LoadPackage( "MonoidalCategories" );
LoadPackage( "MatricesForHomalg" );

#! @Example
vecspaces := CreateCapCategory( "VectorSpaces" );;
ReadPackage( "MonoidalCategories", "examples/VectorSpacesMonoidalCategory.gi" );;
z := ZeroObject( vecspaces );;
a := QVectorSpace( 1 );;
b := QVectorSpace( 2 );;
c := QVectorSpace( 3 );;
alpha := VectorSpaceMorphism( a, [ [ 1, 0 ] ], b );;
beta := VectorSpaceMorphism( b, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], c );;
gamma := VectorSpaceMorphism( c, [ [ 0, 1, 1 ], [ 1, 0, 1 ], [ 1, 1, 0 ] ], c );;
IsCongruentForMorphisms( TensorProductOnMorphisms( alpha, beta ), TensorProductOnMorphisms( beta, alpha ) );
#! false
IsOne( AssociatorRightToLeft( a, b, c ) );
#! true
IsCongruentForMorphisms( gamma, LambdaElimination( c, c, LambdaIntroduction( gamma ) ) );
#! true
IsZero( TraceMap( gamma ) );
#! true
IsCongruentForMorphisms( RankMorphism( DirectSum( a, b ) ), RankMorphism( c ) );
#! true
IsOne( Braiding( b, c ) );
#! false
IsOne( PreCompose( Braiding( b, c ), Braiding( c, b ) ) );
#! true
#! @EndExample