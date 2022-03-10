#! @Chapter Examples and Tests

#! @Section Intersection theory

LoadPackage( "ModulesOverLocalRingsForCAP" );

LoadPackage( "RingsForHomalg" );

#! @Example
Q := HomalgFieldOfRationalsInSingular( );;
R := Q * "x,y,z,w";;
category := CategoryOfLeftModulePresentationsOverLocalRing( R, [ "x", "y", "z", "w" ] );;
Y1 := HomalgMatrix( "[ x,y ]", 2, 1, R );;
Y1 := AsLeftPresentation( Y1 );;
Y2 := HomalgMatrix( "[ z,w ]", 2, 1, R );;
Y2 := AsLeftPresentation( Y2 );;
Y := CokernelObject( Annihilator( DirectSum( Y1, Y2 ) ) );;
Y := AsSerreQuotientCategoryObject( category, Y );;
ZZ := HomalgMatrix( "[ x-z, y-w ]", 2, 1, R );;
ZZ := AsLeftPresentation( ZZ );;
ZZ := AsSerreQuotientCategoryObject( category, ZZ );;
T := TorComplex( ZZ, Y );;
H0 := HomologyFunctor( category, 0 );;
H1 := HomologyFunctor( category, 1 );;
H2 := HomologyFunctor( category, 2 );;
Min := FunctorMinimalModel( category );;
h0 := ApplyFunctor( H0, T );;
h0 := ApplyFunctor( Min, h0 );;
MinimalNumberOfGenerators( h0 );
#! 1
ph0 := Source( FiltrationByPrimeIdealEmbedding( h0 ) );;
ph0 := ApplyFunctor( Min, ph0 );;
MinimalNumberOfGenerators( ph0 );
#! 2
pph0 := Source( FiltrationByPrimeIdealEmbedding( ph0 ) );;
IsZero( pph0 );
#! true
h1 := ApplyFunctor( H1, T );;
h1 := ApplyFunctor( Min, h1 );;
MinimalNumberOfGenerators( h1 );
#! 1
ph1 := Source( FiltrationByPrimeIdealEmbedding( h1 ) );;
IsZero( ph1 );
#! true
IsZero( ApplyFunctor( H2, T ) );
#! true
#! @EndExample
