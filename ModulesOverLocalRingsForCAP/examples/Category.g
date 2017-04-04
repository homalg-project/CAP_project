#! @Chapter Examples and Tests

#! @Section Gauss

LoadPackage( "ModulesOverLocalRingsForCAP" );

LoadPackage( "RingsForHomalg" );
#! @Example
Q := HomalgFieldOfRationalsInSingular();;
R := Q * "x,y,z";;
category := CategoryOfLeftModulePresentationsOverLocalRing( R, [ "x", "y", "z" ] );;
M := AsLeftPresentation( HomalgMatrix( [ [ "(x^2 + y^2 + z^2 - 1)^2" ] ], 1, 1, R ) );;
N := AsSerreQuotientCategoryObject( category, M );;
IsZero( N );
#! true
M := AsLeftPresentation( HomalgMatrix( [ [ "(x^2 + y^2 + z^2)^2" ] ], 1, 1, R ) );;
N := AsSerreQuotientCategoryObject( category, M );;
IsZero( N );
#! false
#! @EndExample