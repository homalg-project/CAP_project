## gapcolor ##
gap> quadruple_functor := PreCompose( double_functor, double_functor );
Precomposition of DoubleOfVecspaces and DoubleOfVecspaces
gap> ApplyFunctor( quadruple_functor, V2 );
<An object in SQVec of dimension 8>
gap> ApplyFunctor( quadruple_functor, alpha2 );
A morphism in SQVec with underlying matrix:
[ [  0,  0,  0,  0,  0,  0,  0,  0 ],
  [  1,  0,  0,  0,  0,  0,  0,  0 ],
  [  0,  1,  0,  0,  0,  0,  0,  0 ],
  [  0,  0,  0,  0,  0,  0,  0,  0 ],
  [  0,  0,  1,  0,  0,  0,  0,  0 ],
  [  0,  0,  0,  1,  0,  0,  0,  0 ],
  [  0,  0,  0,  0,  0,  0,  0,  0 ],
  [  0,  0,  0,  0,  1,  0,  0,  0 ],
  [  0,  0,  0,  0,  0,  1,  0,  0 ],
  [  0,  0,  0,  0,  0,  0,  0,  0 ],
  [  0,  0,  0,  0,  0,  0,  1,  0 ],
  [  0,  0,  0,  0,  0,  0,  0,  1 ] ]

## endgapcolor ##