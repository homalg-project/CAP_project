#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "ActionsForCAP", false );
#! true
LoadPackage( "LinearAlgebraForCAP", false );
#! true

Q := HomalgFieldOfRationals();;
vec := MatrixCategory( Q );;
u := TensorUnit( vec );;
cat := LeftActionsCategory( u );
#! Category of left actions of <A vector space object over Q of dimension 1>
V := MatrixCategoryObject( vec, 2 );
#! <A vector space object over Q of dimension 2>
alpha := VectorSpaceMorphism( TensorProductOnObjects( u, V ), HomalgMatrix( [ [ 0, 1 ], [ -1, 0 ] ], 2, 2, Q ), V );
#! <A morphism in Category of matrices over Q>

#! @EndExample
