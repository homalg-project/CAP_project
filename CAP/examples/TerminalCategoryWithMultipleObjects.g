#! @Chapter Examples and Tests

#! @Section Terminal category

#! @Example
LoadPackage( "MonoidalCategories" );
#! true
T := TerminalCategoryWithMultipleObjects( );
#! TerminalCategoryWithMultipleObjects( )
Display( T );
#! A CAP category with name TerminalCategoryWithMultipleObjects( ):
#! 
#! 63 primitive operations were used to derive 306 operations for this category
#! which algorithmically
#! * IsCategoryWithDecidableColifts
#! * IsCategoryWithDecidableLifts
#! * IsEquippedWithHomomorphismStructure
#! * IsLinearCategoryOverCommutativeRing
#! * IsAbelianCategoryWithEnoughInjectives
#! * IsAbelianCategoryWithEnoughProjectives
#! * IsRigidSymmetricClosedMonoidalCategory
#! * IsRigidSymmetricCoclosedMonoidalCategory
#! and furthermore mathematically
#! * IsLocallyOfFiniteInjectiveDimension
#! * IsLocallyOfFiniteProjectiveDimension
#! * IsTerminalCategory
i := InitialObject( T );
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
t := TerminalObject( T );
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
z := ZeroObject( T );
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
Display( i );
#! ZeroObject
Display( t );
#! ZeroObject
Display( z );
#! ZeroObject
IsIdenticalObj( i, z );
#! true
IsIdenticalObj( t, z );
#! true
id_z := IdentityMorphism( z );
#! <A zero, identity morphism in TerminalCategoryWithMultipleObjects( )>
fn_z := ZeroObjectFunctorial( T );
#! <A zero, isomorphism in TerminalCategoryWithMultipleObjects( )>
IsEqualForMorphisms( id_z, fn_z );
#! false
IsCongruentForMorphisms( id_z, fn_z );
#! true
a := "a" / T;
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
Display( a );
#! a
IsWellDefined( a );
#! true
aa := ObjectConstructor( T, "a" );
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
Display( aa );
#! a
a = aa;
#! true
b := "b" / T;
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
Display( b );
#! b
a = b;
#! false
t := TensorProduct( a, b );
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
Display( t );
#! TensorProductOnObjects
a = t;
#! false
TensorProduct( a, a ) = t;
#! true
m := MorphismConstructor( a, "m", b );
#! <A zero, isomorphism in TerminalCategoryWithMultipleObjects( )>
Display( m );
#! a
#! |
#! | m
#! v
#! b
IsWellDefined( m );
#! true
n := MorphismConstructor( a, "n", b );
#! <A zero, isomorphism in TerminalCategoryWithMultipleObjects( )>
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
#! <A zero, identity morphism in TerminalCategoryWithMultipleObjects( )>
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
#! <A zero, isomorphism in TerminalCategoryWithMultipleObjects( )>
Display( z );
#! a
#! |
#! | ZeroMorphism
#! v
#! a
id = z;
#! true
IsLiftable( m, n );
#! true
lift := Lift( m, n );
#! <A zero, isomorphism in TerminalCategoryWithMultipleObjects( )>
Display( lift );
#! a
#! |
#! | Lift
#! v
#! a
IsColiftable( m, n );
#! true
colift := Colift( m, n );
#! <A zero, isomorphism in TerminalCategoryWithMultipleObjects( )>
Display( colift );
#! b
#! |
#! | Colift
#! v
#! b
#! @EndExample
