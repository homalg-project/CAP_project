LoadPackage( "ActionsForCAP" );
LoadPackage( "LinearAlgebraForCAP" );
Q := HomalgFieldOfRationals();
vec := MatrixCategory( Q );
u := TensorUnit( vec );
LeftActionsCategory( u );
V := VectorSpaceObject( 2, Q );
alpha := VectorSpaceMorphism( TensorProductOnObjects( u, V ), HomalgMatrix( [ [ 0, 1 ], [ -1, 0 ] ], 2, 2, Q ), V );