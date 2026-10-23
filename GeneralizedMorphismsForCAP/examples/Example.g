#! @Chapter Examples and Tests

#! @Section Basic Commands

LoadPackage( "GeneralizedMorphismsForCAP" );
LoadPackage( "LinearAlgebraForCAP" );

#! @Example
Q := HomalgFieldOfRationals();;
vec := MatrixCategory( Q );;
A := MatrixCategoryObject( vec, 4 );;
B := MatrixCategoryObject( vec, 3 );;
C := MatrixCategoryObject( vec, 2 );;
alpha := VectorSpaceMorphism( A, 
HomalgMatrix( [ [ 1, 1, 1 ], [ 0, 1, 1 ], 
[ 1, 0, 1 ], [ 1, 1, 0 ] ], 4, 3, Q ), B );;
gamma := VectorSpaceMorphism( C, 
HomalgMatrix( [ [ -1, 1, -1 ], [ 1, 0, -1 ] ], 2, 3, Q ), B );;
p := ProjectionInFactorOfFiberProduct( [ alpha, gamma ], 1 );;
q := ProjectionInFactorOfFiberProduct( [ alpha, gamma ], 2 );;
PreCompose( AsGeneralizedMorphism( alpha ), GeneralizedInverse( gamma ) );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
gen1 := PreCompose( AsGeneralizedMorphism( alpha ), 
                       GeneralizedInverse( gamma ) );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
gen2 := PreCompose( GeneralizedInverse( p ), AsGeneralizedMorphism( q ) );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
IsCongruentForMorphisms( gen1, gen2 );
#! true
# @drop_example_in_Julia (was moved manually)
#! @EndExample
