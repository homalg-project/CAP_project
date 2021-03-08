## gapcolor ##
gap> InstallFunctor( double_functor, "DoubleFunctor" );
gap> V4 := DoubleFunctor( V2 );
<An object in SQVec of dimension 4>
gap> V4_2 := ApplyFunctor( double_functor, V2 );
<An object in SQVec of dimension 4>
gap> IsIdenticalObj( V4, V4_2 );
true
gap> DoubleFunctor( alpha2 );
A morphism in SQVec with underlying matrix:
[ [  0,  0,  0,  0 ],
  [  1,  0,  0,  0 ],
  [  0,  1,  0,  0 ],
  [  0,  0,  0,  0 ],
  [  0,  0,  1,  0 ],
  [  0,  0,  0,  1 ] ]

## endgapcolor ##