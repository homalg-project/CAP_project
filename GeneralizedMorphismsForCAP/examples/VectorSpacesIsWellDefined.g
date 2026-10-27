#! @Chapter Examples and Tests

#! @Section IsWellDefined

LoadPackage( "GeneralizedMorphismsForCAP" );
LoadPackage( "LinearAlgebraForCAP" );

#! @Example
Q := HomalgFieldOfRationals();
#! Q
vec := MatrixCategory( Q );;
A := MatrixCategoryObject( vec, 1 );
#! <A vector space object over Q of dimension 1>
B := MatrixCategoryObject( vec, 2 );
#! <A vector space object over Q of dimension 2>
alpha := VectorSpaceMorphism( A, [ [ 1, 2 ] ], B );
#! <A morphism in Category of matrices over Q>
g := GeneralizedMorphism( alpha, alpha, alpha );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
IsWellDefined( alpha );
#! true
IsWellDefined( g );
#! true
IsEqualForObjects( A, B );
#! false
# @drop_example_in_Julia (was moved manually)
#! @EndExample
