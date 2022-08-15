#! @Chunk TerminalCategory

LoadPackage( "MonoidalCategories" );

#! @Example
T := TerminalCategory( );
#! TerminalCategory( )
InfoOfInstalledOperationsOfCategory( T );
#! 68 primitive operations were used to derive 317 operations for this category
#! which constructively
#! * IsEquippedWithHomomorphismStructure
#! * IsLinearCategoryOverCommutativeRing
#! * IsAbelianCategoryWithEnoughInjectives
#! * IsAbelianCategoryWithEnoughProjectives
#! * IsRigidSymmetricClosedMonoidalCategory
#! * IsRigidSymmetricCoclosedMonoidalCategory
i := InitialObject( T );
#! <A zero object in TerminalCategory( )>
t := TerminalObject( T );
#! <A zero object in TerminalCategory( )>
z := ZeroObject( T );
#! <A zero object in TerminalCategory( )>
Display( i );
#! A zero object in TerminalCategory( ).
Display( t );
#! A zero object in TerminalCategory( ).
Display( z );
#! A zero object in TerminalCategory( ).
IsIdenticalObj( i, z );
#! true
IsIdenticalObj( t, z );
#! true
IsWellDefined( z );
#! true
id_z := IdentityMorphism( z );
#! <A zero, identity morphism in TerminalCategory( )>
fn_z := ZeroObjectFunctorial( T );
#! <A zero, isomorphism in TerminalCategory( )>
IsWellDefined( fn_z );
#! true
IsEqualForMorphisms( id_z, fn_z );
#! true
IsCongruentForMorphisms( id_z, fn_z );
#! true
#! @EndExample
