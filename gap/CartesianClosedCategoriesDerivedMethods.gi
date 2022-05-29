# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



####################################
## Final derived methods
####################################

## Final methods for CartesianDual
AddFinalDerivation( IsomorphismFromCartesianDualToExponential,
                    [ [ IdentityMorphism, 1 ],
                      [ ExponentialOnObjects, 1 ],
                      [ TerminalObject, 1 ] ],
                    [ CartesianDualOnObjects,
                      CartesianDualOnMorphismsWithGivenCartesianDuals,
                      MorphismToCartesianBidualWithGivenCartesianBidual,
                      IsomorphismFromCartesianDualToExponential,
                      IsomorphismFromExponentialToCartesianDual,
                      UniversalPropertyOfCartesianDual,
                      DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects,
                      CartesianEvaluationForCartesianDualWithGivenDirectProduct,
                      MorphismFromDirectProductToExponentialWithGivenObjects ],
                 
  function( cat, object )
    
    return IdentityMorphism( cat, ExponentialOnObjects( cat, object, TerminalObject( cat ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "IsomorphismFromCartesianDualToExponential as the identity of Exp(a,1)" );

AddFinalDerivation( IsomorphismFromExponentialToCartesianDual,
                    [ [ IdentityMorphism, 1 ],
                      [ ExponentialOnObjects, 1 ],
                      [ TerminalObject, 1 ] ],
                    [ CartesianDualOnObjects,
                      CartesianDualOnMorphismsWithGivenCartesianDuals,
                      MorphismToCartesianBidualWithGivenCartesianBidual,
                      IsomorphismFromCartesianDualToExponential,
                      IsomorphismFromExponentialToCartesianDual,
                      UniversalPropertyOfCartesianDual,
                      DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects,
                      CartesianEvaluationForCartesianDualWithGivenDirectProduct,
                      MorphismFromDirectProductToExponentialWithGivenObjects ],
                 
  function( cat, object )
    
    return IdentityMorphism( cat, ExponentialOnObjects( cat, object, TerminalObject( cat ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "IsomorphismFromExponentialToCartesianDual as the identity of Exp(a,1)" );
