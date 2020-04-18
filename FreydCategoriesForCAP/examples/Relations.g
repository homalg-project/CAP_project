#! @Chapter Examples and Tests

#! @Section Category of relations

LoadPackage( "RingsForHomalg" );;
LoadPackage( "LinearAlgebraForCAP" );;
LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "GeneralizedM" );

#! @Example
F := HomalgRingOfIntegers( 3 );;
mat := MatrixCategory( F );;
rel := RelCategory( mat );;
A := 1/mat/rel;;
id := IdentityMorphism( A );;
IsWellDefined( id );
#! true
alpha := HomalgMatrix( "[ 1, 2 ]", 2, 1, F )/mat;;
alpha_rel := alpha/rel;;
alpha_rel_inv := rel/alpha;;
beta := PreCompose( alpha_rel_inv, alpha_rel );;
IsCongruentForMorphisms( beta, id );
#! true
IsEqualForMorphisms( beta, id );
#! false
#! @EndExample
