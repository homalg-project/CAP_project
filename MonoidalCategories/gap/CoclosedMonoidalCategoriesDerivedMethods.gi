####################################
## Final derived methods
####################################

## Final methods for CoDual
AddFinalDerivation( IsomorphismFromCoDualToInternalCoHom,
                    [ [ IdentityMorphism, 1 ],
                      [ InternalCoHomOnObjects, 1 ],
                      [ TensorUnit, 1 ] ],
                    [ CoDualOnObjects,
                      CoDualOnMorphismsWithGivenCoDuals,
                      MorphismFromCoBidualWithGivenCoBidual,
                      IsomorphismFromCoDualToInternalCoHom,
                      IsomorphismFromInternalCoHomToCoDual,
                      UniversalPropertyOfCoDual,
                      CoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                      CoEvaluationForCoDualWithGivenTensorProduct,
                      MorphismFromInternalCoHomToTensorProductWithGivenObjects
                      ],
  function( object )
    local category;

    category := CapCategory( object );

    return IdentityMorphism( InternalCoHomOnObjects( TensorUnit( category ), object ) );

end : CategoryFilter := IsCoclosedMonoidalCategory,
      Description := "IsomorphismFromCoDualToInternalCoHom as the identity of coHom(1,a)" );

AddFinalDerivation( IsomorphismFromInternalCoHomToCoDual,
                    [ [ IdentityMorphism, 1 ],
                      [ InternalCoHomOnObjects, 1 ],
                      [ TensorUnit, 1 ] ],
                    [ CoDualOnObjects,
                      CoDualOnMorphismsWithGivenCoDuals,
                      MorphismFromCoBidualWithGivenCoBidual,
                      IsomorphismFromCoDualToInternalCoHom,
                      IsomorphismFromInternalCoHomToCoDual,
                      UniversalPropertyOfCoDual,
                      CoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                      CoEvaluationForCoDualWithGivenTensorProduct,
                      MorphismFromInternalCoHomToTensorProductWithGivenObjects
                      ],

  function( object )
    local category;

    category := CapCategory( object );

    return IdentityMorphism( InternalCoHomOnObjects( TensorUnit( category ), object ) );

end : CategoryFilter := IsCoclosedMonoidalCategory,
      Description := "IsomorphismFromInternalCoHomToCoDual as the identity of coHom(1,a)" );
