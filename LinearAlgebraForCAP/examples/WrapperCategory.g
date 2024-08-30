#! @Chapter Examples and Tests

#! @Section WrapperCategory

#! @Example

LoadPackage( "LinearAlgebraForCAP", false );
#! true
Q := HomalgFieldOfRationals( );;
Qmat := MatrixCategory( Q );
#! Category of matrices over Q
Wrapper := WrapperCategory( Qmat, rec( ) );
#! WrapperCategory( Category of matrices over Q )
mor := ZeroMorphism( ZeroObject( Wrapper ), ZeroObject( Wrapper ) );;
(2 / Q) * mor;;
BasisOfExternalHom( Source( mor ), Range( mor ) );;
CoefficientsOfMorphism( mor );;
distinguished_object := DistinguishedObjectOfHomomorphismStructure( Wrapper );;
object := HomomorphismStructureOnObjects( Source( mor ), Source( mor ) );;
HomomorphismStructureOnMorphisms( mor, mor );;
HomomorphismStructureOnMorphismsWithGivenObjects( object, mor, mor, object );;
iota := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( mor );;
InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( distinguished_object, mor, object );;
beta := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( mor ), Range( mor ), iota );;
IsCongruentForMorphisms( mor, beta );
#! true

#! @EndExample
