# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

####################################
## Final derived methods
####################################

## Final methods for Dual
AddFinalDerivationBundle( # IsomorphismFromDualObjectToInternalHomIntoTensorUnit,
                    [ [ IdentityMorphism, 1 ],
                      [ InternalHomOnObjects, 1 ],
                      [ TensorUnit, 1 ] ],
                    [ DualOnObjects,
                      DualOnMorphismsWithGivenDuals,
                      MorphismToBidualWithGivenBidual,
                      IsomorphismFromDualObjectToInternalHomIntoTensorUnit,
                      IsomorphismFromInternalHomIntoTensorUnitToDualObject,
                      UniversalPropertyOfDual,
                      TensorProductDualityCompatibilityMorphismWithGivenObjects,
                      EvaluationForDualWithGivenTensorProduct,
                      MorphismFromTensorProductToInternalHomWithGivenObjects ],
[
  IsomorphismFromDualObjectToInternalHomIntoTensorUnit,
  function( cat, object )
    
    return IdentityMorphism( cat, InternalHomOnObjects( cat, object, TensorUnit( cat ) ) );
    
  end
],
[
  IsomorphismFromInternalHomIntoTensorUnitToDualObject,
  function( cat, object )
    
    return IdentityMorphism( cat, InternalHomOnObjects( cat, object, TensorUnit( cat ) ) );
    
  end
] : CategoryFilter := IsClosedMonoidalCategory,
      Description := "IsomorphismFromDualObjectToInternalHomIntoTensorUnit and its inverse as the identity of Hom(a,1)" );
