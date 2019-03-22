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

  function( object )
    local category;

    category := CapCategory( object );

    return IdentityMorphism( CoexponentialOnObjects( InitialObject( category ), object ) );

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

  function( object )
    local category;

    category := CapCategory( object );

    return IdentityMorphism( CoexponentialOnObjects( InitialObject( category ), object ) );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "IsomorphismFromCoexponentialToCocartesianDual as the identity of coHom(1,a)" );
