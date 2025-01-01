#! @Chapter Examples and Tests

#! @Section Terminal category

#! @Example
LoadPackage( "CAP", false );
#! true
T := TerminalCategoryWithMultipleObjects( );
#! TerminalCategoryWithMultipleObjects( )
i := InitialObject( T );
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
t := TerminalObject( T );
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
z := ZeroObject( T );
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
Display( i );
#! InitialObject(  )
Display( t );
#! TerminalObject(  )
Display( z );
#! ZeroObject(  )
IsIdenticalObj( i, z );
#! false
IsIdenticalObj( t, z );
#! false
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
IsEqualForObjects( a, aa );
#! true
IsIsomorphicForObjects( a, aa );
#! true
IsIsomorphism( SomeIsomorphismBetweenObjects( a, aa ) );
#! true
b := "b" / T;
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
Display( b );
#! b
IsEqualForObjects( a, b );
#! false
IsIsomorphicForObjects( a, b );
#! true
mor_ab := SomeIsomorphismBetweenObjects( a, b );
#! <A zero, isomorphism in TerminalCategoryWithMultipleObjects( )>
IsIsomorphism( mor_ab );
#! true
Display( mor_ab );
#! a
#! |
#! | SomeIsomorphismBetweenObjects
#! v
#! b
Hom_ab := MorphismsOfExternalHom( a, b );;
Length( Hom_ab );
#! 1
Hom_ab[1];
#! <A zero, isomorphism in TerminalCategoryWithMultipleObjects( )>
Display( Hom_ab[1] );
#! a
#! |
#! | InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism
#! v
#! b
Hom_ab[1] = mor_ab;
#! true
HomStructure( mor_ab );
#! <A zero, identity morphism in TerminalCategoryWithSingleObject( )>
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
hom_mn := HomStructure( m, n );
#! <A zero, identity morphism in TerminalCategoryWithSingleObject( )>
id := IdentityMorphism( a );
#! <A zero, identity morphism in TerminalCategoryWithMultipleObjects( )>
Display( id );
#! a
#! |
#! | IdentityMorphism( a )
#! v
#! a
m = id;
#! false
id = MorphismConstructor( a, "xyz", a );
#! true
zero := ZeroMorphism( a, a );
#! <A zero, isomorphism in TerminalCategoryWithMultipleObjects( )>
Display( zero );
#! a
#! |
#! | ZeroMorphism( a, a )
#! v
#! a
id = zero;
#! true
IsLiftable( m, n );
#! true
lift := Lift( m, n );
#! <A zero, isomorphism in TerminalCategoryWithMultipleObjects( )>
Display( lift );
#! a
#! |
#! | Lift( m, n )
#! v
#! a
IsColiftable( m, n );
#! true
colift := Colift( m, n );
#! <A zero, isomorphism in TerminalCategoryWithMultipleObjects( )>
Display( colift );
#! b
#! |
#! | Colift( m, n )
#! v
#! b
DirectProduct( T, [ ] );
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
Equalizer( T, z, [ ] );
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
Coproduct( T, [ ] );
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
Coequalizer( T, z, [ ] );
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
#! @EndExample
