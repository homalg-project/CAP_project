## gapcolor ##
gap> alpha := SQVecMor( V2, [ [ 1, 0, 0 ], [ 0, 1, 1 ] ], V3 );
A morphism in SQVec with underlying matrix:
[ [  1,  0,  0 ],
  [  0,  1,  1 ] ]

gap> beta := SQVecMor( V2, [ [ 1, 1, 0 ], [ 0, 0, 1 ] ], V3 );
A morphism in SQVec with underlying matrix:
[ [  1,  1,  0 ],
  [  0,  0,  1 ] ]

gap> intersection := MorphismFromFiberProductToSink( [ alpha, beta ] );
A morphism in SQVec with underlying matrix:
[ [  1,  1,  1 ] ]

## endgapcolor ##