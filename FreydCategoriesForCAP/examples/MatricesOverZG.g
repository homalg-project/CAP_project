#! @Chapter Examples and Tests

#! @Section Matrices over ZG

LoadPackage( "FreydCategoriesForCAP" );;

#! Construction of a tower of categories

#! @Example
G := SymmetricGroup( 3 );;
CG := GroupAsCategory( G );;
compare_func := function( g, h ) return UnderlyingGroupElement( g ) < UnderlyingGroupElement( h ); end;;
ZZ := HomalgRingOfIntegers( );;
ZCG := LinearClosure( ZZ, CG, compare_func );;
RowsG := AdditiveClosure( ZCG );;
#! @EndExample

#! Construction of elements
#! @Example
a := (1,2)/CG/ZCG;;
b := (2,3)/CG/ZCG;;
e := ()/CG/ZCG;;
omega := [ [ a - e ], [ b - e ] ]/RowsG;;
u := GroupAsCategoryUniqueObject( CG );;
u := LinearClosureObject( ZCG, u );;
u := AsAdditiveClosureObject( u );;
HomStructure( u, omega );;
#! @EndExample

#! A random lifting problem over ZG
#! @Example
elem := Elements( G );;
elem := List( elem, x -> x/CG/ZCG );;
rand_elem := function() local coeffs; coeffs := List( [ 1 .. 6 ], i -> Random( [ -20 .. 20 ] ) ); if ForAll( coeffs, IsZero ) then return ZeroMorphism( v, v ); fi; return Sum( List( [ 1 .. 6 ], i -> Random( [ -20 .. 20 ] ) * One( ZZ ) * elem[i] ) ); end;;
mat10_11 := List( [ 1 .. 10 ], i ->
        List( [ 1 .. 11 ], j ->
            rand_elem()
        )
    );;
mat11_12 := List( [ 1 .. 11 ], i ->
        List( [ 1 .. 12 ], j ->
            rand_elem()
        )
    );;
alpha := mat10_11/RowsG;;
beta := mat11_12/RowsG;;
gamma := PreCompose( alpha, beta );;
lift := Lift( gamma, beta );;
PreCompose( lift, beta ) = gamma;
#! true
#! @EndExample