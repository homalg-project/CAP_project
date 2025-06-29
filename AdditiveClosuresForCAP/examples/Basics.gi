#! @Chapter Examples and Tests

#! @Section Basics based on category of rows

#! @Example
LoadPackage( "RingsForHomalg", false );
#! true
LoadPackage( "AdditiveClosuresForCAP", false );
#! true
R := HomalgRingOfIntegers();;
cat := CategoryOfRows( R );;
obj1 := CategoryOfRowsObject( 1, cat );;
obj2 := CategoryOfRowsObject( 2, cat );;
IsIsomorphicForObjects( obj1, obj2 );
#! false
IsIsomorphicForObjects( obj2, obj2 );
#! true
IsIsomorphism( SomeIsomorphismBetweenObjects( obj2, obj2 ) );
#! true
id := IdentityMorphism( obj2 );;
alpha := CategoryOfRowsMorphism( obj1, HomalgMatrix( [ [ 1, 2 ] ], 1, 2, R ), obj2 );;
beta := CategoryOfRowsMorphism( obj2, HomalgMatrix( [ [ 1, 2 ], [ 3, 4 ] ], 2, 2, R ), obj2 );;
comp := PreCompose( alpha, beta );;
IsZeroForMorphisms( comp );;
zero := ZeroMorphism( obj1, obj2 );;
IsZeroForMorphisms( zero );;
ZeroObject( cat );;
UniversalMorphismIntoZeroObject( obj2 );;
UniversalMorphismFromZeroObject( obj1 );;
IsCongruentForMorphisms(
    SumOfMorphisms( obj1, [ alpha, alpha, alpha ], obj2 ),
    AdditionForMorphisms( alpha, AdditionForMorphisms( alpha, alpha ) )
);
#! true
IsCongruentForMorphisms(
    SumOfMorphisms( obj1, [ ], obj2 ),
    ZeroMorphism( obj1, obj2 )
);
#! true
DirectSum( obj1, obj2 );;
DirectSumFunctorial( [ alpha, beta, id ] );;
proj := ProjectionInFactorOfDirectSum( [ obj2, obj1, obj2 ], 2 );;
IsZeroForMorphisms( ComponentOfMorphismFromDirectSum( proj, [ obj2, obj1, obj2 ], 1 ) );
#! true
IsOne( ComponentOfMorphismFromDirectSum( proj, [ obj2, obj1, obj2 ], 2 ) );
#! true
IsZeroForMorphisms( ComponentOfMorphismFromDirectSum( proj, [ obj2, obj1, obj2 ], 3 ) );
#! true
IsZeroForMorphisms( ComponentOfMorphismFromCoproduct( proj, [ obj2, obj1, obj2 ], 1 ) );
#! true
IsOne( ComponentOfMorphismFromCoproduct( proj, [ obj2, obj1, obj2 ], 2 ) );
#! true
IsZeroForMorphisms( ComponentOfMorphismFromCoproduct( proj, [ obj2, obj1, obj2 ], 3 ) );
#! true
UniversalMorphismIntoDirectSum( [ alpha, alpha, alpha ] );;
inj := InjectionOfCofactorOfDirectSum( [ obj2, obj2, obj1 ], 2 );;
IsZeroForMorphisms( ComponentOfMorphismIntoDirectSum( inj, [ obj2, obj2, obj1 ], 1 ) );
#! true
IsOne( ComponentOfMorphismIntoDirectSum( inj, [ obj2, obj2, obj1 ], 2 ) );
#! true
IsZeroForMorphisms( ComponentOfMorphismIntoDirectSum( inj, [ obj2, obj2, obj1 ], 3 ) );
#! true
IsZeroForMorphisms( ComponentOfMorphismIntoDirectProduct( inj, [ obj2, obj2, obj1 ], 1 ) );
#! true
IsOne( ComponentOfMorphismIntoDirectProduct( inj, [ obj2, obj2, obj1 ], 2 ) );
#! true
IsZeroForMorphisms( ComponentOfMorphismIntoDirectProduct( inj, [ obj2, obj2, obj1 ], 3 ) );
#! true
gamma := CategoryOfRowsMorphism( obj2, HomalgMatrix( [ [ 1, 1 ], [ 1, 1 ] ], 2, 2, R ), obj2 );;
IsColiftable( beta, gamma );
#! true
IsColiftable( gamma, beta );
#! false
ProjectionInFirstFactorOfWeakBiFiberProduct( gamma, gamma );;
ProjectionInFirstFactorOfWeakBiFiberProduct( gamma, ZeroMorphism( Range( gamma ), Range( gamma ) ) );;
lift_arg_1 := PreCompose( ProjectionInFirstFactorOfWeakBiFiberProduct( gamma, gamma + gamma ), gamma );;
lift_arg_2 := gamma + gamma;;
IsLiftable( lift_arg_1, lift_arg_2 );;
Lift( lift_arg_1, lift_arg_2 );;
pi1 := ProjectionInFirstFactorOfWeakBiFiberProduct( alpha, beta );;
pi2 := ProjectionInSecondFactorOfWeakBiFiberProduct( alpha, beta );;
IsEqualForMorphisms( PreCompose( pi1, alpha ), PreCompose( pi2, beta ) );;
inj1 := InjectionOfFirstCofactorOfWeakBiPushout( gamma + gamma, gamma );;
inj2 := InjectionOfSecondCofactorOfWeakBiPushout( gamma + gamma, gamma );;
IsEqualForMorphisms( PreCompose( gamma + gamma, inj1 ), PreCompose( gamma, inj2 ) );;
WeakKernelLift( WeakCokernelProjection( gamma ), gamma );;
pi1 := InjectionOfFirstCofactorOfWeakBiPushout( alpha, alpha );;
pi2 := InjectionOfSecondCofactorOfWeakBiPushout( alpha, alpha );;
UniversalMorphismFromWeakBiPushout( alpha, alpha, pi1, pi2 );;

S := HomalgFieldOfRationalsInSingular() * "x,y,z";;
Rows_S := CategoryOfRows( S );;
S3 := CategoryOfRowsObject( 3, Rows_S );;
S1 := CategoryOfRowsObject( 1, Rows_S );;
mor := CategoryOfRowsMorphism( S3, HomalgMatrix( "[x,y,z]", 3, 1, S ), S1 );;
biased_w := CategoryOfRowsMorphism( S3, HomalgMatrix( "[x,0,0,0,x,0,0,0,x]", 3, 3, S ), S3 );;
biased_h := CategoryOfRowsMorphism( S3, HomalgMatrix( "[x*y, x*z, y^2]", 3, 3, S ), S3 );;
BiasedWeakFiberProduct( biased_h, biased_w );;
ProjectionOfBiasedWeakFiberProduct( biased_h, biased_w );;
IsCongruentForMorphisms(
   PreCompose( UniversalMorphismIntoBiasedWeakFiberProduct( biased_h, biased_w, biased_h ), ProjectionOfBiasedWeakFiberProduct( biased_h, biased_w ) ),
   biased_h
);
#! true
IsCongruentForMorphisms(
  PreCompose( InjectionOfBiasedWeakPushout( biased_h, biased_w ), UniversalMorphismFromBiasedWeakPushout( biased_h, biased_w, biased_h )),
  biased_h
);
#! true

## Homomorphism structures
a := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( gamma );;
IsCongruentForMorphisms( InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( a ), Range( a ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( a ) ), a );;
a := ZeroObjectFunctorial( cat );;
IsCongruentForMorphisms( InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( a ), Range( a ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( a ) ), a );;
#! @EndExample

#! @Section Basics based on category of columns

#! @Example
R := HomalgRingOfIntegers();;
cat := CategoryOfColumns( R );;
obj1 := CategoryOfColumnsObject( 1, cat );;
obj2 := CategoryOfColumnsObject( 2, cat );;
id := IdentityMorphism( obj2 );;
alpha := CategoryOfColumnsMorphism( obj1, HomalgMatrix( [ [ 1 ], [ 2 ] ], 1, 2, R ), obj2 );;
beta := CategoryOfColumnsMorphism( obj2, HomalgMatrix( [ [ 1, 2 ], [ 3, 4 ] ], 2, 2, R ), obj2 );;
comp := PreCompose( alpha, beta );;
IsZeroForMorphisms( comp );;
zero := ZeroMorphism( obj1, obj2 );;
IsZeroForMorphisms( zero );;
ZeroObject( cat );;
UniversalMorphismIntoZeroObject( obj2 );;
UniversalMorphismFromZeroObject( obj1 );;
DirectSum( obj1, obj2 );;
DirectSumFunctorial( [ alpha, beta, id ] );;
proj := ProjectionInFactorOfDirectSum( [ obj2, obj1, obj2 ], 2 );;
IsZeroForMorphisms( ComponentOfMorphismFromDirectSum( proj, [ obj2, obj1, obj2 ], 1 ) );
#! true
IsOne( ComponentOfMorphismFromDirectSum( proj, [ obj2, obj1, obj2 ], 2 ) );
#! true
IsZeroForMorphisms( ComponentOfMorphismFromDirectSum( proj, [ obj2, obj1, obj2 ], 3 ) );
#! true
UniversalMorphismIntoDirectSum( [ alpha, alpha, alpha ] );;
inj := InjectionOfCofactorOfDirectSum( [ obj2, obj2, obj1 ], 2 );;
IsZeroForMorphisms( ComponentOfMorphismIntoDirectSum( inj, [ obj2, obj2, obj1 ], 1 ) );
#! true
IsOne( ComponentOfMorphismIntoDirectSum( inj, [ obj2, obj2, obj1 ], 2 ) );
#! true
IsZeroForMorphisms( ComponentOfMorphismIntoDirectSum( inj, [ obj2, obj2, obj1 ], 3 ) );
#! true
gamma := CategoryOfColumnsMorphism( obj2, HomalgMatrix( [ [ 1, 1 ], [ 1, 1 ] ], 2, 2, R ), obj2 );;
IsColiftable( beta, gamma );
#! false
IsColiftable( gamma, beta );
#! false
ProjectionInFirstFactorOfWeakBiFiberProduct( gamma, gamma );;
ProjectionInFirstFactorOfWeakBiFiberProduct( gamma, ZeroMorphism( Range( gamma ), Range( gamma ) ) );;
lift_arg_1 := PreCompose( ProjectionInFirstFactorOfWeakBiFiberProduct( gamma, gamma + gamma ), gamma );;
lift_arg_2 := gamma + gamma;;
IsLiftable( lift_arg_1, lift_arg_2 );;
Lift( lift_arg_1, lift_arg_2 );;
pi1 := ProjectionInFirstFactorOfWeakBiFiberProduct( alpha, beta );;
pi2 := ProjectionInSecondFactorOfWeakBiFiberProduct( alpha, beta );;
IsEqualForMorphisms( PreCompose( pi1, alpha ), PreCompose( pi2, beta ) );;
inj1 := InjectionOfFirstCofactorOfWeakBiPushout( gamma + gamma, gamma );;
inj2 := InjectionOfSecondCofactorOfWeakBiPushout( gamma + gamma, gamma );;
IsEqualForMorphisms( PreCompose( gamma + gamma, inj1 ), PreCompose( gamma, inj2 ) );;
WeakKernelLift( WeakCokernelProjection( gamma ), gamma );;
pi1 := InjectionOfFirstCofactorOfWeakBiPushout( alpha, alpha );;
pi2 := InjectionOfSecondCofactorOfWeakBiPushout( alpha, alpha );;
UniversalMorphismFromWeakBiPushout( alpha, alpha, pi1, pi2 );;


S := HomalgFieldOfRationalsInSingular() * "x,y,z";;
Cols_S := CategoryOfColumns( S );;
S3 := CategoryOfColumnsObject( 3, Cols_S );;
S1 := CategoryOfColumnsObject( 1, Cols_S );;
mor := CategoryOfColumnsMorphism( S3, HomalgMatrix( "[x,y,z]", 1, 3, S ), S1 );;
biased_w := CategoryOfColumnsMorphism( S3, HomalgMatrix( "[x,0,0,0,x,0,0,0,x]", 3, 3, S ), S3 );;
biased_h := CategoryOfColumnsMorphism( S3, HomalgMatrix( "[x*y, x*z, y^2]", 3, 3, S ), S3 );;
BiasedWeakFiberProduct( biased_h, biased_w );;
ProjectionOfBiasedWeakFiberProduct( biased_h, biased_w );;
IsCongruentForMorphisms(
   PreCompose( UniversalMorphismIntoBiasedWeakFiberProduct( biased_h, biased_w, biased_h ), ProjectionOfBiasedWeakFiberProduct( biased_h, biased_w ) ),
   biased_h
);
#! true
IsCongruentForMorphisms(
  PreCompose( InjectionOfBiasedWeakPushout( biased_h, biased_w ), UniversalMorphismFromBiasedWeakPushout( biased_h, biased_w, biased_h )),
  biased_h
);
#! true

## Homomorphism structures
a := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( gamma );;
IsCongruentForMorphisms( InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( a ), Range( a ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( a ) ), a );;
a := ZeroObjectFunctorial( cat );;
IsCongruentForMorphisms( InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( a ), Range( a ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( a ) ), a );;
#! @EndExample
