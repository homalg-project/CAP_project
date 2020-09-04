#! @Chapter Examples and Tests

#! @Section FiberProduct

if not IsBound( VectorSpacesConstructorsLoaded ) then

  ReadPackage( "CAP", "examples/VectorSpacesConstructors.g" );;

fi;

#! @Example
vecspaces := CreateCapCategory( "VectorSpacesForFiberProductTest" );
#! VectorSpacesForFiberProductTest
ReadPackage( "CAP", "examples/VectorSpacesAllMethods.g" );
#! true
A := QVectorSpace( 1 );
#! <A rational vector space of dimension 1>
B := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
C := QVectorSpace( 3 );
#! <A rational vector space of dimension 3>
AtoC := VectorSpaceMorphism( A, [ [ 1, 2, 0 ] ], C );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  2,  0 ] ]
#! 
BtoC := VectorSpaceMorphism( B, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], C );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  0,  0 ],
#!   [  0,  1,  0 ] ]
#! 
P := FiberProduct( AtoC, BtoC );
#! <A rational vector space of dimension 1>
p1 := ProjectionInFactorOfFiberProduct( [ AtoC, BtoC ], 1 );
#! A rational vector space homomorphism with matrix: 
#! [ [  1/2 ] ]
#! 
p2 := ProjectionInFactorOfFiberProduct( [ AtoC, BtoC ], 2 );
#! A rational vector space homomorphism with matrix: 
#! [ [  1/2,    1 ] ]
#! 
#! @EndExample
