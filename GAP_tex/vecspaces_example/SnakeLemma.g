## gapcolor ##
gap> LoadPackage( "HomologicalAlgebraForCAP" );
true
gap> V1 := QVectorSpace( 1 );
<A rational vector space of dimension 1>
gap> V2 := QVectorSpace( 2 );
<A rational vector space of dimension 2>
gap> V3 := QVectorSpace( 3 );
<A rational vector space of dimension 3>
gap> alpha2 := VectorSpaceMorphism( V3, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ] ], V2 );
A rational vector space homomorphism with matrix: 
[ [  0,  0 ],
  [  1,  0 ],
  [  0,  1 ] ]
gap> beta1 := VectorSpaceMorphism( V2, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], V3 );
A rational vector space homomorphism with matrix: 
[ [  1,  0,  0 ],
  [  0,  1,  0 ] ]
gap> gamma1 := VectorSpaceMorphism( V1, [ [ 1, 0 ] ], V2 );
A rational vector space homomorphism with matrix: 
[ [  1,  0 ] ]
gap> gamma2 := IdentityMorphism( V3 );
A rational vector space homomorphism with matrix: 
[ [  1,  0,  0 ],
  [  0,  1,  0 ],
  [  0,  0,  1 ] ]
gap> gamma3 := VectorSpaceMorphism( V2, [ [ 0 ], [ 1 ] ], V1 );
A rational vector space homomorphism with matrix: 
[ [  0 ],
  [  1 ] ]
gap> snake := SnakeLemmaConnectingHomomorphism( alpha2, gamma1, gamma2,
> gamma3, beta1 );
A rational vector space homomorphism with matrix: 
[ [  1 ] ]
## endgapcolor ##