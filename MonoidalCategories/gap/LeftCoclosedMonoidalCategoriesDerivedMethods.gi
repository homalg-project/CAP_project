# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

####################################
## Final derived methods
####################################

##
AddDerivationToCAP( UniversalPropertyOfLeftCoDual,
                    "UniversalPropertyOfLeftCoDual using the cohom tensor adjunction",
                    [ [ PreCompose, 1 ],
                      [ IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit, 1 ],
                      [ TensorProductToLeftInternalCoHomAdjunctionMap, 1 ] ],
                    
  function( cat, t, a, alpha )
    
    # alpha: 1 → t ⊗ a
    #
    # a_v → ( coHom(1,a) → t ) = Adjoint( alpha )
    
    return PreCompose( cat,
             IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit( cat, a ),
             TensorProductToLeftInternalCoHomAdjunctionMap( cat, t, a, alpha ) );
             
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoDualOnObjects,
                    "LeftCoDualOnObjects as the source of IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit",
                    [ [ IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit, 1 ] ],
                    
  function( cat, a )
    
    # Source( a_v → coHom(1,a) )
    
    return Source( IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit( cat, a ) );

end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoDualOnObjects,
                    "LeftCoDualOnObjects as the range of IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject",
                    [ [ IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject, 1 ] ],
                    
  function( cat, a )
    
    # Range( coHom(1,a) → a_v )
    
    return Range( IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( cat, a ) );

end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoDualOnMorphismsWithGivenLeftCoDuals,
                    "LeftCoDualOnMorphismsWithGivenLeftCoDuals using LeftInternalCoHomOnMorphisms and IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit",
                    [ [ PreComposeList, 1 ],
                      [ IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit, 1 ],
                      [ LeftInternalCoHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorUnit, 1 ],
                      [ IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject, 1 ] ],
                    
  function( cat, s, alpha, r )
    
    # alpha: a → b
    #
    #    b_v
    #     |
    #     v
    # coHom(1,b)
    #     |
    #     | coHom(id_1, alpha)
    #     v
    # coHom(1,a)
    #     |
    #     v
    #    a_v
    
    return PreComposeList( cat,
                   s,
                   [ IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit( cat, Range( alpha ) ),
                     
                     LeftInternalCoHomOnMorphisms( cat,
                             IdentityMorphism( cat, TensorUnit( cat ) ),
                             alpha ),
                     
                     IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( cat, Source( alpha ) ) ],
                   r );
    
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalEvaluationForLeftCoDualWithGivenTensorProduct,
                    "LeftCoclosedMonoidalEvaluationForLeftCoDualWithGivenTensorProduct using the cohom tensor adjunction and IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject",
                    [ [ LeftInternalCoHomToTensorProductAdjunctionMap, 1 ],
                      [ IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject, 1 ] ],
                    
  function( cat, s, a, r )
    
    # s := 1
    #
    # Adjoint( coHom(1,a) → a_v ) = ( 1 → a_v ⊗ a )

    return LeftInternalCoHomToTensorProductAdjunctionMap( cat,
            s,
            a,
            IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( cat, a ) );

end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalLambdaIntroduction,
                    "LeftCoclosedMonoidalLambdaIntroduction using the cohom tensor adjunction and the left unitor inverse",
                    [ [ PreCompose, 1 ],
                      [ LeftUnitorInverse, 1 ],
                      [ TensorProductToLeftInternalCoHomAdjunctionMap, 1 ],
                      [ TensorUnit, 1 ] ],
                    
  function( cat, alpha )
    local result_morphism, range;
    
    #   a
    #   |
    #   | alpha
    #   v
    #   b
    #   |
    #   | (λ_b)^-1
    #   v
    # 1 ⊗ b
    #
    # Adjoint( a → 1 ⊗ b ) = ( coHom(a,b) → 1 )

    range := Range( alpha );

    result_morphism := PreCompose( cat, alpha, LeftUnitorInverse( cat, range ) );

    return TensorProductToLeftInternalCoHomAdjunctionMap( cat,
                   TensorUnit( cat ),
                   range,
                   result_morphism );
    
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalLambdaElimination,
                    "LeftCoclosedMonoidalLambdaElimination using the cohom tensor adjunction and the left unitor",
                    [ [ LeftInternalCoHomToTensorProductAdjunctionMap, 1 ],
                      [ PreCompose, 1 ],
                      [ LeftUnitor, 1 ] ],
                    
  function( cat, a, b, alpha )
    local result_morphism;
    
    # alpha: coHom(a,b) → 1
    # Adjoint( alpha ) = ( a → 1 ⊗ b )
    #
    #   a
    #   |
    #   | Adjoint( alpha )
    #   v
    # 1 ⊗ b
    #   |
    #   | λ_b
    #   v
    #   b
    
    result_morphism := LeftInternalCoHomToTensorProductAdjunctionMap( cat, a, b, alpha );
    
    return PreCompose( cat, result_morphism, LeftUnitor( cat, b ) );
    
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                    "LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of internal cohom and tensor product",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit, 1 ],
                      [ LeftInternalCoHomOnMorphisms, 1 ],
                      [ LeftUnitorInverse, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftInternalCoHomTensorProductCompatibilityMorphism, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject, 2 ] ],
                    
  function( cat, s, a, b, r )
    local unit, tensor_product_on_a_and_b, morphism;
    
    #         (a ⊗ b)_v
    #            |
    #            V
    #      coHom(1, a ⊗ b)
    #            |
    #            | coHom((λ_1)^-1, id_(a ⊗ b))
    #            V
    #  coHom(1 ⊗ 1, a ⊗ b)
    #            |
    #            | CompatMorphism(1,1,a,b)
    #            V
    # coHom(1,a) ⊗ coHom(1,b)
    #            |
    #            v
    #        a_v ⊗ b_v
    
    unit := TensorUnit( cat );
    
    tensor_product_on_a_and_b := TensorProductOnObjects( cat, a, b );
    
    morphism := PreComposeList( cat,
                        s,
                        [ IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit( cat, tensor_product_on_a_and_b ),
                          
                          LeftInternalCoHomOnMorphisms( cat,
                                  LeftUnitorInverse( cat, unit ),
                                  IdentityMorphism( cat, tensor_product_on_a_and_b ) ),
                          
                          LeftInternalCoHomTensorProductCompatibilityMorphism( cat, [ unit, unit, a, b ] ),
                          
                          TensorProductOnMorphisms( cat,
                                  IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( cat, a ),
                                  IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( cat, b ) ) ],
                        r );
    
    return morphism;
    
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom,
                    "IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom using the coclosed coevaluation morphism",
                    [ [ TensorUnit, 1 ],
                      [ PreCompose, 1 ],
                      [ LeftInternalCoHomOnMorphisms, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftCoclosedMonoidalCoevaluationMorphism, 1 ] ],
                    
  function( cat, a, internal_cohom )
    local unit;
    
    #     coHom(a, 1)
    #         |
    #         | coHom((ρ_a)^-1, id_1)
    #         v
    # coHom(a ⊗ 1, 1)
    #         |
    #         | coclcoev_(a,1)
    #         v
    #         a
    
    unit := TensorUnit( cat );
    
    return PreCompose( cat,
                   LeftInternalCoHomOnMorphisms( cat,
                           RightUnitorInverse( cat, a ),
                           IdentityMorphism( cat, unit ) ),
                   
                   LeftCoclosedMonoidalCoevaluationMorphism( cat, a, unit ) );
    
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom,
                    "IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom as the adjoint of the right inverse unitor",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductToLeftInternalCoHomAdjunctionMap, 1 ],
                      [ RightUnitorInverse, 1 ] ],
                    
  function( cat, a, internal_cohom )
    
    # (ρ_a)^-1: a → a ⊗ 1
    #
    # Adjoint( (ρ_a)^-1 ) = ( coHom(a,1) → a )
    
    return TensorProductToLeftInternalCoHomAdjunctionMap( cat,
                   a,
                   TensorUnit( cat ),
                   RightUnitorInverse( cat, a ) );
    
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom,
#                     
#   function( cat, a, internal_cohom )
#
#     # Inverse( a → coHom(a,1) )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToLeftInternalCoHom( cat, a ) );
#     
# end : CategoryFilter := IsLeftCoclosedMonoidalCategory,
#       Description := "IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom as the inverse of IsomorphismFromObjectToLeftInternalCoHom" );

##
AddDerivationToCAP( IsomorphismFromObjectToLeftInternalCoHomWithGivenLeftInternalCoHom,
                    "IsomorphismFromObjectToLeftInternalCoHomWithGivenLeftInternalCoHom using the coclosed evaluation morphism",
                    [ [ TensorUnit, 1 ],
                      [ PreCompose, 1 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 1 ],
                      [ RightUnitor, 1 ] ],
                    
  function( cat, a, internal_cohom )
    
    #       a
    #       |
    #       | coclev_(a,1)
    #       v
    # coHom(a,1) ⊗ 1
    #       |
    #       | ρ_coHom(a,1)
    #       v
    #   coHom(a,1)
    
    return PreCompose( cat,
                   LeftCoclosedMonoidalEvaluationMorphism( cat, a, TensorUnit( cat ) ),
                   RightUnitor( cat, internal_cohom ) );
    
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToLeftInternalCoHomWithGivenLeftInternalCoHom,
#                     
#   function( cat, a, internal_cohom )
#
#     # Inverse( coHom(a,1) → a)
#     
#     return InverseForMorphisms( cat, IsomorphismFromLeftInternalCoHomToObject( cat, a ) );
#     
# end : CategoryFilter := IsLeftClosedMonoidalCategory,
#       Description := "IsomorphismFromObjectToLeftInternalCoHom as the inverse of IsomorphismFromLeftInternalCoHomToObject" );

##
AddDerivationToCAP( MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects,
                    "MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects using LeftInternalCoHomTensorProductCompatibilityMorphism",
                    [ [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ LeftInternalCoHomOnMorphisms, 1 ],
                      [ LeftUnitorInverse, 1 ],
                      [ RightUnitor, 1 ],
                      [ LeftInternalCoHomTensorProductCompatibilityMorphism, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject, 1 ],
                      [ IsomorphismFromLeftInternalCoHomToObject, 1 ] ],
                    
  function( cat, internal_cohom, a, b, tensor_object )
    local unit;
    
    #       coHom(a,b)
    #            |
    #            | coHom((λ_a)^-1, ρ_b)
    #            v
    # coHom(1 ⊗ a, b ⊗ 1)
    #            |
    #            | CompatMorphism
    #            v
    # coHom(1,b) ⊗ coHom(a,1)
    #            |
    #            v
    #        b_v ⊗ a
    
    unit := TensorUnit( cat );
    
    return PreComposeList( cat,
                   internal_cohom,
                   [ LeftInternalCoHomOnMorphisms( cat,
                           LeftUnitorInverse( cat, a ),
                           RightUnitor( cat, b ) ),
                     
                     LeftInternalCoHomTensorProductCompatibilityMorphism( cat,
                             [ unit, a, b, unit ] ),
                     
                     TensorProductOnMorphisms( cat,
                             IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( cat, b ),
                             IsomorphismFromLeftInternalCoHomToObject( cat, a ) ) ],
                   tensor_object );
    
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects,
                    "LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects using associator, coclosed evaluation, and cohom tensor adjunction",
                    [ [ LeftInternalCoHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local cohom_a_b, cohom_b_c, morphism;
    
    #             a
    #             |
    #             | coclev_ab
    #             v
    #      coHom(a,b) ⊗ b
    #             |
    #             | id_coHom(a,b) ⊗ coclev_bc
    #             v
    #  coHom(a,b) ⊗ (coHom(b,c) ⊗ c)
    #             |
    #             | α_( coHom(a,b), ( coHom(b,c), c ) )
    #             v
    # (coHom(a,b) ⊗ coHom(b,c)) ⊗ c
    #
    #
    # Adjoint( a → (coHom(a,b) ⊗ coHom(b,c)) ⊗ c ) = ( coHom(a,c) → coHom(a,b) ⊗ coHom(b,c) )
    
    cohom_a_b := LeftInternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := LeftInternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ LeftCoclosedMonoidalEvaluationMorphism( cat, a, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, cohom_a_b ),
                                  LeftCoclosedMonoidalEvaluationMorphism( cat, b, c ) ),
                          
                          AssociatorRightToLeft( cat, cohom_a_b, cohom_b_c, c ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                    "LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects using compatibility of internal cohom and tensor product",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit, 1 ],
                      [ LeftInternalCoHomTensorProductCompatibilityMorphism, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject, 2 ] ],
                    
  function( cat, source, a, b, range )
    local unit, morphism;
    
    #         (a ⊗ b)_v
    #            |
    #            V
    #      coHom(1, a ⊗ b)
    #            |
    #            | CompatMorphism(1,1,a,b)
    #            V
    # coHom(1,a) ⊗ coHom(1,b)
    #            |
    #            v
    #        a_v ⊗ b_v
    
    unit := TensorUnit( cat );
    
    morphism := PreComposeList( cat,
                        source,
                        [ IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit( cat,
                                TensorProductOnObjects( cat, a, b ) ),
                          
                          LeftInternalCoHomTensorProductCompatibilityMorphism( cat, [ unit, unit, a, b ] ),
                          
                          TensorProductOnMorphisms( cat,
                                  IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( cat, a ),
                                  IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( cat, b ) ) ],
                        range );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsLeftCoclosedMonoidalCategory( cat ) and IsLeftCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects,
                    "LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects using coclosed evaluation, and cohom tensor adjunction",
                    [ [ LeftInternalCoHomOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local morphism;
    
    #             a
    #             |
    #             | coclev_ab
    #             v
    #      coHom(a,b) ⊗ b
    #             |
    #             | id_coHom(a,b) ⊗ coclev_bc
    #             v
    #  coHom(a,b) ⊗ (coHom(b,c) ⊗ c)
    #
    #
    # Adjoint( a → (coHom(a,b) ⊗ coHom(b,c)) ⊗ c ) = ( coHom(a,c) → coHom(a,b) ⊗ coHom(b,c) )
    
    morphism := PreComposeList( cat,
                        a,
                        [ LeftCoclosedMonoidalEvaluationMorphism( cat, a, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, LeftInternalCoHomOnObjects( cat, a, b ) ),
                                  LeftCoclosedMonoidalEvaluationMorphism( cat, b, c ) ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsLeftCoclosedMonoidalCategory( cat ) and IsLeftCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

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
                      MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects ],
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
