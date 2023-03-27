#! @Chapter Examples and Tests

#! @Section WrapperCategory

#! @Example

LoadPackage( "LinearAlgebraForCAP", false );
#! true
Q := HomalgFieldOfRationals( );
#! Q
Qmat := MATRIX_CATEGORY( Q );
#! Category of matrices over Q
Wrapper := WrapperCategory( Qmat, rec( ) );
#! WrapperCategory( Category of matrices over Q )
mor := ZeroMorphism( ZeroObject( Wrapper ), ZeroObject( Wrapper ) );;
2 * mor;;
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

Qmat2 := MATRIX_CATEGORY( Q );
#! Category of matrices over Q
Wrapper2 := WrapperCategory( Qmat2, rec( wrap_range_of_hom_structure := true ) );
#! WrapperCategory( Category of matrices over Q )
mor := ZeroMorphism( ZeroObject( Wrapper2 ), ZeroObject( Wrapper2 ) );;
distinguished_object := DistinguishedObjectOfHomomorphismStructure( Wrapper2 );;
object := HomomorphismStructureOnObjects( Source( mor ), Source( mor ) );;
HomomorphismStructureOnMorphisms( mor, mor );;
HomomorphismStructureOnMorphismsWithGivenObjects( object, mor, mor, object );;
iota := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( mor );;
InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( distinguished_object, mor, object );;
beta := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( mor ), Range( mor ), iota );;
IsCongruentForMorphisms( mor, beta );
#! true

#! @EndExample
