# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToInternalCoHomLeftAdjunctionMap,
                    "TensorProductToInternalCoHomLeftAdjunctionMap using CoclosedMonoidalLeftCoevaluationMorphism and InternalCoHom",
                    [ [ PreCompose, 1 ],
                      [ InternalCoHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CoclosedMonoidalLeftCoevaluationMorphism, 1 ] ],
                    
  function( cat, c, b, g )
    
    # g: a → c ⊗ b
    #
    #    coHom(a,b)
    #        |
    #        | coHom(g, id_b)
    #        v
    # coHom(c ⊗ b, b)
    #        |
    #        | coclcoev_bc
    #        v
    #        c

    return PreCompose( cat,
             InternalCoHomOnMorphisms( cat, g, IdentityMorphism( cat, b ) ),
             CoclosedMonoidalLeftCoevaluationMorphism( cat, b, c ) );
             
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductToInternalCoHomLeftAdjunctionMapWithGivenInternalCoHom,
                    "TensorProductToInternalCoHomLeftAdjunctionMapWithGivenInternalCoHom using CoclosedMonoidalLeftCoevaluationMorphism and InternalCoHom",
                    [ [ CoclosedMonoidalLeftCoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ InternalCoHomOnMorphismsWithGivenInternalCoHoms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, c, b, g, i )
    local coclcoev_bc;
    
    # g: a → c ⊗ b
    #
    #    coHom(a,b)
    #        |
    #        | coHom(g, id_b)
    #        v
    # coHom(c ⊗ b, b)
    #        |
    #        | coclcoev_bc
    #        v
    #        c
    
    coclcoev_bc := CoclosedMonoidalLeftCoevaluationMorphism( cat, b, c );
    
    return PreCompose( cat,
             InternalCoHomOnMorphismsWithGivenInternalCoHoms( cat, i, g, IdentityMorphism( cat, b ), Source( coclcoev_bc ) ),
             coclcoev_bc );
    
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( InternalCoHomToTensorProductLeftAdjunctionMap,
                    "InternalCoHomToTensorProductLeftAdjunctionMap using TensorProductOnMorphisms and CoclosedMonoidalLeftEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ CoclosedMonoidalLeftEvaluationMorphism, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f )
    
    # f: coHom(a,b) → c
    #
    #        a
    #        |
    #        | coclev_ba
    #        v
    # coHom(a,b) ⊗ b
    #        |
    #        | f ⊗ id_b
    #        v
    #      c ⊗ b
    
    return PreCompose( cat,
             CoclosedMonoidalLeftEvaluationMorphism( cat, b, a ),
             TensorProductOnMorphisms( cat, f, IdentityMorphism( cat, b ) ) );
             
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( InternalCoHomToTensorProductLeftAdjunctionMapWithGivenTensorProduct,
                    "InternalCoHomToTensorProductLeftAdjunctionMapWithGivenTensorProduct using TensorProductOnMorphisms and CoclosedMonoidalLeftEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ CoclosedMonoidalLeftEvaluationMorphism, 1 ],
                      [ TensorProductOnMorphismsWithGivenTensorProducts, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f, t )
    local coclev_ba;
    
    # f: coHom(a,b) → c
    #
    #        a
    #        |
    #        | coclev_ba
    #        v
    # coHom(a,b) ⊗ b
    #        |
    #        | f ⊗ id_b
    #        v
    #      c ⊗ b
    
    coclev_ba := CoclosedMonoidalLeftEvaluationMorphism( cat, b, a );
    
    return PreCompose( cat,
             coclev_ba,
             TensorProductOnMorphismsWithGivenTensorProducts( cat, Range( coclev_ba ), f, IdentityMorphism( cat, b ), t ) );
             
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoclosedMonoidalLeftEvaluationMorphismWithGivenRange,
                    "CoclosedMonoidalLeftEvaluationMorphismWithGivenRange using the cohom tensor adjunction on the identity",
                    [ [ InternalCoHomToTensorProductLeftAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ InternalCoHomOnObjects, 1 ] ],
                    
  function( cat, a, b, tensor_object )
    
    # Adjoint( id_coHom(b,a): coHom(b,a) → coHom(b,a) ) = ( b → coHom(b,a) ⊗ a )
    
    return InternalCoHomToTensorProductLeftAdjunctionMap( cat,
             b, a,
             IdentityMorphism( cat, InternalCoHomOnObjects( cat, b, a ) ) );
    
end : CategoryFilter := IsCoclosedMonoidalCategory );

AddDerivationToCAP( CoclosedMonoidalLeftCoevaluationMorphismWithGivenSource,
                    "CoclosedMonoidalLeftCoevaluationMorphismWithGivenSource using the cohom tensor adjunction on the identity",
                    [ [ TensorProductToInternalCoHomLeftAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_cohom )
    
    # Adjoint( id_(b ⊗ a): b ⊗ a → b ⊗ a ) = ( coHom(b ⊗ a, a) → b )
    
    return TensorProductToInternalCoHomLeftAdjunctionMap( cat,
             b, a,
             IdentityMorphism( cat, TensorProductOnObjects( cat, b, a ) ) );
    
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( UniversalPropertyOfCoDual,
                    "UniversalPropertyOfCoDual using the cohom tensor adjunction",
                    [ [ PreCompose, 1 ],
                      [ IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit, 1 ],
                      [ TensorProductToInternalCoHomLeftAdjunctionMap, 1 ] ],
                    
  function( cat, t, a, alpha )
    
    # alpha: 1 → t ⊗ a
    #
    # a_v → ( coHom(1,a) → t ) = Adjoint( alpha )
    
    return PreCompose( cat,
             IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( cat, a ),
             TensorProductToInternalCoHomLeftAdjunctionMap( cat, t, a, alpha ) );
             
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoDualOnObjects,
                    "CoDualOnObjects as the source of IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit",
                    [ [ IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit, 1 ] ],
                    
  function( cat, a )
    
    # Source( a_v → coHom(1,a) )
    
    return Source( IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( cat, a ) );

end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoDualOnObjects,
                    "CoDualOnObjects as the range of IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject",
                    [ [ IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject, 1 ] ],
                    
  function( cat, a )
    
    # Range( coHom(1,a) → a_v )
    
    return Range( IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat, a ) );

end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoDualOnMorphismsWithGivenCoDuals,
                    "CoDualOnMorphismsWithGivenCoDuals using InternalCoHomOnMorphisms and IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit",
                    [ [ PreComposeList, 1 ],
                      [ IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit, 1 ],
                      [ InternalCoHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorUnit, 1 ],
                      [ IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject, 1 ] ],
                    
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
                   [ IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( cat, Range( alpha ) ),
                     
                     InternalCoHomOnMorphisms( cat,
                             IdentityMorphism( cat, TensorUnit( cat ) ),
                             alpha ),
                     
                     IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat, Source( alpha ) ) ],
                   r );
    
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoclosedEvaluationForCoDualWithGivenTensorProduct,
                    "CoclosedEvaluationForCoDualWithGivenTensorProduct using the cohom tensor adjunction and IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject",
                    [ [ InternalCoHomToTensorProductLeftAdjunctionMap, 1 ],
                      [ IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject, 1 ] ],
                    
  function( cat, s, a, r )
    
    # s := 1
    #
    # Adjoint( coHom(1,a) → a_v ) = ( 1 → a_v ⊗ a )

    return InternalCoHomToTensorProductLeftAdjunctionMap( cat,
            s,
            a,
            IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat, a ) );

end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoLambdaIntroduction,
                    "CoLambdaIntroduction using the cohom tensor adjunction and the left unitor inverse",
                    [ [ PreCompose, 1 ],
                      [ LeftUnitorInverse, 1 ],
                      [ TensorProductToInternalCoHomLeftAdjunctionMap, 1 ],
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

    return TensorProductToInternalCoHomLeftAdjunctionMap( cat,
                   TensorUnit( cat ),
                   range,
                   result_morphism );
    
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoLambdaElimination,
                    "CoLambdaElimination using the cohom tensor adjunction and the left unitor",
                    [ [ InternalCoHomToTensorProductLeftAdjunctionMap, 1 ],
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
    
    result_morphism := InternalCoHomToTensorProductLeftAdjunctionMap( cat, a, b, alpha );
    
    return PreCompose( cat, result_morphism, LeftUnitor( cat, b ) );
    
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                    "CoDualityTensorProductCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of internal cohom and tensor product",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit, 1 ],
                      [ InternalCoHomOnMorphisms, 1 ],
                      [ LeftUnitorInverse, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ InternalCoHomTensorProductCompatibilityMorphism, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject, 2 ] ],
                    
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
                        [ IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( cat, tensor_product_on_a_and_b ),
                          
                          InternalCoHomOnMorphisms( cat,
                                  LeftUnitorInverse( cat, unit ),
                                  IdentityMorphism( cat, tensor_product_on_a_and_b ) ),
                          
                          InternalCoHomTensorProductCompatibilityMorphism( cat, [ unit, unit, a, b ] ),
                          
                          TensorProductOnMorphisms( cat,
                                  IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat, a ),
                                  IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat, b ) ) ],
                        r );
    
    return morphism;
    
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom,
                    "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom using the coclosed coevaluation morphism",
                    [ [ TensorUnit, 1 ],
                      [ PreCompose, 1 ],
                      [ InternalCoHomOnMorphisms, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CoclosedMonoidalLeftCoevaluationMorphism, 1 ] ],
                    
  function( cat, a, internal_cohom )
    local unit;
    
    #     coHom(a, 1)
    #         |
    #         | coHom((ρ_a)^-1, id_1)
    #         v
    # coHom(a ⊗ 1, 1)
    #         |
    #         | coclcoev_(1,a)
    #         v
    #         a
    
    unit := TensorUnit( cat );
    
    return PreCompose( cat,
                   InternalCoHomOnMorphisms( cat,
                           RightUnitorInverse( cat, a ),
                           IdentityMorphism( cat, unit ) ),
                   
                   CoclosedMonoidalLeftCoevaluationMorphism( cat, unit, a ) );
    
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom,
                    "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom as the adjoint of the right inverse unitor",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductToInternalCoHomLeftAdjunctionMap, 1 ],
                      [ RightUnitorInverse, 1 ] ],
                    
  function( cat, a, internal_cohom )
    
    # (ρ_a)^-1: a → a ⊗ 1
    #
    # Adjoint( (ρ_a)^-1 ) = ( coHom(a,1) → a )
    
    return TensorProductToInternalCoHomLeftAdjunctionMap( cat,
                   a,
                   TensorUnit( cat ),
                   RightUnitorInverse( cat, a ) );
    
end : CategoryFilter := IsCoclosedMonoidalCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom,
#                     
#   function( cat, a, internal_cohom )
#
#     # Inverse( a → coHom(a,1) )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToInternalCoHom( cat, a ) );
#     
# end : CategoryFilter := IsCoclosedMonoidalCategory,
#       Description := "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom as the inverse of IsomorphismFromObjectToInternalCoHom" );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom,
                    "IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom using the coclosed evaluation morphism",
                    [ [ TensorUnit, 1 ],
                      [ PreCompose, 1 ],
                      [ CoclosedMonoidalLeftEvaluationMorphism, 1 ],
                      [ RightUnitor, 1 ] ],
                    
  function( cat, a, internal_cohom )
    
    #       a
    #       |
    #       | coclev_(1,a)
    #       v
    # coHom(a,1) ⊗ 1
    #       |
    #       | ρ_coHom(a,1)
    #       v
    #   coHom(a,1)
    
    return PreCompose( cat,
                   CoclosedMonoidalLeftEvaluationMorphism( cat, TensorUnit( cat ), a ),
                   RightUnitor( cat, internal_cohom ) );
    
end : CategoryFilter := IsCoclosedMonoidalCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom,
#                     
#   function( cat, a, internal_cohom )
#
#     # Inverse( coHom(a,1) → a)
#     
#     return InverseForMorphisms( cat, IsomorphismFromInternalCoHomToObject( cat, a ) );
#     
# end : CategoryFilter := IsClosedMonoidalCategory,
#       Description := "IsomorphismFromObjectToInternalCoHom as the inverse of IsomorphismFromInternalCoHomToObject" );

##
AddDerivationToCAP( MorphismFromInternalCoHomToTensorProductWithGivenObjects,
                    "MorphismFromInternalCoHomToTensorProductWithGivenObjects using InternalCoHomTensorProductCompatibilityMorphism",
                    [ [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ InternalCoHomOnMorphisms, 1 ],
                      [ LeftUnitorInverse, 1 ],
                      [ RightUnitor, 1 ],
                      [ InternalCoHomTensorProductCompatibilityMorphism, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject, 1 ],
                      [ IsomorphismFromInternalCoHomToObject, 1 ] ],
                    
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
                   [ InternalCoHomOnMorphisms( cat,
                           LeftUnitorInverse( cat, a ),
                           RightUnitor( cat, b ) ),
                     
                     InternalCoHomTensorProductCompatibilityMorphism( cat,
                             [ unit, a, b, unit ] ),
                     
                     TensorProductOnMorphisms( cat,
                             IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat, b ),
                             IsomorphismFromInternalCoHomToObject( cat, a ) ) ],
                   tensor_object );
    
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    "MonoidalPostCoComposeMorphismWithGivenObjects using associator, coclosed evaluation, and cohom tensor adjunction",
                    [ [ InternalCoHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CoclosedMonoidalLeftEvaluationMorphism, 2 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ TensorProductToInternalCoHomLeftAdjunctionMapWithGivenInternalCoHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local cohom_a_b, cohom_b_c, morphism;
    
    #             a
    #             |
    #             | coclev_ba
    #             v
    #      coHom(a,b) ⊗ b
    #             |
    #             | id_coHom(a,b) ⊗ coclev_cb
    #             v
    #  coHom(a,b) ⊗ (coHom(b,c) ⊗ c)
    #             |
    #             | α_( coHom(a,b), ( coHom(b,c), c ) )
    #             v
    # (coHom(a,b) ⊗ coHom(b,c)) ⊗ c
    #
    #
    # Adjoint( a → (coHom(a,b) ⊗ coHom(b,c)) ⊗ c ) = ( coHom(a,c) → coHom(a,b) ⊗ coHom(b,c) )
    
    cohom_a_b := InternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := InternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ CoclosedMonoidalLeftEvaluationMorphism( cat, b, a ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, cohom_a_b ),
                                  CoclosedMonoidalLeftEvaluationMorphism( cat, c, b ) ),
                          
                          AssociatorRightToLeft( cat, cohom_a_b, cohom_b_c, c ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToInternalCoHomLeftAdjunctionMapWithGivenInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := IsCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                    "CoDualityTensorProductCompatibilityMorphismWithGivenObjects using compatibility of internal cohom and tensor product",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit, 1 ],
                      [ InternalCoHomTensorProductCompatibilityMorphism, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject, 2 ] ],
                    
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
                        [ IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( cat,
                                TensorProductOnObjects( cat, a, b ) ),
                          
                          InternalCoHomTensorProductCompatibilityMorphism( cat, [ unit, unit, a, b ] ),
                          
                          TensorProductOnMorphisms( cat,
                                  IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat, a ),
                                  IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat, b ) ) ],
                        range );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsCoclosedMonoidalCategory( cat ) and IsCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    "MonoidalPostCoComposeMorphismWithGivenObjects using coclosed evaluation, and cohom tensor adjunction",
                    [ [ InternalCoHomOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ CoclosedMonoidalLeftEvaluationMorphism, 2 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductToInternalCoHomLeftAdjunctionMapWithGivenInternalCoHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local morphism;
    
    #             a
    #             |
    #             | coclev_ba
    #             v
    #      coHom(a,b) ⊗ b
    #             |
    #             | id_coHom(a,b) ⊗ coclev_cb
    #             v
    #  coHom(a,b) ⊗ (coHom(b,c) ⊗ c)
    #
    #
    # Adjoint( a → (coHom(a,b) ⊗ coHom(b,c)) ⊗ c ) = ( coHom(a,c) → coHom(a,b) ⊗ coHom(b,c) )
    
    morphism := PreComposeList( cat,
                        a,
                        [ CoclosedMonoidalLeftEvaluationMorphism( cat, b, a ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, InternalCoHomOnObjects( cat, a, b ) ),
                                  CoclosedMonoidalLeftEvaluationMorphism( cat, c, b ) ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToInternalCoHomLeftAdjunctionMapWithGivenInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsCoclosedMonoidalCategory( cat ) and IsCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

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
                      MorphismFromInternalCoHomToTensorProductWithGivenObjects ],
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
