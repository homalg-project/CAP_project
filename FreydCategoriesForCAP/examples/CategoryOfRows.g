#! @Chapter Example on category of rows

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );

#####################################
#! @Section Constructors of objects
#####################################

#! @Example
S := HomalgRingOfIntegers();;
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
#! @EndExample

#! @Log
Display( Source( mor ) );
#! A row module over Z of rank 1
Display( Range( mor ) );
#! A row module over Z of rank 2
Display( UnderlyingMatrix( mor ) );
#! [ [  1, 2 ] ]
#! @EndLog





########################################################################
#! @Section A few categorical constructions for category of rows
########################################################################

#! @Example
Size( AdditiveGenerators( rows ) );
#! 1
ZeroObject( rows );
#! <A row module over Z of rank 0>
obj5 := CategoryOfRowsObject( 2, rows );
#! <A row module over Z of rank 2>
#! @EndExample

#! @Log
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
#! @EndLog

#! @Example
obj6 := CategoryOfRowsObject( 1, rows );
#! <A row module over Z of rank 1>
#! @EndExample

#! @Log
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
#! @EndLog

#! @Example
directSum := DirectSum( [ obj5, obj6 ] );
#! <A row module over Z of rank 3>
#! @EndExample

#! @Log
Display( directSum );
#! A row module over Z of rank 3
#! @EndLog

#! @Example
i1 := InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 1 );
#! <A morphism in Rows( Z )>
#! @EndExample

#! @Log
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
#! @EndLog

#! @Example
i2 := InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 2 );
#! <A morphism in Rows( Z )>
#! @EndExample

#! @Log
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
#! @EndLog

#! @Example
proj1 := ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 1 );
#! <A morphism in Rows( Z )>
#! @EndExample

#! @Log
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
#! @EndLog

#! @Example
proj2 := ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 2 );
#! <A morphism in Rows( Z )>
#! @EndExample

#! @Log
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
#! @EndLog

#! @Example
k := WeakKernelEmbedding( proj1 );
#! <A morphism in Rows( Z )>
#! @EndExample

#! @Log
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
#! @EndLog

#! @Example
ck := WeakCokernelProjection( k );
#! <A morphism in Rows( Z )>
#! @EndExample

#! @Log
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
mor1 := CategoryOfRowsMorphism( obj5, HomalgMatrix( [[ 1 ], [ 2 ]], S ), obj6 );
#! <A morphism in Rows( Z )>
#! @EndExample

#! @Log
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
#! @EndLog

#! @Example
mor2 := IdentityMorphism( obj6 );
#! <An identity morphism in Rows( Z )>
#! @EndExample

#! @Log
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
#! @EndLog

#! @Example
lift := Lift( mor1, mor2 );
#! <A morphism in Rows( Z )>
#! @EndExample

#! @Log
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
#! @EndLog

#! @Example
source := CategoryOfRowsObject( 1, rows );
#! <A row module over Z of rank 1>
range := CategoryOfRowsObject( 2, rows );
#! <A row module over Z of rank 2>
mor := CategoryOfRowsMorphism( source, HomalgMatrix( [[ 2, 3 ]], S ), range );
#! <A morphism in Rows( Z )>
colift := Colift( mor2, mor );
#! <A morphism in Rows( Z )>
#! @EndExample

#! @Log
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
#! @EndLog

#! @Example
fp := WeakBiFiberProduct( mor1, mor2 );
#! <A row module over Z of rank 2>
fp_proj := ProjectionOfBiasedWeakFiberProduct( mor1, mor2 );
#! <A morphism in Rows( Z )>
#! @EndExample

#! @Log
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
#! @EndLog

#! @Example
po := WeakBiPushout( mor, mor2 );
#! <A row module over Z of rank 2>
inj_push := InjectionOfBiasedWeakPushout( mor, mor2 );
#! <A morphism in Rows( Z )>
#! @EndExample

#! @Log
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
#! @EndLog

##############
# Equalizer
##############

#! @Example
Q := HomalgFieldOfRationals();;
rows := CategoryOfRows( Q );;
homalg_matrix := HomalgMatrix( [ [ 1, 0 ],
                                 [ 0, 1 ],
                                 [ -2, 0] ], 3, 2, Q );;
alpha := homalg_matrix / rows;;
diagram := [ alpha, 2*alpha, 3*alpha ];;
equalizer := EmbeddingOfEqualizer( diagram );;
Display(equalizer);
#! Source: 
#! A row module over Q of rank 1
#!
#! Matrix:
#! [ [  2,  0,  1 ] ]
#!
#! Range:
#! A row module over Q of rank 3
#!
#! A monomorphism in Rows( Q )
equalizer_d1 := PreCompose( equalizer, diagram[1] );;
equalizer_d2 := PreCompose( equalizer, diagram[2] );;
equalizer_d3 := PreCompose( equalizer, diagram[3] );;
IsEqualForMorphisms( equalizer_d1, equalizer_d2 );
#! true
IsEqualForMorphisms( equalizer_d2, equalizer_d3 );
#! true
IsEqualForMorphisms( equalizer_d1, equalizer_d3 );
#! true
universal_morphism := UniversalMorphismIntoEqualizer( Source(alpha), diagram, Source( 2*equalizer ), 2*equalizer );;
Display( universal_morphism );
#! Source:
#! A row module over Q of rank 1
#! 
#! Matrix:
#! [ [  2 ] ]
#! 
#! Range:
#! A row module over Q of rank 1
#! 
#! A morphism in Rows( Q )
IsEqualForMorphisms( PreCompose( universal_morphism, equalizer ), 2*equalizer );
#! true
#! @EndExample

##############
# Coequalizer
##############

#! @Example
Q := HomalgFieldOfRationals();;
rows := CategoryOfRows( Q );;
homalg_matrix := HomalgMatrix( [ [ 1, 0, -2 ],
                                 [ 0, 1, 0 ] ], 2, 3, Q );;
alpha := homalg_matrix / rows;;
diagram := [ alpha, 2*alpha, 3*alpha ];;
coequalizer := ProjectionOntoCoequalizer( diagram );;
Display( coequalizer );
#! Source:
#! A row module over Q of rank 3
#!
#! Matrix: 
#! [ [  2 ],
#!   [  0 ],
#!   [  1 ] ]
#! 
#! Range:
#! A row module over Q of rank 1
#!
#! An epimorphism in Rows( Q )
coequalizer_d1 := PreCompose( diagram[1], coequalizer );;
coequalizer_d2 := PreCompose( diagram[2], coequalizer );;
coequalizer_d3 := PreCompose( diagram[3], coequalizer );;
IsEqualForMorphisms( coequalizer_d1, coequalizer_d2 );
#! true
IsEqualForMorphisms( coequalizer_d2, coequalizer_d3 );
#! true
IsEqualForMorphisms( coequalizer_d1, coequalizer_d3 );
#! true
universal_morphism := UniversalMorphismFromCoequalizer( Range(alpha), diagram, Range( 2*coequalizer ), 2*coequalizer );;
Display( universal_morphism );
#! Source:
#! A row module over Q of rank 1
#! 
#! Matrix:
#! [ [  2 ] ]
#! 
#! Range:
#! A row module over Q of rank 1
#! 
#! A morphism in Rows( Q )
IsEqualForMorphisms( PreCompose( coequalizer,  universal_morphism ), 2*coequalizer );
#! true
#! @EndExample
