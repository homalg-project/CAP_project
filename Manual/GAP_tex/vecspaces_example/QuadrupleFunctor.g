## gapcolor ##
gap> quadruple_functor := PreCompose( double_functor, double_functor );
Composition of DoubleOfVecspaces and DoubleOfVecspaces
gap> ApplyFunctor( quadruple_functor, V2 );
<A rational vector space of dimension 8>
gap> ApplyFunctor( quadruple_functor, alpha2 );
A rational vector space homomorphism with matrix: 
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