## gapcolor ##
gap> V1 := SQVecObj( 1 );
<An object in SQVec of dimension 1>
gap> delta := SQVecMor( V2, [ [ 1, 0 ], [ 0, 0 ] ], V2 );
A morphism in SQVec with underlying matrix:
[ [  1,  0 ],
  [  0,  0 ] ]

gap> beta := SQVecMor( V2, [ [ 2, 4, 0 ], [ 3, 5, 0 ] ], V3 );
A morphism in SQVec with underlying matrix:
[ [  2,  4,  0 ],
  [  3,  5,  0 ] ]

gap> lambda := SQVecMor( V3, [ [ 0 ], [ 0 ], [ 1 ] ], V1 );
A morphism in SQVec with underlying matrix:
[ [  0 ],
  [  0 ],
  [  1 ] ]

gap> snake_lemma_morphism( delta, beta, lambda );
A morphism in SQVec with underlying matrix:
[ [  -1 ] ]

## endgapcolor ##