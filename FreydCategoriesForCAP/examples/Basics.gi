#! @Chapter Examples and Tests

#! @Section Basics based on category of rows

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );

#! @Example
R := HomalgRingOfIntegers();;
cat := CategoryOfRows( R );;
obj1 := CategoryOfRowsObject( 1, cat );;
obj2 := CategoryOfRowsObject( 2, cat );;
id := IdentityMorphism( obj2 );;
alpha := CategoryOfRowsMorphism( obj1, HomalgMatrix( [ [ 1, 2 ] ], 1, 2, R ), obj2 );;
beta := CategoryOfRowsMorphism( obj2, HomalgMatrix( [ [ 1, 2 ], [ 3, 4 ] ], 2, 2, R ), obj2 );;
comp := PreCompose( alpha, beta );;
IsZero( comp );;
zero := ZeroMorphism( obj1, obj2 );;
IsZero( zero );;
ZeroObject( cat );;
UniversalMorphismIntoZeroObject( obj2 );;
UniversalMorphismFromZeroObject( obj1 );;
DirectSum( obj1, obj2 );;
DirectSumFunctorial( [ alpha, beta, id ] );;
proj := ProjectionInFactorOfDirectSum( [ obj2, obj1, obj2 ], 2 );;
IsZero( ComponentOfMorphismFromDirectSum( proj, [ obj2, obj1, obj2 ], 1 ) );
#! true
IsOne( ComponentOfMorphismFromDirectSum( proj, [ obj2, obj1, obj2 ], 2 ) );
#! true
IsZero( ComponentOfMorphismFromDirectSum( proj, [ obj2, obj1, obj2 ], 3 ) );
#! true
UniversalMorphismIntoDirectSum( [ alpha, alpha, alpha ] );;
inj := InjectionOfCofactorOfDirectSum( [ obj2, obj2, obj1 ], 2 );;
IsZero( ComponentOfMorphismIntoDirectSum( inj, [ obj2, obj2, obj1 ], 1 ) );
#! true
IsOne( ComponentOfMorphismIntoDirectSum( inj, [ obj2, obj2, obj1 ], 2 ) );
#! true
IsZero( ComponentOfMorphismIntoDirectSum( inj, [ obj2, obj2, obj1 ], 3 ) );
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

## Freyd categories
freyd := FreydCategory( cat );;
IsAbelianCategory( freyd );;
obj_gamma := FreydCategoryObject( gamma );;
u := RandomMorphismWithFixedSource( obj_gamma, [ [5], [5] ] );;
IsWellDefined( u ) and IsEqualForObjects( Source(u), obj_gamma );
#! true
u := RandomMorphismWithFixedSource( obj_gamma, 5 );;
IsWellDefined( u ) and IsEqualForObjects( Source(u), obj_gamma );
#! true
u := RandomMorphismWithFixedRange( obj_gamma, [ [5], [5] ] );;
IsWellDefined( u ) and IsEqualForObjects( Range(u), obj_gamma );
#! true
u := RandomMorphismWithFixedRange( obj_gamma, 5 );;
IsWellDefined( u ) and IsEqualForObjects( Range(u), obj_gamma );
#! true
obj_delta := RandomObject( freyd, [[10],[10],[10]] );;
obj_delta := RandomObject( freyd, 10 );;
u := RandomMorphismWithFixedSourceAndRange( obj_gamma, obj_delta, [ 5 ] );;
IsWellDefined( u );
#! true
IsEqualForObjects( Source(u), obj_gamma ) and IsEqualForObjects( Range(u), obj_delta );
#! true
u := RandomMorphismWithFixedSourceAndRange( obj_gamma, obj_delta, 5 );;
IsWellDefined( u );
#! true
IsEqualForObjects( Source(u), obj_gamma ) and IsEqualForObjects( Range(u), obj_delta );
#! true
IsWellDefined( RandomMorphism( freyd, 5 ) );
#! true
IsWellDefined( RandomMorphism( freyd, [[[5],[5],[5]],[[5],[5],[5]],[1]] ) );
#! true
f := FreydCategoryMorphism( obj_gamma, gamma, obj_gamma );;
witness := MorphismWitness( f );;
g := FreydCategoryMorphism( obj_gamma, ZeroMorphism( obj2, obj2 ), obj_gamma );;
IsCongruentForMorphisms( f, g );;
c := PreCompose( f, f );;
s := g + g;;
a := CategoryOfRowsMorphism( obj1, HomalgMatrix( [ [ 2 ] ], 1, 1, R ), obj1 );;
Z2 := FreydCategoryObject( a );;
id := IdentityMorphism( Z2 );;
z := id + id + id;;
d := DirectSumFunctorial( [ z, z, z ] );;
pr2 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );;
pr3 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 3 );;
UniversalMorphismIntoDirectSum( [ pr3, pr2 ] );;
inj1 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 1 );;
inj2 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );;
UniversalMorphismFromDirectSum( [ inj2, inj1 ] );;
ZFree := obj1/freyd;;
id := IdentityMorphism( ZFree );;
z := id + id;;
CokernelProjection( z );;
CokernelColift( z, CokernelProjection( z ) );;
UniversalMorphismFromZeroObjectWithGivenZeroObject( obj_gamma, ZeroObject( freyd ) );;
(2 / R) * f;;

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


k := FreydCategoryObject( mor );;
w := EpimorphismFromSomeProjectiveObjectForKernelObject( UniversalMorphismIntoZeroObject( k ) );;
k := KernelEmbedding( w );;
ColiftAlongEpimorphism( CokernelProjection( k ), CokernelProjection( k ) );;


## Homomorphism structures
a := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( gamma );;
IsCongruentForMorphisms( InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( a ), Range( a ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( a ) ), a );;
a := ZeroObjectFunctorial( cat );;
IsCongruentForMorphisms( InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( a ), Range( a ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( a ) ), a );;

Z4 := FreydCategoryObject( AsCategoryOfRowsMorphism( HomalgMatrix( "[4]", 1, 1, R ), cat ) );;
Z3 := FreydCategoryObject( AsCategoryOfRowsMorphism( HomalgMatrix( "[3]", 1, 1, R ), cat ) );;
HomomorphismStructureOnObjects( Z4, Z2 );;
HomomorphismStructureOnObjects( Z4, Z4 );;
HomomorphismStructureOnObjects( Z2, Z4 );;
HomomorphismStructureOnObjects( Z3, Z4 );;
HomomorphismStructureOnMorphisms( IdentityMorphism( DirectSum( Z4, Z2, Z3 ) ), -IdentityMorphism( DirectSum( Z4, Z3 ) ) );;

## Lifts
S2 := CategoryOfRowsObject( 2, Rows_S );;
S4 := CategoryOfRowsObject( 4, Rows_S );;

S1_freyd := AsFreydCategoryObject( S1 );;
S2_freyd := AsFreydCategoryObject( S2 );;
S3_freyd := AsFreydCategoryObject( S3 );;
S4_freyd := AsFreydCategoryObject( S4 );;

lift := FreydCategoryMorphism( S1_freyd, CategoryOfRowsMorphism( S1, HomalgMatrix( "[x]", 1, 1, S ), S1 ), S1_freyd );;
gamma := FreydCategoryMorphism( S1_freyd, CategoryOfRowsMorphism( S1, HomalgMatrix( "[y]", 1,1, S ), S1 ), S1_freyd );;
alpha := PreCompose( lift, gamma );;
IsLiftable( alpha, gamma );
#! true
Lift( alpha, gamma );;
IsColiftable( lift, alpha );
#! true
IsCongruentForMorphisms( PreCompose( lift, Colift( lift, alpha ) ), alpha );
#! true

lift := FreydCategoryMorphism( S2_freyd, CategoryOfRowsMorphism( S2, HomalgMatrix( "[x,y,z,x^2,1,z+1]", 2, 3, S ), S3 ), S3_freyd );;
gamma := FreydCategoryMorphism( S3_freyd, CategoryOfRowsMorphism( S3, HomalgMatrix( "[x,y,z,z+1, x^2,y^2,z^2,z^2+1, x^3,y^3,z^3,z^3+1]", 3,4, S ), S4 ), S4_freyd );;
alpha := PreCompose( lift, gamma );;
Lift( alpha, gamma );;
Colift( lift, alpha );;
IsCongruentForMorphisms( PreCompose( lift, Colift( lift, alpha ) ), alpha );;
interpretation := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( gamma );;
IsCongruentForMorphisms( gamma,
InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( gamma ), Range( gamma ), interpretation ) );;

## Opposite
HomomorphismStructureOnObjects( Opposite( Z4 ), Opposite( Z2 ) );;
HomomorphismStructureOnObjects( Z2, Z4 );;
interpretation := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( Opposite( gamma ) );;
IsCongruentForMorphisms( Opposite( gamma ),
InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( Opposite( gamma ) ), Range( Opposite( gamma ) ), interpretation ) );
#! true
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
IsZero( comp );;
zero := ZeroMorphism( obj1, obj2 );;
IsZero( zero );;
ZeroObject( cat );;
UniversalMorphismIntoZeroObject( obj2 );;
UniversalMorphismFromZeroObject( obj1 );;
DirectSum( obj1, obj2 );;
DirectSumFunctorial( [ alpha, beta, id ] );;
proj := ProjectionInFactorOfDirectSum( [ obj2, obj1, obj2 ], 2 );;
IsZero( ComponentOfMorphismFromDirectSum( proj, [ obj2, obj1, obj2 ], 1 ) );
#! true
IsOne( ComponentOfMorphismFromDirectSum( proj, [ obj2, obj1, obj2 ], 2 ) );
#! true
IsZero( ComponentOfMorphismFromDirectSum( proj, [ obj2, obj1, obj2 ], 3 ) );
#! true
UniversalMorphismIntoDirectSum( [ alpha, alpha, alpha ] );;
inj := InjectionOfCofactorOfDirectSum( [ obj2, obj2, obj1 ], 2 );;
IsZero( ComponentOfMorphismIntoDirectSum( inj, [ obj2, obj2, obj1 ], 1 ) );
#! true
IsOne( ComponentOfMorphismIntoDirectSum( inj, [ obj2, obj2, obj1 ], 2 ) );
#! true
IsZero( ComponentOfMorphismIntoDirectSum( inj, [ obj2, obj2, obj1 ], 3 ) );
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

## Freyd categories
freyd := FreydCategory( cat );;
IsAbelianCategory( freyd );;
obj_gamma := FreydCategoryObject( gamma );;
f := FreydCategoryMorphism( obj_gamma, gamma, obj_gamma );;
witness := MorphismWitness( f );;
g := FreydCategoryMorphism( obj_gamma, ZeroMorphism( obj2, obj2 ), obj_gamma );;
IsCongruentForMorphisms( f, g );;
c := PreCompose( f, f );;
s := g + g;;
a := CategoryOfColumnsMorphism( obj1, HomalgMatrix( [ [ 2 ] ], 1, 1, R ), obj1 );;
Z2 := FreydCategoryObject( a );;
id := IdentityMorphism( Z2 );;
z := id + id + id;;
d := DirectSumFunctorial( [ z, z, z ] );;
pr2 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );;
pr3 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 3 );;
UniversalMorphismIntoDirectSum( [ pr3, pr2 ] );;
inj1 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 1 );;
inj2 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );;
UniversalMorphismFromDirectSum( [ inj2, inj1 ] );;
ZFree := AsFreydCategoryObject( obj1 );;
id := IdentityMorphism( ZFree );;
z := id + id;;
CokernelProjection( z );;
CokernelColift( z, CokernelProjection( z ) );;

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


k := FreydCategoryObject( mor );;
w := EpimorphismFromSomeProjectiveObjectForKernelObject( UniversalMorphismIntoZeroObject( k ) );;
k := KernelEmbedding( w );;
ColiftAlongEpimorphism( CokernelProjection( k ), CokernelProjection( k ) );;


## Homomorphism structures
a := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( gamma );;
IsCongruentForMorphisms( InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( a ), Range( a ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( a ) ), a );;
a := ZeroObjectFunctorial( cat );;
IsCongruentForMorphisms( InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( a ), Range( a ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( a ) ), a );;

Z4 := FreydCategoryObject( AsCategoryOfColumnsMorphism( HomalgMatrix( "[4]", 1, 1, R ), cat ) );;
Z3 := FreydCategoryObject( AsCategoryOfColumnsMorphism( HomalgMatrix( "[3]", 1, 1, R ), cat ) );;
HomomorphismStructureOnObjects( Z4, Z2 );;
HomomorphismStructureOnObjects( Z4, Z4 );;
HomomorphismStructureOnObjects( Z2, Z4 );;
HomomorphismStructureOnObjects( Z3, Z4 );;
HomomorphismStructureOnMorphisms( IdentityMorphism( DirectSum( Z4, Z2, Z3 ) ), -IdentityMorphism( DirectSum( Z4, Z3 ) ) );;

## Lifts
S2 := CategoryOfColumnsObject( 2, Cols_S );;
S4 := CategoryOfColumnsObject( 4, Cols_S );;

S1_freyd := AsFreydCategoryObject( S1 );;
S2_freyd := AsFreydCategoryObject( S2 );;
S3_freyd := AsFreydCategoryObject( S3 );;
S4_freyd := AsFreydCategoryObject( S4 );;

lift := FreydCategoryMorphism( S1_freyd, CategoryOfColumnsMorphism( S1, HomalgMatrix( "[x]", 1, 1, S ), S1 ), S1_freyd );;
gamma := FreydCategoryMorphism( S1_freyd, CategoryOfColumnsMorphism( S1, HomalgMatrix( "[y]", 1,1, S ), S1 ), S1_freyd );;
alpha := PreCompose( lift, gamma );;
Lift( alpha, gamma );;
Colift( lift, alpha );;
IsCongruentForMorphisms( PreCompose( lift, Colift( lift, alpha ) ), alpha );;



lift := FreydCategoryMorphism( S2_freyd, CategoryOfColumnsMorphism( S2, HomalgMatrix( "[x,y,z,x^2,1,z+1]", 3, 2, S ), S3 ), S3_freyd );;
gamma := FreydCategoryMorphism( S3_freyd, CategoryOfColumnsMorphism( S3, HomalgMatrix( "[x,y,z,z+1, x^2,y^2,z^2,z^2+1, x^3,y^3,z^3,z^3+1]", 4,3, S ), S4 ), S4_freyd );;
alpha := PreCompose( lift, gamma );;
Lift( alpha, gamma );;
Colift( lift, alpha );;
IsCongruentForMorphisms( PreCompose( lift, Colift( lift, alpha ) ), alpha );;
interpretation := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( gamma );;
IsCongruentForMorphisms( gamma,
InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( gamma ), Range( gamma ), interpretation ) );;

## Opposite
HomomorphismStructureOnObjects( Opposite( Z4 ), Opposite( Z2 ) );;
HomomorphismStructureOnObjects( Z2, Z4 );;
interpretation := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( Opposite( gamma ) );;
IsCongruentForMorphisms( Opposite( gamma ),
InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( Opposite( gamma ) ), Range( Opposite( gamma ) ), interpretation ) );
#! true
#! @EndExample
