# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

####################################
## Final derived methods
####################################

## Final methods for CoDual
AddFinalDerivationBundle( # IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit,
                    [ [ IdentityMorphism, 1 ],
                      [ InternalCoHomOnObjects, 1 ],
                      [ TensorUnit, 1 ] ],
                    [ CoDualOnObjects,
                      CoDualOnMorphismsWithGivenCoDuals,
                      MorphismFromCoBidualWithGivenCoBidual,
                      IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit,
                      IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject,
                      UniversalPropertyOfCoDual,
                      CoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                      CoclosedEvaluationForCoDualWithGivenTensorProduct,
                      MorphismFromInternalCoHomToTensorProductWithGivenObjects
                      ],
[
  IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit,
  [ [ IdentityMorphism, 1 ],
    [ InternalCoHomOnObjects, 1 ],
    [ TensorUnit, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, InternalCoHomOnObjects( cat, TensorUnit( cat ), object ) );
    
  end
],
[
  IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject,
  [ [ IdentityMorphism, 1 ],
    [ InternalCoHomOnObjects, 1 ],
    [ TensorUnit, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, InternalCoHomOnObjects( cat, TensorUnit( cat ), object ) );
    
  end
] : CategoryFilter := IsCoclosedMonoidalCategory,
      Description := "IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit as the identity of coHom(1,a)" );
