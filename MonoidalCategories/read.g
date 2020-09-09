#
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Reading the implementation part of the package.
#

## Monoidal
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductAndUnitMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesTensorProductOnObjectsAndUnitObject.gi" );

ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/MonoidalCategories.gi" );

ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategories.gi" );

ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategories.gi" );

## Closed Monoidal
ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategories.gi" );

ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesMethodRecord.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategories.gi" );

## Derived Methods
ReadPackage( "MonoidalCategories", "gap/MonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/AdditiveMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/BraidedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/SymmetricMonoidalCategoriesDerivedMethods.gi" );

ReadPackage( "MonoidalCategories", "gap/ClosedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/SymmetricClosedMonoidalCategoriesDerivedMethods.gi" );
ReadPackage( "MonoidalCategories", "gap/RigidSymmetricClosedMonoidalCategoriesDerivedMethods.gi" );
