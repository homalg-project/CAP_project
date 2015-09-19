#! @Chapter Examples and Tests

#! @Section Kernel

if not IsBound( VectorSpacesConstructorsLoaded ) then
  
  ReadPackage( "CAP", "examples/testfiles/VectorSpacesConstructors.gi" );
  
fi;

#! @Example
vecspaces := CreateCapCategory( "VectorSpaces01" );
#! VectorSpaces01
ReadPackage( "CAP", "examples/testfiles/VectorSpacesAddKernel01.gi" );
#! true
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
T := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
tau := VectorSpaceMorphism( T, [ [ 2, 2 ], [ 2, 2 ] ], V );
#! A rational vector space homomorphism with matrix: 
#! [ [  2,  2 ],
#!   [  2,  2 ] ]
#! 
k_lift := KernelLift( k, tau );
#! A rational vector space homomorphism with matrix: 
#! [ [  2 ],
#!   [  2 ] ]
#! 
HasKernelEmbedding( k );
#! false
KernelEmbedding( k );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  1 ] ]
#! 
#! @EndExample

#! @Example
vecspaces := CreateCapCategory( "VectorSpaces02" );
#! VectorSpaces02
ReadPackage( "CAP", "examples/testfiles/VectorSpacesAddKernel02.gi" );
#! true
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
T := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
tau := VectorSpaceMorphism( T, [ [ 2, 2 ], [ 2, 2 ] ], V );
#! A rational vector space homomorphism with matrix: 
#! [ [  2,  2 ],
#!   [  2,  2 ] ]
#! 
k_lift := KernelLift( k, tau );
#! A rational vector space homomorphism with matrix: 
#! [ [  2 ],
#!   [  2 ] ]
#! 
HasKernelEmbedding( k );
#! false
#! @EndExample

#! @Example
vecspaces := CreateCapCategory( "VectorSpaces03" );
#! VectorSpaces03
ReadPackage( "CAP", "examples/testfiles/VectorSpacesAddKernel03.gi" );
#! true
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
k_emb := KernelEmbedding( k );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  1 ] ]
#! 
IsIdenticalObj( Source( k_emb ), k );
#! true
V := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
W := QVectorSpace( 3 );
#! <A rational vector space of dimension 3>
beta := VectorSpaceMorphism( V, [ [ 1, 1, 1 ], [ -1, -1, -1 ] ], W );
#! A rational vector space homomorphism with matrix: 
#! [ [   1,   1,   1 ],
#!   [  -1,  -1,  -1 ] ]
#! 
k_emb := KernelEmbedding( beta );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  1 ] ]
#! 
IsIdenticalObj( Source( k_emb ), KernelObject( beta ) );
#! true
#! @EndExample
