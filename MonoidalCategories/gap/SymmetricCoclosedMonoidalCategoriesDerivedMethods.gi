# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

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
             
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromLeftCoBidualWithGivenLeftCoBidual,
                    "MorphismFromLeftCoBidualWithGivenLeftCoBidual using the braiding and the universal property of the codual",
                    [ [ PreCompose, 1 ],
                      [ LeftCoclosedMonoidalEvaluationForLeftCoDual, 1 ],
                      [ Braiding, 1 ],
                      [ LeftCoDualOnObjects, 2 ],
                      [ UniversalPropertyOfLeftCoDual, 1 ] ],
                    
  function( cat, a, avv )
    local alpha;
    
    #    1
    #    |
    #    | coclev_a
    #    v
    # a_v ⊗ a
    #    |
    #    | B_(a_v,a)
    #    v
    #  a ⊗ a_v
    #
    #
    # UniversalPropertyOfLeftCoDual( 1 → a ⊗ a_v) = ( a_v_v → a )

    alpha := PreCompose( cat,
                  LeftCoclosedMonoidalEvaluationForLeftCoDual( cat, a ),
                  Braiding( cat, LeftCoDualOnObjects( cat, a ), a ) );
                  
    return UniversalPropertyOfLeftCoDual( cat, a, LeftCoDualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromLeftCoBidualWithGivenLeftCoBidual,
                    "MorphismFromLeftCoBidualWithGivenLeftCoBidual using LeftCoclosedMonoidalEvaluation, LeftInternalCoHom, and LeftCoclosedMonoidalCoevaluation",
                    [ [ LeftCoDualOnObjects, 1 ],
                      [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ LeftInternalCoHomOnMorphisms, 2 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 1 ],
                      [ LeftCoclosedMonoidalCoevaluationMorphism, 1 ] ],
                    
  function( cat, a, avv )
    local av, morphism;
    
    #     coHom(1, a_v)
    #          |
    #          | coHom( coclev_(1,a), id_(a_v) )
    #          v
    # coHom(a_v ⊗ a, a_v)
    #          |
    #          | coHom( B_( a_v, a), id_(a_v) )
    #          v
    # coHom(a ⊗ a_v, a_v)
    #          |
    #          | coclcoev_(a, a_v)
    #          v
    #          a
    
    av := LeftCoDualOnObjects( cat, a );
    
    morphism := PreComposeList( cat,
                        avv,
                        [ LeftInternalCoHomOnMorphisms( cat,
                                LeftCoclosedMonoidalEvaluationMorphism( cat, TensorUnit( cat ), a ),
                                IdentityMorphism( cat, av ) ),
                          
                          LeftInternalCoHomOnMorphisms( cat,
                                  Braiding( cat, av, a ),
                                  IdentityMorphism( cat, av ) ),
                          
                          LeftCoclosedMonoidalCoevaluationMorphism( cat, a, av ) ],
                        a );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoDualOnObjects,
                    "LeftCoDualOnObjects as the source of IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit",
                    [ [ IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit, 1 ] ],
                    
  function( cat, a )
    
    # Source( a_v → coHom(1,a) )
    
    return Source( IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit( cat, a ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoDualOnObjects,
                    "LeftCoDualOnObjects as the range of IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject",
                    [ [ IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject, 1 ] ],
                    
  function( cat, a )
    
    # Range( coHom(1,a) → a_v )
    
    return Range( IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( cat, a ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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
    local result_morphism;
    
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
    
    result_morphism := PreComposeList( cat,
                               s,
                               [ IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit( cat, Range( alpha ) ),
                                 
                                 LeftInternalCoHomOnMorphisms( cat,
                                         IdentityMorphism( cat, TensorUnit( cat ) ),
                                         alpha ),
                                 
                                 IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( cat, Source( alpha ) ) ],
                               r );
    
    return result_morphism;
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalEvaluationForLeftCoDualWithGivenTensorProduct,
                    "LeftCoclosedMonoidalEvaluationForLeftCoDualWithGivenTensorProduct using the cohom tensor adjunction and IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject",
                    [ [ LeftInternalCoHomToTensorProductAdjunctionMap, 1 ],
                      [ IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject, 1 ] ],
                    
  function( cat, s, a, r )
    
    # s := 1
    
    # Adjoint( coHom(1,a) → a_v ) = ( 1 → a_v ⊗ a )

    return LeftInternalCoHomToTensorProductAdjunctionMap( cat,
            s,
            a,
            IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( cat, a ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                    "LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using associator, braiding and the coclosed evaluation morphism",
                    [ [ LeftInternalCoHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 7 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 2 ],
                      [ AssociatorRightToLeft, 2 ],
                      [ AssociatorLeftToRight, 2 ],
                      [ Braiding, 1 ],
                      [ TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, a2, b1, b2, b1b2, int_cohom_a1_b1, int_cohom_a2_b2, id_b2, morphism;
    
    #                   a1 ⊗ a2
    #                      |
    #                      | id_a1 ⊗ coclev_(a2,b2)
    #                      v
    #          a1 ⊗ (coHom(a2,b2) ⊗ b2)
    #                      |
    #                      | α_( a1, (coHom(a2,b2), b2) )
    #                      v
    #          (a1 ⊗ coHom(a2,b2)) ⊗ b2
    #                      |
    #                      | ( coclev_(a1,b1) ⊗ id_coHom(a2,b2) ) ⊗ id_b2
    #                      v
    # ((coHom(a1,b1) ⊗ b1) ⊗ coHom(a2,b2)) ⊗ b2
    #                      |
    #                      | α_( (coHom(a1,b1), b1), coHom(a2,b2) ) ) ⊗ id_b2
    #                      v
    #  (coHom(a1,b1) ⊗ (b1 ⊗ coHom(a2,b2))) ⊗ b2
    #                      |
    #                      | ( id_coHom(a1,b1) ⊗ B_( b1, coHom(a2,b2) ) ) ⊗ id_b2
    #                      v
    #  (coHom(a1,b1) ⊗ (coHom(a2,b2) ⊗ b1)) ⊗ b2
    #                      |
    #                      | α_( coHom(a1,b1), (coHom(a2,b2), b1) ) ⊗ id_b2
    #                      v
    #  ((coHom(a1,b1) ⊗ coHom(a2,b2)) ⊗ b1) ⊗ b2
    #                      |
    #                      | α_( (coHom(a1,b1) ⊗ coHom(a2,b2), b1), b2 )
    #                      v
    #  (coHom(a1,b1) ⊗ coHom(a2,b2)) ⊗ (b1 ⊗ b2)
    #
    #
    # Adjoint[ a1 ⊗ a2 → (coHom(a1,b1) ⊗ coHom(a2,b2)) ⊗ (b1 ⊗ b2) ] = [ coHom(a1 ⊗ a2, b1 ⊗ b2) → coHom(a1,b1) ⊗ coHom(a2,b2) ]
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    b1b2 := TensorProductOnObjects( cat, b1, b2 );
    
    int_cohom_a1_b1 := LeftInternalCoHomOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := LeftInternalCoHomOnObjects( cat, a2, b2 );
    
    id_b2 := IdentityMorphism( cat, b2 );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat, a1, a2 ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, a1 ),
                                LeftCoclosedMonoidalEvaluationMorphism( cat, a2, b2 ) ),
                          
                          AssociatorRightToLeft( cat, a1, int_cohom_a2_b2, b2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          LeftCoclosedMonoidalEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, int_cohom_a2_b2 ) ),
                                  id_b2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  AssociatorLeftToRight( cat, int_cohom_a1_b1, b1, int_cohom_a2_b2 ),
                                  id_b2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          IdentityMorphism( cat, int_cohom_a1_b1 ),
                                          Braiding( cat, b1, int_cohom_a2_b2 ) ),
                                  id_b2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  AssociatorRightToLeft( cat, int_cohom_a1_b1, int_cohom_a2_b2, b1 ),
                                  id_b2 ),
                          
                          AssociatorLeftToRight( cat,
                                  range,
                                  b1, b2 ) ],
                        TensorProductOnObjects( cat,
                                range,
                                b1b2 ) );
    
    return TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom( cat,
                   range,
                   b1b2,
                   morphism,
                   source );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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
# end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
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
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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
# end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
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
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalEvaluationMorphismWithGivenRange,
                    "LeftCoclosedMonoidalEvaluationMorphismWithGivenRange using the cohom tensor adjunction on the identity",
                    [ [ LeftInternalCoHomToTensorProductAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftInternalCoHomOnObjects, 1 ] ],
                    
  function( cat, a, b, tensor_object )
    
    # Adjoint( id_coHom(a,b): coHom(a,b) → coHom(a,b) ) = ( a → coHom(a,b) ⊗ b )
    
    return LeftInternalCoHomToTensorProductAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, LeftInternalCoHomOnObjects( cat, a, b ) )
           );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

AddDerivationToCAP( LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource,
                    "LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource using the cohom tensor adjunction on the identity",
                    [ [ TensorProductToLeftInternalCoHomAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_cohom )
    
    # Adjoint( id_(a ⊗ b): a ⊗ b → a ⊗ b ) = ( coHom(a ⊗ b, b) → a )
    
    return TensorProductToLeftInternalCoHomAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, TensorProductOnObjects( cat, a, b ) )
           );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects,
                    "LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects using associator, braiding, coclosed evaluation, and cohom tensor adjunction",
                    [ [ LeftInternalCoHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local cohom_a_b, cohom_b_c, morphism;
    
    #           a
    #           |
    #           | coclev_ab
    #           v
    #    coHom(a,b) ⊗ b
    #           |
    #           | B_( coHom(a,b), b )
    #           v
    #      b ⊗ coHom(a,b)
    #           |
    #           | coclev_bc ⊗ id_coHom(a,b)
    #           v
    # (coHom(b,c) ⊗ c) ⊗ coHom(a,b)
    #           |
    #           | α_( ( coHom(b,c), c ), coHom(a,b) )
    #           v
    # coHom(b,c) ⊗ (c ⊗ coHom(a,b))
    #           |
    #           | id_coHom(b,c) ⊗ B_( c, coHom(a,b) )
    #           v
    # coHom(b,c) ⊗ (coHom(a,b) ⊗ c)
    #           |
    #           | α_( coHom(b,c), ( coHom(a,b), c ) )
    #           v
    # (coHom(b,c) ⊗ coHom(a,b)) ⊗ c
    #
    #
    # Adjoint( a → (coHom(b,c) ⊗ coHom(a,b)) ⊗ c ) = ( coHom(a,c) → coHom(b,c) ⊗ coHom(a,b) )
    
    cohom_a_b := LeftInternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := LeftInternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ LeftCoclosedMonoidalEvaluationMorphism( cat, a, b ),
                          
                          Braiding( cat, cohom_a_b, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  LeftCoclosedMonoidalEvaluationMorphism( cat, b, c ),
                                  IdentityMorphism( cat, cohom_a_b ) ),
                          
                          AssociatorLeftToRight( cat, cohom_b_c, c, cohom_a_b ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, cohom_b_c ),
                                  Braiding( cat, c, cohom_a_b ) ),
                          
                          AssociatorRightToLeft( cat, cohom_b_c, cohom_a_b, c ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects,
                    "LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects using LeftCoclosedMonoidalPreCoComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ LeftInternalCoHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ LeftCoclosedMonoidalPreCoComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;
    
    #       coHom(a,c)
    #            |
    #            | PreCoCompose
    #            v
    # coHom(b,c) ⊗ coHom(a,b)
    #            |
    #            | B_( coHom(b,c), coHom(a,b) )
    #            v
    # coHom(a,b) ⊗ coHom(b,c)
    
    braiding := Braiding( cat, LeftInternalCoHomOnObjects( cat, b, c ), LeftInternalCoHomOnObjects( cat, a, b ) );
    
    return PreCompose( cat, LeftCoclosedMonoidalPreCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects,
                    "LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects using LeftCoclosedMonoidalPostCoComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ LeftInternalCoHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ LeftCoclosedMonoidalPostCoComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;
    
    #       coHom(a,c)
    #            |
    #            | PostCoCompose
    #            v
    # coHom(a,b) ⊗ coHom(b,c)
    #            |
    #            | B_( coHom(a,b), coHom(b,c) )
    #            v
    # coHom(b,c) ⊗ coHom(a,b)

    braiding := Braiding( cat, LeftInternalCoHomOnObjects( cat, a, b ), LeftInternalCoHomOnObjects( cat, b, c ) );
    
    return PreCompose( cat, LeftCoclosedMonoidalPostCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                    "LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using braiding and the coclosed evaluation morphism",
                    [ [ LeftInternalCoHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 5 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 2 ],
                      [ Braiding, 1 ],
                      [ TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, a2, b1, b2, b1b2, int_cohom_a1_b1, int_cohom_a2_b2, id_b2, morphism;
    
    #           a1 ⊗ a2
    #              |
    #              | id_a1 ⊗ coclev_(a2,b2)
    #              v
    #    a1 ⊗ coHom(a2,b2) ⊗ b2
    #              |
    #              | coclev_(a1,b1) ⊗ id_coHom(a2,b2) ⊗ id_b2
    #              v
    # coHom(a1,b1) ⊗ b1 ⊗ coHom(a2,b2) ⊗ b2
    #              |
    #              | id_coHom(a1,b1) ⊗ B_( b1, coHom(a2,b2) )  ⊗ id_b2
    #              v
    # coHom(a1,b1) ⊗ coHom(a2,b2) ⊗ b1 ⊗ b2
    #
    #
    # Adjoint[ a1 ⊗ a2 → coHom(a1,b1) ⊗ coHom(a2,b2) ⊗ b1 ⊗ b2 ] = [ coHom(a1 ⊗ a2, b1 ⊗ b2) → coHom(a1,b1) ⊗ coHom(a2,b2) ]
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    b1b2 := TensorProductOnObjects( cat, b1, b2 );
    
    int_cohom_a1_b1 := LeftInternalCoHomOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := LeftInternalCoHomOnObjects( cat, a2, b2 );

    id_b2 := IdentityMorphism( cat, b2 );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat, a1, a2 ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, a1 ),
                                LeftCoclosedMonoidalEvaluationMorphism( cat, a2, b2 ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          LeftCoclosedMonoidalEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, int_cohom_a2_b2 ) ),
                                  id_b2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          IdentityMorphism( cat, int_cohom_a1_b1 ),
                                          Braiding( cat, b1, int_cohom_a2_b2 ) ),
                                  id_b2 ) ],
                        TensorProductOnObjects( cat,
                                range,
                                b1b2 ) );
    
    return TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom( cat,
                   range,
                   b1b2,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsSymmetricCoclosedMonoidalCategory( cat ) and IsSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

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
                        [ IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit( cat, TensorProductOnObjects( cat, a, b ) ),
                          
                          LeftInternalCoHomTensorProductCompatibilityMorphism( cat, [ unit, unit, a, b ] ),
                          
                          TensorProductOnMorphisms( cat,
                                  IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( cat, a ),
                                  IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( cat, b ) ) ],
                        range );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsSymmetricCoclosedMonoidalCategory( cat ) and IsSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects,
                    "LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects using braiding, coclosed evaluation, and cohom tensor adjunction",
                    [ [ LeftInternalCoHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ TensorProductOnObjects, 1 ],
                      [ TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local cohom_a_b, cohom_b_c, morphism;
    
    #            a
    #            |
    #            | coclev_ab
    #            v
    #      coHom(a,b) ⊗ b
    #            |
    #            | B_( coHom(a,b), b )
    #            v
    #      b ⊗ coHom(a,b)
    #            |
    #            | coclev_bc ⊗ id_coHom(a,b)
    #            v
    # coHom(b,c) ⊗ c ⊗ coHom(a,b)
    #            |
    #            | id_coHom(b,c) ⊗ B_( c, coHom(a,b) )
    #            v
    # coHom(b,c) ⊗ coHom(a,b) ⊗ c
    #
    #
    # Adjoint( a → (coHom(b,c) ⊗ coHom(a,b)) ⊗ c ) = ( coHom(a,c) → coHom(b,c) ⊗ coHom(a,b) )
    
    cohom_a_b := LeftInternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := LeftInternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ LeftCoclosedMonoidalEvaluationMorphism( cat, a, b ),
                          
                          Braiding( cat, cohom_a_b, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  LeftCoclosedMonoidalEvaluationMorphism( cat, b, c ),
                                  IdentityMorphism( cat, cohom_a_b ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, cohom_b_c ),
                                  Braiding( cat, c, cohom_a_b ) ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsSymmetricCoclosedMonoidalCategory( cat ) and IsSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

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
    
end : CategoryFilter := cat -> HasIsSymmetricCoclosedMonoidalCategory( cat ) and IsSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );
