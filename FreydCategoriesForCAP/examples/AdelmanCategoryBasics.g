#! @Chapter Examples and Tests

#! @Section Adelman category basics for category of rows

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );

#! @Example
R := HomalgRingOfIntegers();;
rows := CategoryOfRows( R );;
adelman := AdelmanCategory( rows );;
obj1 := CategoryOfRowsObject( 1, rows );;
obj2 := CategoryOfRowsObject( 2, rows );;
id := IdentityMorphism( obj2 );;
alpha := CategoryOfRowsMorphism( obj1, HomalgMatrix( [ [ 1, 2 ] ], 1, 2, R ), obj2 );;
beta := CategoryOfRowsMorphism( obj2, HomalgMatrix( [ [ 1, 2 ], [ 3, 4 ] ], 2, 2, R ), obj2 );;
gamma := CategoryOfRowsMorphism( obj2, HomalgMatrix( [ [ 1, 3 ], [ 3, 4 ] ], 2, 2, R ), obj2 );;
obj1_a := AsAdelmanCategoryObject( obj1 );;
obj2_a := AsAdelmanCategoryObject( obj2 );;
m := AsAdelmanCategoryMorphism( beta );;
n := AsAdelmanCategoryMorphism( gamma );;
IsWellDefined( m );
#! true
# backwards compatibility
IsIdenticalObj( MorphismDatum( m ), beta );
#! true
IsCongruentForMorphisms( PreCompose( m, n ), PreCompose( n, m ) );
#! false
IsCongruentForMorphisms( SubtractionForMorphisms( m, m ), ZeroMorphism( obj2_a, obj2_a ) );
#! true
IsCongruentForMorphisms( ZeroObjectFunctorial( adelman ),
                         PreCompose( UniversalMorphismFromZeroObject( obj1_a), UniversalMorphismIntoZeroObject( obj1_a ) ) 
                        );
#! true
d := [ obj1_a, obj2_a ];;
pi1 := ProjectionInFactorOfDirectSum( d, 1 );;
pi2 := ProjectionInFactorOfDirectSum( d, 2 );;
id := IdentityMorphism( DirectSum( d ) );;
iota1 := InjectionOfCofactorOfDirectSum( d, 1 );;
iota2 := InjectionOfCofactorOfDirectSum( d, 2 );;
IsCongruentForMorphisms( PreCompose( pi1, iota1 ) + PreCompose( pi2, iota2 ), id );
#! true
IsCongruentForMorphisms( UniversalMorphismIntoDirectSum( d, [ pi1, pi2 ] ), id );
#! true
IsCongruentForMorphisms( UniversalMorphismFromDirectSum( d, [ iota1, iota2 ] ), id );
#! true
c := CokernelProjection( m );;
c2 := CokernelProjection( c );;
IsCongruentForMorphisms( c2, ZeroMorphism( Source( c2 ), Range( c2 ) ) );
#! true
IsWellDefined( CokernelProjection( m ) );
#! true
IsCongruentForMorphisms( CokernelColift( m, CokernelProjection( m ) ), IdentityMorphism( CokernelObject( m ) ) );
#! true
k := KernelEmbedding( c );;
IsZeroForMorphisms( PreCompose( k, c ) );
#! true
IsCongruentForMorphisms( KernelLift( m, KernelEmbedding( m ) ), IdentityMorphism( KernelObject( m ) ) );
#! true
#! @EndExample

#! @Section Adelman category basics for category of columns

#! @Example
R := HomalgRingOfIntegers();;
cols := CategoryOfColumns( R );;
adelman := AdelmanCategory( cols );;
obj1 := CategoryOfColumnsObject( 1, cols );;
obj2 := CategoryOfColumnsObject( 2, cols );;
id := IdentityMorphism( obj2 );;
alpha := CategoryOfColumnsMorphism( obj1, HomalgMatrix( [ [ 1 ], [ 2 ] ], 2, 1, R ), obj2 );;
beta := CategoryOfColumnsMorphism( obj2, HomalgMatrix( [ [ 1, 3 ], [ 2, 4 ] ], 2, 2, R ), obj2 );;
gamma := CategoryOfColumnsMorphism( obj2, HomalgMatrix( [ [ 1, 3 ], [ 3, 4 ] ], 2, 2, R ), obj2 );;
obj1_a := AsAdelmanCategoryObject( obj1 );;
obj2_a := AsAdelmanCategoryObject( obj2 );;
m := AsAdelmanCategoryMorphism( beta );;
n := AsAdelmanCategoryMorphism( gamma );;
IsWellDefined( m );
#! true
IsCongruentForMorphisms( PreCompose( m, n ), PreCompose( n, m ) );
#! false
IsCongruentForMorphisms( SubtractionForMorphisms( m, m ), ZeroMorphism( obj2_a, obj2_a ) );
#! true
IsCongruentForMorphisms( ZeroObjectFunctorial( adelman ),
                         PreCompose( UniversalMorphismFromZeroObject( obj1_a), UniversalMorphismIntoZeroObject( obj1_a ) ) 
                        );
#! true
d := [ obj1_a, obj2_a ];;
pi1 := ProjectionInFactorOfDirectSum( d, 1 );;
pi2 := ProjectionInFactorOfDirectSum( d, 2 );;
id := IdentityMorphism( DirectSum( d ) );;
iota1 := InjectionOfCofactorOfDirectSum( d, 1 );;
iota2 := InjectionOfCofactorOfDirectSum( d, 2 );;
IsCongruentForMorphisms( PreCompose( pi1, iota1 ) + PreCompose( pi2, iota2 ), id );
#! true
IsCongruentForMorphisms( UniversalMorphismIntoDirectSum( d, [ pi1, pi2 ] ), id );
#! true
IsCongruentForMorphisms( UniversalMorphismFromDirectSum( d, [ iota1, iota2 ] ), id );
#! true
c := CokernelProjection( m );;
c2 := CokernelProjection( c );;
IsCongruentForMorphisms( c2, ZeroMorphism( Source( c2 ), Range( c2 ) ) );
#! true
IsWellDefined( CokernelProjection( m ) );
#! true
IsCongruentForMorphisms( CokernelColift( m, CokernelProjection( m ) ), IdentityMorphism( CokernelObject( m ) ) );
#! true
k := KernelEmbedding( c );;
IsZeroForMorphisms( PreCompose( k, c ) );
#! true
IsCongruentForMorphisms( KernelLift( m, KernelEmbedding( m ) ), IdentityMorphism( KernelObject( m ) ) );
#! true
#! @EndExample
