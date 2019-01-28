####################################
## Final derived methods
####################################

## Final methods for Dual
AddFinalDerivation( IsomorphismFromDualToInternalHom,
                    [ [ IdentityMorphism, 1 ],
                      [ InternalHomOnObjects, 1 ],
                      [ TensorUnit, 1 ] ],
                    [ DualOnObjects,
                      DualOnMorphismsWithGivenDuals,
                      MorphismToBidualWithGivenBidual,
                      IsomorphismFromDualToInternalHom,
                      IsomorphismFromInternalHomToDual,
                      UniversalPropertyOfDual,
                      TensorProductDualityCompatibilityMorphismWithGivenObjects,
                      EvaluationForDualWithGivenTensorProduct,
                      MorphismFromTensorProductToInternalHomWithGivenObjects ],
                 
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return IdentityMorphism( InternalHomOnObjects( object, TensorUnit( category ) ) );
    
end : CategoryFilter := IsClosedMonoidalCategory,
      Description := "IsomorphismFromDualToInternalHom as the identity of Hom(a,1)" );

AddFinalDerivation( IsomorphismFromInternalHomToDual,
                    [ [ IdentityMorphism, 1 ],
                      [ InternalHomOnObjects, 1 ],
                      [ TensorUnit, 1 ] ],
                    [ DualOnObjects,
                      DualOnMorphismsWithGivenDuals,
                      MorphismToBidualWithGivenBidual,
                      IsomorphismFromDualToInternalHom,
                      IsomorphismFromInternalHomToDual,
                      UniversalPropertyOfDual,
                      TensorProductDualityCompatibilityMorphismWithGivenObjects,
                      EvaluationForDualWithGivenTensorProduct,
                      MorphismFromTensorProductToInternalHomWithGivenObjects ],
                 
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return IdentityMorphism( InternalHomOnObjects( object, TensorUnit( category ) ) );
    
end : CategoryFilter := IsClosedMonoidalCategory,
      Description := "IsomorphismFromInternalHomToDual as the identity of Hom(a,1)" );
