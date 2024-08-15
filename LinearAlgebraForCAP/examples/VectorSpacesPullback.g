#! @Chapter Examples and Tests

#! @Section FiberProduct

#! @Example
Q := HomalgFieldOfRationals();;
vec := MatrixCategory( Q );;
A := MatrixCategoryObject( vec, 1 );
#! <A vector space object over Q of dimension 1>
B := MatrixCategoryObject( vec, 2 );
#! <A vector space object over Q of dimension 2>
C := MatrixCategoryObject( vec, 3 );
#! <A vector space object over Q of dimension 3>
AtoC := VectorSpaceMorphism( A, [ [ 1, 2, 0 ] ], C );
#! <A morphism in Category of matrices over Q>
BtoC := VectorSpaceMorphism( B, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], C );
#! <A morphism in Category of matrices over Q>
P := FiberProduct( AtoC, BtoC );
#! <A vector space object over Q of dimension 1>
p1 := ProjectionInFactorOfFiberProduct( [ AtoC, BtoC ], 1 );
#! <A morphism in Category of matrices over Q>
p2 := ProjectionInFactorOfFiberProduct( [ AtoC, BtoC ], 2 );
#! <A morphism in Category of matrices over Q>
#! @EndExample
