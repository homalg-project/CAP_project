#################################################################
#################################################################
#! @Chapter Examples on graded rows and columns
#################################################################
#################################################################

LoadPackage( "FreydCategoriesForCAP" );;



#################################################################
#! @Section Constructors of objects and reduction of degree lists
#################################################################

#! @Example
Q := HomalgFieldOfRationalsInSingular();
#! Q
S := GradedRing( Q * "x_1, x_2, x_3, x_4" );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: yet unset)
SetWeightsOfIndeterminates( S, [[1,0],[1,0],[0,1],[0,1]] );
#!
ObjectL := GradedRow( [ [[1,0],2] ], S );
#! <A graded row of rank 2>
DegreeList( ObjectL );
#! [ [ ( 1, 0 ), 2 ] ]
Object2L := GradedRow( [ [[1,0],2], 
           [[1,0],3],[[0,1],2],[[1,0],1] ], S );
#! <A graded row of rank 8>
DegreeList( Object2L );
#! [ [ ( 1, 0 ), 5 ], [ ( 0, 1 ), 2 ], [ ( 1, 0 ), 1 ] ]
UnzipDegreeList( Object2L );
#! [ ( 1, 0 ), ( 1, 0 ), ( 1, 0 ), ( 1, 0 ), ( 1, 0 ), ( 0, 1 ), ( 0, 1 ), ( 1, 0 ) ]
ObjectR := GradedColumn( [ [[1,0],2] ], S );
#! <A graded column of rank 2>
DegreeList( ObjectR );
#! [ [ ( 1, 0 ), 2 ] ]
Object2R := GradedColumn( [ [[1,0],2], 
           [[1,0],3],[[0,1],2],[[1,0],1] ], S );
#! <A graded column of rank 8>
DegreeList( Object2R );
#! [ [ ( 1, 0 ), 5 ], [ ( 0, 1 ), 2 ], [ ( 1, 0 ), 1 ] ]
UnzipDegreeList( Object2R );
#! [ ( 1, 0 ), ( 1, 0 ), ( 1, 0 ), ( 1, 0 ), ( 1, 0 ), ( 0, 1 ), ( 0, 1 ), ( 1, 0 ) ]
S2 := GradedRing( Q * "x" );;
SetWeightsOfIndeterminates( S2, [ 1 ] );;
IsWellDefined( GradedRow( [ [ [ 1 ], 1 ] ], S2 ) );
#! true
IsWellDefined( GradedColumn( [ [ [ 1 ], 1 ] ], S2 ) );
#! true
#! @EndExample


#! Whenever the object constructor is called, it tries to simplify the given degree list. To this end it checks if
#! subsequent degree group elements match. If so, their multiplicities are added. So, as in the example above we have:
#! $$ [ [(1,0),2], [(1,0),3],[(0,1),2],[(1,0),1] ] \mapsto [ [ ( 1, 0 ), 5 ], [ ( 0, 1 ), 2 ], [ ( 1, 0 ), 1 ] ] $$
#! Note that, even though there are two occurances of $\left( 1,0 \right)$ in the final degree list, we do not
#! simplify further. The reason for this is as follows. Assume that we have a map of graded rows
#! $$ \varphi \colon A \to B $$
#! given by a homomgeneous matrix $M$ and that we want to compute the weak kernel embedding of this mapping. To this end we
#! first compute the row syzygies of
#! $M$. Let us call the corresponding matrix $N$. Then we deduce the degree list of the weak kernel object from $N$ and
#! from the graded row $A$. Once this degree list is known, we would call the object constructor.
#! If this object constructor summarised all (and not only subsequent) occurances of one degree element in the
#! degree list, then in order to make sure that the weak kernel embedding is a mapping of graded rows, the rows
#! of the matrix $N$ would have to be shuffled. The latter we do not wish to perform.
#!
#! Note that the 'IsEqualForObjects' methods returns true whenever the degree lists of two graded rows/columns are identical. So
#! in particular it returns false, if the degree lists are mere permutations of one another.
#! Here is an example.

#! @Example

Object2LShuffle := GradedRow( [ [[0,1],1],
           [[1,0],2],[[0,1],1],[[1,0],4] ], S );
#! <A graded row of rank 8>
IsEqualForObjects( Object2L, Object2LShuffle );
#! false
Object2RShuffle := GradedColumn( [ [[0,1],1],
           [[1,0],2],[[0,1],1],[[1,0],4] ], S );
#! <A graded column of rank 8>
IsEqualForObjects( Object2R, Object2RShuffle );
#! false

#! @EndExample



#####################################
#! @Section Constructors of morphisms
#####################################

#! @Example
Q1L := GradedRow( [ [[0,0],1] ], S );
#! <A graded row of rank 1>
IsWellDefined( Q1L );
#! true
Q2L := GradedRow( [ [[1,0],2] ], S );
#! <A graded row of rank 2>
m1L := GradedRowOrColumnMorphism( 
      Q1L, HomalgMatrix( [["x_1","x_2"]], S ) ,Q2L );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( m1L );
#! true
#! @EndExample

#! @Log
Display( Source( m1L ) );
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
Display( Range( m1L ) );
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
Display( UnderlyingHomalgMatrix( m1L ) );
#! x_1,x_2
#! (over a graded ring)
#! @EndLog

#! @Example
Q1R := GradedColumn( [ [[0,0],1] ], S );
#! <A graded column of rank 1>
IsWellDefined( Q1R );
#! true
Q2R := GradedColumn( [ [[1,0],2] ], S );
#! <A graded column of rank 2>
m1R := GradedRowOrColumnMorphism( 
      Q1R, HomalgMatrix( [["x_1"],["x_2"]], S ) ,Q2R );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( m1R );
#! true
#! @EndExample

#! @Log
Display( Source( m1R ) );
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
Display( Range( m1R ) );
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
Display( UnderlyingHomalgMatrix( m1R ) );
#! x_1,
#! x_2
#! (over a graded ring)
#! @EndLog




##############################
#! @Section The GAP categories
##############################

#! @Example

categoryL := CapCategory( Q1L );
#! Category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
categoryR := CapCategory( Q1R );
#! Category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])

#! @EndExample



#######################################################################
#! @Section A few categorical constructions for graded rows
#######################################################################

#! @Example
ZeroObject( categoryL );
#! <A graded row of rank 0>
O1L := GradedRow( [ [[-1,0],2] ], S );
#! <A graded row of rank 2>
#! @EndExample

#! @Log
Display( ZeroMorphism( ZeroObject( categoryL ), O1L ) );
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 0 and degrees: 
#! [  ]
#! 
#! Matrix:
#! (an empty 0 x 2 matrix)
#! 
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ ( -1, 0 ), 2 ] ]
#! @EndLog

#! @Example
O2L := GradedRow( [ [[0,0],1] ], S );
#! <A graded row of rank 1>
obj3L := GradedRow( [ [[-1,0],1] ], S );
#! <A graded row of rank 1>
#! @EndExample

#! @Log
Display( IdentityMorphism( O2L ) );
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#! 
#! Matrix:
#! 1
#! (over a graded ring)
#! 
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#! @EndLog

#! @Example
IsWellDefined( IdentityMorphism( Q2L ) );
#! true
directSumL := DirectSum( [ O1L, O2L ] );
#! <A graded row of rank 3>
#! @EndExample

#! @Log
Display( directSumL );
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 3 and degrees:
#! [ [ ( -1, 0 ), 2 ], [ 0, 1 ] ]
#! @EndLog

#! @Example
i1L := InjectionOfCofactorOfDirectSum( [ O1L, O2L ], 1 );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( i1L );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( i1L ) );
#! 1,0,0,
#! 0,1,0 
#! (over a graded ring)
#! @EndLog

#! @Example
i2L := InjectionOfCofactorOfDirectSum( [ O1L, O2L ], 2 );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ],[ 0, 1 ] ])>
IsWellDefined( i2L );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( i2L ) );
#! 0,0,1
#! (over a graded ring)
#! @EndLog

#! @Example
proj1L := ProjectionInFactorOfDirectSum( [ O1L, O2L ], 1 );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( proj1L );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( proj1L ) );
#! 1,0,
#! 0,1,
#! 0,0 
#! (over a graded ring)
#! @EndLog

#! @Example
proj2L := ProjectionInFactorOfDirectSum( [ O1L, O2L ], 2 );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( proj2L );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( proj2L ) );
#! 0,
#! 0,
#! 1 
#! (over a graded ring)
#! @EndLog

#! @Example
kL := WeakKernelEmbedding( proj1L );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( kL );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( kL ) );
#! 0,0,1
#! (over a graded ring)
#! @EndLog

#! @Example
ckL := WeakCokernelProjection( kL );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( ckL );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( ckL ) );
#! 1,0,
#! 0,1,
#! 0,0 
#! (over a graded ring)
#! @EndLog

#! @Example
IsMonomorphism( kL );
#! true
IsEpimorphism( kL );
#! false
IsMonomorphism( ckL );
#! false
IsEpimorphism( ckL );
#! true
m1L := GradedRowOrColumnMorphism( O1L, 
      HomalgMatrix( [[ "x_1" ], [ "x_2" ]], S ), O2L );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( m1L );
#! true
m2L := IdentityMorphism( O2L );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( m2L );
#! true
obj1L := GradedRow( [ [[0,0],1], [[-1,0],1] ], S );
#! <A graded row of rank 2>
m1L := GradedRowOrColumnMorphism( obj1L, 
      HomalgMatrix( [[ 1 ], [ "x_2"] ], S ), O2L );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( m1L );
#! true
m3L := GradedRowOrColumnMorphism( obj3L, 
      HomalgMatrix( [[ "x_1" ]], S ), O2L );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( m3L );
#! true
liftL := Lift( m3L, m1L );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( liftL );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( liftL ) );
#! x_1, 0
#! (over a graded ring)
#! @EndLog

#! @Example
O3L := GradedRow( [ [[1,0],2] ], S );
#! <A graded row of rank 2>
morL := GradedRowOrColumnMorphism( 
       O2L, HomalgMatrix( [[ "x_1, x_2" ]], S ), O3L );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( morL );
#! true
coliftL := Colift( m2L, morL );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( coliftL );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( coliftL ) );
#! x_1,x_2
#! (over a graded ring)
#! @EndLog

#! @Example
fpL := WeakBiFiberProduct( m1L, m2L );
#! <A graded row of rank 2>
fp_proj1L := ProjectionInFirstFactorOfWeakBiFiberProduct( m1L, m2L );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( fp_proj1L );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( fp_proj1L ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
#! @EndLog

#! @Example
fp_proj2L := ProjectionInSecondFactorOfWeakBiFiberProduct( m1L, m2L );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( fp_proj2L );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( fp_proj2L ) );
#! 1,
#! x_2 
#! (over a graded ring)
#! @EndLog

#! @Example
BiasedWeakFiberProduct( m1L, m2L );
#! <A graded row of rank 2>
pbwfprow := ProjectionOfBiasedWeakFiberProduct( m1L, m2L );
#! <A morphism in Category of graded rows over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( pbwfprow );
#! true
#! @EndExample

#! @Log
Display( pbwfprow );
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 1 ], [ ( -1, 0 ), 1 ] ]
#! 
#! Matrix:
#! 1,0,
#! 0,1 
#! (over a graded ring)
#! 
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 1 ], [ ( -1, 0 ), 1 ] ]
#! @EndLog

#! @Example
poL := WeakBiPushout( morL, m2L );
#! <A graded row of rank 2>
inj1L := InjectionOfFirstCofactorOfWeakBiPushout( morL, m2L );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( inj1L );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( inj1L ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
#! @EndLog

#! @Example
inj2L := InjectionOfSecondCofactorOfWeakBiPushout( morL, m2L );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( inj2L );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( inj2L ) );
#! x_1,x_2
#! (over a graded ring)
#! @EndLog

#! @Example
injectionL := InjectionOfBiasedWeakPushout( morL, m2L );
#! <A morphism in Category of graded rows over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( injectionL );
#! true
#! @EndExample

#! @Log
Display( injectionL );
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
#! 
#! Matrix:
#! 1,0,
#! 0,1 
#! (over a graded ring)
#! 
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
#! @EndLog

#! @Example
tensorProductL := TensorProductOnObjects( O1L, O2L );
#! <A graded row of rank 2>
#! @EndExample

#! @Log
Display( tensorProductL );
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( -1, 0 ), 2 ] ]
#! @EndLog

#! @Example
tensorProductMorphismL := TensorProductOnMorphisms( m2L, morL );
#! <A morphism in Category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( tensorProductMorphismL );
#! true
#! @EndExample

#! @Log
Display( tensorProductMorphismL );
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#! 
#! Matrix:
#! x_1,x_2
#! (over a graded ring)
#! 
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
Display( DualOnObjects( TensorProductOnObjects( ObjectL, Object2L ) ) );
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 16 and degrees: 
#! [ [ ( -2, 0 ), 5 ], [ ( -1, -1 ), 2 ], [ ( -2, 0 ), 6 ], [ ( -1, -1 ), 2 ], 
#! [ ( -2, 0 ), 1 ] ]
#! @EndLog

#! @Example
IsWellDefined( DualOnMorphisms( m1L ) );
#! true
#! @EndExample

#! @Log
Display( DualOnMorphisms( m1L ) );
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#! 
#! Matrix:
#! 1,x_2
#! (over a graded ring)
#! 
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 1 ], [ ( 1, 0 ), 1 ] ]
#! @EndLog

#! @Example
IsWellDefined( EvaluationForDualWithGivenTensorProduct( TensorProductOnObjects( 
DualOnObjects( ObjectL ), ObjectL ), ObjectL, TensorUnit( categoryL ) ) );
#! true
#! @EndExample

#! @Log
Display( EvaluationForDualWithGivenTensorProduct( TensorProductOnObjects( 
DualOnObjects( ObjectL ), ObjectL ), ObjectL, TensorUnit( categoryL ) ) );
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 4 and degrees: 
#! [ [ 0, 4 ] ]
#! 
#! Matrix:
#! 1,
#! 0,
#! 0,
#! 1 
#! (over a graded ring)
#! 
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
Display( InternalHomOnObjects( ObjectL, ObjectL ) );
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 4 and degrees: 
#! [ [ 0, 4 ] ]
#! @EndLog


########################################################################
#! @Section A few categorical constructions for graded columns
########################################################################

#! @Example
ZeroObject( categoryR );
#! <A graded column of rank 0>
O1R := GradedColumn( [ [[-1,0],2] ], S );
#! <A graded column of rank 2>
#! @EndExample

#! @Log
Display( ZeroMorphism( ZeroObject( categoryR ), O1R ) );
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1,0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 0 and degrees: 
#! [  ]
#! 
#! Matrix:
#! (an empty 2 x 0 matrix)
#! 
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1,0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ ( -1, 0 ), 2 ] ]
#! @EndLog

#! @Example
O2R := GradedColumn( [ [[0,0],1] ], S );
#! <A graded column of rank 1>
obj3R := GradedColumn( [ [[-1,0],1] ], S );
#! <A graded column of rank 1>
#! @EndExample

#! @Log
Display( IdentityMorphism( O2R ) );
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#! 
#! Matrix:
#! 1
#! (over a graded ring)
#! 
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#! @EndLog

#! @Example
IsWellDefined( IdentityMorphism( Q2R ) );
#! true
directSumR := DirectSum( [ O1R, O2R ] );
#! <A graded column of rank 3>
#! @EndExample

#! @Log
Display( directSumR );
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 3 and degrees:
#! [ [ ( -1, 0 ), 2 ], [ 0, 1 ] ]
#! @EndLog

#! @Example
i1R := InjectionOfCofactorOfDirectSum( [ O1R, O2R ], 1 );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( i1R );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( i1R ) );
#! 1,0,
#! 0,1,
#! 0,0
#! (over a graded ring)
#! @EndLog

#! @Example
i2R := InjectionOfCofactorOfDirectSum( [ O1R, O2R ], 2 );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ],[ 0, 1 ] ])>
IsWellDefined( i2R );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( i2R ) );
#! 0,
#! 0,
#! 1
#! (over a graded ring)
#! @EndLog

#! @Example
proj1R := ProjectionInFactorOfDirectSum( [ O1R, O2R ], 1 );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( proj1R );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( proj1R ) );
#! 1,0,0,
#! 0,1,0
#! (over a graded ring)
#! @EndLog

#! @Example
proj2R := ProjectionInFactorOfDirectSum( [ O1R, O2R ], 2 );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( proj2R );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( proj2R ) );
#! 0,0,1
#! (over a graded ring)
#! @EndLog

#! @Example
kR := WeakKernelEmbedding( proj1R );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( kR );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( kR ) );
#! 0,
#! 0,
#! 1
#! (over a graded ring)
#! @EndLog

#! @Example
ckR := WeakCokernelProjection( kR );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( ckR );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( ckR ) );
#! 1,0,0,
#! 0,1,0
#! (over a graded ring)
#! @EndLog

#! @Example
IsMonomorphism( kR );
#! true
IsEpimorphism( kR );
#! false
IsMonomorphism( ckR );
#! false
IsEpimorphism( ckR );
#! true
m1R := GradedRowOrColumnMorphism( O1R, 
      HomalgMatrix( [[ "x_1", "x_2" ]], S ), O2R );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( m1R );
#! true
m2R := IdentityMorphism( O2R );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( m2R );
#! true
obj1R := GradedColumn( [ [[0,0],1], [[-1,0],1] ], S );
#! <A graded column of rank 2>
m1R := GradedRowOrColumnMorphism( obj1R, 
      HomalgMatrix( [ [ 1, "x_2"] ], S ), O2R );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( m1R );
#! true
m3R := GradedRowOrColumnMorphism( obj3R, 
      HomalgMatrix( [[ "x_1" ]], S ), O2R );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( m3R );
#! true
liftR := Lift( m3R, m1R );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( liftR );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( liftR ) );
#! x_1,
#! 0
#! (over a graded ring)
#! @EndLog

#! @Example
O3R := GradedColumn( [ [[1,0],2] ], S );
#! <A graded column of rank 2>
morR := GradedRowOrColumnMorphism( 
       O2R, HomalgMatrix( [[ "x_1" ], [ "x_2" ]], S ), O3R );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( morR );
#! true
coliftR := Colift( m2R, morR );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( coliftR );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( coliftR ) );
#! x_1,
#! x_2
#! (over a graded ring)
#! @EndLog

#! @Example
fpR := WeakBiFiberProduct( m1R, m2R );
#! <A graded column of rank 2>
fp_proj1R := ProjectionInFirstFactorOfWeakBiFiberProduct( m1R, m2R );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( fp_proj1R );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( fp_proj1R ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
#! @EndLog

#! @Example
fp_proj2R := ProjectionInSecondFactorOfWeakBiFiberProduct( m1R, m2R );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( fp_proj2R );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( fp_proj2R ) );
#! 1, x_2
#! (over a graded ring)
#! @EndLog

#! @Example
BiasedWeakFiberProduct( m1R, m2R );
#! <A graded column of rank 2>
pbwfpcol := ProjectionOfBiasedWeakFiberProduct( m1R, m2R );
#! <A morphism in Category of graded columns over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( pbwfpcol );
#! true
#! @EndExample

#! @Log
Display( pbwfpcol );
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 1 ], [ ( -1, 0 ), 1 ] ]
#! 
#! Matrix:
#! 1,0,
#! 0,1 
#! (over a graded ring)
#! 
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 1 ], [ ( -1, 0 ), 1 ] ]
#! @EndLog

#! @Example
poR := WeakBiPushout( morR, m2R );
#! <A graded column of rank 2>
inj1R := InjectionOfFirstCofactorOfWeakBiPushout( morR, m2R );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( inj1R );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( inj1R ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
#! @EndLog

#! @Example
inj2R := InjectionOfSecondCofactorOfWeakBiPushout( morR, m2R );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( inj2R );
#! true
#! @EndExample

#! @Log
Display( UnderlyingHomalgMatrix( inj2R ) );
#! x_1,
#! x_2
#! (over a graded ring)
#! @EndLog

#! @Example
injectionR := InjectionOfBiasedWeakPushout( morR, m2R );
#! <A morphism in Category of graded columns over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( injectionR );
#! true
#! @EndExample

#! @Log
Display( injectionR );
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
#! 
#! Matrix:
#! 1,0,
#! 0,1 
#! (over a graded ring)
#! 
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
#! @EndLog

#! @Example
tensorProductR := TensorProductOnObjects( O1R, O2R );
#! <A graded column of rank 2>
#! @EndExample

#! @Log
Display( tensorProductR );
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( -1, 0 ), 2 ] ]
#! @EndLog

#! @Example
tensorProductMorphismR := TensorProductOnMorphisms( m2R, morR );
#! <A morphism in Category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
IsWellDefined( tensorProductMorphismR );
#! true
#! @EndExample

#! @Log
Display( tensorProductMorphismR );
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#! 
#! Matrix:
#! x_1,
#! x_2 
#! (over a graded ring)
#! 
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
Display( DualOnObjects( TensorProductOnObjects( ObjectR, Object2R ) ) );
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 16 and degrees: 
#! [ [ ( -2, 0 ), 5 ], [ ( -1, -1 ), 2 ], [ ( -2, 0 ), 6 ], [ ( -1, -1 ), 2 ], 
#! [ ( -2, 0 ), 1 ] ]
#! @EndLog

#! @Example
IsWellDefined( DualOnMorphisms( m1R ) );
#! true
#! @EndExample

#! @Log
Display( DualOnMorphisms( m1R ) );
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#! 
#! Matrix:
#! 1, 
#! x_2
#! (over a graded ring)
#! 
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 1 ], [ ( 1, 0 ), 1 ] ]
#! @EndLog

#! @Example
IsWellDefined( EvaluationForDualWithGivenTensorProduct( TensorProductOnObjects( 
DualOnObjects( ObjectR ), ObjectR ), ObjectR, TensorUnit( categoryR ) ) );
#! true
#! @EndExample

#! @Log
Display( EvaluationForDualWithGivenTensorProduct( TensorProductOnObjects( 
DualOnObjects( ObjectR ), ObjectR ), ObjectR, TensorUnit( categoryR ) ) );
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! 
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 4 and degrees: 
#! [ [ 0, 4 ] ]
#! 
#! Matrix:
#! 1,0,0,1
#! (over a graded ring)
#! 
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
Display( InternalHomOnObjects( ObjectR, ObjectR ) );
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 4 and degrees: 
#! [ [ 0, 4 ] ]
#! @EndLog


#####################################################################
#! @Section Additional examples on monoidal structure for graded rows
#####################################################################

#! @Example
aR := GradedRow( [ [ [1,0], 1 ] ], S );
#! <A graded row of rank 1>
bR := ZeroObject( aR );
#! <A graded row of rank 0>
coevR := CoevaluationForDual( bR );
#! <A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( coevR );
#! true
evalR := EvaluationForDual( bR );
#! <A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( evalR );
#! true
cR := GradedRow( [ [ [2,0], 1 ] ], S );
#! <A graded row of rank 1>
aR_o_bR := TensorProductOnObjects( aR, bR );
#! <A graded row of rank 0>
phiR := ZeroMorphism( aR_o_bR, cR );
#! <A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( phiR );
#! true
tens_mor := TensorProductToInternalHomAdjunctionMap(aR,bR,phiR);
#! <A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( tens_mor );
#! true
#! @EndExample


########################################################################
#! @Section Additional examples on monoidal structure for graded columns
########################################################################

#! @Example
aC := GradedColumn( [ [ [1,0], 1 ] ], S );
#! <A graded column of rank 1>
bC := ZeroObject( aC );
#! <A graded column of rank 0>
coevC := CoevaluationForDual( bC );
#! <A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( coevC );
#! true
evalC := EvaluationForDual( bC );
#! <A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( evalC );
#! true
cC := GradedColumn( [ [ [2,0], 1 ] ], S );
#! <A graded column of rank 1>
aC_o_bC := TensorProductOnObjects( aC, bC );
#! <A graded column of rank 0>
phiC := ZeroMorphism( aC_o_bC, cC );
#! <A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( phiC );
#! true
tens_mor := TensorProductToInternalHomAdjunctionMap(aC,bC,phiC);
#! <A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( tens_mor );
#! true
#! @EndExample


########################################################################
#! @Section Examples to test Tools methods in graded rows/cols
########################################################################

#! @Example
S := GradedRing( Q * "x,y" );
#! Q[x,y]
#! (weights: yet unset)
SetWeightsOfIndeterminates( S, [ 1, 1 ] );
mat_1 := HomalgMatrix( "[ x, 0, 0, y ]", 2, 2, S );
#! <A 2 x 2 matrix over a graded ring>
mat_2 := HomalgMatrix( "[ x, 0, 0, 0 ]", 2, 2, S );
#! <A 2 x 2 matrix over a graded ring>
a := GradedRow( [ [ [ 1 ], 1 ], [ [ 2 ], 1 ] ], S );
#! <A graded row of rank 2>
b := GradedColumn( [ [ [ 1 ], 1 ], [ [ 2 ], 1 ] ], S );
#! <A graded column of rank 2>
map := DeduceMapFromMatrixAndRangeForGradedRows( mat_1, a );
#! <A morphism in Category of graded rows over Q[x,y] (with weights [ 1, 1 ])>
some_map := DeduceSomeMapFromMatrixAndRangeForGradedRows( mat_1, a );
#! <A morphism in Category of graded rows over Q[x,y] (with weights [ 1, 1 ])>
IsEqualForMorphisms( map, some_map );
#! true
map := DeduceMapFromMatrixAndSourceForGradedRows( mat_1, a );
#! <A morphism in Category of graded rows over Q[x,y] (with weights [ 1, 1 ])>
some_map := DeduceSomeMapFromMatrixAndSourceForGradedRows( mat_1, a );
#! <A morphism in Category of graded rows over Q[x,y] (with weights [ 1, 1 ])>
IsEqualForMorphisms( map, some_map );
#! true
some_map := DeduceSomeMapFromMatrixAndRangeForGradedRows( mat_2, a );
#! <A morphism in Category of graded rows over Q[x,y] (with weights [ 1, 1 ])>
IsWellDefined( some_map );
#! true
some_map := DeduceSomeMapFromMatrixAndSourceForGradedRows( mat_2, a );
#! <A morphism in Category of graded rows over Q[x,y] (with weights [ 1, 1 ])>
IsWellDefined( some_map );
#! true
map := DeduceMapFromMatrixAndRangeForGradedCols( mat_1, b );
#! <A morphism in Category of graded columns over Q[x,y] (with weights [ 1, 1 ])>
some_map := DeduceSomeMapFromMatrixAndRangeForGradedCols( mat_1, b );
#! <A morphism in Category of graded columns over Q[x,y] (with weights [ 1, 1 ])>
IsEqualForMorphisms( map, some_map );
#! true
map := DeduceMapFromMatrixAndSourceForGradedCols( mat_1, b );
#! <A morphism in Category of graded columns over Q[x,y] (with weights [ 1, 1 ])>
some_map := DeduceSomeMapFromMatrixAndSourceForGradedCols( mat_1, b );
#! <A morphism in Category of graded columns over Q[x,y] (with weights [ 1, 1 ])>
IsEqualForMorphisms( map, some_map );
#! true
some_map := DeduceSomeMapFromMatrixAndRangeForGradedCols( mat_2, b );
#! <A morphism in Category of graded columns over Q[x,y] (with weights [ 1, 1 ])>
IsWellDefined( some_map );
#! true
some_map := DeduceSomeMapFromMatrixAndSourceForGradedCols( mat_2, b );
#! <A morphism in Category of graded columns over Q[x,y] (with weights [ 1, 1 ])>
IsWellDefined( some_map );
#! true
#! @EndExample
