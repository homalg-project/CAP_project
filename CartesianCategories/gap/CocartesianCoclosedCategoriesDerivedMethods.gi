# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



####################################
## Final derived methods
####################################

## Final methods for CocartesianDual
AddFinalDerivationBundle( # IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject,
                    [ [ IdentityMorphism, 1 ],
                      [ CoexponentialOnObjects, 1 ],
                      [ InitialObject, 1 ] ],
                    [ CocartesianDualOnObjects,
                      CocartesianDualOnMorphismsWithGivenCocartesianDuals,
                      MorphismFromCocartesianBidualWithGivenCocartesianBidual,
                      IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject,
                      IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject,
                      UniversalPropertyOfCocartesianDual,
                      CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects,
                      CocartesianEvaluationForCocartesianDualWithGivenCoproduct,
                      MorphismFromCoexponentialToCoproductWithGivenObjects
                      ],
[
  IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject,
  [ [ IdentityMorphism, 1 ],
    [ CoexponentialOnObjects, 1 ],
    [ InitialObject, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, CoexponentialOnObjects( cat, InitialObject( cat ), object ) );
    
  end
],
[
  IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject,
  [ [ IdentityMorphism, 1 ],
    [ CoexponentialOnObjects, 1 ],
    [ InitialObject, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, CoexponentialOnObjects( cat, InitialObject( cat ), object ) );
    
  end
] : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject as the identity of Coexp(1,a)" );
