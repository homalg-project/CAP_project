#! @Chapter Example on additive closure

#! @Section The category of rows over a Bézout domain is pre-abelian.

#! @Example
LoadPackage( "AdditiveClosuresForCAP", false );
#! true
zz := HomalgRingOfIntegers( );
#! Z
Zmat := CategoryOfRows( zz );
#! Rows( Z )
Display( Zmat );
#! A CAP category with name Rows( Z ):
#! 
#! 83 primitive operations were used to derive 425 operations for this category \
#! which algorithmically
#! * IsEquippedWithHomomorphismStructure
#! * IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
#! * IsPreAbelianCategory
#! * IsRigidSymmetricClosedMonoidalCategory
#! * IsRigidSymmetricCoclosedMonoidalCategory
#! and furthermore mathematically
#! * IsSkeletalCategory
#! * IsStrictMonoidalCategory
mat := HomalgMatrix(
               [ [  -36,   18,  -80,  -54,   28 ],
                 [   90,  -45,  140,   45,  -40 ],
                 [  -24,   12,  -32,   -4,    8 ],
                 [   -6,    3,   -4,    5,    0 ] ], zz );;
mor := mat / Zmat;
#! <A morphism in Rows( Z )>
split_epi := CoimageProjection( mor );
#! <An epimorphism in Rows( Z )>
IsSplitEpimorphism( split_epi );
#! true
split_mono := ImageEmbedding( mor );
#! <A monomorphism in Rows( Z )>
IsSplitMonomorphism( split_mono );
#! true
epimono := MorphismFromCoimageToImage( mor );
#! <A morphism in Rows( Z )>
IsEpimorphism( epimono );
#! true
IsMonomorphism( epimono );
#! true
LiftAlongMonomorphism( split_mono, AstrictionToCoimage( mor ) ) = epimono;
#! true
ColiftAlongEpimorphism( split_epi, CoastrictionToImage( mor ) ) = epimono;
#! true
PreCompose( [ split_epi, epimono, split_mono ] ) = mor;
#! true
#! @EndExample
