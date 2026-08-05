#! @Chapter Examples and Tests

#! @Section Finite skeletal discrete categories

#! @Example
LoadPackage( "CAP", false );
#! true

# Set 'overhead := false' so that the actual function installed
# for IsEqualForMorphisms is executed in the CI and not just
# its redirect function.
D := FiniteSkeletalDiscreteCategory( 5 : overhead := false );
#! FiniteSkeletalDiscreteCategory( 5 )

one := ObjectConstructor( D, 1 );
#! <An object in FiniteSkeletalDiscreteCategory( 5 )>
IsWellDefinedForObjects( one );
#! true
ObjectDatum( one ) = 1;
#! true
Display( one );
#! 1
IsEqualForObjects( one, D[1] );
#! true
id_one := IdentityMorphism( D, one );
#! <A morphism in FiniteSkeletalDiscreteCategory( 5 )>
IsWellDefinedForMorphisms( id_one );
#! true
MorphismDatum( id_one ) = fail;
#! true
Display( id_one );
#! 1
#! |
#! | A morphism in FiniteSkeletalDiscreteCategory( 5 )
#! v
#! 1
IsEqualForMorphisms( PreCompose( id_one, id_one ), id_one );
#! true
Length( SetOfObjectsOfCategory( D ) );
#! 5
Length( SetOfMorphismsOfFiniteCategory( D ) );
#! 5
#! @EndExample
