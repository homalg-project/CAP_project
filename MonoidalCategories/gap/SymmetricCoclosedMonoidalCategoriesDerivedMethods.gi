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
             
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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
             
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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
             
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( UniversalPropertyOfCoDual,
                    "UniversalPropertyOfCoDual using the cohom tensor adjunction",
                    [ [ PreCompose, 1 ],
                      [ IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit, 1 ],
                      [ TensorProductToInternalCoHomAdjunctionMap, 1 ] ],
                    
  function( cat, t, a, alpha )
    
    # alpha: 1 → t ⊗ a
    #
    # a_v → ( Cohom(1,a) → t ) = Adjoint( alpha )
    
    return PreCompose( cat,
             IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( cat, a ),
             TensorProductToInternalCoHomAdjunctionMap( cat, t, a, alpha ) );
             
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,
                    "MorphismFromCoBidualWithGivenCoBidual using the braiding and the universal property of the codual",
                    [ [ PreCompose, 1 ],
                      [ CoclosedEvaluationForCoDual, 1 ],
                      [ Braiding, 1 ],
                      [ CoDualOnObjects, 2 ],
                      [ UniversalPropertyOfCoDual, 1 ] ],
                    
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
    # UniversalPropertyOfCoDual( 1 → a ⊗ a_v) = ( a_v_v → a )

    alpha := PreCompose( cat,
                  CoclosedEvaluationForCoDual( cat, a ),
                  Braiding( cat, CoDualOnObjects( cat, a ), a ) );
                  
    return UniversalPropertyOfCoDual( cat, a, CoDualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,
                    "MorphismFromCoBidualWithGivenCoBidual using CoclosedEvaluation, InternalCoHom, and CoclosedCoevaluation",
                    [ [ CoDualOnObjects, 1 ],
                      [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ InternalCoHomOnMorphisms, 2 ],
                      [ CoclosedEvaluationMorphism, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 1 ],
                      [ CoclosedCoevaluationMorphism, 1 ] ],
                    
  function( cat, a, avv )
    local av, morphism;
    
    #     Cohom(1, a_v)
    #          |
    #          | Cohom( coclev_(1,a), id_(a_v) )
    #          v
    # Cohom(a_v ⊗ a, a_v)
    #          |
    #          | Cohom( B_( a_v, a), id_(a_v) )
    #          v
    # Cohom(a ⊗ a_v, a_v)
    #          |
    #          | coclcoev_(a, a_v)
    #          v
    #          a
    
    av := CoDualOnObjects( cat, a );
    
    morphism := PreComposeList( cat,
                        avv,
                        [ InternalCoHomOnMorphisms( cat,
                                CoclosedEvaluationMorphism( cat, TensorUnit( cat ), a ),
                                IdentityMorphism( cat, av ) ),
                          
                          InternalCoHomOnMorphisms( cat,
                                  Braiding( cat, av, a ),
                                  IdentityMorphism( cat, av ) ),
                          
                          CoclosedCoevaluationMorphism( cat, a, av ) ],
                        a );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoDualOnObjects,
                    "CoDualOnObjects as the source of IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit",
                    [ [ IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit, 1 ] ],
                    
  function( cat, a )
    
    # Source( a_v → Cohom(1,a) )
    
    return Source( IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( cat, a ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoDualOnObjects,
                    "CoDualOnObjects as the range of IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject",
                    [ [ IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject, 1 ] ],
                    
  function( cat, a )
    
    # Range( Cohom(1,a) → a_v )
    
    return Range( IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat, a ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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
    local result_morphism;
    
    # alpha: a → b
    #
    #    b_v
    #     |
    #     v
    # Cohom(1,b)
    #     |
    #     | Cohom(id_1, alpha)
    #     v
    # Cohom(1,a)
    #     |
    #     v
    #    a_v
    
    result_morphism := PreComposeList( cat,
                               s,
                               [ IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( cat, Range( alpha ) ),
                                 
                                 InternalCoHomOnMorphisms( cat,
                                         IdentityMorphism( cat, TensorUnit( cat ) ),
                                         alpha ),
                                 
                                 IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat, Source( alpha ) ) ],
                               r );
    
    return result_morphism;
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoclosedEvaluationForCoDualWithGivenTensorProduct,
                    "CoclosedEvaluationForCoDualWithGivenTensorProduct using the cohom tensor adjunction and IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject",
                    [ [ InternalCoHomToTensorProductAdjunctionMap, 1 ],
                      [ IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject, 1 ] ],
                    
  function( cat, s, a, r )
    
    # s := 1
    
    # Adjoint( Cohom(1,a) → a_v ) = ( 1 → a_v ⊗ a )

    return InternalCoHomToTensorProductAdjunctionMap( cat,
            s,
            a,
            IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat, a ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoLambdaIntroduction,
                    "CoLambdaIntroduction using the cohom tensor adjunction and the left unitor inverse",
                    [ [ PreCompose, 1 ],
                      [ LeftUnitorInverse, 1 ],
                      [ TensorProductToInternalCoHomAdjunctionMap, 1 ],
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
    # Adjoint( a → 1 ⊗ b ) = ( Cohom(a,b) → 1 )

    range := Range( alpha );

    result_morphism := PreCompose( cat, alpha, LeftUnitorInverse( cat, range ) );

    return TensorProductToInternalCoHomAdjunctionMap( cat,
             TensorUnit( cat ),
             range,
             result_morphism );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoLambdaElimination,
                    "CoLambdaElimination using the cohom tensor adjunction and the left unitor",
                    [ [ InternalCoHomToTensorProductAdjunctionMap, 1 ],
                      [ PreCompose, 1 ],
                      [ LeftUnitor, 1 ] ],
                    
  function( cat, a, b, alpha )
    local result_morphism;
    
    # alpha: Cohom(a,b) → 1
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
    
    result_morphism := InternalCoHomToTensorProductAdjunctionMap( cat, a, b, alpha );
    
    return PreCompose( cat, result_morphism, LeftUnitor( cat, b ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                    "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using associator, braiding and the coclosed evaluation morphism",
                    [ [ InternalCoHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 7 ],
                      [ CoclosedEvaluationMorphism, 2 ],
                      [ AssociatorRightToLeft, 2 ],
                      [ AssociatorLeftToRight, 2 ],
                      [ Braiding, 1 ],
                      [ TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, a2, b1, b2, b1b2, int_cohom_a1_b1, int_cohom_a2_b2, id_b2, morphism;
    
    #                   a1 ⊗ a2
    #                      |
    #                      | id_a1 ⊗ coclev_(a2,b2)
    #                      v
    #          a1 ⊗ (Cohom(a2,b2) ⊗ b2)
    #                      |
    #                      | α_( a1, (Cohom(a2,b2), b2) )
    #                      v
    #          (a1 ⊗ Cohom(a2,b2)) ⊗ b2
    #                      |
    #                      | ( coclev_(a1,b1) ⊗ id_Cohom(a2,b2) ) ⊗ id_b2
    #                      v
    # ((Cohom(a1,b1) ⊗ b1) ⊗ Cohom(a2,b2)) ⊗ b2
    #                      |
    #                      | α_( (Cohom(a1,b1), b1), Cohom(a2,b2) ) ) ⊗ id_b2
    #                      v
    #  (Cohom(a1,b1) ⊗ (b1 ⊗ Cohom(a2,b2))) ⊗ b2
    #                      |
    #                      | ( id_Cohom(a1,b1) ⊗ B_( b1, Cohom(a2,b2) ) ) ⊗ id_b2
    #                      v
    #  (Cohom(a1,b1) ⊗ (Cohom(a2,b2) ⊗ b1)) ⊗ b2
    #                      |
    #                      | α_( Cohom(a1,b1), (Cohom(a2,b2), b1) ) ⊗ id_b2
    #                      v
    #  ((Cohom(a1,b1) ⊗ Cohom(a2,b2)) ⊗ b1) ⊗ b2
    #                      |
    #                      | α_( (Cohom(a1,b1) ⊗ Cohom(a2,b2), b1), b2 )
    #                      v
    #  (Cohom(a1,b1) ⊗ Cohom(a2,b2)) ⊗ (b1 ⊗ b2)
    #
    #
    # Adjoint[ a1 ⊗ a2 → (Cohom(a1,b1) ⊗ Cohom(a2,b2)) ⊗ (b1 ⊗ b2) ] = [ Cohom(a1 ⊗ a2, b1 ⊗ b2) → Cohom(a1,b1) ⊗ Cohom(a2,b2) ]
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    b1b2 := TensorProductOnObjects( cat, b1, b2 );
    
    int_cohom_a1_b1 := InternalCoHomOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := InternalCoHomOnObjects( cat, a2, b2 );
    
    id_b2 := IdentityMorphism( cat, b2 );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat, a1, a2 ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, a1 ),
                                CoclosedEvaluationMorphism( cat, a2, b2 ) ),
                          
                          AssociatorRightToLeft( cat, a1, int_cohom_a2_b2, b2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          CoclosedEvaluationMorphism( cat, a1, b1 ),
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
    
    return TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom( cat,
                   range,
                   b1b2,
                   morphism,
                   source );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

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
    #      Cohom(1, a ⊗ b)
    #            |
    #            | Cohom((λ_1)^-1, id_(a ⊗ b))
    #            V
    #  Cohom(1 ⊗ 1, a ⊗ b)
    #            |
    #            | CompatMorphism(1,1,a,b)
    #            V
    # Cohom(1,a) ⊗ Cohom(1,b)
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
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom,
                    "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom using the coclosed coevaluation morphism",
                    [ [ TensorUnit, 1 ],
                      [ PreCompose, 1 ],
                      [ InternalCoHomOnMorphisms, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CoclosedCoevaluationMorphism, 1 ] ],
                    
  function( cat, a, internal_cohom )
    local unit;
    
    #     Cohom(a, 1)
    #         |
    #         | Cohom((ρ_a)^-1, id_1)
    #         v
    # Cohom(a ⊗ 1, 1)
    #         |
    #         | coclcoev_(a,1)
    #         v
    #         a
    
    unit := TensorUnit( cat );
    
    return PreCompose( cat,
                   InternalCoHomOnMorphisms( cat,
                           RightUnitorInverse( cat, a ),
                           IdentityMorphism( cat, unit ) ),
                   
                   CoclosedCoevaluationMorphism( cat, a, unit ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom,
                    "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom as the adjoint of the right inverse unitor",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductToInternalCoHomAdjunctionMap, 1 ],
                      [ RightUnitorInverse, 1 ] ],
                    
  function( cat, a, internal_cohom )
    
    # (ρ_a)^-1: a → a ⊗ 1
    #
    # Adjoint( (ρ_a)^-1 ) = ( Cohom(a,1) → a )
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
                   a,
                   TensorUnit( cat ),
                   RightUnitorInverse( cat, a ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom,
#                     
#   function( cat, a, internal_cohom )
#
#     # Inverse( a → Cohom(a,1) )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToInternalCoHom( cat, a ) );
#     
# end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
#       Description := "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom as the inverse of IsomorphismFromObjectToInternalCoHom" );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom,
                    "IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom using the coclosed evaluation morphism",
                    [ [ TensorUnit, 1 ],
                      [ PreCompose, 1 ],
                      [ CoclosedEvaluationMorphism, 1 ],
                      [ RightUnitor, 1 ] ],
                    
  function( cat, a, internal_cohom )
    
    #       a
    #       |
    #       | coclev_(a,1)
    #       v
    # Cohom(a,1) ⊗ 1
    #       |
    #       | ρ_Cohom(a,1)
    #       v
    #   Cohom(a,1)
    
    return PreCompose( cat,
                   CoclosedEvaluationMorphism( cat, a, TensorUnit( cat ) ),
                   RightUnitor( cat, internal_cohom ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom,
#                     
#   function( cat, a, internal_cohom )
#
#     # Inverse( Cohom(a,1) → a)
#     
#     return InverseForMorphisms( cat, IsomorphismFromInternalCoHomToObject( cat, a ) );
#     
# end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
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
    
    #       Cohom(a,b)
    #            |
    #            | Cohom((λ_a)^-1, ρ_b)
    #            v
    # Cohom(1 ⊗ a, b ⊗ 1)
    #            |
    #            | CompatMorphism
    #            v
    # Cohom(1,b) ⊗ Cohom(a,1)
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
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoclosedEvaluationMorphismWithGivenRange,
                    "CoclosedEvaluationMorphismWithGivenRange using the cohom tensor adjunction on the identity",
                    [ [ InternalCoHomToTensorProductAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ InternalCoHomOnObjects, 1 ] ],
                    
  function( cat, a, b, tensor_object )
    
    # Adjoint( id_Cohom(a,b): Cohom(a,b) → Cohom(a,b) ) = ( a → Cohom(a,b) ⊗ b )
    
    return InternalCoHomToTensorProductAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, InternalCoHomOnObjects( cat, a, b ) )
           );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

AddDerivationToCAP( CoclosedCoevaluationMorphismWithGivenSource,
                    "CoclosedCoevaluationMorphismWithGivenSource using the cohom tensor adjunction on the identity",
                    [ [ TensorProductToInternalCoHomAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_cohom )
    
    # Adjoint( id_(a ⊗ b): a ⊗ b → a ⊗ b ) = ( Cohom(a ⊗ b, b) → a )
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, TensorProductOnObjects( cat, a, b ) )
           );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                    "MonoidalPreCoComposeMorphismWithGivenObjects using associator, braiding, coclosed evaluation, and cohom tensor adjunction",
                    [ [ InternalCoHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CoclosedEvaluationMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local cohom_a_b, cohom_b_c, morphism;
    
    #           a
    #           |
    #           | coclev_ab
    #           v
    #    Cohom(a,b) ⊗ b
    #           |
    #           | B_( Cohom(a,b), b )
    #           v
    #      b ⊗ Cohom(a,b)
    #           |
    #           | coclev_bc ⊗ id_Cohom(a,b)
    #           v
    # (Cohom(b,c) ⊗ c) ⊗ Cohom(a,b)
    #           |
    #           | α_( ( Cohom(b,c), c ), Cohom(a,b) )
    #           v
    # Cohom(b,c) ⊗ (c ⊗ Cohom(a,b))
    #           |
    #           | id_Cohom(b,c) ⊗ B_( c, Cohom(a,b) )
    #           v
    # Cohom(b,c) ⊗ (Cohom(a,b) ⊗ c)
    #           |
    #           | α_( Cohom(b,c), ( Cohom(a,b), c ) )
    #           v
    # (Cohom(b,c) ⊗ Cohom(a,b)) ⊗ c
    #
    #
    # Adjoint( a → (Cohom(b,c) ⊗ Cohom(a,b)) ⊗ c ) = ( Cohom(a,c) → Cohom(b,c) ⊗ Cohom(a,b) )
    
    cohom_a_b := InternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := InternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ CoclosedEvaluationMorphism( cat, a, b ),
                          
                          Braiding( cat, cohom_a_b, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  CoclosedEvaluationMorphism( cat, b, c ),
                                  IdentityMorphism( cat, cohom_a_b ) ),
                          
                          AssociatorLeftToRight( cat, cohom_b_c, c, cohom_a_b ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, cohom_b_c ),
                                  Braiding( cat, c, cohom_a_b ) ),
                          
                          AssociatorRightToLeft( cat, cohom_b_c, cohom_a_b, c ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    "MonoidalPostCoComposeMorphismWithGivenObjects using associator, coclosed evaluation, and cohom tensor adjunction",
                    [ [ InternalCoHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CoclosedEvaluationMorphism, 2 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local cohom_a_b, cohom_b_c, morphism;
    
    #             a
    #             |
    #             | coclev_ab
    #             v
    #      Cohom(a,b) ⊗ b
    #             |
    #             | id_Cohom(a,b) ⊗ coclev_bc
    #             v
    #  Cohom(a,b) ⊗ (Cohom(b,c) ⊗ c)
    #             |
    #             | α_( Cohom(a,b), ( Cohom(b,c), c ) )
    #             v
    # (Cohom(a,b) ⊗ Cohom(b,c)) ⊗ c
    #
    #
    # Adjoint( a → (Cohom(a,b) ⊗ Cohom(b,c)) ⊗ c ) = ( Cohom(a,c) → Cohom(a,b) ⊗ Cohom(b,c) )
    
    cohom_a_b := InternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := InternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ CoclosedEvaluationMorphism( cat, a, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, cohom_a_b ),
                                  CoclosedEvaluationMorphism( cat, b, c ) ),
                          
                          AssociatorRightToLeft( cat, cohom_a_b, cohom_b_c, c ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    "MonoidalPostCoComposeMorphismWithGivenObjects using MonoidalPreCoComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ InternalCoHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ MonoidalPreCoComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;
    
    #       Cohom(a,c)
    #            |
    #            | PreCoCompose
    #            v
    # Cohom(b,c) ⊗ Cohom(a,b)
    #            |
    #            | B_( Cohom(b,c), Cohom(a,b) )
    #            v
    # Cohom(a,b) ⊗ Cohom(b,c)
    
    braiding := Braiding( cat, InternalCoHomOnObjects( cat, b, c ), InternalCoHomOnObjects( cat, a, b ) );
    
    return PreCompose( cat, MonoidalPreCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                    "MonoidalPreCoComposeMorphismWithGivenObjects using MonoidalPostCoComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ InternalCoHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ MonoidalPostCoComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;
    
    #       Cohom(a,c)
    #            |
    #            | PostCoCompose
    #            v
    # Cohom(a,b) ⊗ Cohom(b,c)
    #            |
    #            | B_( Cohom(a,b), Cohom(b,c) )
    #            v
    # Cohom(b,c) ⊗ Cohom(a,b)

    braiding := Braiding( cat, InternalCoHomOnObjects( cat, a, b ), InternalCoHomOnObjects( cat, b, c ) );
    
    return PreCompose( cat, MonoidalPostCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                    "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using braiding and the coclosed evaluation morphism",
                    [ [ InternalCoHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 5 ],
                      [ CoclosedEvaluationMorphism, 2 ],
                      [ Braiding, 1 ],
                      [ TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, a2, b1, b2, b1b2, int_cohom_a1_b1, int_cohom_a2_b2, id_b2, morphism;
    
    #           a1 ⊗ a2
    #              |
    #              | id_a1 ⊗ coclev_(a2,b2)
    #              v
    #    a1 ⊗ Cohom(a2,b2) ⊗ b2
    #              |
    #              | coclev_(a1,b1) ⊗ id_Cohom(a2,b2) ⊗ id_b2
    #              v
    # Cohom(a1,b1) ⊗ b1 ⊗ Cohom(a2,b2) ⊗ b2
    #              |
    #              | id_Cohom(a1,b1) ⊗ B_( b1, Cohom(a2,b2) )  ⊗ id_b2
    #              v
    # Cohom(a1,b1) ⊗ Cohom(a2,b2) ⊗ b1 ⊗ b2
    #
    #
    # Adjoint[ a1 ⊗ a2 → Cohom(a1,b1) ⊗ Cohom(a2,b2) ⊗ b1 ⊗ b2 ] = [ Cohom(a1 ⊗ a2, b1 ⊗ b2) → Cohom(a1,b1) ⊗ Cohom(a2,b2) ]
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    b1b2 := TensorProductOnObjects( cat, b1, b2 );
    
    int_cohom_a1_b1 := InternalCoHomOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := InternalCoHomOnObjects( cat, a2, b2 );

    id_b2 := IdentityMorphism( cat, b2 );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat, a1, a2 ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, a1 ),
                                CoclosedEvaluationMorphism( cat, a2, b2 ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          CoclosedEvaluationMorphism( cat, a1, b1 ),
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
    
    return TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom( cat,
                   range,
                   b1b2,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsSymmetricCoclosedMonoidalCategory( cat ) and IsSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

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
    #      Cohom(1, a ⊗ b)
    #            |
    #            | CompatMorphism(1,1,a,b)
    #            V
    # Cohom(1,a) ⊗ Cohom(1,b)
    #            |
    #            v
    #        a_v ⊗ b_v
    
    unit := TensorUnit( cat );
    
    morphism := PreComposeList( cat,
                        source,
                        [ IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( cat, TensorProductOnObjects( cat, a, b ) ),
                          
                          InternalCoHomTensorProductCompatibilityMorphism( cat, [ unit, unit, a, b ] ),
                          
                          TensorProductOnMorphisms( cat,
                                  IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat, a ),
                                  IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat, b ) ) ],
                        range );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsSymmetricCoclosedMonoidalCategory( cat ) and IsSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                    "MonoidalPreCoComposeMorphismWithGivenObjects using braiding, coclosed evaluation, and cohom tensor adjunction",
                    [ [ InternalCoHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CoclosedEvaluationMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ TensorProductOnObjects, 1 ],
                      [ TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local cohom_a_b, cohom_b_c, morphism;
    
    #            a
    #            |
    #            | coclev_ab
    #            v
    #      Cohom(a,b) ⊗ b
    #            |
    #            | B_( Cohom(a,b), b )
    #            v
    #      b ⊗ Cohom(a,b)
    #            |
    #            | coclev_bc ⊗ id_Cohom(a,b)
    #            v
    # Cohom(b,c) ⊗ c ⊗ Cohom(a,b)
    #            |
    #            | id_Cohom(b,c) ⊗ B_( c, Cohom(a,b) )
    #            v
    # Cohom(b,c) ⊗ Cohom(a,b) ⊗ c
    #
    #
    # Adjoint( a → (Cohom(b,c) ⊗ Cohom(a,b)) ⊗ c ) = ( Cohom(a,c) → Cohom(b,c) ⊗ Cohom(a,b) )
    
    cohom_a_b := InternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := InternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ CoclosedEvaluationMorphism( cat, a, b ),
                          
                          Braiding( cat, cohom_a_b, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  CoclosedEvaluationMorphism( cat, b, c ),
                                  IdentityMorphism( cat, cohom_a_b ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, cohom_b_c ),
                                  Braiding( cat, c, cohom_a_b ) ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsSymmetricCoclosedMonoidalCategory( cat ) and IsSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    "MonoidalPostCoComposeMorphismWithGivenObjects using coclosed evaluation, and cohom tensor adjunction",
                    [ [ InternalCoHomOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ CoclosedEvaluationMorphism, 2 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local morphism;
    
    #             a
    #             |
    #             | coclev_ab
    #             v
    #      Cohom(a,b) ⊗ b
    #             |
    #             | id_Cohom(a,b) ⊗ coclev_bc
    #             v
    #  Cohom(a,b) ⊗ (Cohom(b,c) ⊗ c)
    #
    #
    # Adjoint( a → (Cohom(a,b) ⊗ Cohom(b,c)) ⊗ c ) = ( Cohom(a,c) → Cohom(a,b) ⊗ Cohom(b,c) )
    
    morphism := PreComposeList( cat,
                        a,
                        [ CoclosedEvaluationMorphism( cat, a, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, InternalCoHomOnObjects( cat, a, b ) ),
                                  CoclosedEvaluationMorphism( cat, b, c ) ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsSymmetricCoclosedMonoidalCategory( cat ) and IsSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );
