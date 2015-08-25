## gapcolor ##
gap> V2;
<A rational vector space of dimension 2>
gap> ApplyFunctor( double_functor, V2 );
<A rational vector space of dimension 4>
gap> alpha2;
A rational vector space homomorphism with matrix:
[ [  0,  0 ],
  [  1,  0 ],
  [  0,  1 ] ]
gap> ApplyFunctor( double_functor, alpha2 );
A rational vector space homomorphism with matrix:
[ [  0,  0,  0,  0 ],
  [  1,  0,  0,  0 ],
  [  0,  1,  0,  0 ],
  [  0,  0,  0,  0 ],
  [  0,  0,  1,  0 ],
  [  0,  0,  0,  1 ] ]
## endgapcolor ##