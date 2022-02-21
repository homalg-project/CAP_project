#! @Chapter Examples and Tests

#! @Section Testing if an object is projective, injective, bijective

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );

#! @Example
R := HomalgRingOfIntegers();;
rows := CategoryOfRows( R );;
adelman := AdelmanCategory( rows );;
obj1 := CategoryOfRowsObject( 1, rows );;
alpha := ProjectionInFactorOfDirectSum( [ obj1, obj1 ], 1 );;
alpha := AsAdelmanCategoryMorphism( alpha );;
obj := CokernelObject( alpha );;
IsBijectiveObject( obj );
#! true
beta := 2 * IdentityMorphism( obj1 );;
beta := AsAdelmanCategoryMorphism( beta );;
obj1 := CokernelObject( beta );;
obj2 := KernelObject( beta );;
IsBijectiveObject( obj1 );
#! false
IsInjective( obj1 );
#! true
IsBijectiveObject( obj2 );
#! false
IsProjective( obj2 );
#! true
#! @EndExample
