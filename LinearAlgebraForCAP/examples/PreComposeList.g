#! @Chapter Examples and Tests

#! @Section PreComposeList and PostComposeList

LoadPackage( "LinearAlgebraForCAP" );

#! @Example
field := HomalgFieldOfRationals( );;
vec := MatrixCategory( field );;
A := MatrixCategoryObject( vec, 1 );;
B := MatrixCategoryObject( vec, 2 );;
C := MatrixCategoryObject( vec, 3 );;

alpha := VectorSpaceMorphism( A, HomalgMatrix( [ [ 1, 0, 0 ] ], 1, 3, field ), C );;
beta := VectorSpaceMorphism( C, HomalgMatrix( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ], 3, 2, field ), B );;

IsCongruentForMorphisms( PreCompose( alpha, beta ), PostCompose( beta, alpha ) );
#! true

IsCongruentForMorphisms( PreComposeList( A, [ ], A ), IdentityMorphism( A ) );
#! true
IsCongruentForMorphisms( PreComposeList( A, [ alpha ], C ), alpha );
#! true
IsCongruentForMorphisms( PreComposeList( A, [ alpha, beta ], B ), PreCompose( alpha, beta ) );
#! true

IsCongruentForMorphisms( PostComposeList( A, [ ], A ), IdentityMorphism( A ) );
#! true
IsCongruentForMorphisms( PostComposeList( A, [ alpha ], C ), alpha );
#! true
IsCongruentForMorphisms( PostComposeList( A, [ beta, alpha ], B ), PostCompose( beta, alpha ) );
#! true

#! @EndExample
