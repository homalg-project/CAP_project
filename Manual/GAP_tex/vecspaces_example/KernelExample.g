## gapcolor ##
gap> KernelEmbedding( alpha );
A morphism in SQVec with underlying matrix:
[ [  1,  1 ] ]

gap> CokernelObject( alpha );
<An object in SQVec of dimension 2>
gap> CokernelProjection( alpha );
A morphism in SQVec with underlying matrix:
[ [  -1,  -1 ],
  [   1,   0 ],
  [   0,   1 ] ]

gap> alpha + alpha;
A morphism in SQVec with underlying matrix:
[ [   2,   2,   2 ],
  [  -2,  -2,  -2 ] ]

gap> - alpha;
A morphism in SQVec with underlying matrix:
[ [  -1,  -1,  -1 ],
  [   1,   1,   1 ] ]

## endgapcolor ##