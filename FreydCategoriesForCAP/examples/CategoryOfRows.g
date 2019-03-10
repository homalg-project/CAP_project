#! @Chapter Example on category of rows

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );

#####################################
#! @Section Constructors of objects
#####################################

#! @Example
S := HomalgRingOfIntegers();
#! Z
rows := CategoryOfRows( S );
#! Rows( Z )
obj1 := CategoryOfRowsObject( 2, rows );
#! <A row module over Z of rank 2>
obj2 := CategoryOfRowsObject( 8, rows );
#! <A row module over Z of rank 8>
#! @EndExample


#####################################
#! @Section Constructors of morphisms
#####################################

#! @Example
obj3 := CategoryOfRowsObject( 1, rows );
#! <A row module over Z of rank 1>
IsWellDefined( obj1 );
#! true
obj4 := CategoryOfRowsObject( 2, rows );
#! <A row module over Z of rank 2>
mor := CategoryOfRowsMorphism( obj3, HomalgMatrix( [[1,2]], S ), obj4 );
#! <A morphism in Rows( Z )>
IsWellDefined( mor );
#! true
Display( Source( mor ) );
#! A row module over Z of rank 1
Display( Range( mor ) );
#! A row module over Z of rank 2
Display( UnderlyingMatrix( mor ) );
#! [ [  1 ],
#!   [  2 ] ]
#! @EndExample





########################################################################
#! @Section A few categorical constructions for category of rows
########################################################################

#! @Example
ZeroObject( rows );
#! A row module over Z of rank 0
obj5 := CategoryOfRowsObject( 2, rows );
#! <A row module over Z of rank 2>
Display( ZeroMorphism( ZeroObject( rows ), obj5 ) );
#! (an empty 2 x 0 matrix)
#! 
#! A zero, split monomorphism in Rows( Z )
obj6 := CategoryOfRowsObject( 1, rows );
#! <A row module over Z of rank 1>
Display( IdentityMorphism( obj6 ) );
#! [ [  1 ] ]
#! 
#! An identity morphism in Rows( Z )
directSum := DirectSum( [ obj5, obj6 ] );
#! <A graded row of rank 3>
Display( directSum );
#! A row module over Z of rank 3
i1 := InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 1 );
#! <A morphism in Rows( Z )>
Display( i1 );
#! [ [  1,  0,  0 ],
#!   [  0,  1,  0 ] ]
#! 
#! A morphism in Rows( Z )
i2 := InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 2 );
#! <A morphism in Rows( Z )>
Display( i2 );
#! [ [  0,  0,  1 ] ]
#! 
#! A morphism in Rows( Z )
proj1 := ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 1 );
#! <A morphism in Rows( Z )>
Display( proj1 );
#! [ [  1,  0 ],
#!   [  0,  1 ],
#!   [  0,  0 ] ]
#! 
#! A morphism in Rows( Z )
proj2 := ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 2 );
#! <A morphism in Rows( Z )>
Display( proj2 );
#! [ [  0  ],
#!   [  0  ], 
#!   [  1  ] ]
#! 
#! A morphism in Rows( Z )
k := WeakKernelEmbedding( proj1 );
#! <A morphism in Rows( Z )>
Display( k );
#! [ [  0,  0,  1 ] ]
#! 
#! A morphism in Rows( Z )
ck := WeakCokernelProjection( k );
#! <A morphism in Rows( Z )>
Display( ck );
#! [ [   0,  -1 ],
#!   [   1,   0 ],
#!   [   0,   0 ] ]
#! 
#! A morphism in Rows( Z )
IsMonomorphism( k );
#! true
IsEpimorphism( k );
#! false
IsMonomorphism( ck );
#! false
IsEpimorphism( ck );
#! true
mor1 := CategoryOfRowsMorphism( obj5, HomalgMatrix( [[ 1 ], [ 2 ]], S ), obj6 );
#! <A morphism in Rows( Z )>
Display( mor1 );
#! [ [  1 ], [  2 ] ]
#! 
#! A morphism in Rows( Z )
mor2 := IdentityMorphism( obj6 );
#! <A morphism in Rows( Z )>
Display( mor2 );
#! [ [  1 ] ]
#! 
#! A morphism in Rows( Z )
lift := Lift( mor1, mor2 );
#! A morphism in Rows( Z )
Display( lift );
#! [ [  1 ], [ 2 ] ]
#! 
#! A morphism in Rows( Z )
source := CategoryOfRowsObject( 1, rows );
#! A row module of over Z of rank 1
range := CategoryOfRowsObject( 2, rows );
#! A row module of over Z of rank 2
mor := CategoryOfRowsMorphism( source, HomalgMatrix( [[ 2, 3 ]], S ), range );
#! A morphism in Rows( Z )
colift := Colift( mor2, mor );
#! A morphism in Rows( Z )
Display( colift );
#! [ [  2, 3 ] ]
#!
#! A morphism in Rows( Z )
fp := WeakBiFiberProduct( mor1, mor2 );
#! <A row module over Z of rank 2>
fp_proj := ProjectionOfBiasedWeakFiberProduct( mor1, mor2 );
#! <A morphism in Rows( Z )>
Display( fp_proj );
#! [ [  -2,   1 ],
#!   [  -1,   0 ] ]
#! 
#! A morphism in Rows( Z )
po := WeakBiPushout( mor, mor2 );
#! <A row module over Z of rank 2>
inj_push := InjectionOfBiasedWeakPushout( mor, mor2 );
#! <A morphism in Rows( Z )>
Display( inj_push );
#! [ [  -3,   1 ],
#!   [   2,  -1 ] ]
#! 
#! A morphism in Rows( Z )

#! @EndExample
