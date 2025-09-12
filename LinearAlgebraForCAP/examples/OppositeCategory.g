#! @Chapter Examples and Tests

#! @Section Opposite category

#! @Example
LoadPackage( "LinearAlgebraForCAP", ">= 2024.01-04", false );
#! true
QQ := HomalgFieldOfRationals();;
vec := MatrixCategory( QQ );;
op := Opposite( vec );;
Perform( ListKnownCategoricalProperties( op ), Display );
#! IsAbCategory
#! IsAbelianCategory
#! IsAbelianCategoryWithEnoughInjectives
#! IsAbelianCategoryWithEnoughProjectives
#! IsAdditiveCategory
#! IsAdditiveMonoidalCategory
#! IsBraidedMonoidalCategory
#! IsCategoryWithCoequalizers
#! IsCategoryWithCokernels
#! IsCategoryWithEqualizers
#! IsCategoryWithInitialObject
#! IsCategoryWithKernels
#! IsCategoryWithTerminalObject
#! IsCategoryWithZeroObject
#! IsClosedMonoidalCategory
#! IsCoclosedMonoidalCategory
#! IsEnrichedOverCommutativeRegularSemigroup
#! IsEquippedWithHomomorphismStructure
#! IsLinearCategoryOverCommutativeRing
#! IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
#! IsMonoidalCategory
#! IsPreAbelianCategory
#! IsRigidSymmetricClosedMonoidalCategory
#! IsRigidSymmetricCoclosedMonoidalCategory
#! IsSkeletalCategory
#! IsStrictMonoidalCategory
#! IsSymmetricClosedMonoidalCategory
#! IsSymmetricCoclosedMonoidalCategory
#! IsSymmetricMonoidalCategory
V1 := Opposite( TensorUnit( vec ) );;
V2 := DirectSum( V1, V1 );;
V3 := DirectSum( V1, V2 );;
V4 := DirectSum( V1, V3 );;
V5 := DirectSum( V1, V4 );;
IsWellDefined( MorphismBetweenDirectSums( op, [ ], [ ], [ V1 ] ) );
#! true
IsWellDefined( MorphismBetweenDirectSums( op, [ V1 ], [ [ ] ], [ ] ) );
#! true
alpha13 := InjectionOfCofactorOfDirectSum( [ V1, V2 ], 1 );;
alpha14 := InjectionOfCofactorOfDirectSum( [ V1, V2, V1 ], 3 );;
alpha15 := InjectionOfCofactorOfDirectSum( [ V2, V1, V2 ], 2 );;
alpha23 := InjectionOfCofactorOfDirectSum( [ V2, V1 ], 1 );;
alpha24 := InjectionOfCofactorOfDirectSum( [ V1, V2, V1 ], 2 );;
alpha25 := InjectionOfCofactorOfDirectSum( [ V2, V2, V1 ], 1 );;
mat := [
    [ alpha13, alpha14, alpha15 ],
    [ alpha23, alpha24, alpha25 ]
];;
mor := MorphismBetweenDirectSums( mat );;
IsWellDefined( mor );
#! true
IsWellDefined( Opposite( mor ) );
#! true
IsCongruentForMorphisms(
    UniversalMorphismFromImage( mor, [ CoastrictionToImage( mor ), ImageEmbedding( mor ) ] ),
    IdentityMorphism( ImageObject( mor ) )
);
#! true
#! @EndExample
