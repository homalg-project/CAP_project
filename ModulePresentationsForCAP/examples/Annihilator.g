#! @Chapter Examples and Tests

#! @Section Annihilator

LoadPackage( "ModulePresentationsForCAP" );

LoadPackage( "RingsForHomalg" );

#! @Example
ZZZ := HomalgRingOfIntegersInSingular();;
fpres := LeftPresentations( ZZZ );;
M1 := AsLeftPresentation( fpres, HomalgMatrix( [ [ "2" ] ], ZZZ ) );;
M2 := AsLeftPresentation( fpres, HomalgMatrix( [ [ "3" ] ], ZZZ ) );;
M3 := AsLeftPresentation( fpres, HomalgMatrix( [ [ "4" ] ], ZZZ ) );;
M := DirectSum( M1, M2, M3 );;
Display( Annihilator( M ) );
#! 12
#! 
#! A monomorphism in Category of left presentations of Z
fpres := RightPresentations( ZZZ );;
M1 := AsRightPresentation( fpres, HomalgMatrix( [ [ "2" ] ], ZZZ ) );;
M2 := AsRightPresentation( fpres, HomalgMatrix( [ [ "3" ] ], ZZZ ) );;
M3 := AsRightPresentation( fpres, HomalgMatrix( [ [ "4" ] ], ZZZ ) );;
M := DirectSum( M1, M2, M3 );;
Display( Annihilator( M ) );
#! 12
#! 
#! A monomorphism in Category of right presentations of Z
#! @EndExample
