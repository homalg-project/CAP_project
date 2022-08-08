#! @Chunk InitialCategory

LoadPackage( "CartesianCategories" );

#! @Example
I := InitialCategory( );
#! InitialCategory( )
IsInitialCategory( I );
#! true
InfoOfInstalledOperationsOfCategory( I );
#! 5 primitive operations were used to derive 11 operations for this category
OI := Opposite( I );
#! Opposite of InitialCategory( )
IsInitialCategory( OI );
#! true
InfoOfInstalledOperationsOfCategory( OI );
#! 15 primitive operations were used to derive 15 operations for this category
#! @EndExample
