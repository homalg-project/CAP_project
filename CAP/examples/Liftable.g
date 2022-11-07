#! @Chapter Examples and Tests

#! @Section Liftable

LoadPackage( "LinearAlgebraForCAP" );

#! @Example
field := HomalgFieldOfRationals( );;
V := VectorSpaceObject( 1, field );;
W := VectorSpaceObject( 2, field );;
alpha := VectorSpaceMorphism( V, HomalgMatrix( [ [ 1, -1 ] ], 1, 2, field ), W );;
beta := VectorSpaceMorphism( W, HomalgMatrix( [ [ 1, 2 ], [ 3, 4 ] ], 2, 2, field ), W );;
IsLiftable( alpha, beta );
#! true
IsLiftable( beta, alpha );
#! false
IsLiftableAlongMonomorphism( beta, alpha );
#! true
gamma := VectorSpaceMorphism( W, HomalgMatrix( [ [ 1 ], [ 1 ] ], 2, 1, field ), V );;
IsColiftable( beta, gamma );
#! true
IsColiftable( gamma, beta );
#! false
IsColiftableAlongEpimorphism( beta, gamma );
#! true
PreCompose( PreInverseForMorphisms( gamma ), gamma ) = IdentityMorphism( V );
#! true
PreCompose( alpha, PostInverseForMorphisms( alpha ) ) = IdentityMorphism( V );
#! true
#! @EndExample
