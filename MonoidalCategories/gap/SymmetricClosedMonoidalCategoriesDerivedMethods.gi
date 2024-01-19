# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( UniversalPropertyOfLeftDual,
                    "UniversalPropertyOfLeftDual using the tensor hom adjunction",
                    [ [ PreCompose, 1 ],
                      [ TensorProductToLeftInternalHomAdjunctionMap, 1 ],
                      [ IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject, 1 ] ],
                    
  function( cat, t, a, alpha )

    # alpha: t ⊗ a → 1
    #
    # Adjoint( alpha ) = ( t → Hom(a,1) ) → a^v
    
    return PreCompose( cat,
             TensorProductToLeftInternalHomAdjunctionMap( cat, t, a, alpha ),
             IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismToLeftBidualWithGivenLeftBidual,
                    "MorphismToLeftBidualWithGivenLeftBidual using the braiding and the universal property of the dual",
                    [ [ PreCompose, 1 ],
                      [ Braiding, 1 ],
                      [ LeftDualOnObjects, 2 ],
                      [ LeftClosedMonoidalEvaluationForLeftDual, 1 ],
                      [ UniversalPropertyOfLeftDual, 1 ] ],
                    
  function( cat, a, avv )
    local alpha;

    #    a ⊗ a^v
    #      |
    #      | B_(a,a^v)
    #      v
    #  a^v ⊗ a
    #      |
    #      | ev_a
    #      v
    #      1
    #
    # UniversalProperty( a ⊗ a^v → 1 ) = ( a → a^v^v)

    alpha := PreCompose( cat, Braiding( cat, a, LeftDualOnObjects( cat, a ) ),
                            LeftClosedMonoidalEvaluationForLeftDual( cat, a ) );
    
    return UniversalPropertyOfLeftDual( cat, a, LeftDualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismToLeftBidualWithGivenLeftBidual,
                    "MorphismToLeftBidualWithGivenLeftBidual using LeftClosedMonoidalCoevaluation, LeftInternalHom, and LeftClosedMonoidalEvaluation",
                    [ [ LeftDualOnObjects, 1 ],
                      [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ LeftClosedMonoidalCoevaluationMorphism, 1 ],
                      [ LeftInternalHomOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 1 ] ],
                    
  function( cat, a, avv )
    local av, morphism;
    
    #        a
    #        |
    #        | coev_(a,a^v)
    #        v
    #  Hom(av, a ⊗ a^v)
    #        |
    #        | Hom(id_av, B_(a,a^v))
    #        v
    # Hom(av, a^v ⊗ a)
    #        |
    #        | Hom(id_(a^v), ev_(a,1))
    #        v
    #    Hom(a^v,1)
    
    av := LeftDualOnObjects( cat, a );
    
    morphism := PreComposeList( cat,
                        a,
                        [ LeftClosedMonoidalCoevaluationMorphism( cat, a, av ),
                          
                          LeftInternalHomOnMorphisms( cat,
                                  IdentityMorphism( cat, av ),
                                  Braiding( cat, a, av ) ),
                          
                          LeftInternalHomOnMorphisms( cat,
                                  IdentityMorphism( cat, av ),
                                  LeftClosedMonoidalEvaluationMorphism( cat, a, TensorUnit( cat ) ) ) ],
                        avv );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftDualOnObjects,
                    "LeftDualOnObjects as the source of IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit",
                    [ [ IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit, 1 ] ],
                    
  function( cat, a )

    # Source( a^v → Hom(a,1) )
    
    return Source( IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftDualOnObjects,
                    "LeftDualOnObjects as the range of IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject",
                    [ [ IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject, 1 ] ],
                    
  function( cat, a )

    # Range( Hom(a,1) → a^v )
    
    return Range( IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalEvaluationForLeftDualWithGivenTensorProduct,
                    "LeftClosedMonoidalEvaluationForLeftDualWithGivenTensorProduct using the tensor hom adjunction and IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit",
                    [ [ LeftInternalHomToTensorProductAdjunctionMap, 1 ],
                      [ IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit, 1 ] ],
                    
  function( cat, s, a, r )

    # r := 1
    #
    # Adjoint( a^v → Hom(a,1) ) = ( a^v ⊗ a → 1 )
    
    return LeftInternalHomToTensorProductAdjunctionMap( cat, a, r,
                                                    IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalLambdaIntroduction,
                    "LeftClosedMonoidalLambdaIntroduction using the tensor hom adjunction and left unitor",
                    [ [ PreCompose, 1 ],
                      [ LeftUnitor, 1 ],
                      [ TensorProductToLeftInternalHomAdjunctionMap, 1 ],
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
    
    return TensorProductToLeftInternalHomAdjunctionMap( cat, TensorUnit( cat ), source, result_morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalLambdaElimination,
                    "LeftClosedMonoidalLambdaElimination using the tensor hom adjunction and left unitor inverse",
                    [ [ LeftInternalHomToTensorProductAdjunctionMap, 1 ],
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
    
    result_morphism := LeftInternalHomToTensorProductAdjunctionMap( cat, a, b, alpha );
    
    return PreCompose( cat, LeftUnitorInverse( cat, a ), result_morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects,
                    "TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects using associator, braiding and the evaluation morphism",
                    [ [ LeftInternalHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ AssociatorRightToLeft, 2 ],
                      [ TensorProductOnMorphisms, 7 ],
                      [ AssociatorLeftToRight, 2 ],
                      [ Braiding, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, b1, a2, b2, a1a2, int_hom_a1_b1, int_hom_a2_b2, id_a2, morphism;
    
    # (Hom(a1,b1) ⊗ Hom(a2,b2)) ⊗ (a1 ⊗ a2)
    #                  |
    #                  | α_( Hom(a1,b1) ⊗ Hom(a2,b2), (a1, a2) )
    #                  v
    # ((Hom(a1,b1) ⊗ Hom(a2,b2)) ⊗ a1) ⊗ a2
    #                  |
    #                  | α_( ( Hom(a1,b1), Hom(a2,b2) ), a1 ) ⊗ id_a2
    #                  v
    # (Hom(a1,b1) ⊗ (Hom(a2,b2) ⊗ a1)) ⊗ a2
    #                  |
    #                  | ( id_Hom(a1,b1) ⊗ B_( Hom(a2,b2), a1 ) ) ⊗ id_a2
    #                  v
    # (Hom(a1,b1) ⊗ (a1 ⊗ Hom(a2,b2))) ⊗ a2
    #                  |
    #                  | α_( Hom(a1,b1), ( a1, Hom(a2,b2) ) ) ⊗ id_a2
    #                  v
    # ((Hom(a1,b1) ⊗ a1) ⊗ Hom(a2,b2)) ⊗ a2
    #                  |
    #                  | ( ev_(a1,b1) ⊗ id_Hom(a2,b2) ) ⊗ id_a2
    #                  v
    #       (b1 ⊗ Hom(a2,b2)) ⊗ a2
    #                  |
    #                  | α_( ( b1, Hom(a2,b2) ), a2 )
    #                  v
    #       b1 ⊗ (Hom(a2,b2) ⊗ a2)
    #                  |
    #                  | id_b1 ⊗ ev_(a2,b2)
    #                  v
    #               b1 ⊗ b2
    #
    #
    # Adjoint[ (Hom(a1,b1) ⊗ Hom(a2,b2)) ⊗ (a1 ⊗ a2) → b1 ⊗ b2 ] = [ Hom(a1,b1) ⊗ Hom(a2,b2) → Hom(a1 ⊗ a2, b1 ⊗ b2) ]
    
    a1 := list[1];
    b1 := list[2];
    a2 := list[3];
    b2 := list[4];
    
    a1a2 := TensorProductOnObjects( cat, a1, a2 );
    
    int_hom_a1_b1 := LeftInternalHomOnObjects( cat, a1, b1 );
    
    int_hom_a2_b2 := LeftInternalHomOnObjects( cat, a2, b2 );
    
    id_a2 := IdentityMorphism( cat, a2 );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a1a2 ),
                        [ AssociatorRightToLeft( cat,
                                source,
                                a1, a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  AssociatorLeftToRight( cat, int_hom_a1_b1, int_hom_a2_b2, a1 ),
                                  id_a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          IdentityMorphism( cat, int_hom_a1_b1 ),
                                          Braiding( cat, int_hom_a2_b2, a1 ) ),
                                  id_a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  AssociatorRightToLeft( cat, int_hom_a1_b1, a1, int_hom_a2_b2 ),
                                  id_a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          LeftClosedMonoidalEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, int_hom_a2_b2 ) ),
                                  id_a2 ),
                          
                          AssociatorLeftToRight( cat, b1, int_hom_a2_b2, a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b1 ),
                                  LeftClosedMonoidalEvaluationMorphism( cat, a2, b2 ) ) ],
                        TensorProductOnObjects( cat, b1, b2 ) );
    
    return TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom( cat,
                   source,
                   a1a2,
                   morphism,
                   range );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

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
    #       | coev_(a,1)
    #       v
    # Hom(1, a ⊗ 1)
    #       |
    #       | Hom(id_1, ρ_a)
    #       v
    #   Hom(1, a)
    
    unit := TensorUnit( cat );
    
    return PreCompose( cat,
             LeftClosedMonoidalCoevaluationMorphism( cat, a, unit ),
             LeftInternalHomOnMorphisms( cat,
               IdentityMorphism( cat, unit ),
               RightUnitor( cat, a ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom,
                    "IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom as the adjoint of the right unitor",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductToLeftInternalHomAdjunctionMap, 1 ],
                      [ RightUnitor, 1 ] ],
                    
  function( cat, a, internal_hom )
    
    # ρ_a: a ⊗ 1 → a
    #
    # Adjoint( ρ_a ) = ( a → Hom(1,a) )
    
    return TensorProductToLeftInternalHomAdjunctionMap( cat,
                   a,
                   TensorUnit( cat ),
                   RightUnitor( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

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
# end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
#       Description := "IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom as the inverse of IsomorphismFromObjectToLeftInternalHom" );

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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

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
# end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
#       Description := "IsomorphismFromObjectToLeftInternalHom as the inverse of IsomorphismFromLeftInternalHomToObject" );

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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalEvaluationMorphismWithGivenSource,
                    "LeftClosedMonoidalEvaluationMorphismWithGivenSource using the tensor hom adjunction on the identity",
                    [ [ LeftInternalHomToTensorProductAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftInternalHomOnObjects, 1 ] ],
                    
  function( cat, a, b, tensor_object )

    # Adjoint( id_Hom(a,b): Hom(a,b) → Hom(a,b) ) = ( Hom(a,b) ⊗ a → b )
    
    return LeftInternalHomToTensorProductAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, LeftInternalHomOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalCoevaluationMorphismWithGivenRange,
                    "LeftClosedMonoidalCoevaluationMorphismWithGivenRange using the tensor hom adjunction on the identity",
                    [ [ TensorProductToLeftInternalHomAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    
    # Adjoint( id_(a ⊗ b): a ⊗ b → a ⊗ b ) = ( a → Hom(b, a ⊗ b) )

    return TensorProductToLeftInternalHomAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, TensorProductOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalPreComposeMorphismWithGivenObjects,
                    "LeftClosedMonoidalPreComposeMorphismWithGivenObjects using associator, braiding, evaluation, and tensor hom adjunction",
                    [ [ LeftInternalHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local hom_a_b, hom_b_c, morphism;
    
    # (Hom(a,b) ⊗ Hom(b,c)) ⊗ a
    #           |
    #           | α_( ( Hom(a,b), Hom(b,c) ), a)
    #           v
    # Hom(a,b) ⊗ (Hom(b,c) ⊗ a)
    #           |
    #           | id_Hom(a,b) ⊗ B_( Hom(b,c), a )
    #           v
    # Hom(a,b) ⊗ (a ⊗ Hom(b,c))
    #           |
    #           | α_( Hom(a,b), ( a, Hom(b,c) ) )
    #           v
    # (Hom(a,b) ⊗ a) ⊗ Hom(b,c)
    #           |
    #           | ev_ab ⊗ id_Hom(b,c)
    #           v
    #      b ⊗ Hom(b,c)
    #           |
    #           | B_( b, Hom(b,c) )
    #           v
    #     Hom(b,c) ⊗ b
    #           |
    #           | ev_bc
    #           v
    #           c
    #
    #
    # Adjoint(  (Hom(a,b) ⊗ Hom(b,c)) ⊗ a → c ) = ( Hom(a,b) ⊗ Hom(b,c) → Hom(a,c) )

    hom_a_b := LeftInternalHomOnObjects( cat, a, b );
    
    hom_b_c := LeftInternalHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a ),
                        [ AssociatorLeftToRight( cat, hom_a_b, hom_b_c, a ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, hom_a_b ),
                                  Braiding( cat, hom_b_c, a ) ),
                          
                          AssociatorRightToLeft( cat, hom_a_b, a, hom_b_c ),
                          
                          TensorProductOnMorphisms( cat,
                                  LeftClosedMonoidalEvaluationMorphism( cat, a, b ),
                                  IdentityMorphism( cat, hom_b_c ) ),
                          
                          Braiding( cat, b, hom_b_c ),
                          
                          LeftClosedMonoidalEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalPostComposeMorphismWithGivenObjects,
                    "LeftClosedMonoidalPostComposeMorphismWithGivenObjects using associator, evaluation, and tensor hom adjunction",
                    [ [ LeftInternalHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom, 1 ],
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
    
    return TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalPostComposeMorphismWithGivenObjects,
                    "LeftClosedMonoidalPostComposeMorphismWithGivenObjects using LeftClosedMonoidalPreComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ LeftInternalHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ LeftClosedMonoidalPreComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;

    # Hom(b,c) ⊗ Hom(a,b)
    #          |
    #          | B_( Hom(b,c), Hom(a,b) )
    #          v
    # Hom(a,b) ⊗ Hom(b,c)
    #          |
    #          | PreCompose
    #          v
    #       Hom(a,c)
    
    braiding := Braiding( cat, LeftInternalHomOnObjects( cat, b, c ), LeftInternalHomOnObjects( cat, a, b ) );
    
    return PreCompose( cat, braiding, LeftClosedMonoidalPreComposeMorphism( cat, a, b, c ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalPreComposeMorphismWithGivenObjects,
                    "LeftClosedMonoidalPreComposeMorphismWithGivenObjects using LeftClosedMonoidalPostComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ LeftInternalHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ LeftClosedMonoidalPostComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;

    # Hom(a,b) ⊗ Hom(b,c)
    #          |
    #          | B_( Hom(a,b), Hom(b,c) )
    #          v
    # Hom(b,c) ⊗ Hom(a,b)
    #          |
    #          | PostCompose
    #          v
    #       Hom(a,c)
    
    braiding := Braiding( cat, LeftInternalHomOnObjects( cat, a, b ), LeftInternalHomOnObjects( cat, b, c ) );
    
    return PreCompose( cat, braiding, LeftClosedMonoidalPostComposeMorphism( cat, a, b, c ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects,
                    "TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects using braiding and the evaluation morphism",
                    [ [ LeftInternalHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 5 ],
                      [ Braiding, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, b1, a2, b2, a1a2, int_hom_a1_b1, int_hom_a2_b2, id_a2, morphism;
    
    # Hom(a1,b1) ⊗ Hom(a2,b2) ⊗ a1 ⊗ a2
    #                 |
    #                 | id_Hom(a1,b1) ⊗ B_( Hom(a2,b2), a1 ) ⊗ id_a2
    #                 v
    # Hom(a1,b1) ⊗ a1 ⊗ Hom(a2,b2) ⊗ a2
    #                 |
    #                 | ev_(a1,b1) ⊗ id_Hom(a2,b2) ⊗ id_a2
    #                 v
    #       b1 ⊗ Hom(a2,b2) ⊗ a2
    #                 |
    #                 | id_b1 ⊗ ev_(a2,b2)
    #                 v
    #              b1 ⊗ b2
    #
    #
    # Adjoint[ Hom(a1,b1) ⊗ Hom(a2,b2) ⊗ a1 ⊗ a2 → b1 ⊗ b2 ] = [ Hom(a1,b1) ⊗ Hom(a2,b2) → Hom(a1 ⊗ a2, b1 ⊗ b2) ]
    
    a1 := list[1];
    b1 := list[2];
    a2 := list[3];
    b2 := list[4];
    
    a1a2 := TensorProductOnObjects( cat, a1, a2 );
    
    int_hom_a1_b1 := LeftInternalHomOnObjects( cat, a1, b1 );
    
    int_hom_a2_b2 := LeftInternalHomOnObjects( cat, a2, b2 );
    
    id_a2 := IdentityMorphism( cat, a2 );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a1a2 ),
                        [ TensorProductOnMorphisms( cat,
                                TensorProductOnMorphisms( cat,
                                        IdentityMorphism( cat, int_hom_a1_b1 ),
                                        Braiding( cat, int_hom_a2_b2, a1 ) ),
                                id_a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          LeftClosedMonoidalEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, int_hom_a2_b2 ) ),
                                  id_a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b1 ),
                                  LeftClosedMonoidalEvaluationMorphism( cat, a2, b2 ) ) ],
                        TensorProductOnObjects( cat, b1, b2 ) );
    
    return TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom( cat,
                   source,
                   a1a2,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

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
    
end : CategoryFilter := cat -> HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( LeftClosedMonoidalPreComposeMorphismWithGivenObjects,
                    "LeftClosedMonoidalPreComposeMorphismWithGivenObjects using, braiding, evaluation, and tensor hom adjunction",
                    [ [ LeftInternalHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local hom_a_b, hom_b_c, morphism;

    # Hom(a,b) ⊗ Hom(b,c) ⊗ a
    #          |
    #          | id_Hom(a,b) ⊗ B_( Hom(b,c), a )
    #          v
    # Hom(a,b) ⊗ a ⊗ Hom(b,c)
    #          |
    #          | ev_ab ⊗ id_Hom(b,c)
    #          v
    #     b ⊗ Hom(b,c)
    #          |
    #          | B_( b, Hom(b,c) )
    #          v
    #     Hom(b,c) ⊗ b
    #          |
    #          | ev_bc
    #          v
    #          c
    #
    #
    # Adjoint(  (Hom(a,b) ⊗ Hom(b,c)) ⊗ a → c ) = ( Hom(a,b) ⊗ Hom(b,c) → Hom(a,c) )
    
    hom_a_b := LeftInternalHomOnObjects( cat, a, b );
    
    hom_b_c := LeftInternalHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, hom_a_b ),
                                Braiding( cat, hom_b_c, a ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  LeftClosedMonoidalEvaluationMorphism( cat, a, b ),
                                  IdentityMorphism( cat, hom_b_c ) ),
                          
                          Braiding( cat, b, hom_b_c ),
                          
                          LeftClosedMonoidalEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( LeftClosedMonoidalPostComposeMorphismWithGivenObjects,
                    "LeftClosedMonoidalPostComposeMorphismWithGivenObjects using evaluation, and tensor hom adjunction",
                    [ [ LeftInternalHomOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom, 1 ],
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
    
    return TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );
