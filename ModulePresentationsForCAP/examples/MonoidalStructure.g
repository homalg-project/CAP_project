#! @Chapter Examples and Tests

#! @Section Closed Monoidal Structure

LoadPackage( "ModulePresentationsForCAP" );

LoadPackage( "RingsForHomalg" );

#! @Example
R := HomalgRingOfIntegers( );;
fpres := LeftPresentations( R );;
M := AsLeftPresentation( fpres, HomalgMatrix( [ [ 2 ] ], 1, 1, R ) );
#! <An object in Category of left presentations of Z>
N := AsLeftPresentation( fpres, HomalgMatrix( [ [ 3 ] ], 1, 1, R ) );
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
#! [ [   0,   0,   0,  -2 ],
#!   [   1,   2,   0,   0 ],
#!   [   0,   2,   2,   0 ],
#!   [   2,   3,   0,   2 ] ]
#! 
#! An object in Category of left presentations of Z
alpha := StandardGeneratorMorphism( H, 3 );
#! <A morphism in Category of left presentations of Z>
l := LambdaElimination( DirectSum( M, M ), DirectSum( M, N ), alpha );
#! <A morphism in Category of left presentations of Z>
IsZero( l );
#! false
Display( l );
#! [ [  -2,   6 ],
#!   [  -1,  -3 ] ]
#!
#! A morphism in Category of left presentations of Z
#! @EndExample
