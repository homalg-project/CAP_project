#! @Chapter Examples and Tests

#! @Section Opposite category

#! @Example

LoadPackage( "Toposes", false );
#! true
LoadPackage( "FinSetsForCAP", false );
#! true

op := Opposite( SkeletalFinSets );;
ListKnownCategoricalProperties( op );
#! [ "IsCartesianCategory", "IsCocartesianCategory", "IsSkeletalCategory" ]

#! @EndExample
