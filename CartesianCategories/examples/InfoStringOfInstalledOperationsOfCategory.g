#! @Chapter Examples and Tests

#! @Section InfoOfInstalledOperationsOfCategory

#! @Example

LoadPackage( "CartesianCategories", false );
#! true

distributive := DummyCategory( rec(
  list_of_operations_to_install :=
    Concatenation(
      CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianClosedCategory,
      CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory  ),
  properties := [ "IsCartesianClosedCategory", "IsCocartesianCategory",
                  "IsSkeletalCategory" ] ) );;

InfoOfInstalledOperationsOfCategory( distributive );
#! 19 primitive operations were used to derive 107 operations for this category
#! which algorithmically
#! * IsBicartesianClosedCategory
#! and furthermore mathematically
#! * IsDistributiveCategory (but not yet algorithmically)
#! * IsSkeletalCategory

#! @EndExample
