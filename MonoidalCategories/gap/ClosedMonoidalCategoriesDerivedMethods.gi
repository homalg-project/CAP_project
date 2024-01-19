# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToLeftInternalHomAdjunctionMap,
                    "TensorProductToLeftInternalHomAdjunctionMap using LeftClosedMonoidalCoevaluationMorphism and LeftInternalHom",
                    [ [ PreCompose, 1 ],
                      [ LeftClosedMonoidalCoevaluationMorphism, 1 ],
                      [ LeftInternalHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f )

    # f: a ⊗ b → c
    #
    #      a
    #      |
    #      | coev_ab
    #      v
    # Hom(b,a ⊗ b)
    #      |
    #      | Hom(id_b, f)
    #      v
    #   Hom(b,c)

    return PreCompose( cat,
             LeftClosedMonoidalCoevaluationMorphism( cat, a, b ),
             LeftInternalHomOnMorphisms( cat, IdentityMorphism( cat, b ), f ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom,
                    "TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom using LeftClosedMonoidalCoevaluationMorphism and LeftInternalHom",
                    [ [ LeftClosedMonoidalCoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ LeftInternalHomOnMorphismsWithGivenLeftInternalHoms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f, i )
    local coev_ab;
    
    # f: a ⊗ b → c
    #
    #      a
    #      |
    #      | coev_ab
    #      v
    # Hom(b,a ⊗ b)
    #      |
    #      | Hom(id_b, f)
    #      v
    #   Hom(b,c)
    
    coev_ab := LeftClosedMonoidalCoevaluationMorphism( cat, a, b );
    
    return PreCompose( cat,
             coev_ab,
             LeftInternalHomOnMorphismsWithGivenLeftInternalHoms( cat, Range( coev_ab ), IdentityMorphism( cat, b ), f, i ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalHomToTensorProductAdjunctionMap,
                    "LeftInternalHomToTensorProductAdjunctionMap using TensorProductOnMorphisms and LeftClosedMonoidalEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 1 ] ],
                    
  function( cat, b, c, g )

    # g: a → Hom(b,c)
    #
    #    a ⊗ b
    #      |
    #      | g ⊗ id_b
    #      v
    # Hom(b,c) ⊗ b
    #      |
    #      | ev_bc
    #      v
    #      c

    return PreCompose( cat,
             TensorProductOnMorphisms( cat, g, IdentityMorphism( cat, b ) ),
             LeftClosedMonoidalEvaluationMorphism( cat, b, c ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalHomToTensorProductAdjunctionMapWithGivenTensorProduct,
                    "LeftInternalHomToTensorProductAdjunctionMapWithGivenTensorProduct using TensorProductOnMorphisms and LeftClosedMonoidalEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ TensorProductOnMorphismsWithGivenTensorProducts, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 1 ] ],
                    
  function( cat, b, c, g, t )
    local ev_bc;
    
    # g: a → Hom(b,c)
    #
    #    a ⊗ b
    #      |
    #      | g ⊗ id_b
    #      v
    # Hom(b,c) ⊗ b
    #      |
    #      | ev_bc
    #      v
    #      c
     
    ev_bc := LeftClosedMonoidalEvaluationMorphism( cat, b, c );
     
    return PreCompose( cat,
             TensorProductOnMorphismsWithGivenTensorProducts( cat, t, g, IdentityMorphism( cat, b ), Source( ev_bc ) ),
             ev_bc );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

####################################
## Final derived methods
####################################

## Final methods for LeftDual
AddFinalDerivationBundle( "IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit and its inverse as the identity of Hom(a,1)",
                    [ [ IdentityMorphism, 1 ],
                      [ LeftInternalHomOnObjects, 1 ],
                      [ TensorUnit, 1 ] ],
                    [ LeftDualOnObjects,
                      LeftDualOnMorphismsWithGivenLeftDuals,
                      MorphismToLeftBidualWithGivenLeftBidual,
                      IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit,
                      IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject,
                      UniversalPropertyOfLeftDual,
                      TensorProductLeftDualityCompatibilityMorphismWithGivenObjects,
                      LeftClosedMonoidalEvaluationForLeftDualWithGivenTensorProduct,
                      MorphismFromTensorProductToLeftInternalHomWithGivenObjects ],
[
  IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit,
  [ [ IdentityMorphism, 1 ],
    [ LeftInternalHomOnObjects, 1 ],
    [ TensorUnit, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, LeftInternalHomOnObjects( cat, object, TensorUnit( cat ) ) );
    
  end
],
[
  IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject,
  [ [ IdentityMorphism, 1 ],
    [ LeftInternalHomOnObjects, 1 ],
    [ TensorUnit, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, LeftInternalHomOnObjects( cat, object, TensorUnit( cat ) ) );
    
  end
] : CategoryFilter := IsLeftClosedMonoidalCategory );
