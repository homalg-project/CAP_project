#! @Chunk Quickstart_Associator_D8

LoadPackage( "GroupRepresentationsForCAP" );

#! @Example
G := DihedralGroup( 8 );;
ComputeAssociator( G, true, true, false );;
path := Filename( DirectoryTemporary( ), "D8" );;
WriteAssociatorComputationToFiles( path );
#! @EndExample


