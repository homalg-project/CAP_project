#! @Chapter Examples and Tests

#! @Section Finite skeletal discrete categories

#! @Example
LoadPackage( "CAP", false );
#! true
gap_objects := [ 1 .. 5 ];;
D := FiniteSkeletalDiscreteCategory( gap_objects );
#! FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )
one := ObjectConstructor( D, 1 );
#! <An object in FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )>
IsWellDefinedForObjects( one );
#! true
ObjectDatum( one ) = 1;
#! true
Display( one );
#! 1
IsEqualForObjects( one, one );
#! true
id_one := IdentityMorphism( D, one );
#! <An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )>
IsWellDefinedForMorphisms( id_one );
#! true
MorphismDatum( id_one ) = fail;
#! true
Display( id_one );
#! 1
#! |
#! | A morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )
#! v
#! 1
IsEqualForMorphisms( PreCompose( id_one, id_one ), id_one );
#! true
objs := SetOfObjectsOfCategory( D );
#! [ <An object in FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )>,
#!   <An object in FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )>,
#!   <An object in FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )>,
#!   <An object in FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )>,
#!   <An object in FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )> ]
mors := SetOfMorphismsOfFiniteCategory( D );
#! [ <An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )>,
#!   <An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )>,
#!   <An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )>,
#!   <An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )>,
#!   <An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 5 ] )> ]
#! @EndExample
