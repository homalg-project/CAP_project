#! @Chunk InitialCategory

LoadPackage( "CartesianCategories" );

#! @Example
I := InitialCategory( );
#! InitialCategory( )
IsInitialCategory( I );
#! true
InfoOfInstalledOperationsOfCategory( I );
#! 5 primitive operations were used to derive 13 operations for this category which mathematically
#! * IsInitialCategory
OI := Opposite( I );
#! Opposite( InitialCategory( ) )
IsInitialCategory( OI );
#! true
InfoOfInstalledOperationsOfCategory( OI );
#! 17 primitive operations were used to derive 17 operations for this category which mathematically
#! * IsInitialCategory
#! @EndExample
