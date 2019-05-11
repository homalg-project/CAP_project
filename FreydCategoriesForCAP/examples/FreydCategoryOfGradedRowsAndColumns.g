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
#! <A morphism in CAP category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
freyd := FreydCategory( cat );
#! Category of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
IsAbelianCategory( freyd );
#! true
obj_gamma := FreydCategoryObject( gamma );
#! <An object in Category of graded left module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
f := FreydCategoryMorphism( obj_gamma, gamma, obj_gamma );
#! <A morphism in Category of graded left module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
witness := MorphismWitness( f );
#! <A morphism in CAP category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( witness );
#! A morphism in CAP category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! Matrix:
#! 2,0,
#! 2,0
#! (over a graded ring)
#!
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#! @EndLog

#! @Example
g := FreydCategoryMorphism( obj_gamma, 
                                   ZeroMorphism( obj2, obj2 ), obj_gamma );
#! <A morphism in Category of graded left module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsCongruentForMorphisms( f, g );
#! true
c := PreCompose( f, f );
#! <A morphism in Category of graded left module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( c );
#! A morphism in Category of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
#!
#! --------------------------------
#!
#! Source:
#! A morphism in CAP category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! Matrix:
#! 1,1,
#! 1,1
#! (over a graded ring)
#!
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! --------------------------------
#!
#! Morphism datum:
#! A morphism in CAP category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! Matrix:
#! 2,2,
#! 2,2 
#! (over a graded ring)
#!
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! --------------------------------
#!
#! Range:
#! A morphism in CAP category of graded row over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! Matrix:
#! 1,1,
#! 1,1
#! (over a graded ring)
#!
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! --------------------------------
#! @EndLog

#! @Example
s := g + g;
#! <A morphism in Category of graded left module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
a := GradedRowOrColumnMorphism( obj1, 
                                 HomalgMatrix( [ [ 2 ] ], 1, 1, S ), obj1 );
#! <A morphism in CAP category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( a );
#! A morphism in CAP category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 1, 1 ), 1 ] ]
#!
#! Matrix:
#! 2
#! (over a graded ring)
#!
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 1, 1 ), 1 ] ]
#! @EndLog

#! @Example
Z2 := FreydCategoryObject( a );
#! <An object in Category of graded left module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( Z2 );
#! An object in Freyd( CAP category of graded rows over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
#!
#! Relation morphism:
#! A morphism in CAP category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 1, 1 ), 1 ] ]
#!
#! Matrix:
#! 2
#! (over a graded ring)
#!
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 1, 1 ), 1 ] ]
#! @EndLog

#! @Example
id := IdentityMorphism( Z2 );
#! <An identity morphism in Category of graded left module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
z := id + id + id;
#! <A morphism in Category of graded left module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
d := DirectSumFunctorial( [ z, z, z ] );
#! <A morphism in Category of graded left module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
pr2 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );
#! <A morphism in Category of graded left module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
pr3 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 3 );
#! <A morphism in Category of graded left module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
uni := UniversalMorphismIntoDirectSum( [ pr3, pr2 ] );
#! <A morphism in Category of graded left module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
inj1 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 1 );
#! <A morphism in Category of graded left module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
inj2 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );
#! <A morphism in Category of graded left module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
uni2 := UniversalMorphismFromDirectSum( [ inj2, inj1 ] );
#! <A morphism in Category of graded left module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
ZFree := AsFreydCategoryObject( obj1 );
#! <A projective object in Category of graded left module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( ZFree );
#! A projective object in Freyd( CAP category of graded rows over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
#!
#! Relation morphism:
#! A morphism in CAP category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees:
#! [  ]
#!
#! Matrix:
#! (an empty 0 x 1 matrix)
#!
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 1, 1 ), 1 ] ]
#! @EndLog

#! @Example
id := IdentityMorphism( ZFree );
#! <An identity morphism in Category of graded left module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
z := id + id;
#! <A morphism in Category of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
coker_proj := CokernelProjection( z );
#! <An epimorphism in Category of graded left module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
cokernel_colift := CokernelColift( z, CokernelProjection( z ) );
#! <A morphism in Category of graded left module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
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
#! <A morphism in CAP category of graded columns over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
freyd := FreydCategory( cat );
#! Category of graded right module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
IsAbelianCategory( freyd );
#! true
obj_gamma := FreydCategoryObject( gamma );
#! <An object in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
f := FreydCategoryMorphism( obj_gamma, gamma, obj_gamma );
#! <A morphism in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
witness := MorphismWitness( f );
#! <A morphism in CAP category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( witness );
#! A morphism in CAP category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! Matrix:
#! 2,2,
#! 0,0 
#! (over a graded ring)
#!
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#! @EndLog

#! @Example
g := FreydCategoryMorphism( obj_gamma, 
                                   ZeroMorphism( obj2, obj2 ), obj_gamma );
#! <A morphism in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsCongruentForMorphisms( f, g );
#! true
c := PreCompose( f, f );
#! <A morphism in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( c );
#! A morphism in Category of graded right module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
#!
#! --------------------------------
#!
#! Source:
#! A morphism in CAP category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! Matrix:
#! 1,1,
#! 1,1
#! (over a graded ring)
#!
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! --------------------------------
#!
#! Morphism datum:
#! A morphism in CAP category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! Matrix:
#! 2,2,
#! 2,2
#! (over a graded ring)
#!
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! --------------------------------
#!
#! Range:
#! A morphism in CAP category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! Matrix:
#! 1,1,
#! 1,1
#! (over a graded ring)
#!
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 2 and degrees:
#! [ [ ( 1, 1 ), 2 ] ]
#!
#! --------------------------------
#! @EndLog

#! @Example
s := g + g;
#! <A morphism in Category of graded right module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
a := GradedRowOrColumnMorphism( obj1, 
                                 HomalgMatrix( [ [ 2 ] ], 1, 1, S ), obj1 );
#! <A morphism in CAP category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( a );
#! A morphism in CAP category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 1, 1 ), 1 ] ]
#!
#! Matrix:
#! 2
#! (over a graded ring)
#!
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 1, 1 ), 1 ] ]
#! @EndLog

#! @Example
Z2 := FreydCategoryObject( a );
#! <An object in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( Z2 );
#! An object in Freyd( CAP category of graded columns over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
#!
#! Relation morphism:
#! A morphism in CAP category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 1, 1 ), 1 ] ]
#!
#! Matrix:
#! 2
#! (over a graded ring)
#!
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 1, 1 ), 1 ] ]
#! @EndLog

#! @Example
id := IdentityMorphism( Z2 );
#! <An identity morphism in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
z := id + id + id;
#! <A morphism in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
d := DirectSumFunctorial( [ z, z, z ] );
#! <A morphism in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
pr2 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );
#! <A morphism in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
pr3 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 3 );
#! <A morphism in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
uni := UniversalMorphismIntoDirectSum( [ pr3, pr2 ] );
#! <A morphism in Category of graded right module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
inj1 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 1 );
#! <A morphism in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
inj2 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );
#! <A morphism in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
uni2 := UniversalMorphismFromDirectSum( [ inj2, inj1 ] );
#! <A morphism in Category of graded right module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
ZFree := AsFreydCategoryObject( obj1 );
#! <A projective object in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( ZFree );
#! A projective object in Category of graded right module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
#!
#! Relation morphism:
#! A morphism in CAP category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees:
#! [  ]
#!
#! Matrix:
#! (an empty 1 x 0 matrix)
#!
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 1, 1 ), 1 ] ]
#! @EndLog

#! @Example
id := IdentityMorphism( ZFree );
#! <An identity morphism in Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
z := id + id;
#! <A morphism in Category of graded right module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
coker_proj := CokernelProjection( z );
#! <An epimorphism in Category of graded right module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
cokernel_colift := CokernelColift( z, CokernelProjection( z ) );
#! <A morphism in Category of graded right module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample
