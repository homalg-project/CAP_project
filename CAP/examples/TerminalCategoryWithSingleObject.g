#! @Chapter Examples and Tests

#! @Section Terminal category

#! @Example
LoadPackage( "MonoidalCategories", ">= 2024.06-02", false );
#! true
T := TerminalCategoryWithSingleObject( );
#! TerminalCategoryWithSingleObject( )
Display( T );
#! A CAP category with name TerminalCategoryWithSingleObject( ):
#! 
#! 80 primitive operations were used to derive 388 operations for this category \
#! which algorithmically
#! * IsCategoryWithDecidableColifts
#! * IsCategoryWithDecidableLifts
#! * IsEquippedWithHomomorphismStructure
#! * IsLinearCategoryOverCommutativeRing
#! * IsLeftClosedMonoidalCategory
#! * IsLeftCoclosedMonoidalCategory
#! * IsRigidSymmetricClosedMonoidalCategory
#! * IsRigidSymmetricCoclosedMonoidalCategory
#! * IsAbelianCategoryWithEnoughInjectives
#! * IsAbelianCategoryWithEnoughProjectives
#! and not yet algorithmically
#! * IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
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
#! false
IsIdenticalObj( t, z );
#! false
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
DirectProduct( T, [ ] );
#! <A zero object in TerminalCategoryWithSingleObject( )>
Equalizer( T, z, [ ] );
#! <A zero object in TerminalCategoryWithSingleObject( )>
Coproduct( T, [ ] );
#! <A zero object in TerminalCategoryWithSingleObject( )>
Coequalizer( T, z, [ ] );
#! <A zero object in TerminalCategoryWithSingleObject( )>
#! @EndExample
