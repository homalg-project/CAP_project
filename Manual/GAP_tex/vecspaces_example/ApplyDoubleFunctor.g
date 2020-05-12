## gapcolor ##
gap> ApplyFunctor( double_functor, V2 );
<An object in SQVec of dimension 4>
gap> alpha2 := SQVecMor( V3, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ] ], V2 );
A morphism in SQVec with underlying matrix:
[ [  0,  0 ],
  [  1,  0 ],
  [  0,  1 ] ]

gap> ApplyFunctor( double_functor, alpha2 );
A morphism in SQVec with underlying matrix:
[ [  0,  0,  0,  0 ],
  [  1,  0,  0,  0 ],
  [  0,  1,  0,  0 ],
  [  0,  0,  0,  0 ],
  [  0,  0,  1,  0 ],
  [  0,  0,  0,  1 ] ]

## endgapcolor ##