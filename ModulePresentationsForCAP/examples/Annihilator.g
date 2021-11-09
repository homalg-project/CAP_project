#! @Chapter Examples and Tests

#! @Section Annihilator

LoadPackage( "ModulePresentationsForCAP" );

LoadPackage( "RingsForHomalg" );

#! @Example
ZZ := HomalgRingOfIntegersInSingular();;
M1 := AsLeftPresentation( HomalgMatrix( [ [ "2" ] ], ZZ ) );;
M2 := AsLeftPresentation( HomalgMatrix( [ [ "3" ] ], ZZ ) );;
M3 := AsLeftPresentation( HomalgMatrix( [ [ "4" ] ], ZZ ) );;
M := DirectSum( M1, M2, M3 );;
Display( Annihilator( M ) );
#! 12
#! 
#! A monomorphism in Category of left presentations of Z
M1 := AsRightPresentation( HomalgMatrix( [ [ "2" ] ], ZZ ) );;
M2 := AsRightPresentation( HomalgMatrix( [ [ "3" ] ], ZZ ) );;
M3 := AsRightPresentation( HomalgMatrix( [ [ "4" ] ], ZZ ) );;
M := DirectSum( M1, M2, M3 );;
Display( Annihilator( M ) );
#! 12
#! 
#! A monomorphism in Category of right presentations of Z
#! @EndExample
