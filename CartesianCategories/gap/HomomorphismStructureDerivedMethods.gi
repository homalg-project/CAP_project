# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



####################################
## Final derived methods
####################################

##
AddFinalDerivationBundle( # DistinguishedObjectOfHomomorphismStructure,
                    [ [ TerminalObject, 1 ],
                      [ ExponentialOnObjects, 1 ],
                      [ ExponentialOnMorphismsWithGivenExponentials, 1 ],
                      [ CartesianLambdaIntroduction, 1 ],
                      [ CartesianLambdaElimination, 1 ],
                      ],
                    [
                      DistinguishedObjectOfHomomorphismStructure,
                      HomomorphismStructureOnObjects,
                      HomomorphismStructureOnMorphisms,
                      HomomorphismStructureOnMorphismsWithGivenObjects,
                      InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
                      InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects,
                      InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism
                    ],
[
  DistinguishedObjectOfHomomorphismStructure,
  function ( cat )
    
    return TerminalObject( cat );
    
  end
],
[
  HomomorphismStructureOnObjects,
  function ( cat, a, b )
    
    return ExponentialOnObjects( cat, a, b );
    
end
],
[
  HomomorphismStructureOnMorphismsWithGivenObjects,
  function ( cat, s, alpha, beta, r )
    
    return ExponentialOnMorphismsWithGivenExponentials( cat, s, alpha, beta, r );
    
end
],
[
  InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
  function( cat, alpha )
    local iota;
    
    return CartesianLambdaIntroduction( cat, alpha );
    
  end
],
[
  InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism,
  function ( cat, a, b, iota )
    
    return CartesianLambdaElimination( cat, a, b, iota );
    
  end
] : CategoryFilter := function( cat )
      return (HasIsEquippedWithHomomorphismStructure and IsEquippedWithHomomorphismStructure)( cat ) and
             HasRangeCategoryOfHomomorphismStructure( cat ) and
             IsIdenticalObj( RangeCategoryOfHomomorphismStructure( cat ), cat );
    end,
    Description := "adding the homomorphism structure using the closed cartesian structure"
);
