LoadPackage( "ActionsForCAP" );

G := SymmetricGroup( 3 );

## 1. boolean: true = use Dixon; false = use IrreducibleAffordingRepresentation
## 2. boolean: true = associator for all triples, false = for sufficiently many
ComputeAssociator( G, true, true );

WriteAssociatorComputationToFiles( "S3" );