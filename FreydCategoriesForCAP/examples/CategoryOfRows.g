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
#! [ [  1, 2 ] ]
#! @EndExample





########################################################################
#! @Section A few categorical constructions for category of rows
########################################################################

#! @Example
ZeroObject( rows );
#! <A row module over Z of rank 0>
obj5 := CategoryOfRowsObject( 2, rows );
#! <A row module over Z of rank 2>
Display( ZeroMorphism( ZeroObject( rows ), obj5 ) );
#! A zero, split monomorphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 0
#! 
#! Matrix: 
#! (an empty 0 x 2 matrix)
#! 
#! Range: 
#! A row module over Z of rank 2
obj6 := CategoryOfRowsObject( 1, rows );
#! <A row module over Z of rank 1>
Display( IdentityMorphism( obj6 ) );
#! An identity morphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 1
#! 
#! Matrix: 
#! [ [  1 ] ]
#! 
#! Range: 
#! A row module over Z of rank 1
directSum := DirectSum( [ obj5, obj6 ] );
#! <A row module over Z of rank 3>
Display( directSum );
#! A row module over Z of rank 3
i1 := InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 1 );
#! <A morphism in Rows( Z )>
Display( i1 );
#! A morphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 2
#! 
#! Matrix: 
#! [ [  1,  0,  0 ],
#!   [  0,  1,  0 ] ]
#! 
#! Range: 
#! A row module over Z of rank 3
i2 := InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 2 );
#! <A morphism in Rows( Z )>
Display( i2 );
#! A morphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 1
#! 
#! Matrix: 
#! [ [  0,  0,  1 ] ]
#! 
#! Range: 
#! A row module over Z of rank 3
proj1 := ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 1 );
#! <A morphism in Rows( Z )>
Display( proj1 );
#! A morphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 3
#! 
#! Matrix: 
#! [ [  1,  0 ],
#!   [  0,  1 ],
#!   [  0,  0 ] ]
#! 
#! Range: 
#! A row module over Z of rank 2
proj2 := ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 2 );
#! <A morphism in Rows( Z )>
Display( proj2 );
#! A morphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 3
#! 
#! Matrix: 
#! [ [  0 ],
#!   [  0 ],
#!   [  1 ] ]
#! 
#! Range: 
#! A row module over Z of rank 1
k := WeakKernelEmbedding( proj1 );
#! <A morphism in Rows( Z )>
Display( k );
#! A morphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 1
#! 
#! Matrix: 
#! [ [  0,  0,  1 ] ]
#! 
#! Range: 
#! A row module over Z of rank 3
ck := WeakCokernelProjection( k );
#! <A morphism in Rows( Z )>
Display( ck );
#! A morphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 3
#! 
#! Matrix: 
#! [ [   0,  -1 ],
#!   [   1,   0 ],
#!   [   0,   0 ] ]
#! 
#! Range: 
#! A row module over Z of rank 2
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
#! A morphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 2
#! 
#! Matrix: 
#! [ [  1 ],
#!   [  2 ] ]
#! 
#! Range: 
#! A row module over Z of rank 1
mor2 := IdentityMorphism( obj6 );
#! <An identity morphism in Rows( Z )>
Display( mor2 );
#! An identity morphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 1
#! 
#! Matrix: 
#! [ [  1 ] ]
#! 
#! Range: 
#! A row module over Z of rank 1
lift := Lift( mor1, mor2 );
#! <A morphism in Rows( Z )>
Display( lift );
#! A morphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 2
#! 
#! Matrix: 
#! [ [  1 ],
#!   [  2 ] ]
#! 
#! Range: 
#! A row module over Z of rank 1
source := CategoryOfRowsObject( 1, rows );
#! <A row module over Z of rank 1>
range := CategoryOfRowsObject( 2, rows );
#! <A row module over Z of rank 2>
mor := CategoryOfRowsMorphism( source, HomalgMatrix( [[ 2, 3 ]], S ), range );
#! <A morphism in Rows( Z )>
colift := Colift( mor2, mor );
#! <A morphism in Rows( Z )>
Display( colift );
#! A morphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 1
#! 
#! Matrix: 
#! [ [  2,  3 ] ]
#! 
#! Range: 
#! A row module over Z of rank 2
fp := WeakBiFiberProduct( mor1, mor2 );
#! <A row module over Z of rank 2>
fp_proj := ProjectionOfBiasedWeakFiberProduct( mor1, mor2 );
#! <A morphism in Rows( Z )>
Display( fp_proj );
#! A morphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 2
#! 
#! Matrix: 
#! [ [  -2,   1 ],
#!   [  -1,   0 ] ]
#! 
#! Range: 
#! A row module over Z of rank 2
po := WeakBiPushout( mor, mor2 );
#! <A row module over Z of rank 2>
inj_push := InjectionOfBiasedWeakPushout( mor, mor2 );
#! <A morphism in Rows( Z )>
Display( inj_push );
#! A morphism in Rows( Z )
#! 
#! Source: 
#! A row module over Z of rank 2
#! 
#! Matrix: 
#! [ [  -3,   1 ],
#!   [   2,  -1 ] ]
#! 
#! Range: 
#! A row module over Z of rank 2
#! @EndExample
