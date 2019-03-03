##
AddDerivationToCAP( InternalCoHomOnObjects,
                  
  function( object_1, object_2 )
    
    return Source( IsomorphismFromInternalCoHomToTensorProduct( object_1, object_2 ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomOnObjects as the source of IsomorphismFromInternalCoHomToTensorProduct" );

##
AddDerivationToCAP( InternalCoHomOnObjects,
                  
  function( object_1, object_2 )
    
    return Range( IsomorphismFromTensorProductToInternalCoHom( object_1, object_2 ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalCoHomOnObjects as the range of IsomorphismFromTensorProductToInternalCoHom" );

##
AddDerivationToCAP( InternalCoHomOnMorphismsWithGivenInternalCoHoms,
                  
  function( internal_cohom_source, morphism_1, morphism_2, internal_cohom_range )
    local codual_morphism;
    
    codual_morphism := CoDualOnMorphisms( morphism_2 );
    
    return PreCompose( [
             IsomorphismFromInternalCoHomToTensorProduct( Source( morphism_1 ), Range( morphism_2 ) ),
             TensorProductOnMorphisms( morphism_1, codual_morphism ),
             IsomorphismFromTensorProductToInternalCoHom( Range( morphism_1 ), Source( morphism_2 ) ) 
           ] );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomOnMorphismsWithGivenInternalCoHoms using functoriality of CoDual and TensorProduct" );
