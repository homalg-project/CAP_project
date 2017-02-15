## Reproduce an associator computation using the *Key.g and *Dec.g file
LoadPackage( "GroupRepresentationsForCAP" );

log_list := ReadSkeletalFunctorData( "S3Key.g", "S3Dec.g" );

associator := AssociatorForSufficientlyManyTriples( log_list, true );

G := SymmetricGroup( 3 );

associator2 := ComputeAssociator( G, true, true );

associator = associator2;
#! true
