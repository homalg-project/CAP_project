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
S := HomalgRingOfIntegers();
#! Z
cols := CategoryOfColumns( S );
#! Columns( Z )
obj1 := CategoryOfColumnsObject( 2, cols );
#! <A column module over Z of rank 2>
obj2 := CategoryOfColumnsObject( 8, cols );
#! <A column module over Z of rank 8>
#! @EndExample


#####################################
#! @Section Constructors of morphisms
#####################################

#! @Example
obj3 := CategoryOfColumnsObject( 1, cols );
#! <A column module over Z of rank 1>
IsWellDefined( obj1 );
#! true
obj4 := CategoryOfColumnsObject( 2, cols );
#! <A column module over Z of rank 2>
mor := CategoryOfColumnsMorphism( obj3, HomalgMatrix( [[1],[2]], S ), obj4 );
#! <A morphism in Columns( Z )>
IsWellDefined( mor );
#! true
Display( Source( mor ) );
#! A column module over Z of rank 1
Display( Range( mor ) );
#! A column module over Z of rank 2
Display( UnderlyingMatrix( mor ) );
#! [ [  1 ],
#!   [  2 ] ]
#! @EndExample





########################################################################
#! @Section A few categorical constructions for projective right modules
########################################################################

#! @Example
ZeroObject( cols );
#! A column module over Z of rank 0

Error( "Test" );

O1R := GradedColumn( [ [[1,0],2] ], S );
#! <A graded column of rank 2>
Display( ZeroMorphism( ZeroObject( categoryR ), O1R ) );
#! A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! (an empty 2 x 0 matrix)
O2R := GradedColumn( [ [[0,0],1] ], S );
#! <A graded column of rank 1>
Display( IdentityMorphism( O2R ) );
#! A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1
#! (over a graded ring)
directSumR := DirectSum( [ O1R, O2R ] );
#! <A graded column of rank 3>
Display( directSumR );
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 3 and degrees:
#! [ [ ( 1, 0 ), 2 ], [ 0, 1 ] ]
i1R := InjectionOfCofactorOfDirectSum( [ O1R, O2R ], 1 );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( i1R ) );
#! 1,0,
#! 0,1,
#! 0,0
#! (over a graded ring)
i2R := InjectionOfCofactorOfDirectSum( [ O1R, O2R ], 2 );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ],[ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( i2R ) );
#! 0,
#! 0,
#! 1
#! (over a graded ring)
proj1R := ProjectionInFactorOfDirectSum( [ O1R, O2R ], 1 );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( proj1R ) );
#! 1,0,0,
#! 0,1,0
#! (over a graded ring)
proj2R := ProjectionInFactorOfDirectSum( [ O1R, O2R ], 2 );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( proj2R ) );
#! 0,0,1
#! (over a graded ring)
kR := WeakKernelEmbedding( proj1R );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( kR ) );
#! 0,
#! 0,
#! 1
#! (over a graded ring)
ckR := WeakCokernelProjection( kR );
#! <A morphism in the category of graded columns over 
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
m1R := GradedRowOrColumnMorphism( O1R, 
      HomalgMatrix( [[ "x_1", "x_2" ]], S ), O2R );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
m2R := IdentityMorphism( O2R );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
liftR := Lift( m1R, m2R );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( liftR ) );
#! x_1,x_2
#! (over a graded ring)
O3R := GradedColumn( [ [[-1,0],2] ], S );
#! <A graded column of rank 2>
morR := GradedRowOrColumnMorphism( 
       O2R, HomalgMatrix( [[ "x_1" ], [ "x_2" ]], S ), O3R );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
coliftR := Colift( m2R, morR );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( coliftR ) );
#! x_1,
#! x_2
#! (over a graded ring)
fpR := FiberProduct( [ m1R, m2R, IdentityMorphism( Range( m2R ) ) ] );
#! <A graded column of rank 2>
fp_proj1R := ProjectionInFactorOfFiberProduct( [ m1R, m2R ], 1 );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( fp_proj1R ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
fp_proj2R := ProjectionInFactorOfFiberProduct( [ m1R, m2R ], 2 );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( fp_proj2R ) );
#! x_1, x_2
#! (over a graded ring)
poR := Pushout( morR, m2R );
#! <A graded column of rank 2>
inj1R := InjectionOfCofactorOfPushout( [ morR, m2R ], 1 );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( inj1R ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
inj2R := InjectionOfCofactorOfPushout( [ morR, m2R ], 2 );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( inj2R ) );
#! x_1,
#! x_2
#! (over a graded ring)
tensorProductR := TensorProductOnObjects( O1R, O2R );
#! <A graded column of rank 2>
Display( tensorProductR );
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
tensorProductMorphismR := TensorProductOnMorphisms( m2R, morR );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( tensorProductMorphismR );
#! A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,
#! x_2
#! (over a graded ring)
Display( DualOnObjects( TensorProductOnObjects( ObjectR, Object2R ) ) );
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 16 and degrees: 
#! [ [ ( -2, 0 ), 5 ], [ ( -1, -1 ), 2 ], [ ( -2, 0 ), 6 ], [ ( -1, -1 ), 2 ], 
#! [ ( -2, 0 ), 1 ] ]
Display( DualOnMorphisms( m1R ) );
#! A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! x_1,
#! x_2 
#! (over a graded ring)
Display( EvaluationForDualWithGivenTensorProduct( TensorProductOnObjects( 
         DualOnObjects( ObjectR ), ObjectR ), ObjectR, TensorUnit( categoryR ) ) );
#! A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1,0,0,1
#! (over a graded ring)
Display( InternalHomOnObjects( ObjectR, ObjectR ) );
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 4 and degrees: 
#! [ [ 0, 4 ] ]

#! @EndExample
