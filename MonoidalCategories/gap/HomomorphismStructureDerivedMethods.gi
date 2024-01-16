# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

####################################
## Final derived methods
####################################

##
AddFinalDerivationBundle( "adding the homomorphism structure using the closed monoidal structure",
                    [ [ TensorUnit, 1 ],
                      [ LeftInternalHomOnObjects, 1 ],
                      [ LeftInternalHomOnMorphismsWithGivenLeftInternalHoms, 1 ],
                      [ LeftClosedMonoidalLambdaIntroduction, 1 ],
                      [ LeftClosedMonoidalLambdaElimination, 1 ],
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
  [ [ TensorUnit, 1 ] ],
  function ( cat )
    
    return TensorUnit( cat );
    
  end
],
[
  HomomorphismStructureOnObjects,
  [ [ LeftInternalHomOnObjects, 1 ] ],
  function ( cat, a, b )
    
    return LeftInternalHomOnObjects( cat, a, b );
    
end
],
[
  HomomorphismStructureOnMorphismsWithGivenObjects,
  [ [ LeftInternalHomOnMorphismsWithGivenLeftInternalHoms, 1 ] ],
  function ( cat, s, alpha, beta, r )
    
    return LeftInternalHomOnMorphismsWithGivenLeftInternalHoms( cat, s, alpha, beta, r );
    
end
],
[
  InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
  [ [ LeftClosedMonoidalLambdaIntroduction, 1 ] ],
  function( cat, alpha )
    local iota;
    
    return LeftClosedMonoidalLambdaIntroduction( cat, alpha );
    
  end
],
[
  InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism,
  [ [ LeftClosedMonoidalLambdaElimination, 1 ] ],
  function ( cat, a, b, iota )
    
    return LeftClosedMonoidalLambdaElimination( cat, a, b, iota );
    
  end
] : CategoryFilter := function( cat )
      return HasIsEquippedWithHomomorphismStructure( cat ) and
             IsEquippedWithHomomorphismStructure( cat ) and
             HasRangeCategoryOfHomomorphismStructure( cat ) and
             IsIdenticalObj( RangeCategoryOfHomomorphismStructure( cat ), cat );
    end
);
