#! @Chapter Examples and Tests

#! @Section FiberProduct

#! @Example
Q := HomalgFieldOfRationals();
#! Q
A := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
B := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
C := VectorSpaceObject( 3, Q );
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
