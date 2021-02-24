#! @Chapter Examples and Tests

#! @Section Projectivity test

LoadPackage( "ModulePresentationsForCAP" );

LoadPackage( "RingsForHomalg" );

#! @Example
Q := HomalgFieldOfRationalsInSingular();;
R := Q * "x";;
F := FreeLeftPresentation( 2, Q );;
HasIsProjective( F ) and IsProjective( F );
#! true
G := FreeRightPresentation( 2, Q );;
HasIsProjective( G ) and IsProjective( G );
#! true
M := AsLeftPresentation( HomalgMatrix( "[ x, x ]", 1, 2, R ) );;
IsProjective( M );
#! false
N := AsLeftPresentation( HomalgMatrix( "[ 1, x ]", 1, 2, R ) );;
IsProjective( N );
#! true
#! @EndExample
