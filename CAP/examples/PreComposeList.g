#! @Chapter Examples and Tests

#! @Section PreComposeList and PostComposeList

LoadPackage( "LinearAlgebraForCAP" );

#! @Example
field := HomalgFieldOfRationals( );;
A := VectorSpaceObject( 1, field );;
B := VectorSpaceObject( 2, field );;
C := VectorSpaceObject( 3, field );;

alpha := VectorSpaceMorphism( A, HomalgMatrix( [ [ 1, 0, 0 ] ], 1, 3, field ), C );;
beta := VectorSpaceMorphism( C, HomalgMatrix( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ], 3, 2, field ), B );;

IsCongruentForMorphisms( PreCompose( alpha, beta ), PostCompose( beta, alpha ) );
#! true

IsOne( PreComposeList( A, [ ], A ) );
#! true
IsCongruentForMorphisms( PreComposeList( A, [ alpha ], C ), alpha );
#! true
IsCongruentForMorphisms( PreComposeList( A, [ alpha, beta ], B ), PreCompose( alpha, beta ) );
#! true

IsOne( PostComposeList( A, [ ], A ) );
#! true
IsCongruentForMorphisms( PostComposeList( A, [ alpha ], C ), alpha );
#! true
IsCongruentForMorphisms( PostComposeList( A, [ beta, alpha ], B ), PostCompose( beta, alpha ) );
#! true

#! @EndExample
