#! @Chapter Examples and Tests

#! @Section Basics

LoadPackage( "FreydCategoriesForCAP" );;

#! @Example
R := HomalgRingOfIntegers();
cat := CategoryOfRows( R );
obj1 := CategoryOfRowsObject( 1, cat );
obj2 := CategoryOfRowsObject( 2, cat );
id := IdentityMorphism( obj2 );
alpha := CategoryOfRowsMorphism( obj1, HomalgMatrix( [ [ 1, 2 ] ], 1, 2, R ), obj2 );
beta := CategoryOfRowsMorphism( obj2, HomalgMatrix( [ [ 1, 2 ], [ 3, 4 ] ], 2, 2, R ), obj2 );
comp := PreCompose( alpha, beta );
IsZero( comp );
zero := ZeroMorphism( obj1, obj2 );
IsZero( zero );
ZeroObject( cat );
UniversalMorphismIntoZeroObject( obj2 );
UniversalMorphismFromZeroObject( obj1 );
DirectSum( obj1, obj2 );
DirectSumFunctorial( [ alpha, beta, id ] );
ProjectionInFactorOfDirectSum( [ obj2, obj1, obj2 ], 3 );
UniversalMorphismIntoDirectSum( [ alpha, alpha, alpha ] );
InjectionOfCofactorOfDirectSum( [ obj2, obj2, obj1 ], 2 );
gamma := CategoryOfRowsMorphism( obj2, HomalgMatrix( [ [ 1, 1 ], [ 1, 1 ] ], 2, 2, R ), obj2 );
ProjectionInFirstFactorOfWeakBiFiberProduct( gamma, gamma );
ProjectionInFirstFactorOfWeakBiFiberProduct( gamma, ZeroMorphism( Range( gamma ), Range( gamma ) ) );
Lift( PreCompose( ProjectionInFirstFactorOfWeakBiFiberProduct( gamma, gamma + gamma ), gamma ), gamma + gamma );
pi1 := ProjectionInFirstFactorOfWeakBiFiberProduct( alpha, beta );
pi2 := ProjectionInSecondFactorOfWeakBiFiberProduct( alpha, beta );
IsEqualForMorphisms( PreCompose( pi1, alpha ), PreCompose( pi2, beta ) );
inj1 := InjectionOfFirstCofactorOfWeakBiPushout( gamma + gamma, gamma );
inj2 := InjectionOfSecondCofactorOfWeakBiPushout( gamma + gamma, gamma );
IsEqualForMorphisms( PreCompose( gamma + gamma, inj1 ), PreCompose( gamma, inj2 ) );
WeakKernelLift( WeakCokernelProjection( gamma ), gamma );
#! @EndExample
