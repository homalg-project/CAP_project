## Reproduce an associator computation using the *Key.g and *Reps.g file
LoadPackage( "GroupRepresentationsForCAP" );

log_list := ReadRepresentationsData( "S3Key.g", "S3Reps.g" );

log_list := SkeletalFunctorTensorData( log_list );

associator := AssociatorForSufficientlyManyTriples( log_list, true );

G := SymmetricGroup( 3 );

associator2 := ComputeAssociator( G, true, true );

associator = associator2;
#! true
