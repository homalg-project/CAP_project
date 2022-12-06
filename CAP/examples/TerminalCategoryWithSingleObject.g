#! @Chapter Examples and Tests

#! @Section Terminal category

#! @Example
LoadPackage( "MonoidalCategories" );
#! true
T := TerminalCategoryWithSingleObject( );
#! TerminalCategoryWithSingleObject( )
Display( T );
#! A CAP category with name TerminalCategoryWithSingleObject( ):
#! 
#! 63 primitive operations were used to derive 280 operations for this category
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
#! * IsSkeletalCategory
#! * IsStrictMonoidalCategory
#! * IsTerminalCategory
i := InitialObject( T );
#! <A zero object in TerminalCategoryWithSingleObject( )>
t := TerminalObject( T );
#! <A zero object in TerminalCategoryWithSingleObject( )>
z := ZeroObject( T );
#! <A zero object in TerminalCategoryWithSingleObject( )>
Display( i );
#! A zero object in TerminalCategoryWithSingleObject( ).
Display( t );
#! A zero object in TerminalCategoryWithSingleObject( ).
Display( z );
#! A zero object in TerminalCategoryWithSingleObject( ).
IsIdenticalObj( i, z );
#! true
IsIdenticalObj( t, z );
#! true
IsWellDefined( z );
#! true
id_z := IdentityMorphism( z );
#! <A zero, identity morphism in TerminalCategoryWithSingleObject( )>
fn_z := ZeroObjectFunctorial( T );
#! <A zero, identity morphism in TerminalCategoryWithSingleObject( )>
IsWellDefined( fn_z );
#! true
IsEqualForMorphisms( id_z, fn_z );
#! true
IsCongruentForMorphisms( id_z, fn_z );
#! true
IsLiftable( id_z, fn_z );
#! true
Lift( id_z, fn_z );
#! <A zero, identity morphism in TerminalCategoryWithSingleObject( )>
IsColiftable( id_z, fn_z );
#! true
Colift( id_z, fn_z );
#! <A zero, identity morphism in TerminalCategoryWithSingleObject( )>
#! @EndExample
