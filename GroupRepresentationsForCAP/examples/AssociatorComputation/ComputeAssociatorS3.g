LoadPackage( "GroupRepresentationsForCAP" );

G := SymmetricGroup( 3 );

log_list := InitializeGroupDataDixon( G );

log_list := SkeletalFunctorTensorData( log_list );
