#! @Chapter Examples and Tests

#! @Section Rings as Ab-categories

LoadPackage( "FreydCategoriesForCAP" );;

#! @Example
CR := RingAsCategory( Integers );;
u := RingAsCategoryUniqueObject( CR );;
alpha := 2 / CR;
#! <2>
IsOne( alpha );
#! false
IsZero( alpha );
#! false
alpha * alpha;
#! <4>
-alpha;
#! <-2>
IsZero( alpha + AdditiveInverse( alpha ) );
#! true
beta := RingAsCategoryMorphism( 1/2, CR );;
IsWellDefined( beta );
#! false
gamma := IdentityMorphism( u );
#! <1>
IsOne( gamma );
#! true
delta := ZeroMorphism( u, u );
#! <0>
IsZero( delta );
#! true
2 * beta;
#! <1>
Lift( alpha * alpha, alpha );
#! <2>
Colift( alpha, alpha * alpha );
#! <2>

#! @EndExample
