#################################################################
#################################################################
#! @Chapter Examples on graded rows and columns
#################################################################
#################################################################

LoadPackage( "FreydCategoriesForCAP" );;



#################################################################
#! @Section Freyd category of graded rows
#################################################################

#! @Example
Q := HomalgFieldOfRationalsInSingular();
#! Q
S := GradedRing( Q * "x_1, x_2, x_3, x_4" );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: yet unset)
SetWeightsOfIndeterminates( S, [[1,0],[1,0],[0,1],[0,1]] );
#!
cat := CAPCategoryOfGradedRows( S );
#! CAP category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
obj1 := GradedRow( [ [[1,1],1] ], S );
#! <A graded row of rank 1>
obj2 := GradedRow( [ [[1,1],2] ], S );
#! <A graded row of rank 2>
gamma := GradedRowOrColumnMorphism( obj2, 
                       HomalgMatrix( [ [ 1, 1 ], [ 1, 1 ] ], 2, 2, S ), obj2 );
#! <A morphism in the category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
freyd := FreydCategory( cat );
#! Freyd( CAP category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
IsAbelianCategory( freyd );
#! true
obj_gamma := FreydCategoryObject( gamma );
#! <An object in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
f := FreydCategoryMorphism( obj_gamma, gamma, obj_gamma );
#! <A morphism in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
witness := MorphismWitness( f );
#! <A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( witness );
#! A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 2,0,
#! 2,0 
#! (over a graded ring)
g := FreydCategoryMorphism( obj_gamma, 
                                   ZeroMorphism( obj2, obj2 ), obj_gamma );
#! <A morphism in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
IsCongruentForMorphisms( f, g );
#! true
c := PreCompose( f, f );
#! <A morphism in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( c );
#! Morphism datum:
#! A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 2,2,
#! 2,2 
#! (over a graded ring)
s := g + g;
#! <A morphism in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( s );
#! Morphism datum:
#! A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 0,0,
#! 0,0 
#! (over a graded ring)
a := GradedRowOrColumnMorphism( obj1, 
                                 HomalgMatrix( [ [ 2 ] ], 1, 1, S ), obj1 );
#! <A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( a );
#! A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 2
#! (over a graded ring)
Z2 := FreydCategoryObject( a );
#! <An object in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( Z2 );
#! Relation morphism:
#! A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 2
#! (over a graded ring)
id := IdentityMorphism( Z2 );
#! <An identity morphism in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
z := id + id + id;
#! <A morphism in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( z );
#! Morphism datum:
#! A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 3
#! (over a graded ring)
d := DirectSumFunctorial( [ z, z, z ] );
#! <A morphism in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( d );
#! Morphism datum:
#! A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 3,0,0,
#! 0,3,0,
#! 0,0,3 
#! (over a graded ring)
pr2 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );
#! <A morphism in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
pr3 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 3 );
#! <A morphism in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( UniversalMorphismIntoDirectSum( [ pr3, pr2 ] ) );
#! Morphism datum:
#! A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 0,0,
#! 0,1,
#! 1,0 
#! (over a graded ring)
inj1 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 1 );
#! <A morphism in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
inj2 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );
#! <A morphism in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( UniversalMorphismFromDirectSum( [ inj2, inj1 ] ) );
#! Morphism datum:
#! A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 0,1,0,
#! 1,0,0 
#! (over a graded ring)
ZFree := AsFreydCategoryObject( obj1 );
#! <A projective object in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( ZFree );
#! Relation morphism:
#! A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! (an empty 0 x 1 matrix)
id := IdentityMorphism( ZFree );
#! <An identity morphism in Freyd( CAP category of graded rows over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
z := id + id;
#! <A morphism in Freyd( CAP category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( z );
#! Morphism datum:
#! A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 2
#! (over a graded ring)
Display( CokernelProjection( z ) );
#! Morphism datum:
#! A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 1
#! (over a graded ring)
Display( CokernelColift( z, CokernelProjection( z ) ) );
#! Morphism datum:
#! A morphism in the category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 1
#! (over a graded ring)
#! @EndExample



#################################################################
#! @Section Freyd category of graded columns
#################################################################

#! @Example
Q := HomalgFieldOfRationalsInSingular();
#! Q
S := GradedRing( Q * "x_1, x_2, x_3, x_4" );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: yet unset)
SetWeightsOfIndeterminates( S, [[1,0],[1,0],[0,1],[0,1]] );
#!
cat := CAPCategoryOfGradedColumns( S );
#! CAP category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
obj1 := GradedColumn( [ [[1,1],1] ], S );
#! <A graded column of rank 1>
obj2 := GradedColumn( [ [[1,1],2] ], S );
#! <A graded column of rank 2>
gamma := GradedRowOrColumnMorphism( obj2, 
                       HomalgMatrix( [ [ 1, 1 ], [ 1, 1 ] ], 2, 2, S ), obj2 );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
freyd := FreydCategory( cat );
#! Freyd( CAP category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
IsAbelianCategory( freyd );
#! true
obj_gamma := FreydCategoryObject( gamma );
#! <An object in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
f := FreydCategoryMorphism( obj_gamma, gamma, obj_gamma );
#! <A morphism in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
witness := MorphismWitness( f );
#! <A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( witness );
#! A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 2,2,
#! 0,0 
#! (over a graded ring)
g := FreydCategoryMorphism( obj_gamma, 
                                   ZeroMorphism( obj2, obj2 ), obj_gamma );
#! <A morphism in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
IsCongruentForMorphisms( f, g );
#! true
c := PreCompose( f, f );
#! <A morphism in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( c );
#! Morphism datum:
#! A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 2,2,
#! 2,2 
#! (over a graded ring)
s := g + g;
#! <A morphism in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( s );
#! Morphism datum:
#! A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 0,0,
#! 0,0 
#! (over a graded ring)
a := GradedRowOrColumnMorphism( obj1, 
                                 HomalgMatrix( [ [ 2 ] ], 1, 1, S ), obj1 );
#! <A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( a );
#! A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 2
#! (over a graded ring)
Z2 := FreydCategoryObject( a );
#! <An object in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( Z2 );
#! Relation morphism:
#! A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 2
#! (over a graded ring)
id := IdentityMorphism( Z2 );
#! <An identity morphism in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
z := id + id + id;
#! <A morphism in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( z );
#! Morphism datum:
#! A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 3
#! (over a graded ring)
d := DirectSumFunctorial( [ z, z, z ] );
#! <A morphism in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( d );
#! Morphism datum:
#! A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 3,0,0,
#! 0,3,0,
#! 0,0,3 
#! (over a graded ring)
pr2 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );
#! <A morphism in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
pr3 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 3 );
#! <A morphism in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( UniversalMorphismIntoDirectSum( [ pr3, pr2 ] ) );
#! Morphism datum:
#! A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 0,0,1,
#! 0,1,0
#! (over a graded ring)
inj1 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 1 );
#! <A morphism in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
inj2 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );
#! <A morphism in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( UniversalMorphismFromDirectSum( [ inj2, inj1 ] ) );
#! Morphism datum:
#! A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 0,1,
#! 1,0,
#! 0,0
#! (over a graded ring)
ZFree := AsFreydCategoryObject( obj1 );
#! <A projective object in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( ZFree );
#! Relation morphism:
#! A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! (an empty 1 x 0 matrix)
id := IdentityMorphism( ZFree );
#! <An identity morphism in Freyd( CAP category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
z := id + id;
#! <A morphism in Freyd( CAP category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )>
Display( z );
#! Morphism datum:
#! A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 2
#! (over a graded ring)
Display( CokernelProjection( z ) );
#! Morphism datum:
#! A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 1
#! (over a graded ring)
Display( CokernelColift( z, CokernelProjection( z ) ) );
#! Morphism datum:
#! A morphism in the category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 1
#! (over a graded ring)
#! @EndExample
