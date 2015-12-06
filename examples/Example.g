#! @Chapter Examples and Tests

LoadPackage( "CAPCategoryOfProjectiveGradedModules" );;


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
ObjectL := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],2] ], S );
#! <A projective graded left module of rank 2>
DegreeList( ObjectL );
#! [ [ ( 1, 0 ), 2 ] ]
Object2L := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],2], 
           [[1,0],3],[[0,1],2],[[1,0],1] ], S );
#! <A projective graded left module of rank 8>
DegreeList( Object2L );
#! [ [ ( 1, 0 ), 5 ], [ ( 0, 1 ), 2 ], [ ( 1, 0 ), 1 ] ]
ObjectR := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],2] ], S );
#! <A projective graded right module of rank 2>
DegreeList( ObjectR );
#! [ [ ( 1, 0 ), 2 ] ]
Object2R := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],2], 
           [[1,0],3],[[0,1],2],[[1,0],1] ], S );
#! <A projective graded right module of rank 8>
DegreeList( Object2R );
#! [ [ ( 1, 0 ), 5 ], [ ( 0, 1 ), 2 ], [ ( 1, 0 ), 1 ] ]

#! @EndExample

#! Whenever the object constructor is called, it tried to simplify the given degree list. To this end it checks if 
#! subsequent degree group elements match. If so, their multiplicities are added. So, as in the example above we have:
#! $$ [ [[1,0],2], [[1,0],3],[[0,1],2],[[1,0],1] ] \mapsto [ [ ( 1, 0 ), 5 ], [ ( 0, 1 ), 2 ], [ ( 1, 0 ), 1 ] ] $$
#! Note that, even though there are two occurances of $\left( 1,0 \right)$ in the final degree list, which we do not 
#! simplify. The reason for this is as follows. Assume that we have a map of graded modules
#! $$ \varphi \colon A \to B $$
#! given by a homomgeneous matrix $M$ and that we want to compute the kernel embedding of this mapping. To this end we
#! first compute the syzygies (of rows or columns, depending on whether we are dealing with right or left-modules) of
#! $M$. Let us call the corresponding matrix $N$. Then we deduce the degree list of the kernel object from $N$ and
#! from the projective graded module $A$. Once this degree list is known, we would call the object constructor.
#! If this object constructor summarised all (and not only subsequent) occurances of one degree element in the 
#! degree list, then in order to make sure that the kernel embedding is a mapping of graded modules, rows/columns
#! of the matrix $N$ would have to be shuffled. The latter we do not wish to perform.

#! Nevertheless, the 'IsEqualForObjects' methods returns true whenever two projective modules are isomorphic. So
#! in particular it returns true, if the degree lists are mere permutations of one another. Here is an example.

#! @Example

Object2LShuffle := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[0,1],1],
           [[1,0],2],[[0,1],1],[[1,0],4] ], S );
#! <A projective graded left module of rank 8>
IsEqualForObjects( Object2L, Object2LShuffle );
#! true
Object2RShuffle := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[0,1],1],
           [[1,0],2],[[0,1],1],[[1,0],4] ], S );
#! <A projective graded right module of rank 8>
IsEqualForObjects( Object2R, Object2RShuffle );
#! true

#! @EndExample



#####################################
#! @Section Constructors of morphisms
#####################################

#! @Example
Q1L := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],1] ], S );
#! <A projective graded left module of rank 1>
IsWellDefined( Q1L );
#! true
Q2L := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[0,0],2] ], S );
#! <A projective graded left module of rank 2>
m1L := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q1L, HomalgMatrix( [["x_1","x_2"]], S ) ,Q2L );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( m1L );
#! true
Display( Source( m1L ) );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
Display( Range( m1L ) );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
Display( UnderlyingHomalgMatrix( m1L ) );
#! x_1,x_2
#! (over a graded ring)
Q1R := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],1] ], S );
#! <A projective graded right module of rank 1>
IsWellDefined( Q1R );
#! true
Q2R := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[0,0],2] ], S );
#! <A projective graded right module of rank 2>
m1R := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q1R, HomalgMatrix( [["x_1"],["x_2"]], S ) ,Q2R );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( m1R );
#! true
Display( Source( m1R ) );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
Display( Range( m1R ) );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
Display( UnderlyingHomalgMatrix( m1R ) );
#! x_1,
#! x_2
#! (over a graded ring)

#! @EndExample



##############################
#! @Section The GAP categories
##############################

#! @Example

categoryL := CapCategory( Q1L );
#! CAP category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
categoryR := CapCategory( Q1R );
#! CAP category of projective graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])

#! @EndExample



#######################################################################
#! @Section A few categorical constructions for projective left modules
#######################################################################

#! @Example

ZeroObject( categoryL );
#! <A projective graded left module of rank 0>
O1L := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],2] ], S );
#! <A projective graded left module of rank 2>
Display( ZeroMorphism( ZeroObject( categoryL ), O1L ) );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! (an empty 0 x 2 matrix)
O2L := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[0,0],1] ], S );
#! <A projective graded left module of rank 1>
Display( IdentityMorphism( O2L ) );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1
#! (over a graded ring)
directSumL := DirectSum( [ O1L, O2L ] );
#! <A projective graded left module of rank 3>
Display( directSumL );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 3 and degrees:
#! [ [ ( 1, 0 ), 2 ], [ 0, 1 ] ]
i1L := InjectionOfCofactorOfDirectSum( [ O1L, O2L ], 1 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( i1L ) );
#! 1,0,0,
#! 0,1,0 
#! (over a graded ring)
i2L := InjectionOfCofactorOfDirectSum( [ O1L, O2L ], 2 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ],[ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( i2L ) );
#! 0,0,1
#! (over a graded ring)
proj1L := ProjectionInFactorOfDirectSum( [ O1L, O2L ], 1 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( proj1L ) );
#! 1,0,
#! 0,1,
#! 0,0 
#! (over a graded ring)
proj2L := ProjectionInFactorOfDirectSum( [ O1L, O2L ], 2 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( proj2L ) );
#! 0,
#! 0,
#! 1 
#! (over a graded ring)
kL := KernelEmbedding( proj1L );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( kL ) );
#! 0,0,1
#! (over a graded ring)
ckL := CokernelProjection( kL );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( ckL ) );
#! 1,0,
#! 0,1,
#! 0,0 
#! (over a graded ring)
IsMonomorphism( kL );
#! true
IsEpimorphism( kL );
#! false
IsMonomorphism( ckL );
#! false
IsEpimorphism( ckL );
#! true
m1L := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( O1L, 
      HomalgMatrix( [[ "x_1" ], [ "x_2" ]], S ), O2L );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
m2L := IdentityMorphism( O2L );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
liftL := Lift( m1L, m2L );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( liftL ) );
#! x_1,
#! x_2 
#! (over a graded ring)
O3L := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[-1,0],2] ], S );
#! <A projective graded left module of rank 2>
morL := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
       O2L, HomalgMatrix( [[ "x_1, x_2" ]], S ), O3L );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
coliftL := Colift( m2L, morL );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( coliftL ) );
#! x_1,x_2
#! (over a graded ring)
fpL := FiberProduct( [ m1L, m2L, IdentityMorphism( Range( m2L ) ) ] );
#! <A projective graded left module of rank 2>
fp_proj1L := ProjectionInFactorOfFiberProduct( [ m1L, m2L ], 1 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( fp_proj1L ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
fp_proj2L := ProjectionInFactorOfFiberProduct( [ m1L, m2L ], 2 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( fp_proj2L ) );
#! x_1,
#! x_2 
#! (over a graded ring)
poL := Pushout( morL, m2L );
#! <A projective graded left module of rank 2>
inj1L := InjectionOfCofactorOfPushout( [ morL, m2L ], 1 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( inj1L ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
inj2L := InjectionOfCofactorOfPushout( [ morL, m2L ], 2 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( inj2L ) );
#! x_1,x_2
#! (over a graded ring)
tensorProductL := TensorProductOnObjects( O1L, O2L );
#! <A projective graded left module of rank 2>
Display( tensorProductL );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
tensorProductMorphismL := TensorProductOnMorphisms( m2L, morL );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( tensorProductMorphismL );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2
#! (over a graded ring)
Display( DualOnObjects( TensorProductOnObjects( ObjectL, Object2L ) ) );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 16 and degrees: 
#! [ [ ( -2, 0 ), 5 ], [ ( -1, -1 ), 2 ], [ ( -2, 0 ), 6 ], [ ( -1, -1 ), 2 ], 
#! [ ( -2, 0 ), 1 ] ]
Display( DualOnMorphisms( m1L ) );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2
#! (over a graded ring)
Display( EvaluationForDualWithGivenTensorProduct( TensorProductOnObjects( 
         DualOnObjects( ObjectL ), ObjectL ), ObjectL, TensorUnit( categoryL ) ) );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1,
#! 0,
#! 0,
#! 1 
#! (over a graded ring)
Display( InternalHomOnObjects( ObjectL, ObjectL ) );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 4 and degrees: 
#! [ [ 0, 4 ] ]

#! @EndExample



########################################################################
#! @Section A few categorical constructions for projective right modules
########################################################################

#! @Example
ZeroObject( categoryR );
#! <A projective graded right module of rank 0>
O1R := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],2] ], S );
#! <A projective graded right module of rank 2>
Display( ZeroMorphism( ZeroObject( categoryR ), O1R ) );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! (an empty 2 x 0 matrix)
O2R := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[0,0],1] ], S );
#! <A projective graded right module of rank 1>
Display( IdentityMorphism( O2R ) );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1
#! (over a graded ring)
directSumR := DirectSum( [ O1R, O2R ] );
#! <A projective graded right module of rank 3>
Display( directSumR );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 3 and degrees:
#! [ [ ( 1, 0 ), 2 ], [ 0, 1 ] ]
i1R := InjectionOfCofactorOfDirectSum( [ O1R, O2R ], 1 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( i1R ) );
#! 1,0,
#! 0,1,
#! 0,0
#! (over a graded ring)
i2R := InjectionOfCofactorOfDirectSum( [ O1R, O2R ], 2 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ],[ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( i2R ) );
#! 0,
#! 0,
#! 1
#! (over a graded ring)
proj1R := ProjectionInFactorOfDirectSum( [ O1R, O2R ], 1 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( proj1R ) );
#! 1,0,0,
#! 0,1,0
#! (over a graded ring)
proj2R := ProjectionInFactorOfDirectSum( [ O1R, O2R ], 2 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( proj2R ) );
#! 0,0,1
#! (over a graded ring)
kR := KernelEmbedding( proj1R );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( kR ) );
#! 0,
#! 0,
#! 1
#! (over a graded ring)
ckR := CokernelProjection( kR );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( ckR ) );
#! 1,0,0,
#! 0,1,0
#! (over a graded ring)
IsMonomorphism( kR );
#! true
IsEpimorphism( kR );
#! false
IsMonomorphism( ckR );
#! false
IsEpimorphism( ckR );
#! true
m1R := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( O1R, 
      HomalgMatrix( [[ "x_1", "x_2" ]], S ), O2R );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
m2R := IdentityMorphism( O2R );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
liftR := Lift( m1R, m2R );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( liftR ) );
#! x_1,x_2
#! (over a graded ring)
O3R := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[-1,0],2] ], S );
#! <A projective graded right module of rank 2>
morR := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
       O2R, HomalgMatrix( [[ "x_1" ], [ "x_2" ]], S ), O3R );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
coliftR := Colift( m2R, morR );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( coliftR ) );
#! x_1,
#! x_2
#! (over a graded ring)
fpR := FiberProduct( [ m1R, m2R, IdentityMorphism( Range( m2R ) ) ] );
#! <A projective graded right module of rank 2>
fp_proj1R := ProjectionInFactorOfFiberProduct( [ m1R, m2R ], 1 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( fp_proj1R ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
fp_proj2R := ProjectionInFactorOfFiberProduct( [ m1R, m2R ], 2 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( fp_proj2R ) );
#! x_1, x_2
#! (over a graded ring)
poR := Pushout( morR, m2R );
#! <A projective graded right module of rank 2>
inj1R := InjectionOfCofactorOfPushout( [ morR, m2R ], 1 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( inj1R ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
inj2R := InjectionOfCofactorOfPushout( [ morR, m2R ], 2 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( inj2R ) );
#! x_1,
#! x_2
#! (over a graded ring)
tensorProductR := TensorProductOnObjects( O1R, O2R );
#! <A projective graded right module of rank 2>
Display( tensorProductR );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
tensorProductMorphismR := TensorProductOnMorphisms( m2R, morR );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( tensorProductMorphismR );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,
#! x_2
#! (over a graded ring)
Display( DualOnObjects( TensorProductOnObjects( ObjectR, Object2R ) ) );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 16 and degrees: 
#! [ [ ( -2, 0 ), 5 ], [ ( -1, -1 ), 2 ], [ ( -2, 0 ), 6 ], [ ( -1, -1 ), 2 ], 
#! [ ( -2, 0 ), 1 ] ]
Display( DualOnMorphisms( m1R ) );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! x_1,
#! x_2 
#! (over a graded ring)
Display( EvaluationForDualWithGivenTensorProduct( TensorProductOnObjects( 
         DualOnObjects( ObjectR ), ObjectR ), ObjectR, TensorUnit( categoryR ) ) );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1,0,0,1
#! (over a graded ring)
Display( InternalHomOnObjects( ObjectR, ObjectR ) );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 4 and degrees: 
#! [ [ 0, 4 ] ]

#! @EndExample




####################################################
#! @Section Cone and semigroup wrappers
####################################################

#! @Example
s := SemigroupGeneratorList( [[ 1,0 ], [ 1,1 ]] );
#! <A list of generators of a semigroup of Z^2>
IsConeSemigroup( s );
#! true
s2 := TurnIntoConeHPresentationList( s );
#! <A list of hyperplane constraints of a cone in Z^2>
Display( s2 );
#! A list of hyperplane constraints of a cone in Z^2 - h-constraints are as follows: 
#! [ [   1,  -1 ],
#!   [   0,   1 ] ]
t := ConeHPresentationList( [[ 1,0 ], [ 0,1 ]] );
#! <A list of hyperplane constraints of a cone in Z^2>

#! @EndExample




#########################################################
#! @Section Truncations of projective graded left modules
#########################################################

#! @Example
S;
#! Q[x_1,x_2,x_3,x_4]
#! (weights: [ ( 1, 0 ), ( 1, 0 ), ( 0, 1 ), ( 0, 1 ) ])
D := DegreeGroup( S );
#! <A free left module of rank 2 on free generators>
IsFree( D );
#! true
NewObjectL := CAPCategoryOfProjectiveGradedLeftModulesObject( 
              [ [[1,0],1], [[-1,-1],2] ], S );
#! <A projective graded left module of rank 3>
tL := TruncationOfProjectiveGradedModule( NewObjectL, 
      SemigroupGeneratorList( [[1,0],[0,1]] ) );
#! <A projective graded left module of rank 1>
Display( tL );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
tL2 := TruncationOfProjectiveGradedModule( NewObjectL, 
       SemigroupGeneratorList( [[ 1,0 ], [ 0,2 ]] ) );
#! <A projective graded left module of rank 1>
Display( tL2 );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
embL := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectL, 
        SemigroupGeneratorList( [[1,0],[0,1]] ) );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embL ) );
#! 1, 0, 0
#! (over a graded ring)
embL2 := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectL, 
        SemigroupGeneratorList( [[1,0],[0,2]] ) );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embL2 ) );
#! 1, 0, 0
#! (over a graded ring)
embL3 := EmbeddingOfTruncationOfProjectiveGradedModuleWithGivenTruncationObject(
         NewObjectL, tL );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embL3 ) );
#! 1, 0, 0
#! (over a graded ring)
projL := ProjectionOntoTruncationOfProjectiveGradedModule( NewObjectL, 
         SemigroupGeneratorList( [[ 1,0 ], [ 0,1 ]] ) );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projL ) );
#! 1,
#! 0,
#! 0
#! (over a graded ring)
projL2 := ProjectionOntoTruncationOfProjectiveGradedModule( NewObjectL, 
         SemigroupGeneratorList( [[ 1,0 ], [ 0,2 ]] ) );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projL2 ) );
#! 1,
#! 0,
#! 0 
#! (over a graded ring)
projL3 := ProjectionOntoTruncationOfProjectiveGradedModuleWithGivenTruncationObject( 
          NewObjectL, tL ); 
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projL3 ) );
#! 1,
#! 0,
#! 0 
#! (over a graded ring)
truncatorL := TruncationFunctorForProjectiveGradedLeftModules(
                        S, SemigroupGeneratorList( [[ 1,0 ], [ 0,2 ]] ) );
#! Truncation functor for CAP category of projective graded 
#! left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the semigroup generated by [ [ 1, 0 ], [ 0, 2 ] ]
truncatorL2 := TruncationFunctorForProjectiveGradedLeftModules(
                        S, SemigroupGeneratorList( [[ 1,0 ], [ 0,1 ]] ) );
#! Truncation functor for CAP category of projective graded 
#! left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone given by the h-constraints [ [ 1, 0 ], [ 0, 1 ] ]
tL2 := ApplyFunctor( truncatorL, NewObjectL );
#! <A projective graded left module of rank 1>
Display( tL2 );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
sourceL := CAPCategoryOfProjectiveGradedLeftModulesObject( 
           [ [[1,0],1], [[0,1],1] ], S );
#! <A projective graded left module of rank 2>
rangeL := CAPCategoryOfProjectiveGradedLeftModulesObject( 
           [ [[1,0],1] ], S );
#! <A projective graded left module of rank 1>
test_morphismL := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      sourceL, HomalgMatrix( [ [ 1 ],[ 0 ] ], S ) ,rangeL );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
tr_test_morphismL := ApplyFunctor( truncatorL, test_morphismL );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( tr_test_morphismL ) );
#! 1
#! (over a graded ring)
tr2_test_morphismL := ApplyFunctor( truncatorL2, test_morphismL );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( tr2_test_morphismL ) );
#! 1,
#! 0
#! (over a graded ring)
NaturalTransformationFromTruncationToIdentityForProjectiveGradedLeftModules( 
                        S, SemigroupGeneratorList( [[ 1,0 ], [ 0,1 ]] ) );
#! Natural transformation from Truncation functor for CAP category 
#! of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone given by the h-constraints [ [ 1, 0 ], [ 0, 1 ] ] to id

#! @EndExample


#########################################################
#! @Section Truncations of projective graded right modules
#########################################################

#! @Example
NewObjectR := CAPCategoryOfProjectiveGradedRightModulesObject( 
              [ [[1,0],1], [[-1,-1],2] ], S );
#! <A projective graded right module of rank 3>
tR := TruncationOfProjectiveGradedModule( NewObjectR, 
      SemigroupGeneratorList( [[1,0],[0,1]] ) );
#! <A projective graded right module of rank 1>
Display( tR );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
tR2 := TruncationOfProjectiveGradedModule( NewObjectR, 
       SemigroupGeneratorList( [[ 1,0 ], [ 0,2 ]] ) );
#! <A projective graded right module of rank 1>
Display( tR2 );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
embR := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectR, 
        SemigroupGeneratorList( [[1,0],[0,1]] ) );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embR ) );
#! 1,
#! 0,
#! 0
#! (over a graded ring)
embR2 := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectL, 
        SemigroupGeneratorList( [[1,0],[0,2]] ) );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embR2 ) );
#! 1,
#! 0,
#! 0
#! (over a graded ring)
embR3 := EmbeddingOfTruncationOfProjectiveGradedModuleWithGivenTruncationObject(
         NewObjectR, tR );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embR3 ) );
#! 1,
#! 0,
#! 0
#! (over a graded ring)
projR := ProjectionOntoTruncationOfProjectiveGradedModule( NewObjectR,
         SemigroupGeneratorList( [[ 1,0 ], [ 0,1 ]] ) );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projR ) );
#! 1, 0, 0
#! (over a graded ring)
projR2 := ProjectionOntoTruncationOfProjectiveGradedModule( NewObjectR, 
         SemigroupGeneratorList( [[ 1,0 ], [ 0,2 ]] ) );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projR2 ) );
#! 1, 0, 0
#! (over a graded ring)
projR3 := ProjectionOntoTruncationOfProjectiveGradedModuleWithGivenTruncationObject( 
          NewObjectR, tR ); 
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projR3 ) );
#! 1, 0, 0
#! (over a graded ring)
truncatorR := TruncationFunctorForProjectiveGradedRightModules( S, 
                             SemigroupGeneratorList( [[ 1,0 ], [ 0,2 ]] ) );
#! Truncation functor for CAP category of projective graded 
#! right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the semigroup generated by [ [ 1, 0 ], [ 0, 2 ] ]
truncatorR2 := TruncationFunctorForProjectiveGradedRightModules(
                        S, SemigroupGeneratorList( [[ 1,0 ], [ 0,1 ]] ) );
#! Truncation functor for CAP category of projective graded 
#! right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone given by the h-constraints [ [ 1, 0 ], [ 0, 1 ] ]
tR2 := ApplyFunctor( truncatorR, NewObjectR );
#! <A projective graded right module of rank 1>
Display( tR2 );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
sourceR := CAPCategoryOfProjectiveGradedRightModulesObject( 
           [ [[1,0],1], [[0,1],1] ], S );
#! <A projective graded right module of rank 2>
rangeR := CAPCategoryOfProjectiveGradedRightModulesObject( 
           [ [[1,0],1] ], S );
#! <A projective graded right module of rank 1>
test_morphismR := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      sourceR, HomalgMatrix( [ [ 1, 0 ] ], S ) ,rangeR );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
tr_test_morphismR := ApplyFunctor( truncatorR, test_morphismR );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( tr_test_morphismR ) );
#! 1
#! (over a graded ring)
tr2_test_morphismR := ApplyFunctor( truncatorR2, test_morphismR );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( tr2_test_morphismR ) );
#! 1, 0
#! (over a graded ring)
NaturalTransformationFromTruncationToIdentityForProjectiveGradedRightModules
                               ( S, SemigroupGeneratorList( [[1,0],[0,1]] ) );
#! Natural transformation from Truncation functor for CAP category 
#! of projective graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone given by the h-constraints [ [ 1, 0 ], [ 0, 1 ] ] to id

#! @EndExample