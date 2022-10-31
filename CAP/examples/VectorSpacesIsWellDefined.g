#! @Chapter Examples and Tests

#! @Section IsWellDefined

if not IsBound( VectorSpacesConstructorsLoaded ) then

  ReadPackage( "CAP", "examples/VectorSpacesConstructors.g" );;

fi;

#! @Example
vecspaces := CreateCapCategory( "VectorSpacesForIsWellDefinedTest" );
#! VectorSpacesForIsWellDefinedTest 
ReadPackage( "CAP", "examples/VectorSpacesAllMethods.g" );
#! true
LoadPackage( "GeneralizedMorphismsForCAP", false );
#! true
A := QVectorSpace( 1 );
#! <A rational vector space of dimension 1>
B := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
alpha := VectorSpaceMorphism( A, [ [ 1, 2 ] ], B );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  2 ] ]
#! 
g := GeneralizedMorphism( alpha, alpha, alpha );
#! <A morphism in Generalized morphism category of VectorSpacesForIsWellDefinedTest>
IsWellDefined( alpha );
#! true
IsWellDefined( g );
#! true
IsEqualForObjects( A, B );
#! false
#! @EndExample
