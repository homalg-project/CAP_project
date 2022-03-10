#! @Chapter Examples and Tests

#! @Section Intersection theory

LoadPackage( "ModulesOverLocalRingsForCAP" );

LoadPackage( "RingsForHomalg" );

#! @Example
Q := HomalgFieldOfRationalsInSingular( );;
R := Q * "x,y,z";;
category := CategoryOfLeftModulePresentationsOverLocalRing( R, [ "y","z" ] );;
A := HomalgMatrix( "[ y ]", 1, 1, R );;
Ap := AsLeftPresentation( A );;
A := AsSerreQuotientCategoryObject( category, Ap );;
B := HomalgMatrix( "[ z ]", 1, 1, R );;
Bp := AsLeftPresentation( B );;
B := AsSerreQuotientCategoryObject( category, Bp );;
T := TorComplex( A, B );;
H0 := HomologyFunctor( category, 0 );;
H1 := HomologyFunctor( category, 1 );;
H2 := HomologyFunctor( category, 2 );;
h0 := ApplyFunctor( H0, T );;
MinimalNumberOfGenerators( h0 );
#! 1
ph0 := Source( FiltrationByPrimeIdealEmbedding( h0 ) );;
MinimalNumberOfGenerators( ph0 );
#! 0
h1 := ApplyFunctor( H1, T );;
MinimalNumberOfGenerators( h1 );
#! 0
#! @EndExample
