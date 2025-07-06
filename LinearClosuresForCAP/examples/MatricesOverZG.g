#! @Chapter Examples and Tests

#! @Section Matrices over ZG

LoadPackage( "LinearClosuresForCAP" );;

#! Construction of a tower of categories

#! @Example
#! #@if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2023.07-03" )
G := SymmetricGroup( 3 );;
CG := GroupAsCategory( G );;
ZZZ := HomalgRingOfIntegers( );;
ZCG := LinearClosure( ZZZ, CG );;
RowsG := AdditiveClosure( ZCG );;
#! #@fi
#! @EndExample

#! Construction of elements
#! @Example
#! #@if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2023.07-03" )
a := (1,2)/CG/ZCG;;
b := (2,3)/CG/ZCG;;
e := ()/CG/ZCG;;
omega := [ [ a - e ], [ b - e ] ]/RowsG;;
u := GroupAsCategoryUniqueObject( CG );;
v := LinearClosureObject( ZCG, u );;
u := AsAdditiveClosureObject( v );;
HomStructure( u, omega );;
#! #@fi
#! @EndExample

#! A random lifting problem over ZG
#! @Example
#! #@if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2023.07-03" )
elem := Elements( G );;
elem := List( elem, x -> x/CG/ZCG );;
rand_elem := function() local coeffs; coeffs := List( [ 1 .. 6 ], i -> Random( [ -20 .. 20 ] ) ); if ForAll( coeffs, IsZero ) then return ZeroMorphism( v, v ); fi; return Sum( List( [ 1 .. 6 ], i -> Random( [ -20 .. 20 ] ) * One( ZZZ ) * elem[i] ) ); end;;
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
#! #@fi
#! @EndExample
