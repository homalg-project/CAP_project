#! @Chapter Examples and Tests

#! @Section IsWellDefined

LoadPackage( "GeneralizedMorphismsForCAP" );
LoadPackage( "LinearAlgebraForCAP" );

#! @Example
Q := HomalgFieldOfRationals();
#! Q
A := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
B := VectorSpaceObject( 2, Q );
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
#! @EndExample
