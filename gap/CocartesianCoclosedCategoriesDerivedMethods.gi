# THIS FILE WAS AUTOMATICALLY GENERATED
# FROM MonoidalCategories v2021.12-01
# USING CategoryConstructor v2021.12-02

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

####################################
## Final derived methods
####################################

## Final methods for CocartesianDual
AddFinalDerivation( IsomorphismFromCocartesianDualToCoexponential,
                    [ [ IdentityMorphism, 1 ],
                      [ CoexponentialOnObjects, 1 ],
                      [ InitialObject, 1 ] ],
                    [ CocartesianDualOnObjects,
                      CocartesianDualOnMorphismsWithGivenCocartesianDuals,
                      MorphismFromCocartesianBidualWithGivenCocartesianBidual,
                      IsomorphismFromCocartesianDualToCoexponential,
                      IsomorphismFromCoexponentialToCocartesianDual,
                      UniversalPropertyOfCocartesianDual,
                      CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects,
                      CocartesianEvaluationForCocartesianDualWithGivenCoproduct,
                      MorphismFromCoexponentialToCoproductWithGivenObjects
                      ],
  function( cat, object )
    
    return IdentityMorphism( cat, CoexponentialOnObjects( cat, InitialObject( cat ), object ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "IsomorphismFromCocartesianDualToCoexponential as the identity of coHom(1,a)" );

AddFinalDerivation( IsomorphismFromCoexponentialToCocartesianDual,
                    [ [ IdentityMorphism, 1 ],
                      [ CoexponentialOnObjects, 1 ],
                      [ InitialObject, 1 ] ],
                    [ CocartesianDualOnObjects,
                      CocartesianDualOnMorphismsWithGivenCocartesianDuals,
                      MorphismFromCocartesianBidualWithGivenCocartesianBidual,
                      IsomorphismFromCocartesianDualToCoexponential,
                      IsomorphismFromCoexponentialToCocartesianDual,
                      UniversalPropertyOfCocartesianDual,
                      CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects,
                      CocartesianEvaluationForCocartesianDualWithGivenCoproduct,
                      MorphismFromCoexponentialToCoproductWithGivenObjects
                      ],

  function( cat, object )
    
    return IdentityMorphism( cat, CoexponentialOnObjects( cat, InitialObject( cat ), object ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "IsomorphismFromCoexponentialToCocartesianDual as the identity of coHom(1,a)" );
