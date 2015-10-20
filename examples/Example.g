#! @Chapter Examples and Tests

#! @Section Constructors of objects and reduction of degree lists

LoadPackage( "ToricVarieties" );;
LoadPackage( "CAPCategoryOfProjectiveGradedModules" );;

#! @Example

P1 := ProjectiveSpace( 1 );
#! <A projective toric variety of dimension 1>
P1xP1 := P1*P1;
#! <A projective toric variety of dimension 2 which is a product of 2 toric varieties>
ByASmallerPresentation( ClassGroup( P1xP1 ) );
#! <A free left module of rank 2 on free generators>
S := CoxRing( P1xP1 );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: [ ( 1, 0 ), ( 1, 0 ), ( 0, 1 ), ( 0, 1 ) ])
Object := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],2] ], S );
#! <A projective graded left module of rank 2>
DegreeList( Object );
#! [ [ ( 1, 0 ), 2 ] ]
Object2 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],2], 
           [[1,0],3],[[0,1],2],[[1,0],1] ], S );
#! <A projective graded left module of rank 8>
DegreeList( Object2 );
#! [ [ ( 1, 0 ), 5 ], [ ( 0, 1 ), 2 ], [ ( 1, 0 ), 1 ] ]
#! @EndExample

#! @Section Constructors of morphisms

#! @Example
Q1 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],1] ], S );
#! <A projective graded left module of rank 1>
Q2 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[0,0],2] ], S );
#! <A projective graded left module of rank 2>
m1 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q1, HomalgMatrix( [["x_1","x_2"]], S ) ,Q2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( Source( m1 ) );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
Display( Range( m1 ) );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
Display( UnderlyingHomalgMatrix( m1 ) );
#! x_1,x_2
#! (over a graded ring)

#! @EndExample


#! @Section A few categorical constructions for left modules

#! @Example
O1 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],2] ], S );
#! <A projective graded left module of rank 2>
O2 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[0,0],1] ], S );
#! <A projective graded left module of rank 1>
directSum := DirectSum( [ O1, O2 ] );
#! <A projective graded left module of rank 3>
Display( directSum );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 3 and degrees:
#! [ [ ( 1, 0 ), 2 ], [ 0, 1 ] ]
i1 := InjectionOfCofactorOfDirectSum( [ O1, O2 ], 1 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( i1 ) );
#! 1,0,0,
#! 0,1,0 
#! (over a graded ring)
i2 := InjectionOfCofactorOfDirectSum( [ O1, O2 ], 2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ],[ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( i2 ) );
#! 0,0,1
#! (over a graded ring)
proj1 := ProjectionInFactorOfDirectSum( [ O1, O2 ], 1 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( proj1 ) );
#! 1,0,
#! 0,1,
#! 0,0 
#! (over a graded ring)
proj2 := ProjectionInFactorOfDirectSum( [ O1, O2 ], 2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( proj2 ) );
#! 0,
#! 0,
#! 1 
#! (over a graded ring)
k := KernelEmbedding( proj1 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( k ) );
#! 0,0,1
#! (over a graded ring)
ck := CokernelProjection( k );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( ck ) );
#! 1,0,
#! 0,1,
#! 0,0 
#! (over a graded ring)
IsMonomorphism( k );
#! true
IsEpimorphism( k );
#! false
IsMonomorphism( ck );
#! false
IsEpimorphism( ck );
#! true
m1 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( O1, 
      HomalgMatrix( [[ "x_1" ], [ "x_2" ]], S ), O2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
m2 := IdentityMorphism( O2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Lift( m1, m2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( Lift( m1, m2 ) ) );
#! x_1,
#! x_2 
#! (over a graded ring)
O3 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[-1,0],2] ], S );
#! <A projective graded left module of rank 2>
mor := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
       O2, HomalgMatrix( [[ "x_1, x_2" ]], S ), O3 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Colift( m2, mor );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( Colift( m2, mor ) ) );
#! x_1,x_2
#! (over a graded ring)
fp := FiberProduct( [ m1, m2 ] );
#! <A projective graded left module of rank 2>
fp_proj1 := ProjectionInFactorOfFiberProduct( [ m1, m2 ], 1 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( fp_proj1 ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
fp_proj2 := ProjectionInFactorOfFiberProduct( [ m1, m2 ], 2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( fp_proj2 ) );
#! x_1,
#! x_2 
#! (over a graded ring)
po := Pushout( mor, m2 );
#! <A projective graded left module of rank 2>
inj1 := InjectionOfCofactorOfPushout( [ mor, m2 ], 1 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( inj1 ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
inj2 := InjectionOfCofactorOfPushout( [ mor, m2 ], 2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( inj2 ) );
#! x_1,x_2
#! (over a graded ring)

#! @EndExample


#! @Section A few categorical constructions for right modules

#! @Example
P1 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],2] ], S );
#! <A projective graded right module of rank 2>
P2 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[0,0],1] ], S );
#! <A projective graded right module of rank 1>
directSum := DirectSum( [ P1, P2 ] );
#! <A projective graded right module of rank 3>
Display( directSum );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 3 and degrees:
#! [ [ ( 1, 0 ), 2 ], [ 0, 1 ] ]
i1 := InjectionOfCofactorOfDirectSum( [ P1, P2 ], 1 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( i1 ) );
#! 1,0,
#! 0,1,
#! 0,0
#! (over a graded ring)
i2 := InjectionOfCofactorOfDirectSum( [ P1, P2 ], 2 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ],[ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( i2 ) );
#! 0,
#! 0,
#! 1
#! (over a graded ring)
proj1 := ProjectionInFactorOfDirectSum( [ P1, P2 ], 1 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( proj1 ) );
#! 1,0,0,
#! 0,1,0
#! (over a graded ring)
proj2 := ProjectionInFactorOfDirectSum( [ P1, P2 ], 2 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( proj2 ) );
#! 0,0,1
#! (over a graded ring)
k := KernelEmbedding( proj1 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( k ) );
#! 0,
#! 0,
#! 1
#! (over a graded ring)
ck := CokernelProjection( k );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( ck ) );
#! 1,0,0,
#! 0,1,0
#! (over a graded ring)
IsMonomorphism( k );
#! true
IsEpimorphism( k );
#! false
IsMonomorphism( ck );
#! false
IsEpimorphism( ck );
#! true
m1 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( P1, 
      HomalgMatrix( [[ "x_1", "x_2" ]], S ), P2 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
m2 := IdentityMorphism( P2 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Lift( m1, m2 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( Lift( m1, m2 ) ) );
#! x_1,x_2
#! (over a graded ring)
P3 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[-1,0],2] ], S );
#! <A projective graded right module of rank 2>
mor := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
       P2, HomalgMatrix( [[ "x_1" ], [ "x_2" ]], S ), P3 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Colift( m2, mor );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( Colift( m2, mor ) ) );
#! x_1,
#! x_2
#! (over a graded ring)
fp := FiberProduct( [ m1, m2 ] );
#! <A projective graded right module of rank 2>
fp_proj1 := ProjectionInFactorOfFiberProduct( [ m1, m2 ], 1 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( fp_proj1 ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
fp_proj2 := ProjectionInFactorOfFiberProduct( [ m1, m2 ], 2 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( fp_proj2 ) );
#! x_1, x_2
#! (over a graded ring)
po := Pushout( mor, m2 );
#! <A projective graded right module of rank 2>
inj1 := InjectionOfCofactorOfPushout( [ mor, m2 ], 1 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( inj1 ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
inj2 := InjectionOfCofactorOfPushout( [ mor, m2 ], 2 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( inj2 ) );
#! x_1,
#! x_2
#! (over a graded ring)

#! @EndExample

