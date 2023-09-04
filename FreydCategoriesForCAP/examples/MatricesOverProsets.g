#! @Chapter Examples and Tests

#! @Section Matrices over ZP_K

LoadPackage( "FreydCategoriesForCAP" );;

#! @Example
#! #@if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2023.07-03" )
#Incidence matrix of our proset
K := [ [1, 1, 1], [0, 1, 1], [0, 1, 1] ];;
#Construction of a tower of categories
CP_K := ProSetAsCategory( K );;
ZZZ := HomalgRingOfIntegers( );;
ZP_K := LinearClosure( ZZZ, CP_K, ReturnTrue );;
RowsP_K := AdditiveClosure( ZP_K );;

a := ProSetAsCategoryObject( 1, CP_K );;
b := ProSetAsCategoryObject( 2, CP_K );;
c := ProSetAsCategoryObject( 3, CP_K );;

#Three random objects in the additive closure
#Such that there exists morphisms from A->B and B->C:
rand_coef := List( [ 1 .. 5 ], i -> Random( [ 2 .. 20 ] ) );;

A1 := List( [ 1 .. rand_coef[ 1 ] ], i -> a );;
A2 := List( [ 1 .. rand_coef[ 2 ] ], i -> b );;
A := Concatenation( A1, A2 );;

B1 := List( [ 1 .. rand_coef[ 3 ] ], i -> b );;
B2 := List( [ 1 .. rand_coef[ 4 ] ], i -> c );;
B :=  Concatenation( B1, B2 );;

C := List([ 1 .. rand_coef[ 5 ] ], i -> c);;

#A random lifting problem over ZP_K
MA_B :=  List( [ 1 .. rand_coef[ 1 ] + rand_coef[ 2 ] ], i ->
            List( [ 1 .. rand_coef[ 3 ] + rand_coef[ 4 ] ], j ->
                LinearClosureMorphism( LinearClosureObject( A[i], ZP_K ), [Random( [ -20 .. 20 ] )], [ProSetAsCategoryMorphism( A[i], B[j] )], LinearClosureObject( B[j], ZP_K ) )
                )
              );;

alpha := MA_B/RowsP_K;;

MB_C :=  List( [ 1 .. rand_coef[ 3 ] + rand_coef[ 4 ] ], i ->
            List( [ 1 .. rand_coef[ 5 ] ], j ->
                LinearClosureMorphism( LinearClosureObject( B[i], ZP_K ), [Random( [ -20 .. 20 ] )], [ProSetAsCategoryMorphism( B[i], C[j] )], LinearClosureObject( C[j], ZP_K ) )
                )
             );;

beta := MB_C/RowsP_K;;

gamma := PreCompose( alpha, beta );;
lift := Lift( gamma, beta );;
PreCompose(lift, beta) = gamma;
#! true
#! #@fi
#! @EndExample
