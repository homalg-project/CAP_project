## gapcolor ##
gap> KernelEmb( alpha );
A rational vector space homomorphism with matrix:
[ [  1,  1 ] ]
gap> Cokernel( alpha );
<A rational vector space of dimension 2>
gap> CokernelProj( alpha );
A rational vector space homomorphism with matrix: 
[ [  -1,  -1 ],
  [   1,   0 ],
  [   0,   1 ] ]
gap> alpha + alpha;
A rational vector space homomorphism with matrix: 
[ [   2,   2,   2 ],
  [  -2,  -2,  -2 ] ]
gap> - alpha;
A rational vector space homomorphism with matrix: 
[ [  -1,  -1,  -1 ],
  [   1,   1,   1 ] ]
## endgapcolor ##