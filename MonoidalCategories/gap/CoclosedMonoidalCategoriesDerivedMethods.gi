# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToLeftInternalCoHomAdjunctionMap,
                    "TensorProductToLeftInternalCoHomAdjunctionMap using LeftCoclosedMonoidalCoevaluationMorphism and LeftInternalCoHom",
                    [ [ PreCompose, 1 ],
                      [ LeftInternalCoHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftCoclosedMonoidalCoevaluationMorphism, 1 ] ],
                    
  function( cat, c, b, g )
    
    # g: a → c ⊗ b
    #
    #    coHom(a,b)
    #        |
    #        | coHom(g, id_b)
    #        v
    # coHom(c ⊗ b, b)
    #        |
    #        | coclcoev_cb
    #        v
    #        c

    return PreCompose( cat,
             LeftInternalCoHomOnMorphisms( cat, g, IdentityMorphism( cat, b ) ),
             LeftCoclosedMonoidalCoevaluationMorphism( cat, c, b ) );
             
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom,
                    "TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom using LeftCoclosedMonoidalCoevaluationMorphism and LeftInternalCoHom",
                    [ [ LeftCoclosedMonoidalCoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, c, b, g, i )
    local coclcoev_cb;
    
    # g: a → c ⊗ b
    #
    #    coHom(a,b)
    #        |
    #        | coHom(g, id_b)
    #        v
    # coHom(c ⊗ b, b)
    #        |
    #        | coclcoev_cb
    #        v
    #        c
    
    coclcoev_cb := LeftCoclosedMonoidalCoevaluationMorphism( cat, c, b );
    
    return PreCompose( cat,
             LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms( cat, i, g, IdentityMorphism( cat, b ), Source( coclcoev_cb ) ),
             coclcoev_cb );
    
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalCoHomToTensorProductAdjunctionMap,
                    "LeftInternalCoHomToTensorProductAdjunctionMap using TensorProductOnMorphisms and LeftCoclosedMonoidalEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f )
    
    # f: coHom(a,b) → c
    #
    #        a
    #        |
    #        | coclev_ab
    #        v
    # coHom(a,b) ⊗ b
    #        |
    #        | f ⊗ id_b
    #        v
    #      c ⊗ b
    
    return PreCompose( cat,
             LeftCoclosedMonoidalEvaluationMorphism( cat, a, b ),
             TensorProductOnMorphisms( cat, f, IdentityMorphism( cat, b ) ) );
             
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct,
                    "LeftInternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct using TensorProductOnMorphisms and LeftCoclosedMonoidalEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 1 ],
                      [ TensorProductOnMorphismsWithGivenTensorProducts, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f, t )
    local coclev_bc;
    
    # f: coHom(a,b) → c
    #
    #        a
    #        |
    #        | coclev_ab
    #        v
    # coHom(a,b) ⊗ b
    #        |
    #        | f ⊗ id_b
    #        v
    #      c ⊗ b
    
    coclev_bc := LeftCoclosedMonoidalEvaluationMorphism( cat, a, b );
    
    return PreCompose( cat,
             coclev_bc,
             TensorProductOnMorphismsWithGivenTensorProducts( cat, Range( coclev_bc ), f, IdentityMorphism( cat, b ), t ) );
             
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

####################################
## Final derived methods
####################################

## Final methods for LeftCoDual
AddFinalDerivationBundle( "IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit as the identity of coHom(1,a)",
                    [ [ IdentityMorphism, 1 ],
                      [ LeftInternalCoHomOnObjects, 1 ],
                      [ TensorUnit, 1 ] ],
                    [ LeftCoDualOnObjects,
                      LeftCoDualOnMorphismsWithGivenLeftCoDuals,
                      MorphismFromLeftCoBidualWithGivenLeftCoBidual,
                      IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit,
                      IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject,
                      UniversalPropertyOfLeftCoDual,
                      LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                      LeftCoclosedMonoidalEvaluationForLeftCoDualWithGivenTensorProduct,
                      MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects
                      ],
[
  IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit,
  [ [ IdentityMorphism, 1 ],
    [ LeftInternalCoHomOnObjects, 1 ],
    [ TensorUnit, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, LeftInternalCoHomOnObjects( cat, TensorUnit( cat ), object ) );
    
  end
],
[
  IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject,
  [ [ IdentityMorphism, 1 ],
    [ LeftInternalCoHomOnObjects, 1 ],
    [ TensorUnit, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, LeftInternalCoHomOnObjects( cat, TensorUnit( cat ), object ) );
    
  end
] : CategoryFilter := IsLeftCoclosedMonoidalCategory );
