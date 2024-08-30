#! @Chapter Examples and Tests

#! @Section Functors

LoadPackage( "ModulePresentationsForCAP" );

#! We create a binary functor $F$ with one covariant and one contravariant component in two ways.
#! Here is the first way to model a binary functor:

#! @Example
ring := HomalgRingOfIntegers( );;
vec := LeftPresentations( ring );;
F := CapFunctor( "CohomForVec", [ vec, [ vec, true ] ], vec );;
obj_func := function( A, B ) return TensorProductOnObjects( A, DualOnObjects( B ) ); end;;
mor_func := function( source, alpha, beta, range ) return TensorProductOnMorphismsWithGivenTensorProducts( source, alpha, DualOnMorphisms( beta ), range ); end;;
AddObjectFunction( F, obj_func );;
AddMorphismFunction( F, mor_func );;
#! @EndExample

#! CAP regards $F$ as a binary functor on a technical level,
#! as we can see by looking at its input signature:

#! @Example
InputSignature( F );
#! [ [ Category of left presentations of Z, false ], [ Category of left presentations of Z, true ] ]
#! @EndExample

#! We can see that <C>ApplyFunctor</C> works both on two arguments and on one argument (in the product category).

#! @Example
V1 := TensorUnit( vec );;
V3 := DirectSum( V1, V1, V1 );;
pi1 := ProjectionInFactorOfDirectSum( [ V1, V1 ], 1 );;
pi2 := ProjectionInFactorOfDirectSum( [ V3, V1 ], 1 );;
value1 := ApplyFunctor( F, pi1, pi2 );;
input := Product( pi1, Opposite( pi2 ) );;
value2 := ApplyFunctor( F, input );;
IsCongruentForMorphisms( value1, value2 );
#! true
#! @EndExample

#! Here is the second way to model a binary functor:

#! @Example
F2 := CapFunctor( "CohomForVec2", Product( vec, Opposite( vec ) ), vec );;
AddObjectFunction( F2, a -> obj_func( a[1], Opposite( a[2] ) ) );;
AddMorphismFunction( F2, function( source, datum, range ) return mor_func( source, datum[1], Opposite( datum[2] ), range ); end );;
value3 := ApplyFunctor( F2,input );;
IsCongruentForMorphisms( value1, value3 );
#! true
#! @EndExample

#! CAP regards $F2$ as a unary functor on a technical level,
#! as we can see by looking at its input signature:

#! @Example
InputSignature( F2 );
#! [ [ Product of: Category of left presentations of Z, Opposite( Category of left presentations of Z ), false ] ]
#! @EndExample

#! Installation of the first functor as a GAP-operation.
#! It will be installed both as a unary and binary version.

#! @Example
InstallFunctor( F, "F_installation" );;
F_installation( pi1, pi2 );;
F_installation( input );;
F_installationOnObjects( V1, V1 );;
F_installationOnObjects( Product( V1, Opposite( V1 ) ) );;
F_installationOnMorphisms( pi1, pi2 );;
F_installationOnMorphisms( input );;
#! @EndExample

#! Installation of the second functor as a GAP-operation.
#! It will be installed only as a unary version.

#! @Example
InstallFunctor( F2, "F_installation2" );;
F_installation2( input );;
F_installation2OnObjects( Product( V1, Opposite( V1 ) ) );;
F_installation2OnMorphisms( input );;
#! @EndExample
