#! @Chapter Examples and Tests
#! This is an example from homalg.

#! @Section Gauss
LoadPackage( "ModulesOverLocalRingsForCAP" );

LoadPackage( "RingsForHomalg" );

#! @Example
F5 := HomalgRingOfIntegersInSingular( 5 );;
R := F5 * "x,y,z,v,w";;
category := CategoryOfLeftModulePresentationsOverLocalRing( R, [ "x", "y", "z", "v", "w" ] );;
i1 := HomalgMatrix( "[ x-z, y-w ]", 2, 1, R );;
i2 := HomalgMatrix( "[ y^6*v^2*w-y^3*v*w^20+1, x*y^4*z^4*w-z^5*w^5+x^3*y*z^2-1 ]", 2, 1, R );;
M1 := AsLeftPresentation( i1 );;
M2 := AsLeftPresentation( i2 );;
# the next line does not terminate in time, see https://github.com/homalg-project/CAP_project/issues/857
#OI0 := CokernelObject( Annihilator( DirectSum( M1, M2 ) ) );;
#j1 := HomalgMatrix( "[ x*z, x*w, y*z, y*w, v^2 ]", 5, 1, R );;
#j2 := HomalgMatrix( "[ y^6*v^2*w-y^3*v*w^2+1, x*y^4*z^4*w-z^5*w^5+x^3*y*z^2-1, x^7 ]", 3, 1, R );;
#M1 := AsLeftPresentation( j1 );;
#M2 := AsLeftPresentation( j2 );;
#OJ0 := CokernelObject( Annihilator( DirectSum( M1, M2 ) ) );;
#M := AsSerreQuotientCategoryObject( category, OI0 );;
#N := AsSerreQuotientCategoryObject( category, OJ0 );;
#Min := FunctorMinimalModel( category );;
#M_min := ApplyFunctor( Min, M );;
#N_min := ApplyFunctor( Min, N );;
#T := TorComplex( M_min, N_min );;
#H0 := HomologyFunctor( category, 0 );;
#H1 := HomologyFunctor( category, 1 );;
#H2 := HomologyFunctor( category, 2 );;
#h0 := ApplyFunctor( H0, T );;
#MinimalNumberOfGenerators( h0 );
## 1
#h0 := Source( FiltrationByPrimeIdealEmbedding( h0 ) );;
#MinimalNumberOfGenerators( h0 );
## 3
#h0 := Source( FiltrationByPrimeIdealEmbedding( h0 ) );;
#MinimalNumberOfGenerators( h0 );
## 2
#h0 := Source( FiltrationByPrimeIdealEmbedding( h0 ) );;
#MinimalNumberOfGenerators( h0 );
## 0
#h1 := ApplyFunctor( H1, T );;
#MinimalNumberOfGenerators( h1 );
## 1
#h1 := Source( FiltrationByPrimeIdealEmbedding( h1 ) );;
#MinimalNumberOfGenerators( h1 );
## 1
#h1 := Source( FiltrationByPrimeIdealEmbedding( h1 ) );;
#MinimalNumberOfGenerators( h1 );
## 0
#h2 := ApplyFunctor( H2, T );;
#MinimalNumberOfGenerators( h2 );
## 0
#! @EndExample
