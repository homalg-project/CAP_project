## gapcolor ##
gap> alpha := VectorSpaceMorphism( V, [ [ 1, 0, 0 ], [ 0, 1, 1 ] ], W );
A rational vector space homomorphism with matrix: 
[ [  1,  0,  0 ],
  [  0,  1,  1 ] ]
gap> beta := VectorSpaceMorphism( V, [ [ 1, 1, 0 ], [ 0, 0, 1 ] ], W );
A rational vector space homomorphism with matrix: 
[ [  1,  1,  0 ],
  [  0,  0,  1 ] ]
gap> fiberproduct := FiberProduct( alpha, beta );
<A rational vector space of dimension 1>
gap> projection := ProjectionInFactor( fiberproduct, 1 );
A rational vector space homomorphism with matrix: 
[ [  1,  1 ] ]
gap> intersection := PreCompose( projection, alpha );
A rational vector space homomorphism with matrix: 
[ [  1,  1,  1 ] ]
## endgapcolor ##