#! @Chapter Examples and Tests

#! @Section Gauss

LoadPackage( "ModulesOverLocalRingsForCAP" );

LoadPackage( "RingsForHomalg" );

#! @Example
R := HomalgRingOfIntegers( 4 );;
category := CategoryOfLeftModulePresentationsOverLocalRing( R, [ 2 ] );;
IsRegular( category );
#! false
#! @EndExample

#! @Example
R := HomalgFieldOfRationalsInSingular() * "x,y";;
R := R/ "x^2 - y^3";;
category1 := CategoryOfLeftModulePresentationsOverLocalRing( R, [ "x", "y" ] );;
IsRegular( category1 );
#! false
category2 := CategoryOfLeftModulePresentationsOverLocalRing( R, [ "x-1", "y-1" ] );;
IsRegular( category2 );
#! true
#! @EndExample
