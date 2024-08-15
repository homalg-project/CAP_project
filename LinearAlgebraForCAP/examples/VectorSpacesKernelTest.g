#! @Chapter Examples and Tests

#! @Section Kernel

#! @Example
Q := HomalgFieldOfRationals();;
vec := MatrixCategory( Q );;
V := MatrixCategoryObject( vec, 2 );
#! <A vector space object over Q of dimension 2>
W := MatrixCategoryObject( vec, 3 );
#! <A vector space object over Q of dimension 3>
alpha := VectorSpaceMorphism( V, [ [ 1, 1, 1 ], [ -1, -1, -1 ] ], W );
#! <A morphism in Category of matrices over Q>
k := KernelObject( alpha );
#! <A vector space object over Q of dimension 1>
T := MatrixCategoryObject( vec, 2 );
#! <A vector space object over Q of dimension 2>
tau := VectorSpaceMorphism( T, [ [ 2, 2 ], [ 2, 2 ] ], V );
#! <A morphism in Category of matrices over Q>
k_lift := KernelLift( alpha, tau );
#! <A morphism in Category of matrices over Q>
HasKernelEmbedding( alpha );
#! false
KernelEmbedding( alpha );
#! <A split monomorphism in Category of matrices over Q>
#! @EndExample

#! @Example
Q := HomalgFieldOfRationals();;
vec := MatrixCategory( Q );;
V := MatrixCategoryObject( vec, 2 );
#! <A vector space object over Q of dimension 2>
W := MatrixCategoryObject( vec, 3 );
#! <A vector space object over Q of dimension 3>
alpha := VectorSpaceMorphism( V, [ [ 1, 1, 1 ], [ -1, -1, -1 ] ], W );
#! <A morphism in Category of matrices over Q>
k := KernelObject( alpha );
#! <A vector space object over Q of dimension 1>
T := MatrixCategoryObject( vec, 2 );
#! <A vector space object over Q of dimension 2>
tau := VectorSpaceMorphism( T, [ [ 2, 2 ], [ 2, 2 ] ], V );
#! <A morphism in Category of matrices over Q>
k_lift := KernelLift( alpha, tau );
#! <A morphism in Category of matrices over Q>
HasKernelEmbedding( alpha );
#! false
#! @EndExample

#! @Example
Q := HomalgFieldOfRationals();;
vec := MatrixCategory( Q );;
V := MatrixCategoryObject( vec, 2 );
#! <A vector space object over Q of dimension 2>
W := MatrixCategoryObject( vec, 3 );
#! <A vector space object over Q of dimension 3>
alpha := VectorSpaceMorphism( V, [ [ 1, 1, 1 ], [ -1, -1, -1 ] ], W );
#! <A morphism in Category of matrices over Q>
k := KernelObject( alpha );
#! <A vector space object over Q of dimension 1>
k_emb := KernelEmbedding( alpha );
#! <A split monomorphism in Category of matrices over Q>
IsEqualForObjects( Source( k_emb ), k );
#! true
V := MatrixCategoryObject( vec, 2 );
#! <A vector space object over Q of dimension 2>
W := MatrixCategoryObject( vec, 3 );
#! <A vector space object over Q of dimension 3>
beta := VectorSpaceMorphism( V, [ [ 1, 1, 1 ], [ -1, -1, -1 ] ], W );
#! <A morphism in Category of matrices over Q>
k_emb := KernelEmbedding( beta );
#! <A split monomorphism in Category of matrices over Q>
IsIdenticalObj( Source( k_emb ), KernelObject( beta ) );
#! true
#! @EndExample
