#! @Chapter Examples and Tests

#! @Section Testing if an object is projective, injective, bijective, and computing projective/injective dimensions

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );

#! @Example
R := HomalgRingOfIntegers();;
rows := CategoryOfRows( R );;
adelman := AdelmanCategory( rows );;
rowobj := CategoryOfRowsObject( 1, rows );;
alpha := ProjectionInFactorOfDirectSum( [ rowobj, rowobj ], 1 );;
alpha := AsAdelmanCategoryMorphism( alpha );;
obj := CokernelObject( alpha );;
IsBijectiveObject( obj );
#! true
beta := 2 * IdentityMorphism( rowobj );;
beta := AsAdelmanCategoryMorphism( beta );;
obj1 := CokernelObject( beta );;
obj2 := KernelObject( beta );;
obj3 := ImageObject( beta );;
obj4 := HomologyObject( beta, beta );;
IsBijectiveObject( obj1 );
#! false
IsInjective( obj1 );
#! true
ProjectiveDimension( obj1 );
#! 2
IsBijectiveObject( obj2 );
#! false
IsProjective( obj2 );
#! true
InjectiveDimension( obj2 );
#! 2
ProjectiveDimension( obj3 );
#! 1
InjectiveDimension( obj3 );
#! 1
ProjectiveDimension( obj4 );
#! 2
InjectiveDimension( obj4 );
#! 2
#! @EndExample
