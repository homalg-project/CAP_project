LoadPackage( "ModulesOverLocalRingsForCAP" );

LoadPackage( "RingsForHomalg" );

LoadPackage( "LocalizeRingForHomalg" );

LoadPackage( "Modules" );

F5 := HomalgRingOfIntegersInSingular( 5 );
R := F5 * "x,y,z,v,w";;
R0 := LocalizeAtZero( R );;


category := CategoryOfLeftModulePresentationsOverLocalRing( R, [ "x", "y", "z", "v", "w" ] );;
i1 := HomalgMatrix( "[ x-z, y-w ]", 2, 1, R );;
i2 := HomalgMatrix( "[ y^6*v^2*w-y^3*v*w^20+1, x*y^4*z^4*w-z^5*w^5+x^3*y*z^2-1 ]", 2, 1, R );;
M1 := AsLeftPresentation( i1 );
M2 := AsLeftPresentation( i2 );
OI0 := CokernelObject( Annihilator( DirectSum( M1, M2 ) ) );
j1 := HomalgMatrix( "[ x*z, x*w, y*z, y*w, v^2 ]", 5, 1, R );;
j2 := HomalgMatrix( "[ y^6*v^2*w-y^3*v*w^2+1, x*y^4*z^4*w-z^5*w^5+x^3*y*z^2-1, x^7 ]", 3, 1, R );;
M1 := AsLeftPresentation( j1 );
M2 := AsLeftPresentation( j2 );
OJ0 := CokernelObject( Annihilator( DirectSum( M1, M2 ) ) );
M := AsSerreQuotientCategoryObject( category, OI0 );
N := AsSerreQuotientCategoryObject( category, OJ0 );
# 
# FN := MinimalFreeResolution( N );
# d1 := Differential( FN, 1 );
# g1 := UnderlyingGeneralizedMorphism( d1 );
# r1 := HonestRepresentative( g1 );
# n := UnderlyingMatrix( r1 );
# Nn := AsLeftPresentation( n );
# Nn := AsSerreQuotientCategoryObject( category, Nn );

Min := FunctorMinimalModel( category );
M_min := ApplyFunctor( Min, M );
N_min := ApplyFunctor( Min, N );
T := TorComplex( M_min, N_min );

d1 := Differential( T, 1 );
g1 := UnderlyingGeneralizedMorphism( d1 );
a := Arrow( g1 );
r := RangeAid( g1 );

source_a := UnderlyingMatrix( Source( r ) ) * R0;
source_a := LeftPresentation( source_a );
range_a := UnderlyingMatrix( Range( r ) ) * R0;
range_a := LeftPresentation( range_a );
morphism_a := UnderlyingMatrix( r ) * R0;
alpha := HomalgMap( morphism_a, source_a, range_a );

source_r := UnderlyingMatrix( Source( r ) ) * R0;
source_r := LeftPresentation( source_r );
morphism_r := UnderlyingMatrix( r ) * R0;
rho := HomalgMap( morphism_r, source_r, range_a ); ##targets need to be identical
