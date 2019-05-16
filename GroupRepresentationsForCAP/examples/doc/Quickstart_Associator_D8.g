#! @Chunk Quickstart_Associator_D8

LoadPackage( "GroupRepresentationsForCAP" );

#! @Example
G := DihedralGroup( 8 );;
ComputeAssociator( G, true, true, false );;
path := Concatenation(
  PackageInfo( "GroupRepresentationsForCAP" )[1].InstallationPath,
  "/examples/doc/D8" );;
WriteAssociatorComputationToFiles( path );
#! @EndExample


