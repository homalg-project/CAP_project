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
#! @EndExample

#! @Log
Display( Source( mor ) );
#! A column module over Z of rank 1
Display( Range( mor ) );
#! A column module over Z of rank 2
Display( UnderlyingMatrix( mor ) );
#! [ [  1 ],
#!   [  2 ] ]
#! @EndLog





########################################################################
#! @Section A few categorical constructions for category of columns
########################################################################

#! @Example
ZeroObject( cols );
#! <A column module over Z of rank 0>
obj5 := CategoryOfColumnsObject( 2, cols );
#! <A column module over Z of rank 2>
#! @EndExample

#! @Log
Display( ZeroMorphism( ZeroObject( cols ), obj5 ) );
#! A zero, split monomorphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 0
#! 
#! Matrix: 
#! (an empty 2 x 0 matrix)
#! 
#! Range: 
#! A column module over Z of rank 2
#! @EndLog

#! @Example
obj6 := CategoryOfColumnsObject( 1, cols );
#! <A column module over Z of rank 1>
#! @EndExample

#! @Log
Display( IdentityMorphism( obj6 ) );
#! An identity morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 1
#! 
#! Matrix: 
#! [ [  1 ] ]
#! 
#! Range: 
#! A column module over Z of rank 1
#! @EndLog

#! @Example
directSum := DirectSum( [ obj5, obj6 ] );
#! <A column module over Z of rank 3>
#! @EndExample

#! @Log
Display( directSum );
#! A column module over Z of rank 3
#! @EndLog

#! @Example
i1 := InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 1 );
#! <A morphism in Columns( Z )>
#! @EndExample

#! @Log
Display( i1 );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 2
#! 
#! Matrix: 
#! [ [  1,  0 ],
#!   [  0,  1 ],
#!   [  0,  0 ] ]
#! 
#! Range: 
#! A column module over Z of rank 3
#! @EndLog

#! @Example
i2 := InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 2 );
#! <A morphism in Columns( Z )>
#! @EndExample

#! @Log
Display( i2 );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 1
#! 
#! Matrix: 
#! [ [  0 ],
#!   [  0 ],
#!   [  1 ] ]
#! 
#! Range: 
#! A column module over Z of rank 3
#! @EndLog

#! @Example
proj1 := ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 1 );
#! <A morphism in Columns( Z )>
#! @EndExample

#! @Log
Display( proj1 );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 3
#! 
#! Matrix: 
#! [ [  1,  0,  0 ],
#!   [  0,  1,  0 ] ]
#! 
#! Range: 
#! A column module over Z of rank 2
#! @EndLog

#! @Example
proj2 := ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 2 );
#! <A morphism in Columns( Z )>
#! @EndExample

#! @Log
Display( proj2 );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 3
#! 
#! Matrix: 
#! [ [  0,  0,  1 ] ]
#! 
#! Range: 
#! A column module over Z of rank 1
#! @EndLog

#! @Example
k := WeakKernelEmbedding( proj1 );
#! <A morphism in Columns( Z )>
#! @EndExample

#! @Log
Display( k );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 1
#! 
#! Matrix: 
#! [ [  0 ],
#!   [  0 ],
#!   [  1 ] ]
#! 
#! Range: 
#! A column module over Z of rank 3
#! @EndLog

#! @Example
ck := WeakCokernelProjection( k );
#! <A morphism in Columns( Z )>
#! @EndExample

#! @Log
Display( ck );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 3
#! 
#! Matrix: 
#! [ [   0,   1,   0 ],
#!   [  -1,   0,   0 ] ]
#! 
#! Range: 
#! A column module over Z of rank 2
#! @EndLog

#! @Example
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
#! @EndExample

#! @Log
Display( mor1 );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 2
#! 
#! Matrix: 
#! [ [  1,  2 ] ]
#! 
#! Range: 
#! A column module over Z of rank 1
#! @EndLog

#! @Example
mor2 := IdentityMorphism( obj6 );
#! <An identity morphism in Columns( Z )>
#! @EndExample

#! @Log
Display( mor2 );
#! An identity morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 1
#! 
#! Matrix: 
#! [ [  1 ] ]
#! 
#! Range: 
#! A column module over Z of rank 1
#! @EndLog

#! @Example
lift := Lift( mor1, mor2 );
#! <A morphism in Columns( Z )>
#! @EndExample

#! @Log
Display( lift );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 2
#! 
#! Matrix: 
#! [ [  1,  2 ] ]
#! 
#! Range: 
#! A column module over Z of rank 1
#! @EndLog

#! @Example
source := CategoryOfColumnsObject( 1, cols );
#! <A column module over Z of rank 1>
range := CategoryOfColumnsObject( 2, cols );
#! <A column module over Z of rank 2>
mor := CategoryOfColumnsMorphism( source, HomalgMatrix( [[ 2 ], [ 3 ]], S ), range );
#! <A morphism in Columns( Z )>
colift := Colift( mor2, mor );
#! <A morphism in Columns( Z )>
#! @EndExample

#! @Log
Display( colift );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 1
#! 
#! Matrix: 
#! [ [  2 ],
#!   [  3 ] ]
#! 
#! Range: 
#! A column module over Z of rank 2
#! @EndLog

#! @Example
fp := WeakBiFiberProduct( mor1, mor2 );
#! <A column module over Z of rank 2>
fp_proj := ProjectionOfBiasedWeakFiberProduct( mor1, mor2 );
#! <A morphism in Columns( Z )>
#! @EndExample

#! @Log
Display( fp_proj );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 2
#! 
#! Matrix: 
#! [ [  -2,  -1 ],
#!   [   1,   0 ] ]
#! 
#! Range: 
#! A column module over Z of rank 2
#! @EndLog

#! @Example
po := WeakBiPushout( mor, mor2 );
#! <A column module over Z of rank 2>
inj_push := InjectionOfBiasedWeakPushout( mor, mor2 );
#! <A morphism in Columns( Z )>
#! @EndExample

#! @Log
Display( inj_push );
#! A morphism in Columns( Z )
#! 
#! Source: 
#! A column module over Z of rank 2
#! 
#! Matrix: 
#! [ [  -3,   2 ],
#!   [   1,  -1 ] ]
#! 
#! Range: 
#! A column module over Z of rank 2
#! @EndLog
