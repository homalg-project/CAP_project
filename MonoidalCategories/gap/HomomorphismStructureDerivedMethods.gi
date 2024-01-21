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
                      [ InternalHomOnObjects, 1 ],
                      [ InternalHomOnMorphismsWithGivenInternalHoms, 1 ],
                      [ LambdaIntroduction, 1 ],
                      [ LambdaElimination, 1 ],
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
  [ [ InternalHomOnObjects, 1 ] ],
  function ( cat, a, b )
    
    return InternalHomOnObjects( cat, a, b );
    
end
],
[
  HomomorphismStructureOnMorphismsWithGivenObjects,
  [ [ InternalHomOnMorphismsWithGivenInternalHoms, 1 ] ],
  function ( cat, s, alpha, beta, r )
    
    return InternalHomOnMorphismsWithGivenInternalHoms( cat, s, alpha, beta, r );
    
end
],
[
  InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
  [ [ LambdaIntroduction, 1 ] ],
  function( cat, alpha )
    local iota;
    
    return LambdaIntroduction( cat, alpha );
    
  end
],
[
  InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism,
  [ [ LambdaElimination, 1 ] ],
  function ( cat, a, b, iota )
    
    return LambdaElimination( cat, a, b, iota );
    
  end
] : CategoryFilter := function( cat )
      return HasIsEquippedWithHomomorphismStructure( cat ) and
             IsEquippedWithHomomorphismStructure( cat ) and
             HasRangeCategoryOfHomomorphismStructure( cat ) and
             IsIdenticalObj( RangeCategoryOfHomomorphismStructure( cat ), cat );
    end
);
