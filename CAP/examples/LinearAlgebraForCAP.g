#! @Chunk LinearAlgebraForCAP

#! @Example

LoadPackage( "WrapperCategories", false );
#! true
LoadPackage( "LinearAlgebraForCAP", false );
#! true
Q := HomalgFieldOfRationals( );
#! Q
Qmat := MatrixCategory( Q );
#! Category of matrices over Q
Wrapper := WrapperCategory( Qmat, rec( ) );
#! WrapperCategory( Category of matrices over Q )
mor := ZeroMorphism( ZeroObject( Wrapper ), ZeroObject( Wrapper ) );;
2 * mor;;
BasisOfExternalHom( Source( mor ), Range( mor ) );;
CoefficientsOfMorphism( mor );;
DistinguishedObjectOfHomomorphismStructure( Wrapper );;
HomomorphismStructureOnObjects( Source( mor ), Source( mor ) );;
HomomorphismStructureOnMorphisms( mor, mor );;
iota := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( mor );;
beta := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( mor ), Range( mor ), iota );;
IsCongruentForMorphisms( mor, beta );
#! true

Wrapper2 := WrapperCategory( Qmat, rec( wrap_range_of_hom_structure := true ) );
#! WrapperCategory( Category of matrices over Q )
mor := ZeroMorphism( ZeroObject( Wrapper2 ), ZeroObject( Wrapper2 ) );;
DistinguishedObjectOfHomomorphismStructure( Wrapper2 );;
HomomorphismStructureOnObjects( Source( mor ), Source( mor ) );;
HomomorphismStructureOnMorphisms( mor, mor );;
iota := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( mor );;
beta := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( mor ), Range( mor ), iota );;
IsCongruentForMorphisms( mor, beta );
#! true

#! @EndExample
