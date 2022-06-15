#! @Chunk TerminalCategoryWithMultipleObjects

LoadPackage( "MonoidalCategories" );

#! @Example
T := TerminalCategoryWithMultipleObjects( );
#! TerminalCategoryWithMultipleObjects
InfoOfInstalledOperationsOfCategory( T );
#! 54 primitive operations were used to derive 205 operations for this category
#! which constructively
#! * IsEquippedWithHomomorphismStructure
#! * IsLinearCategoryOverCommutativeRing
#! * IsRigidSymmetricClosedMonoidalCategory
#! * IsRigidSymmetricCoclosedMonoidalCategory
a := "a" / T;
#! <An object in TerminalCategoryWithMultipleObjects>
Display( a );
#! a
IsWellDefined( a );
#! true
aa := ObjectConstructor( T, "a" );
#! <An object in TerminalCategoryWithMultipleObjects>
Display( aa );
#! a
a = aa;
#! true
b := "b" / T;
#! <An object in TerminalCategoryWithMultipleObjects>
Display( b );
#! b
a = b;
#! false
t := TensorProduct( a, b );
#! <An object in TerminalCategoryWithMultipleObjects>
Display( t );
#! TensorProductOnObjects
a = t;
#! false
TensorProduct( a, a ) = t;
#! true
m := MorphismConstructor( a, "m", b );
#! <A morphism in TerminalCategoryWithMultipleObjects>
Display( m );
#! a
#! |
#! | m
#! v
#! b
IsWellDefined( m );
#! true
n := MorphismConstructor( a, "n", b );
#! <A morphism in TerminalCategoryWithMultipleObjects>
Display( n );
#! a
#! |
#! | n
#! v
#! b
IsEqualForMorphisms( m, n );
#! false
IsCongruentForMorphisms( m, n );
#! true
m = n;
#! true
id := IdentityMorphism( a );
#! <An identity morphism in TerminalCategoryWithMultipleObjects>
Display( id );
#! a
#! |
#! | IdentityMorphism
#! v
#! a
m = id;
#! false
id = MorphismConstructor( a, "xyz", a );
#! true
z := ZeroMorphism( a, a );
#! <A zero morphism in TerminalCategoryWithMultipleObjects>
Display( z );
#! a
#! |
#! | ZeroMorphism
#! v
#! a
id = z;
#! true
#! @EndExample
