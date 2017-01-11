#! @System Quickstart_Associator_D8

LoadPackage( "GroupRepresentationsForCAP" );

#! @Example
G := DihedralGroup( 8 );;
ComputeAssociator( G, true, true, false );;
WriteAssociatorComputationToFiles( "D8" );
#! @EndExample


