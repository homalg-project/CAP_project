# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

####################################
## Final derived methods
####################################

##
AddFinalDerivation( DistinguishedObjectOfHomomorphismStructure,
                    [ [ TensorUnit, 1 ],
                      [ InternalHomOnObjects, 1 ],
                      [ InternalHomOnMorphismsWithGivenInternalHoms, 1 ],
                      [ LambdaIntroduction, 1 ],
                      [ LambdaElimination, 1 ],
                      ],
                    [
                      DistinguishedObjectOfHomomorphismStructure,
                      HomomorphismStructureOnObjects,
                      HomomorphismStructureOnMorphismsWithGivenObjects,
                      InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
                      InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism
                    ],
        
  function ( cat )
    
    return TensorUnit( cat );
    
  end,
[
  HomomorphismStructureOnObjects,
  function ( cat, a, b )
    
    return InternalHomOnObjects( cat, a, b );
    
end
],
[
  HomomorphismStructureOnMorphismsWithGivenObjects,
  function ( cat, s, alpha, beta, r )
    
    return InternalHomOnMorphismsWithGivenInternalHoms( cat, s, alpha, beta, r );
    
end
],
[
  InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
  function( cat, alpha )
    local iota;
    
    return LambdaIntroduction( cat, alpha );
    
  end
],
[
  InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism,
  function ( cat, a, b, iota )
    
    return LambdaElimination( cat, a, b, iota );
    
  end
] : CategoryFilter := function( cat )
      return not HasRangeCategoryOfHomomorphismStructure( cat );
    end,
    FunctionCalledBeforeInstallation :=
      function( cat )
        SetRangeCategoryOfHomomorphismStructure( cat, cat );
        SetIsEquippedWithHomomorphismStructure( cat, true );
    end,
    Description := "adding the homomorphism structure using the closed monoidal structure"
);
