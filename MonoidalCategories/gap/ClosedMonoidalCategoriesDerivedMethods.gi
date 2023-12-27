# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToInternalHomAdjunctionMap,
                    "TensorProductToInternalHomAdjunctionMap using CoevaluationMorphism and InternalHom",
                    [ [ PreCompose, 1 ],
                      [ CoevaluationMorphism, 1 ],
                      [ InternalHomOnMorphisms, 1 ],
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
             CoevaluationMorphism( cat, a, b ),
             InternalHomOnMorphisms( cat, IdentityMorphism( cat, b ), f ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductToInternalHomAdjunctionMapWithGivenInternalHom,
                    "TensorProductToInternalHomAdjunctionMapWithGivenInternalHom using CoevaluationMorphism and InternalHom",
                    [ [ CoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ InternalHomOnMorphismsWithGivenInternalHoms, 1 ],
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
    
    coev_ab := CoevaluationMorphism( cat, a, b );
    
    return PreCompose( cat,
             coev_ab,
             InternalHomOnMorphismsWithGivenInternalHoms( cat, Range( coev_ab ), IdentityMorphism( cat, b ), f, i ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( InternalHomToTensorProductAdjunctionMap,
                    "InternalHomToTensorProductAdjunctionMap using TensorProductOnMorphisms and EvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ EvaluationMorphism, 1 ] ],
                    
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
             EvaluationMorphism( cat, b, c ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( InternalHomToTensorProductAdjunctionMapWithGivenTensorProduct,
                    "InternalHomToTensorProductAdjunctionMapWithGivenTensorProduct using TensorProductOnMorphisms and EvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ TensorProductOnMorphismsWithGivenTensorProducts, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ EvaluationMorphism, 1 ] ],
                    
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
     
    ev_bc := EvaluationMorphism( cat, b, c );
     
    return PreCompose( cat,
             TensorProductOnMorphismsWithGivenTensorProducts( cat, t, g, IdentityMorphism( cat, b ), Source( ev_bc ) ),
             ev_bc );
    
end : CategoryFilter := IsClosedMonoidalCategory );

####################################
## Final derived methods
####################################

## Final methods for Dual
AddFinalDerivationBundle( "IsomorphismFromDualObjectToInternalHomIntoTensorUnit and its inverse as the identity of Hom(a,1)",
                    [ [ IdentityMorphism, 1 ],
                      [ InternalHomOnObjects, 1 ],
                      [ TensorUnit, 1 ] ],
                    [ DualOnObjects,
                      DualOnMorphismsWithGivenDuals,
                      MorphismToBidualWithGivenBidual,
                      IsomorphismFromDualObjectToInternalHomIntoTensorUnit,
                      IsomorphismFromInternalHomIntoTensorUnitToDualObject,
                      UniversalPropertyOfDual,
                      TensorProductDualityCompatibilityMorphismWithGivenObjects,
                      EvaluationForDualWithGivenTensorProduct,
                      MorphismFromTensorProductToInternalHomWithGivenObjects ],
[
  IsomorphismFromDualObjectToInternalHomIntoTensorUnit,
  [ [ IdentityMorphism, 1 ],
    [ InternalHomOnObjects, 1 ],
    [ TensorUnit, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, InternalHomOnObjects( cat, object, TensorUnit( cat ) ) );
    
  end
],
[
  IsomorphismFromInternalHomIntoTensorUnitToDualObject,
  [ [ IdentityMorphism, 1 ],
    [ InternalHomOnObjects, 1 ],
    [ TensorUnit, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, InternalHomOnObjects( cat, object, TensorUnit( cat ) ) );
    
  end
] : CategoryFilter := IsClosedMonoidalCategory );
