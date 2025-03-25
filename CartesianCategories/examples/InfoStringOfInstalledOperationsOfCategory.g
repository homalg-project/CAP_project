#! @Chapter Examples and Tests

#! @Section InfoOfInstalledOperationsOfCategory

#! @Example

LoadPackage( "CartesianCategories", false );
#! true

distributive := DummyCategory( rec(
  list_of_operations_to_install :=
    ListOfDefiningOperations( "IsBicartesianClosedCategory" ),
  properties := [ "IsBicartesianClosedCategory", "IsSkeletalCategory" ] ) );;

InfoOfInstalledOperationsOfCategory( distributive );
#! 21 primitive operations were used to derive 121 operations for this category \
#! which algorithmically
#! * IsBicartesianClosedCategory
#! and not yet algorithmically
#! * IsDistributiveCategory
#! and furthermore mathematically
#! * IsSkeletalCategory

#! @EndExample
