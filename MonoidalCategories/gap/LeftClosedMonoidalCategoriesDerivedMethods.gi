# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToLeftInternalHomAdjunctMorphism,
                    "TensorProductToLeftInternalHomAdjunctMorphism using LeftClosedMonoidalCoevaluationMorphism and LeftInternalHom",
                    [ [ PreCompose, 1 ],
                      [ LeftClosedMonoidalCoevaluationMorphism, 1 ],
                      [ LeftInternalHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f )

    # f: a ⊗ b → c
    #
    #      a
    #      |
    #      | coev_ba
    #      v
    # Hom(b,a ⊗ b)
    #      |
    #      | Hom(id_b, f)
    #      v
    #   Hom(b,c)

    return PreCompose( cat,
             LeftClosedMonoidalCoevaluationMorphism( cat, b, a ),
             LeftInternalHomOnMorphisms( cat, IdentityMorphism( cat, b ), f ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductToLeftInternalHomAdjunctMorphismWithGivenLeftInternalHom,
                    "TensorProductToLeftInternalHomAdjunctMorphismWithGivenLeftInternalHom using LeftClosedMonoidalCoevaluationMorphism and LeftInternalHom",
                    [ [ LeftClosedMonoidalCoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ LeftInternalHomOnMorphismsWithGivenLeftInternalHoms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f, i )
    local coev_ba;
    
    # f: a ⊗ b → c
    #
    #      a
    #      |
    #      | coev_ba
    #      v
    # Hom(b,a ⊗ b)
    #      |
    #      | Hom(id_b, f)
    #      v
    #   Hom(b,c)
    
    coev_ba := LeftClosedMonoidalCoevaluationMorphism( cat, b, a );
    
    return PreCompose( cat,
             coev_ba,
             LeftInternalHomOnMorphismsWithGivenLeftInternalHoms( cat, Range( coev_ba ), IdentityMorphism( cat, b ), f, i ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalHomToTensorProductAdjunctMorphism,
                    "LeftInternalHomToTensorProductAdjunctMorphism using TensorProductOnMorphisms and LeftClosedMonoidalEvaluationMorphism",
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
AddDerivationToCAP( LeftInternalHomToTensorProductAdjunctMorphismWithGivenTensorProduct,
                    "LeftInternalHomToTensorProductAdjunctMorphismWithGivenTensorProduct using TensorProductOnMorphisms and LeftClosedMonoidalEvaluationMorphism",
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

##
AddDerivationToCAP( LeftClosedMonoidalEvaluationMorphismWithGivenSource,
                    "LeftClosedMonoidalEvaluationMorphismWithGivenSource using the tensor hom adjunction on the identity",
                    [ [ LeftInternalHomToTensorProductAdjunctMorphism, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftInternalHomOnObjects, 1 ] ],
                    
  function( cat, a, b, tensor_object )
    
    # Adjoint( id_Hom(a,b): Hom(a,b) → Hom(a,b) ) = ( Hom(a,b) ⊗ a → b )
    
    return LeftInternalHomToTensorProductAdjunctMorphism( cat,
             a, b,
             IdentityMorphism( cat, LeftInternalHomOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalCoevaluationMorphismWithGivenRange,
                    "LeftClosedMonoidalCoevaluationMorphismWithGivenRange using the tensor hom adjunction on the identity",
                    [ [ TensorProductToLeftInternalHomAdjunctMorphism, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    
    # Adjoint( id_(b ⊗ a): b ⊗ a → b ⊗ a ) = ( b → Hom(a, b ⊗ a) )
    
    return TensorProductToLeftInternalHomAdjunctMorphism( cat,
             b, a,
             IdentityMorphism( cat, TensorProductOnObjects( cat, b, a ) ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( UniversalPropertyOfLeftDual,
                    "UniversalPropertyOfLeftDual using the tensor hom adjunction",
                    [ [ PreCompose, 1 ],
                      [ TensorProductToLeftInternalHomAdjunctMorphism, 1 ],
                      [ IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject, 1 ] ],
                    
  function( cat, t, a, alpha )

    # alpha: t ⊗ a → 1
    #
    # Adjoint( alpha ) = ( t → Hom(a,1) ) → a^v
    
    return PreCompose( cat,
             TensorProductToLeftInternalHomAdjunctMorphism( cat, t, a, alpha ),
             IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject( cat, a ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( LeftDualOnObjects,
                    "LeftDualOnObjects as the source of IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit",
                    [ [ IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit, 1 ] ],
                    
  function( cat, a )

    # Source( a^v → Hom(a,1) )
    
    return Source( IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit( cat, a ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( LeftDualOnObjects,
                    "LeftDualOnObjects as the range of IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject",
                    [ [ IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject, 1 ] ],
                    
  function( cat, a )

    # Range( Hom(a,1) → a^v )
    
    return Range( IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject( cat, a ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( LeftDualOnMorphismsWithGivenLeftDuals,
                    "LeftDualOnMorphismsWithGivenLeftDuals using LeftInternalHomOnMorphisms and IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit",
                    [ [ PreComposeList, 1 ],
                      [ IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit, 1 ],
                      [ LeftInternalHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorUnit, 1 ],
                      [ IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject, 1 ] ],
                    
  function( cat, s, alpha, r )
    
    # alpha: a → b
    #
    #   b^v
    #    |
    #    v
    # Hom(b,1)
    #    |
    #    | Hom(alpha, id_1)
    #    v
    # Hom(a,1)
    #    |
    #    v
    #   a^v
    
    return PreComposeList( cat,
                   s,
                   [ IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit( cat, Range( alpha ) ),
                     
                     LeftInternalHomOnMorphisms( cat,
                             alpha,
                             IdentityMorphism( cat, TensorUnit( cat ) ) ),
                     
                     IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject( cat, Source( alpha ) ) ],
                   r );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalEvaluationForLeftDualWithGivenTensorProduct,
                    "LeftClosedMonoidalEvaluationForLeftDualWithGivenTensorProduct using the tensor hom adjunction and IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit",
                    [ [ LeftInternalHomToTensorProductAdjunctMorphism, 1 ],
                      [ IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit, 1 ] ],
                    
  function( cat, s, a, r )

    # r := 1
    #
    # Adjoint( a^v → Hom(a,1) ) = ( a^v ⊗ a → 1 )
    
    return LeftInternalHomToTensorProductAdjunctMorphism( cat,
                   a,
                   r,
                   IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit( cat, a ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalLambdaIntroduction,
                    "LeftClosedMonoidalLambdaIntroduction using the tensor hom adjunction and left unitor",
                    [ [ PreCompose, 1 ],
                      [ LeftUnitor, 1 ],
                      [ TensorProductToLeftInternalHomAdjunctMorphism, 1 ],
                      [ TensorUnit, 1 ] ],
                    
  function( cat, alpha )
    local result_morphism, source;

    # 1 ⊗ a
    #   |
    #   | λ_a
    #   v
    #   a
    #   |
    #   | alpha
    #   v
    #   b
    #
    # Adjoint( 1 ⊗ a → b) = ( 1 → Hom(a,b) )
    
    source := Source( alpha );
    
    result_morphism := PreCompose( cat, LeftUnitor( cat, source ), alpha );
    
    return TensorProductToLeftInternalHomAdjunctMorphism( cat,
                   TensorUnit( cat ),
                   source,
                   result_morphism );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalLambdaElimination,
                    "LeftClosedMonoidalLambdaElimination using the tensor hom adjunction and left unitor inverse",
                    [ [ LeftInternalHomToTensorProductAdjunctMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ LeftUnitorInverse, 1 ] ],
                    
  function( cat, a, b, alpha )
    local result_morphism;

    # alpha: 1 → Hom(a,b)
    # Adjoint( alpha ) = ( 1 ⊗ a → b)
    #
    #   a
    #   |
    #   | (λ_a)^-1
    #   v
    # 1 ⊗ a
    #   |
    #   | Adjoint( alpha)
    #   v
    #   b
    
    result_morphism := LeftInternalHomToTensorProductAdjunctMorphism( cat, a, b, alpha );
    
    return PreCompose( cat, LeftUnitorInverse( cat, a ), result_morphism );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductLeftDualityCompatibilityMorphismWithGivenObjects,
                    "TensorProductLeftDualityCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of tensor product and internal hom",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit, 2 ],
                      [ TensorProductLeftInternalHomCompatibilityMorphism, 1 ],
                      [ LeftInternalHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftUnitor, 1 ],
                      [ IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject, 1 ] ],
                    
  function( cat, s, a, b, r )
    local unit, tensor_product_on_a_and_b, morphism;
    
    #      a^v ⊗ b^v
    #          |
    #          v
    # Hom(a,1) ⊗ Hom(b,1)
    #          |
    #          | CompatMorphism(a,1,b,1)
    #          V
    #  Hom(a ⊗ b, 1 ⊗ 1)
    #          |
    #          | Hom(id_(a ⊗ b), λ_1)
    #          V
    #    Hom(a ⊗ b, 1)
    #          |
    #          V
    #       (a ⊗ b)^v
    
    unit := TensorUnit( cat );
    
    tensor_product_on_a_and_b := TensorProductOnObjects( cat, a, b );
    
    morphism := PreComposeList( cat,
                        s,
                        [ TensorProductOnMorphisms( cat,
                                IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit( cat, a ),
                                IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit( cat, b ) ),
                          
                          TensorProductLeftInternalHomCompatibilityMorphism( cat, [ a, unit, b, unit ] ),
                          
                          LeftInternalHomOnMorphisms( cat,
                                  IdentityMorphism( cat, tensor_product_on_a_and_b ),
                                  LeftUnitor( cat, unit ) ),
                          
                          IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject( cat, tensor_product_on_a_and_b ) ],
                        r );
    
    return morphism;
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom,
                    "IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom using the coevaluation morphism",
                    [ [ TensorUnit, 1 ],
                      [ PreCompose, 1 ],
                      [ LeftClosedMonoidalCoevaluationMorphism, 1 ],
                      [ LeftInternalHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ RightUnitor, 1 ] ],
                    
  function( cat, a, internal_hom )
    local unit;
    
    #       a
    #       |
    #       | coev_(1,a)
    #       v
    # Hom(1, a ⊗ 1)
    #       |
    #       | Hom(id_1, ρ_a)
    #       v
    #   Hom(1, a)
    
    unit := TensorUnit( cat );
    
    return PreCompose( cat,
                   LeftClosedMonoidalCoevaluationMorphism( cat, unit, a ),
                   
                   LeftInternalHomOnMorphisms( cat,
                           IdentityMorphism( cat, unit ),
                           RightUnitor( cat, a ) ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom,
                    "IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom as the adjoint of the right unitor",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductToLeftInternalHomAdjunctMorphism, 1 ],
                      [ RightUnitor, 1 ] ],
                    
  function( cat, a, internal_hom )
    
    # ρ_a: a ⊗ 1 → a
    #
    # Adjoint( ρ_a ) = ( a → Hom(1,a) )
    
    return TensorProductToLeftInternalHomAdjunctMorphism( cat,
                   a,
                   TensorUnit( cat ),
                   RightUnitor( cat, a ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom,
#                     
#   function( cat, object, internal_hom )
#
#     # Inverse( a → Hom(1,a))
#     
#     return InverseForMorphisms( cat, IsomorphismFromLeftInternalHomToObject( cat, object ) );
#     
# end : CategoryFilter := IsLeftClosedMonoidalCategory,
#       Description := "IsomorphismFromObjectToLeftInternalHom as the inverse of IsomorphismFromLeftInternalHomToObject" );

##
AddDerivationToCAP( IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom,
                    "IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom using the evaluation morphism",
                    [ [ TensorUnit, 1 ],
                      [ PreCompose, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 1 ] ],
                    
  function( cat, a, internal_hom )
    
    #  Hom(1,a)
    #      |
    #      | ( ρ_Hom(1,a) )^-1
    #      v
    # Hom(1,a) ⊗ 1
    #      |
    #      | ev_(1,a)
    #      v
    #      a
    
    return PreCompose( cat,
                   RightUnitorInverse( cat, internal_hom ),
                   LeftClosedMonoidalEvaluationMorphism( cat, TensorUnit( cat ), a ) );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom,
#                     
#   function( cat, a, internal_hom )
#
#     # Inverse( a → Hom(1,a) )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToLeftInternalHom( cat, a ) );
#     
# end : CategoryFilter := IsLeftClosedMonoidalCategory,
#       Description := "IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom as the inverse of IsomorphismFromObjectToLeftInternalHom" );

##
AddDerivationToCAP( MorphismFromTensorProductToLeftInternalHomWithGivenObjects,
                    "MorphismFromTensorProductToLeftInternalHomWithGivenObjects using TensorProductLeftInternalHomCompatibilityMorphism",
                    [ [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit, 1 ],
                      [ IsomorphismFromObjectToLeftInternalHom, 1 ],
                      [ TensorProductLeftInternalHomCompatibilityMorphism, 1 ],
                      [ LeftInternalHomOnMorphisms, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ LeftUnitor, 1 ] ],
                    
  function( cat, tensor_object, a, b, internal_hom )
    local unit;
    
    #      a^v ⊗ b
    #          |
    #          v
    # Hom(a,1) ⊗ Hom(1,b)
    #          |
    #          | CompatMorphism
    #          v
    # Hom(a ⊗ 1, 1 ⊗ b)
    #          |
    #          | Hom((ρ_a)^-1, λ_b)
    #          v
    #       Hom(a,b)
    
    unit := TensorUnit( cat );
    
    return PreComposeList( cat,
                   tensor_object,
                   [ TensorProductOnMorphisms( cat,
                           IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit( cat, a ),
                           IsomorphismFromObjectToLeftInternalHom( cat, b ) ),
                     
                     TensorProductLeftInternalHomCompatibilityMorphism( cat,
                             [ a, unit, unit, b ] ),
                     
                     LeftInternalHomOnMorphisms( cat,
                             RightUnitorInverse( cat, a ),
                             LeftUnitor( cat, b ) ) ],
                   internal_hom );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalPostComposeMorphismWithGivenObjects,
                    "LeftClosedMonoidalPostComposeMorphismWithGivenObjects using associator, evaluation, and tensor hom adjunction",
                    [ [ LeftInternalHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductToLeftInternalHomAdjunctMorphismWithGivenLeftInternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local hom_a_b, hom_b_c, morphism;
    
    # (Hom(b,c) ⊗ Hom(a,b)) ⊗ a
    #            |
    #            | α_( ( Hom(b,c), Hom(a,b) ), c )
    #            v
    # Hom(b,c) ⊗ (Hom(a,b) ⊗ a)
    #            |
    #            | id_Hom(b,c) ⊗ ev_ab
    #            v
    #      Hom(b,c) ⊗ b
    #            |
    #            | ev_bc
    #            v
    #            c
    #
    #
    # Adjoint( (Hom(b,c) ⊗ Hom(a,b)) ⊗ a → c ) = ( Hom(b,c) ⊗ Hom(a,b) → Hom(a,c) )
    
    hom_a_b := LeftInternalHomOnObjects( cat, a, b );
    
    hom_b_c := LeftInternalHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a ),
                        [ AssociatorLeftToRight( cat, hom_b_c, hom_a_b, a ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, hom_b_c ),
                                  LeftClosedMonoidalEvaluationMorphism( cat, a, b ) ),
                          
                          LeftClosedMonoidalEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToLeftInternalHomAdjunctMorphismWithGivenLeftInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := IsLeftClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductLeftDualityCompatibilityMorphismWithGivenObjects,
                    "TensorProductLeftDualityCompatibilityMorphismWithGivenObjects using compatibility of tensor product and internal hom",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit, 2 ],
                      [ TensorProductLeftInternalHomCompatibilityMorphism, 1 ],
                      [ IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject, 1 ] ],
                    
  function( cat, source, a, b, range )
    local unit, morphism;
    
    #      a^v ⊗ b^v
    #          |
    #          v
    # Hom(a,1) ⊗ Hom(b,1)
    #          |
    #          | CompatMorphism(a,1,b,1)
    #          V
    #  Hom(a ⊗ b, 1)
    #          |
    #          V
    #       (a ⊗ b)^v
    
    unit := TensorUnit( cat );
    
    morphism := PreComposeList( cat,
                        source,
                        [ TensorProductOnMorphisms( cat,
                                IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit( cat, a ),
                                IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit( cat, b ) ),
                          
                          TensorProductLeftInternalHomCompatibilityMorphism( cat, [ a, unit, b, unit ] ),
                          
                          IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject( cat,
                                  TensorProductOnObjects( cat, a, b ) ) ],
                        range );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsLeftClosedMonoidalCategory( cat ) and IsLeftClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( LeftClosedMonoidalPostComposeMorphismWithGivenObjects,
                    "LeftClosedMonoidalPostComposeMorphismWithGivenObjects using evaluation, and tensor hom adjunction",
                    [ [ LeftInternalHomOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductToLeftInternalHomAdjunctMorphismWithGivenLeftInternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local morphism;
    
    # Hom(b,c) ⊗ Hom(a,b) ⊗ a
    #            |
    #            | id_Hom(b,c) ⊗ ev_ab
    #            v
    #      Hom(b,c) ⊗ b
    #            |
    #            | ev_bc
    #            v
    #            c
    #
    #
    # Adjoint( Hom(b,c) ⊗ Hom(a,b) ⊗ a → c ) = ( Hom(b,c) ⊗ Hom(a,b) → Hom(a,c) )
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, LeftInternalHomOnObjects( cat, b, c ) ),
                                LeftClosedMonoidalEvaluationMorphism( cat, a, b ) ),
                          
                          LeftClosedMonoidalEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToLeftInternalHomAdjunctMorphismWithGivenLeftInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsLeftClosedMonoidalCategory( cat ) and IsLeftClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

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
