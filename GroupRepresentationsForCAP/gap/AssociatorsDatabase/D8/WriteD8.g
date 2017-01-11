LoadPackage( "GroupRepresentationsForCAP" );
G := DihedralGroup( 8 );
ComputeAssociator( G, true, true, false );
WriteAssociatorComputationToFiles( "D8" );



