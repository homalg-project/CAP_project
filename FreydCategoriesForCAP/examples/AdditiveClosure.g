#! @Chapter Example on additive closure

#! @Section Using matrix data structures

LoadPackage( "FreydCategoriesForCAP" );;

#! @Example
QQ := HomalgFieldOfRationalsInSingular();;

R := QQ * "x,y,z";;
CR := RingAsCategory( R );;
CRplus := AdditiveClosure( CR );;

M := HomalgMatrix( "[[x^2,4*y]]", 1, 2, R );;
N := HomalgMatrix( "[[1,3*x], [2*y^3,5*y]]", 2, 2, R );;
P := M * N;;

o := AsAdditiveClosureObject( RingAsCategoryUniqueObject( CR ) );;

A := o;;
B := DirectSum( o, o );;

alpha := AdditiveClosureMorphism( A, M, B );;
IsWellDefined( alpha );
#! true
beta := AdditiveClosureMorphism( B, N, B );;
IsWellDefined( beta );
#! true
gamma := PreCompose( alpha, beta );;
IsWellDefined( gamma );
#! true
MorphismMatrix( gamma ) = P;
#! true


# E and EE are both occupied by GAP
EEE := KoszulDualRing( R );;
CEEE := RingAsCategory( EEE );;
CEEEplus := AdditiveClosure( CEEE );;

M := HomalgMatrix( "[[e0*e1,3*e0]]", 1, 2, EEE );;
N := HomalgMatrix( "[[1,e0*e2], [2*e0*e1*e2,5*e2]]", 2, 2, EEE );;
P := M * N;;

o := AsAdditiveClosureObject( RingAsCategoryUniqueObject( CEEE ) );;

A := o;;
B := DirectSum( o, o );;

alpha := AdditiveClosureMorphism( A, M, B );;
IsWellDefined( alpha );
#! true
beta := AdditiveClosureMorphism( B, N, B );;
IsWellDefined( beta );
#! true
gamma := PreCompose( alpha, beta );;
IsWellDefined( gamma );
#! true
MorphismMatrix( gamma ) = P;
#! true

#! @EndExample
