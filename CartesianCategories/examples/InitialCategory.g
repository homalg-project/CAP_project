#! @Chunk InitialCategory

LoadPackage( "CartesianCategories" );

#! @Example
I := InitialCategory( );
#! InitialCategory( )
IsInitialCategory( I );
#! true
Display( I );
#! A CAP category with name InitialCategory( ):
#! 
#! 5 primitive operations were used to derive 13 operations for this category
#! which mathematically
#! * IsInitialCategory
OI := Opposite( I );
#! Opposite( InitialCategory( ) )
IsInitialCategory( OI );
#! true
Display( OI );
#! A CAP category with name Opposite( InitialCategory( ) ):
#! 
#! 17 primitive operations were used to derive 17 operations for this category
#! which mathematically
#! * IsInitialCategory
#! @EndExample
