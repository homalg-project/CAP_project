#! @Chapter Examples and Tests

#! @Section Category of relations

LoadPackage( "RingsForHomalg" );;
LoadPackage( "LinearAlgebraForCAP" );;
LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "GeneralizedM" );

#! @Example
F := HomalgRingOfIntegers( 3 );;
vec := CategoryOfRows( F );;
rel := RelCategory( vec );;
A := 1/vec/rel;;
id := IdentityMorphism( A );;
IsWellDefined( id );
#! true
alpha := HomalgMatrix( "[ 1, 2 ]", 2, 1, F )/vec;;
alpha_rel := alpha/rel;;
alpha_rel_inv := rel/alpha;;
beta := PreCompose( alpha_rel_inv, alpha_rel );;
IsCongruentForMorphisms( beta, id );
#! true
IsEqualForMorphisms( beta, id );
#! false
R := HomalgFieldOfRationalsInSingular() * "t";;
t := IndeterminatesOfPolynomialRing( R )[1];;
cocycle := function( a, b, c ) local e; e := CoastrictionToImage( UniversalMorphismIntoDirectSum( [ ReversedArrow( c ), Arrow( c ) ] ) ); return t^RankOfObject( KernelObject( e ) ); end;;
#! #@if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2023.07-03" )
T := TwistedLinearClosure( R, rel, cocycle );;
gamma := beta/T;;
delta := ZeroMorphism( 1/vec, 1/vec )/rel/T;;
IsZero( 3*gamma - 3*gamma );
#! true
IsCongruentForMorphisms( delta, gamma );
#! false
beta := PreCompose( alpha_rel_inv/T, alpha_rel/T );;
IsZero( beta - t * IdentityMorphism( Range( alpha_rel/T ) ) );
#! true
IsZero( ( gamma * delta ) * gamma - gamma * ( delta * gamma ) );
#! true
#! #@fi
#! @EndExample
