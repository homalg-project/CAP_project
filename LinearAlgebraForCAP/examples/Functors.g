#! @Chapter Examples and Tests

#! @Section Functors

#! @Example
LoadPackage( "LinearAlgebraForCAP", false );
#! true
ring := HomalgFieldOfRationals( );;
vec := MatrixCategory( ring );;
F := CapFunctor( "CohomForVec", [ vec, [ vec, true ] ], vec );;
obj_func := function( A, B ) return TensorProductOnObjects( A, DualOnObjects( B ) ); end;;
mor_func := function( source, alpha, beta, range ) return TensorProductOnMorphismsWithGivenTensorProducts( source, alpha, DualOnMorphisms( beta ), range ); end;;
AddObjectFunction( F, obj_func );;
AddMorphismFunction( F, mor_func );;
Display( InputSignature( F ) );
#! [ [ Category of matrices over Q, false ], [ Category of matrices over Q, true ] ]

V1 := TensorUnit( vec );;
V3 := DirectSum( V1, V1, V1 );;
pi1 := ProjectionInFactorOfDirectSum( [ V1, V1 ], 1 );;
pi2 := ProjectionInFactorOfDirectSum( [ V3, V1 ], 1 );;
value1 := ApplyFunctor( F, pi1, pi2 );;
input := ProductCategoryMorphism( SourceOfFunctor( F ), [ pi1, Opposite( pi2 ) ] );;
value2 := ApplyFunctor( F, input );;
IsCongruentForMorphisms( value1, value2 );
#! true

InstallFunctor( F, "F_installation" );;
F_installation( pi1, pi2 );;
F_installation( input );;
F_installationOnObjects( V1, V1 );;
F_installationOnObjects( ProductCategoryObject( SourceOfFunctor( F ), [ V1, Opposite( V1 ) ] ) );;
F_installationOnMorphisms( pi1, pi2 );;
F_installationOnMorphisms( input );;

F2 := CapFunctor( "CohomForVec2", ProductCategory( [ vec, Opposite( vec ) ] ), vec );;
AddObjectFunction( F2, a -> obj_func( a[1], Opposite( a[2] ) ) );;
AddMorphismFunction( F2, function( source, datum, range ) return mor_func( source, datum[1], Opposite( datum[2] ), range ); end );;
input := ProductCategoryMorphism( SourceOfFunctor( F2 ), [ pi1, Opposite( pi2 ) ] );;
value3 := ApplyFunctor( F2, input );;
IsCongruentForMorphisms( value1, value3 );
#! true
Display( InputSignature( F2 ) );
#! [ [ Product of: Category of matrices over Q, Opposite( Category of matrices over Q ), false ] ]

InstallFunctor( F2, "F_installation2" );;
F_installation2( input );;
F_installation2OnObjects( ProductCategoryObject( SourceOfFunctor( F2 ), [ V1, Opposite( V1 ) ] ) );;
F_installation2OnMorphisms( input );;
#! @EndExample
