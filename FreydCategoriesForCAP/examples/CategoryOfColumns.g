#! @Chapter Example on category of columns

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );

#####################################
#! @Section Constructors of objects
#####################################

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
#! @Section A few categorical constructions for category of columns
########################################################################

#! @Example
ZeroObject( cols );
#! <A column module over Z of rank 0>
obj5 := CategoryOfColumnsObject( 2, cols );
#! <A column module over Z of rank 2>
Display( ZeroMorphism( ZeroObject( cols ), obj5 ) );
#! A zero, split monomorphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 0
#! 
#! Mapping matrix: 
#! (an empty 2 x 0 matrix)
#! 
#! Range: 
#! A column module over Z of rank 2
obj6 := CategoryOfColumnsObject( 1, cols );
#! <A column module over Z of rank 1>
Display( IdentityMorphism( obj6 ) );
#! An identity morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 1
#! 
#! Mapping matrix: 
#! [ [  1 ] ]
#! 
#! Range: 
#! A column module over Z of rank 1
directSum := DirectSum( [ obj5, obj6 ] );
#! <A column module over Z of rank 3>
Display( directSum );
#! A column module over Z of rank 3
i1 := InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 1 );
#! <A morphism in Columns( Z )>
Display( i1 );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 2
#! 
#! Mapping matrix: 
#! [ [  1,  0 ],
#!   [  0,  1 ],
#!   [  0,  0 ] ]
#! 
#! Range: 
#! A column module over Z of rank 3
i2 := InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 2 );
#! <A morphism in Columns( Z )>
Display( i2 );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 1
#! 
#! Mapping matrix: 
#! [ [  0 ],
#!   [  0 ],
#!   [  1 ] ]
#! 
#! Range: 
#! A column module over Z of rank 3
proj1 := ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 1 );
#! <A morphism in Columns( Z )>
Display( proj1 );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 3
#! 
#! Mapping matrix: 
#! [ [  1,  0,  0 ],
#!   [  0,  1,  0 ] ]
#! 
#! Range: 
#! A column module over Z of rank 2
proj2 := ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 2 );
#! <A morphism in Columns( Z )>
Display( proj2 );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 3
#! 
#! Mapping matrix: 
#! [ [  0,  0,  1 ] ]
#! 
#! Range: 
#! A column module over Z of rank 1
k := WeakKernelEmbedding( proj1 );
#! <A morphism in Columns( Z )>
Display( k );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 1
#! 
#! Mapping matrix: 
#! [ [  0 ],
#!   [  0 ],
#!   [  1 ] ]
#! 
#! Range: 
#! A column module over Z of rank 3
ck := WeakCokernelProjection( k );
#! <A morphism in Columns( Z )>
Display( ck );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 3
#! 
#! Mapping matrix: 
#! [ [   0,   1,   0 ],
#!   [  -1,   0,   0 ] ]
#! 
#! Range: 
#! A column module over Z of rank 2
IsMonomorphism( k );
#! true
IsEpimorphism( k );
#! false
IsMonomorphism( ck );
#! false
IsEpimorphism( ck );
#! true
mor1 := CategoryOfColumnsMorphism( obj5, HomalgMatrix( [[ 1, 2 ]], S ), obj6 );
#! <A morphism in Columns( Z )>
Display( mor1 );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 2
#! 
#! Mapping matrix: 
#! [ [  1,  2 ] ]
#! 
#! Range: 
#! A column module over Z of rank 1
mor2 := IdentityMorphism( obj6 );
#! <An identity morphism in Columns( Z )>
Display( mor2 );
#! An identity morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 1
#! 
#! Mapping matrix: 
#! [ [  1 ] ]
#! 
#! Range: 
#! A column module over Z of rank 1
lift := Lift( mor1, mor2 );
#! <A morphism in Columns( Z )>
Display( lift );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 2
#! 
#! Mapping matrix: 
#! [ [  1,  2 ] ]
#! 
#! Range: 
#! A column module over Z of rank 1
source := CategoryOfColumnsObject( 1, cols );
#! <A column module over Z of rank 1>
range := CategoryOfColumnsObject( 2, cols );
#! <A column module over Z of rank 2>
mor := CategoryOfColumnsMorphism( source, HomalgMatrix( [[ 2 ], [ 3 ]], S ), range );
#! <A morphism in Columns( Z )>
colift := Colift( mor2, mor );
#! <A morphism in Columns( Z )>
Display( colift );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 1
#! 
#! Mapping matrix: 
#! [ [  2 ],
#!   [  3 ] ]
#! 
#! Range: 
#! A column module over Z of rank 2
fp := WeakBiFiberProduct( mor1, mor2 );
#! <A column module over Z of rank 2>
fp_proj := ProjectionOfBiasedWeakFiberProduct( mor1, mor2 );
#! <A morphism in Columns( Z )>
Display( fp_proj );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 2
#! 
#! Mapping matrix: 
#! [ [  -2,  -1 ],
#!   [   1,   0 ] ]
#! 
#! Range: 
#! A column module over Z of rank 2
po := WeakBiPushout( mor, mor2 );
#! <A column module over Z of rank 2>
inj_push := InjectionOfBiasedWeakPushout( mor, mor2 );
#! <A morphism in Columns( Z )>
Display( inj_push );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 2
#! 
#! Mapping matrix: 
#! [ [  -3,   2 ],
#!   [   1,  -1 ] ]
#! 
#! Range: 
#! A column module over Z of rank 2

#! @EndExample
