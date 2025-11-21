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
#! 5 primitive operations were used to derive 14 operations for this category \
#! which not yet algorithmically
#! * IsEquippedWithHomomorphismStructure
#! and furthermore mathematically
#! * IsInitialCategory
OI := Opposite( I );
#! Opposite( InitialCategory( ) )
IsInitialCategory( OI );
#! true
Display( OI );
#! A CAP category with name Opposite( InitialCategory( ) ):
#! 
#! 18 primitive operations were used to derive 18 operations for this category \
#! which not yet algorithmically
#! * IsEquippedWithHomomorphismStructure
#! and furthermore mathematically
#! * IsInitialCategory
#! @EndExample
