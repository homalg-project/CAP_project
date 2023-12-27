# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToInternalCoHomAdjunctionMap,
                    "TensorProductToInternalCoHomAdjunctionMap using CoclosedCoevaluationMorphism and InternalCoHom",
                    [ [ PreCompose, 1 ],
                      [ InternalCoHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CoclosedCoevaluationMorphism, 1 ] ],
                    
  function( cat, c, b, g )
    
    # g: a → c ⊗ b
    #
    #    Cohom(a,b)
    #        |
    #        | Cohom(g, id_b)
    #        v
    # Cohom(c ⊗ b, b)
    #        |
    #        | coclcoev_cb
    #        v
    #        c

    return PreCompose( cat,
             InternalCoHomOnMorphisms( cat, g, IdentityMorphism( cat, b ) ),
             CoclosedCoevaluationMorphism( cat, c, b ) );
             
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom,
                    "TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom using CoclosedCoevaluationMorphism and InternalCoHom",
                    [ [ CoclosedCoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ InternalCoHomOnMorphismsWithGivenInternalCoHoms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, c, b, g, i )
    local coclcoev_cb;
    
    # g: a → c ⊗ b
    #
    #    Cohom(a,b)
    #        |
    #        | Cohom(g, id_b)
    #        v
    # Cohom(c ⊗ b, b)
    #        |
    #        | coclcoev_cb
    #        v
    #        c
    
    coclcoev_cb := CoclosedCoevaluationMorphism( cat, c, b );
    
    return PreCompose( cat,
             InternalCoHomOnMorphismsWithGivenInternalCoHoms( cat, i, g, IdentityMorphism( cat, b ), Source( coclcoev_cb ) ),
             coclcoev_cb );
    
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( InternalCoHomToTensorProductAdjunctionMap,
                    "InternalCoHomToTensorProductAdjunctionMap using TensorProductOnMorphisms and CoclosedEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ CoclosedEvaluationMorphism, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f )
    
    # f: Cohom(a,b) → c
    #
    #        a
    #        |
    #        | coclev_ab
    #        v
    # Cohom(a,b) ⊗ b
    #        |
    #        | f ⊗ id_b
    #        v
    #      c ⊗ b
    
    return PreCompose( cat,
             CoclosedEvaluationMorphism( cat, a, b ),
             TensorProductOnMorphisms( cat, f, IdentityMorphism( cat, b ) ) );
             
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( InternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct,
                    "InternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct using TensorProductOnMorphisms and CoclosedEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ CoclosedEvaluationMorphism, 1 ],
                      [ TensorProductOnMorphismsWithGivenTensorProducts, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f, t )
    local coclev_bc;
    
    # f: Cohom(a,b) → c
    #
    #        a
    #        |
    #        | coclev_ab
    #        v
    # Cohom(a,b) ⊗ b
    #        |
    #        | f ⊗ id_b
    #        v
    #      c ⊗ b
    
    coclev_bc := CoclosedEvaluationMorphism( cat, a, b );
    
    return PreCompose( cat,
             coclev_bc,
             TensorProductOnMorphismsWithGivenTensorProducts( cat, Range( coclev_bc ), f, IdentityMorphism( cat, b ), t ) );
             
end : CategoryFilter := IsCoclosedMonoidalCategory );

####################################
## Final derived methods
####################################

## Final methods for CoDual
AddFinalDerivationBundle( "IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit as the identity of coHom(1,a)",
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
] : CategoryFilter := IsCoclosedMonoidalCategory );
