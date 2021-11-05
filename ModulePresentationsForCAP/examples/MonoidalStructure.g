#! @Chapter Examples and Tests

#! @Section Closed Monoidal Structure

LoadPackage( "ModulePresentationsForCAP" );

LoadPackage( "RingsForHomalg" );

#! @Example
R := HomalgRingOfIntegers( );;
M := AsLeftPresentation( HomalgMatrix( [ [ 2 ] ], 1, 1, R ) );
#! <An object in Category of left presentations of Z>
N := AsLeftPresentation( HomalgMatrix( [ [ 3 ] ], 1, 1, R ) );
#! <An object in Category of left presentations of Z>
T := TensorProductOnObjects( M, N );
#! <An object in Category of left presentations of Z>
Display( T );
#! [ [  3 ],
#!   [  2 ] ]
#! 
#! An object in Category of left presentations of Z
IsZero( T );
#! true
H := InternalHomOnObjects( DirectSum( M, M ), DirectSum( M, N ) );
#! <An object in Category of left presentations of Z>
Display( H );
#! [ [  -4,  -2 ],
#!   [   2,   2 ] ]
#! 
#! An object in Category of left presentations of Z
alpha := StandardGeneratorMorphism( H, 1 );
#! <A morphism in Category of left presentations of Z>
l := LambdaElimination( DirectSum( M, M ), DirectSum( M, N ), alpha );
#! <A morphism in Category of left presentations of Z>
IsZero( l );
#! false
Display( l );
#! [ [  0,   0 ],
#!   [  1,  0 ] ]
#!
#! A morphism in Category of left presentations of Z
alpha2 := StandardGeneratorMorphism( H, 2 );
#! <A morphism in Category of left presentations of Z>
l2 := LambdaElimination( DirectSum( M, M ), DirectSum( M, N ), alpha2 );
#! <A morphism in Category of left presentations of Z>
IsZero( l2 );
#! false
Display( l2 );
#! [ [  1,   0 ],
#!   [  0,  0 ] ]
#!
#! A morphism in Category of left presentations of Z
#! @EndExample
