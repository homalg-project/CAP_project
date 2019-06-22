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
cat := CategoryOfGradedRows( S );
#! Category of graded rows over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
obj1 := GradedRow( [ [[1,1],1] ], S );
#! <A graded row of rank 1>
obj2 := GradedRow( [ [[1,1],2] ], S );
#! <A graded row of rank 2>
gamma := GradedRowOrColumnMorphism( obj2, 
                       HomalgMatrix( [ [ 1, 1 ], [ 1, 1 ] ], 2, 2, S ), obj2 );
#! <A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
freyd := FreydCategory( cat );
#! Category of f.p. graded left modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
IsAbelianCategory( freyd );
#! true
obj_gamma := FreydCategoryObject( gamma );
#! <An object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
f := FreydCategoryMorphism( obj_gamma, gamma, obj_gamma );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
witness := MorphismWitness( f );
#! <A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( witness );
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
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
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsCongruentForMorphisms( f, g );
#! true
c := PreCompose( f, f );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( c );
#! A morphism in Category of f.p. graded left modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
#!
#! --------------------------------
#!
#! Source:
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
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
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
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
#! A morphism in Category of graded row over Q[x_1,x_2,x_3,x_4]
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
#! <A morphism in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
a := GradedRowOrColumnMorphism( obj1, 
                                 HomalgMatrix( [ [ 2 ] ], 1, 1, S ), obj1 );
#! <A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( a );
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
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
#! <An object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( Z2 );
#! An object in Freyd( Category of graded rows over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
#!
#! Relation morphism:
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
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
#! <An identity morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
z := id + id + id;
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
d := DirectSumFunctorial( [ z, z, z ] );
#! <A morphism in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
pr2 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
pr3 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 3 );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
uni := UniversalMorphismIntoDirectSum( [ pr3, pr2 ] );
#! <A morphism in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
inj1 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 1 );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
inj2 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
uni2 := UniversalMorphismFromDirectSum( [ inj2, inj1 ] );
#! <A morphism in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
ZFree := AsFreydCategoryObject( obj1 );
#! <A projective object in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( ZFree );
#! A projective object in Freyd( Category of graded rows over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
#!
#! Relation morphism:
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
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
#! <An identity morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
z := id + id;
#! <A morphism in Category of f.p. graded left modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
coker_proj := CokernelProjection( z );
#! <An epimorphism in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
cokernel_colift := CokernelColift( z, CokernelProjection( z ) );
#! <A morphism in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
a := ZFree;
#! <A projective object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
b := obj_gamma;
#! <An object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
c := TensorProductOnObjects( ZFree, obj_gamma );
#! <An object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
KaxbKxc := TensorProductOnObjects( TensorProductOnObjects( a, b ), c );
#! <An object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsEqualForObjects( KaxbKxc, ZeroObject( freyd ) );
#! false
tensor_product_morphism := TensorProductOnMorphisms( cokernel_colift, coker_proj );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsEpimorphism( tensor_product_morphism );
#! true
IsEqualForObjects( Source( tensor_product_morphism ), Range( tensor_product_morphism ) );
#! false
unit := TensorUnit( freyd );
#! <An object in Category of f.p. graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsEqualForObjects( TensorProductOnObjects( a, unit ), a );
#! true
axKbxcK := TensorProductOnObjects( a, TensorProductOnObjects( b, c ) );
#! <An object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
ass_left_to_right := AssociatorLeftToRightWithGivenTensorProducts( KaxbKxc, a, b, c, axKbxcK );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsIsomorphism( ass_left_to_right );
#! true
ass_right_to_left := AssociatorLeftToRightWithGivenTensorProducts( axKbxcK, a, b, c, KaxbKxc );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsMonomorphism( ass_right_to_left );
#! true
IsEpimorphism( ass_right_to_left );
#! true
LeftUnitor( a );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
LeftUnitorInverse( axKbxcK );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
RightUnitor( b );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
RightUnitorInverse( TensorProductOnObjects( axKbxcK, axKbxcK ) );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Braiding( axKbxcK, KaxbKxc );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
braiding := Braiding( a, b );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( braiding );
#! true
hom := InternalHomOnObjects( axKbxcK, axKbxcK );
#! <An object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsZero( hom );
#! false
free_mod1 := AsFreydCategoryObject( GradedRow( [ [[0,0],1] ], S ) );
#! <A projective object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
free_mod2 := AsFreydCategoryObject( GradedRow( [ [[1,1],1] ], S ) );
#! <A projective object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
hom2 := InternalHomOnObjects( free_mod1, free_mod2 );
#! <An object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsZero( hom2 );
#! false
IsZero( Source( RelationMorphism( hom2 ) ) );
#! true
Rank( Range( RelationMorphism( hom2 ) ) );
#! 1
hom3 := InternalHomOnObjects( free_mod2, free_mod1 );
#! <An object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsZero( hom3 );
#! false
InternalHomOnMorphisms( ass_left_to_right, ass_right_to_left );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
eval := EvaluationMorphism( a, b );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsEpimorphism( eval );
#! true
IsMonomorphism( eval );
#! true
coeval := CoevaluationMorphism( a, b );
#! <A morphism in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsEpimorphism( coeval );
#! true
IsMonomorphism( coeval );
#! true
#! @EndExample


#################################################################
#! @Section Tools for Freyd category of graded rows
#################################################################

#! We have introduced functionality, to easily compute tensor products.
#! Namely, * surves as tensor product among objects and morphisms in Freyd.
#! In case the n-th tensor product of an object with itself is desired, we can just use ^n.

#! @Example
power_obj2 := axKbxcK * axKbxcK;
#! <An object in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
power_obj3 := axKbxcK^3;
#! <An object in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
power_mor2 := coeval * coeval;
#! <A morphism in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
power_mor3 := coeval^3;
#! <A morphism in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! Also, we can compute Frobenius powers of objects.

#! @Example
frob0 := FrobeniusPowerOfFPGradedModule( axKbxcK, 0 );
#! <An object in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
frob1 := FrobeniusPowerOfFPGradedModule( axKbxcK, 1 );
#! <An object in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
frob2 := FrobeniusPowerOfFPGradedModule( axKbxcK, 2 );
#! <An object in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample


#################################################################
#! @Section Functors for Freyd category of graded rows
#################################################################

#! A f.p. graded module admits many presentations. For computational efficiency, those
#! presentations, which are easiest/quickest to perform computations by, are of particular interest.
#! For example we have

#! @Log
Display( power_obj2 );
#! An object in Category of f.p. graded left modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Relation morphism:
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 64 and degrees: [ [ ( 8, 8 ), 64 ] ]
#!
#! Matrix:
#! 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,1,0,0,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,0,0,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,1,1,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,1,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#!  1,0,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#!  0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#!  1,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#!  0,1,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,1,0,1,0,1,1,0,0,0,0,0,0,0,0,0,0,
#! 0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,
#! 0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,1,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,
#! 0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,1,0,0,0,0,0,0,0,0,
#! 0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,1,0,0,
#! 0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,0,0,
#! 0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,1,1,
#! 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,1 
#! (over a graded ring)
#!
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 16 and degrees: [ [ ( 8, 8 ), 16 ] ]
#! @EndLog

#! But we can find a better presentation. Namely,
#! @Example
reduced_power_obj2 := ByASmallerPresentation( power_obj2 );
#! <An object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! Namely, this module is now presented as follows:

#! @BeginLog
Display( reduced_power_obj2 );
#! An object in Category of f.p. graded left modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Relation morphism:
#! A morphism in Category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 0 and degrees: [  ]
#!
#! Matrix:
#! (an empty 1 x 0 matrix)
#!
#! Range:
#! A graded row over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 1 and degrees: [ [ ( 8, 8 ), 1 ] ]
#! @EndLog

#! This functionality is available as a functor, along with other functors:

#! @Example
FunctorLessGradedGeneratorsLeft( S );
#! Less generators for Category of f.p. graded left modules
#! over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
FunctorGradedStandardModuleLeft( S );
#! Graded standard module for Category of f.p. graded left modules
#! over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
FunctorByASmallerPresentationLeft( S );
#! ByASmallerPresentation for Category of f.p. graded
#! left modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! @EndExample

#! We also provide the natural isomorphism between
#! the identity functor and the standard module functor, namely

#! @BeginExample
NaturalIsomorphismFromIdentityToGradedStandardModuleLeft( S );
#! Natural isomorphism from Id to Graded standard module for
#! Category of f.p. graded left modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! @EndExample

#! There are also some functors which we provide for all Freyd categories.
#! Examples include the embedding functor of the additive category in its 
#! Freyd category and the best projective approximation functor.

#! @BeginExample
EmbeddingIntoFreydCategory( cat );
#! Embedding functor of Category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! into its Freyd category
BestProjectiveApproximationFunctor( cat );
#! Best projective approximation functor of the Freyd category
#! of Category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
BestEmbeddedProjectiveApproximationFunctor( cat );
#! Best embedded projective approximation functor of the Freyd category
#! of Category of graded rows over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
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
cat := CategoryOfGradedColumns( S );
#! Category of graded columns over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
obj1 := GradedColumn( [ [[1,1],1] ], S );
#! <A graded column of rank 1>
obj2 := GradedColumn( [ [[1,1],2] ], S );
#! <A graded column of rank 2>
gamma := GradedRowOrColumnMorphism( obj2, 
                       HomalgMatrix( [ [ 1, 1 ], [ 1, 1 ] ], 2, 2, S ), obj2 );
#! <A morphism in Category of graded columns over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
freyd := FreydCategory( cat );
#! Category of f.p. graded right modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
IsAbelianCategory( freyd );
#! true
obj_gamma := FreydCategoryObject( gamma );
#! <An object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
f := FreydCategoryMorphism( obj_gamma, gamma, obj_gamma );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
witness := MorphismWitness( f );
#! <A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( witness );
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
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
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsCongruentForMorphisms( f, g );
#! true
c := PreCompose( f, f );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( c );
#! A morphism in Category of f.p. graded right modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
#!
#! --------------------------------
#!
#! Source:
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
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
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
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
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
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
#! <A morphism in Category of f.p. graded right modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
a := GradedRowOrColumnMorphism( obj1, 
                                 HomalgMatrix( [ [ 2 ] ], 1, 1, S ), obj1 );
#! <A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( a );
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
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
#! <An object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( Z2 );
#! An object in Freyd( Category of graded columns over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
#!
#! Relation morphism:
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
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
#! <An identity morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
z := id + id + id;
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
d := DirectSumFunctorial( [ z, z, z ] );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
pr2 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
pr3 := ProjectionInFactorOfDirectSum( [ Z2, Z2, Z2 ], 3 );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
uni := UniversalMorphismIntoDirectSum( [ pr3, pr2 ] );
#! <A morphism in Category of f.p. graded right modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
inj1 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 1 );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
inj2 := InjectionOfCofactorOfDirectSum( [ Z2, Z2, Z2 ], 2 );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
uni2 := UniversalMorphismFromDirectSum( [ inj2, inj1 ] );
#! <A morphism in Category of f.p. graded right modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
ZFree := AsFreydCategoryObject( obj1 );
#! <A projective object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! @Log
Display( ZFree );
#! A projective object in Category of f.p. graded right modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) )
#!
#! Relation morphism:
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
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
#! <An identity morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
z := id + id;
#! <A morphism in Category of f.p. graded right modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
coker_proj := CokernelProjection( z );
#! <An epimorphism in Category of f.p. graded right modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
cokernel_colift := CokernelColift( z, CokernelProjection( z ) );
#! <A morphism in Category of f.p. graded right modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
a := ZFree;
#! <A projective object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
b := obj_gamma;
#! <An object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
c := TensorProductOnObjects( a, b );
#! <An object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
KaxbKxc := TensorProductOnObjects( TensorProductOnObjects( a, b ), c );
#! <An object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsEqualForObjects( KaxbKxc, ZeroObject( freyd ) );
#! false
tensor_product_morphism := TensorProductOnMorphisms( cokernel_colift, coker_proj );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsEpimorphism( tensor_product_morphism );
#! true
IsEqualForObjects( Source( tensor_product_morphism ), Range( tensor_product_morphism ) );
#! false
unit := TensorUnit( freyd );
#! <An object in Category of f.p. graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsEqualForObjects( TensorProductOnObjects( a, unit ), a );
#! true
axKbxcK := TensorProductOnObjects( a, TensorProductOnObjects( b, c ) );
#! <An object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
ass_left_to_right := AssociatorLeftToRightWithGivenTensorProducts( KaxbKxc, a, b, c, axKbxcK );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsIsomorphism( ass_left_to_right );
#! true
ass_right_to_left := AssociatorLeftToRightWithGivenTensorProducts( axKbxcK, a, b, c, KaxbKxc );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsMonomorphism( ass_right_to_left );
#! true
IsEpimorphism( ass_right_to_left );
#! true
LeftUnitor( a );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
LeftUnitorInverse( axKbxcK );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
RightUnitor( b );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
RightUnitorInverse( TensorProductOnObjects( axKbxcK, axKbxcK ) );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Braiding( axKbxcK, KaxbKxc );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
braiding := Braiding( a, b );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefined( braiding );
#! true
hom := InternalHomOnObjects( axKbxcK, axKbxcK );
#! <An object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsZero( hom );
#! false
free_mod1 := AsFreydCategoryObject( GradedColumn( [ [[0,0],1] ], S ) );
#! <A projective object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
free_mod2 := AsFreydCategoryObject( GradedColumn( [ [[1,1],1] ], S ) );
#! <A projective object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
hom2 := InternalHomOnObjects( free_mod1, free_mod2 );
#! <An object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsZero( hom2 );
#! false
IsZero( Source( RelationMorphism( hom2 ) ) );
#! true
Rank( Range( RelationMorphism( hom2 ) ) );
#! 1
hom3 := InternalHomOnObjects( free_mod2, free_mod1 );
#! <An object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsZero( hom3 );
#! false
InternalHomOnMorphisms( ass_left_to_right, ass_right_to_left );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
eval := EvaluationMorphism( a, b );
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsEpimorphism( eval );
#! true
IsMonomorphism( eval );
#! true
coeval := CoevaluationMorphism( a, b );
#! <A morphism in Category of f.p. graded right modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsEpimorphism( coeval );
#! true
IsMonomorphism( coeval );
#! true
#! @EndExample


#################################################################
#! @Section Tools for Freyd category of graded columns
#################################################################

#! Note that we have introduced some neat functionality, to easily compute tensor products.
#! Namely, * surves as tensor product among objects and morphisms in Freyd.
#! In case the n-th tensor product of an object with itself is desired, we can just use ^n.

#! @Example
power_obj2 := axKbxcK * axKbxcK;
#! <An object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
power_obj3 := axKbxcK^3;
#! <An object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
power_mor2 := coeval * coeval;
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
power_mor3 := coeval^3;
#! <A morphism in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! Also, we can compute Frobenius powers of objects.

#! @Example
frob0 := FrobeniusPowerOfFPGradedModule( axKbxcK, 0 );
#! <An object in Category of f.p. graded right modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
frob1 := FrobeniusPowerOfFPGradedModule( axKbxcK, 1 );
#! <An object in Category of f.p. graded right modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
frob2 := FrobeniusPowerOfFPGradedModule( axKbxcK, 2 );
#! <An object in Category of f.p. graded right modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample


#################################################################
#! @Section Functors for Freyd category of graded columns
#################################################################

#! A f.p. graded module admits many presentations. For computational efficiency, those
#! presentations, which are easiest/quickest to perform computations by, are of particular interest.
#! For example we have

#! @Log
Display( power_obj2 );
#! An object in Category of f.p. graded right modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Relation morphism:
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 64 and degrees: [ [ ( 8, 8 ), 64 ] ]
#!
#! Matrix:
#! 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,1,0,0,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,0,0,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,1,1,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,1,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#!  1,0,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#!  0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#!  1,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#!  0,1,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
#! 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,1,0,1,0,1,1,0,0,0,0,0,0,0,0,0,0,
#! 0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,
#! 0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,1,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,
#! 0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,1,0,0,0,0,0,0,0,0,
#! 0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,1,0,0,
#! 0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,0,0,
#! 0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,1,1,
#! 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,
#!  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,1 
#! (over a graded ring)
#!
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 16 and degrees: [ [ ( 8, 8 ), 16 ] ]
#! @EndLog

#! But we can find a better presentation. Namely,

#! @Example
reduced_power_obj2 := ByASmallerPresentation( power_obj2 );
#! <An object in Category of f.p. graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
#! @EndExample

#! Now, this module is presented as follows:

#! @BeginLog
Display( reduced_power_obj2 );
#! An object in Category of f.p. graded right modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Relation morphism:
#! A morphism in Category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#!
#! Source:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 0 and degrees: [  ]
#!
#! Matrix:
#! (an empty 1 x 0 matrix)
#!
#! Range:
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! of rank 1 and degrees: [ [ ( 8, 8 ), 1 ] ]
#! @EndLog

#! This functionality is available as a functor. Of course, more functors are
#! available:

#! @Example
FunctorLessGradedGeneratorsRight( S );
#! Less generators for Category of f.p. graded right modules
#! over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
FunctorGradedStandardModuleRight( S );
#! Graded standard module for Category of f.p. graded right modules
#! over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
FunctorByASmallerPresentationRight( S );
#! ByASmallerPresentation for Category of f.p. graded
#! right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! @EndExample

#! We also provide the natural isomorphism between
#! the identity functor and the standard module functor, namely

#! @BeginExample
NaturalIsomorphismFromIdentityToGradedStandardModuleRight( S );
#! Natural isomorphism from Id to Graded standard module for
#! Category of f.p. graded right modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! @EndExample

#! There are also some functors which we provide for all Freyd categories.
#! Examples include the embedding functor of the additive category in its 
#! Freyd category and the best projective approximation functor.

#! @BeginExample
EmbeddingIntoFreydCategory( cat );
#! Embedding functor of Category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! into its Freyd category
BestProjectiveApproximationFunctor( cat );
#! Best projective approximation functor of the Freyd category
#! of Category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
BestEmbeddedProjectiveApproximationFunctor( cat );
#! Best embedded projective approximation functor of the Freyd category
#! of Category of graded columns over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! @EndExample
