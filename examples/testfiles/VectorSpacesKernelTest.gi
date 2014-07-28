Read( "VectorSpacesConstructors.gi" );
vecspaces := CreateHomalgCategory( "VectorSpaces01" );
#! VectorSpaces01
Read( "VectorSpacesAddKernel01.gi" );
V := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
W := QVectorSpace( 3 );
#! <A rational vector space of dimension 3>
alpha := VectorSpaceMorphism( V, [ [ 1, 1, 1 ], [ -1, -1, -1 ] ], W );
#! A rational vector space homomorphism with matrix: 
#! [ [   1,   1,   1 ],
#!   [  -1,  -1,  -1 ] ]
#! 
k := KernelObject( alpha );
#! <A rational vector space of dimension 1>
KernelEmb( k );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  1 ] ]
#!
IsIdenticalObj( Source( last ), k );
#! true
T := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
tau := VectorSpaceMorphism( T, [ [ 2, 2 ], [ 2, 2 ] ], V );
#! A rational vector space homomorphism with matrix: 
#! [ [  2,  2 ],
#!   [  2,  2 ] ]
#! 
KernelLift( k, tau );
#! A rational vector space homomorphism with matrix: 
#! [ [  2 ],
#!   [  2 ] ]
#! 
IsIdenticalObj( Range( last ), k );
#! true