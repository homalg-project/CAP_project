#! @Chapter Examples and Tests

#! @Section Opposite category

#! @Example

LoadPackage( "Toposes", false );
#! true
LoadPackage( "FinSetsForCAP", ">= 2021.12-09", false );
#! true

op := Opposite( SkeletalFinSets );;
ListKnownCategoricalProperties( op );
#! [ "IsCartesianCategory", "IsCocartesianCategory",
#!   "IsEquippedWithHomomorphismStructure", "IsSkeletalCategory" ]

#! @EndExample
