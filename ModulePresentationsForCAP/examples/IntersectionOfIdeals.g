#! @Chapter Examples and Tests

#! @Section Intersection of Submodules

LoadPackage( "ModulePresentationsForCAP" );

LoadPackage( "RingsForHomalg" );

#! @Example
Q := HomalgFieldOfRationalsInSingular();;
R := Q * "x,y";
#! Q[x,y]
fpres := LeftPresentations( R );;
F := AsLeftPresentation( fpres, HomalgMatrix( [ [ 0 ] ], R ) );
#! <An object in Category of left presentations of Q[x,y]>
I1 := AsLeftPresentation( fpres, HomalgMatrix( [ [ "x" ] ], R ) );;
I2 := AsLeftPresentation( fpres, HomalgMatrix( [ [ "y" ] ], R ) );;
Display( I1 );
#! x
#! 
#! An object in Category of left presentations of Q[x,y]
Display( I2 );
#! y
#! 
#! An object in Category of left presentations of Q[x,y]
eps1 := PresentationMorphism( F, HomalgMatrix( [ [ 1 ] ], R ), I1 );
#! <A morphism in Category of left presentations of Q[x,y]>
eps2 := PresentationMorphism( F, HomalgMatrix( [ [ 1 ] ], R ), I2 );
#! <A morphism in Category of left presentations of Q[x,y]>
kernelemb1 := KernelEmbedding( eps1 );
#! <A monomorphism in Category of left presentations of Q[x,y]>
kernelemb2 := KernelEmbedding( eps2 );
#! <A monomorphism in Category of left presentations of Q[x,y]>
P := FiberProduct( kernelemb1, kernelemb2 );;
Display( P );
#! (an empty 0 x 1 matrix)
#! 
#! An object in Category of left presentations of Q[x,y]
pi1 := ProjectionInFactorOfFiberProduct( [ kernelemb1, kernelemb2 ], 1 );
#! <A monomorphism in Category of left presentations of Q[x,y]>
composite := PreCompose( pi1, kernelemb1 );
#! <A monomorphism in Category of left presentations of Q[x,y]>
Display( composite );
#! x*y
#! 
#! A monomorphism in Category of left presentations of Q[x,y]
#! @EndExample
