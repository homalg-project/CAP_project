## gapcolor ##
gap> S3_S4 := GroupHomomorphismByImages( S3, S4, GeneratorsOfGroup(S3) );
[ (1,2,3), (1,2) ] -> [ (1,2,3), (1,2) ]
gap> AddMorphism( grps, S3_S4 );
gap> PreCompose( id_S3, S3_S4 );
[ (1,2,3), (1,2) ] -> [ (1,2,3), (1,2) ]
## endgapcolor ##