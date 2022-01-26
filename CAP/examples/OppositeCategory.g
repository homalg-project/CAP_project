#! @Chapter Examples and Tests

#! @Section Opposite category
LoadPackage( "LinearAlgebraForCAP" );

#! @Example
QQ := HomalgFieldOfRationals();;
vec := MatrixCategory( QQ );;
op := Opposite( vec );;
ListKnownCategoricalProperties( op );
#! [ "IsAbCategory", "IsAbelianCategory", "IsAbelianCategoryWithEnoughInjectives",
#!   "IsAbelianCategoryWithEnoughProjectives", "IsAdditiveCategory",
#!   "IsBraidedMonoidalCategory", "IsClosedMonoidalCategory",
#!   "IsCoclosedMonoidalCategory", "IsEnrichedOverCommutativeRegularSemigroup",
#!   "IsLinearCategoryOverCommutativeRing", "IsMonoidalCategory",
#!   "IsPreAbelianCategory", "IsRigidSymmetricClosedMonoidalCategory",
#!   "IsRigidSymmetricCoclosedMonoidalCategory", "IsSkeletalCategory",
#!   "IsStrictMonoidalCategory", "IsSymmetricClosedMonoidalCategory",
#!   "IsSymmetricCoclosedMonoidalCategory", "IsSymmetricMonoidalCategory" ]
V1 := Opposite( TensorUnit( vec ) );;
V2 := DirectSum( V1, V1 );;
V3 := DirectSum( V1, V2 );;
V4 := DirectSum( V1, V3 );;
V5 := DirectSum( V1, V4 );;
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
IsOne( UniversalMorphismFromImage( mor, [ CoastrictionToImage( mor ), ImageEmbedding( mor ) ] ) );
#! true
#! @EndExample
