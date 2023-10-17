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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( UniversalPropertyOfDual,
                    "UniversalPropertyOfDual using the tensor hom adjunction",
                    [ [ PreCompose, 1 ],
                      [ TensorProductToInternalHomAdjunctionMap, 1 ],
                      [ IsomorphismFromInternalHomIntoTensorUnitToDualObject, 1 ] ],
                    
  function( cat, t, a, alpha )

    # alpha: t ⊗ a → 1
    #
    # Adjoint( alpha ) = ( t → Hom(a,1) ) → a^v
    
    return PreCompose( cat,
             TensorProductToInternalHomAdjunctionMap( cat, t, a, alpha ),
             IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                    "MorphismToBidualWithGivenBidual using the braiding and the universal property of the dual",
                    [ [ PreCompose, 1 ],
                      [ Braiding, 1 ],
                      [ DualOnObjects, 2 ],
                      [ EvaluationForDual, 1 ],
                      [ UniversalPropertyOfDual, 1 ] ],
                    
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

    alpha := PreCompose( cat, Braiding( cat, a, DualOnObjects( cat, a ) ),
                            EvaluationForDual( cat, a ) );
    
    return UniversalPropertyOfDual( cat, a, DualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                    "MorphismToBidualWithGivenBidual using Coevaluation, InternalHom, and Evaluation",
                    [ [ DualOnObjects, 1 ],
                      [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ CoevaluationMorphism, 1 ],
                      [ InternalHomOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 1 ],
                      [ EvaluationMorphism, 1 ] ],
                    
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
    
    av := DualOnObjects( cat, a );
    
    morphism := PreComposeList( cat,
                        a,
                        [ CoevaluationMorphism( cat, a, av ),
                          
                          InternalHomOnMorphisms( cat,
                                  IdentityMorphism( cat, av ),
                                  Braiding( cat, a, av ) ),
                          
                          InternalHomOnMorphisms( cat,
                                  IdentityMorphism( cat, av ),
                                  EvaluationMorphism( cat, a, TensorUnit( cat ) ) ) ],
                        avv );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( DualOnObjects,
                    "DualOnObjects as the source of IsomorphismFromDualObjectToInternalHomIntoTensorUnit",
                    [ [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit, 1 ] ],
                    
  function( cat, a )

    # Source( a^v → Hom(a,1) )
    
    return Source( IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( DualOnObjects,
                    "DualOnObjects as the range of IsomorphismFromInternalHomIntoTensorUnitToDualObject",
                    [ [ IsomorphismFromInternalHomIntoTensorUnitToDualObject, 1 ] ],
                    
  function( cat, a )

    # Range( Hom(a,1) → a^v )
    
    return Range( IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( DualOnMorphismsWithGivenDuals,
                    "DualOnMorphismsWithGivenDuals using InternalHomOnMorphisms and IsomorphismFromDualObjectToInternalHomIntoTensorUnit",
                    [ [ PreComposeList, 1 ],
                      [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit, 1 ],
                      [ InternalHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorUnit, 1 ],
                      [ IsomorphismFromInternalHomIntoTensorUnitToDualObject, 1 ] ],
                    
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
                   [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, Range( alpha ) ),
                     
                     InternalHomOnMorphisms( cat,
                             alpha,
                             IdentityMorphism( cat, TensorUnit( cat ) ) ),
                     
                     IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, Source( alpha ) ) ],
                   r );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( EvaluationForDualWithGivenTensorProduct,
                    "EvaluationForDualWithGivenTensorProduct using the tensor hom adjunction and IsomorphismFromDualObjectToInternalHomIntoTensorUnit",
                    [ [ InternalHomToTensorProductAdjunctionMap, 1 ],
                      [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit, 1 ] ],
                    
  function( cat, s, a, r )

    # r := 1
    #
    # Adjoint( a^v → Hom(a,1) ) = ( a^v ⊗ a → 1 )
    
    return InternalHomToTensorProductAdjunctionMap( cat, a, r,
                                                    IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LambdaIntroduction,
                    "LambdaIntroduction using the tensor hom adjunction and left unitor",
                    [ [ PreCompose, 1 ],
                      [ LeftUnitor, 1 ],
                      [ TensorProductToInternalHomAdjunctionMap, 1 ],
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
    
    return TensorProductToInternalHomAdjunctionMap( cat, TensorUnit( cat ), source, result_morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LambdaElimination,
                    "LambdaElimination using the tensor hom adjunction and left unitor inverse",
                    [ [ InternalHomToTensorProductAdjunctionMap, 1 ],
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
    
    result_morphism := InternalHomToTensorProductAdjunctionMap( cat, a, b, alpha );
    
    return PreCompose( cat, LeftUnitorInverse( cat, a ), result_morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                    "TensorProductInternalHomCompatibilityMorphismWithGivenObjects using associator, braiding and the evaluation morphism",
                    [ [ InternalHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ AssociatorRightToLeft, 2 ],
                      [ TensorProductOnMorphisms, 7 ],
                      [ AssociatorLeftToRight, 2 ],
                      [ Braiding, 1 ],
                      [ EvaluationMorphism, 2 ],
                      [ TensorProductToInternalHomAdjunctionMapWithGivenInternalHom, 1 ] ],
                    
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
    
    int_hom_a1_b1 := InternalHomOnObjects( cat, a1, b1 );
    
    int_hom_a2_b2 := InternalHomOnObjects( cat, a2, b2 );
    
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
                                          EvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, int_hom_a2_b2 ) ),
                                  id_a2 ),
                          
                          AssociatorLeftToRight( cat, b1, int_hom_a2_b2, a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b1 ),
                                  EvaluationMorphism( cat, a2, b2 ) ) ],
                        TensorProductOnObjects( cat, b1, b2 ) );
    
    return TensorProductToInternalHomAdjunctionMapWithGivenInternalHom( cat,
                   source,
                   a1a2,
                   morphism,
                   range );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductDualityCompatibilityMorphismWithGivenObjects,
                    "TensorProductDualityCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of tensor product and internal hom",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit, 2 ],
                      [ TensorProductInternalHomCompatibilityMorphism, 1 ],
                      [ InternalHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftUnitor, 1 ],
                      [ IsomorphismFromInternalHomIntoTensorUnitToDualObject, 1 ] ],
                    
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
                                IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ),
                                IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, b ) ),
                          
                          TensorProductInternalHomCompatibilityMorphism( cat, [ a, unit, b, unit ] ),
                          
                          InternalHomOnMorphisms( cat,
                                  IdentityMorphism( cat, tensor_product_on_a_and_b ),
                                  LeftUnitor( cat, unit ) ),
                          
                          IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, tensor_product_on_a_and_b ) ],
                        r );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
                    "IsomorphismFromObjectToInternalHomWithGivenInternalHom using the coevaluation morphism",
                    [ [ TensorUnit, 1 ],
                      [ PreCompose, 1 ],
                      [ CoevaluationMorphism, 1 ],
                      [ InternalHomOnMorphisms, 1 ],
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
             CoevaluationMorphism( cat, a, unit ),
             InternalHomOnMorphisms( cat,
               IdentityMorphism( cat, unit ),
               RightUnitor( cat, a ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
                    "IsomorphismFromObjectToInternalHomWithGivenInternalHom as the adjoint of the right unitor",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductToInternalHomAdjunctionMap, 1 ],
                      [ RightUnitor, 1 ] ],
                    
  function( cat, a, internal_hom )
    
    # ρ_a: a ⊗ 1 → a
    #
    # Adjoint( ρ_a ) = ( a → Hom(1,a) )
    
    return TensorProductToInternalHomAdjunctionMap( cat,
                   a,
                   TensorUnit( cat ),
                   RightUnitor( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromInternalHomToObjectWithGivenInternalHom,
#                     
#   function( cat, a, internal_hom )
#
#     # Inverse( a → Hom(1,a) )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToInternalHom( cat, a ) );
#     
# end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
#       Description := "IsomorphismFromInternalHomToObjectWithGivenInternalHom as the inverse of IsomorphismFromObjectToInternalHom" );

##
AddDerivationToCAP( IsomorphismFromInternalHomToObjectWithGivenInternalHom,
                    "IsomorphismFromInternalHomToObjectWithGivenInternalHom using the evaluation morphism",
                    [ [ TensorUnit, 1 ],
                      [ PreCompose, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ EvaluationMorphism, 1 ] ],
                    
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
                   EvaluationMorphism( cat, TensorUnit( cat ), a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
#                     
#   function( cat, object, internal_hom )
#
#     # Inverse( a → Hom(1,a))
#     
#     return InverseForMorphisms( cat, IsomorphismFromInternalHomToObject( cat, object ) );
#     
# end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
#       Description := "IsomorphismFromObjectToInternalHom as the inverse of IsomorphismFromInternalHomToObject" );

##
AddDerivationToCAP( MorphismFromTensorProductToInternalHomWithGivenObjects,
                    "MorphismFromTensorProductToInternalHomWithGivenObjects using TensorProductInternalHomCompatibilityMorphism",
                    [ [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit, 1 ],
                      [ IsomorphismFromObjectToInternalHom, 1 ],
                      [ TensorProductInternalHomCompatibilityMorphism, 1 ],
                      [ InternalHomOnMorphisms, 1 ],
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
                           IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ),
                           IsomorphismFromObjectToInternalHom( cat, b ) ),
                     
                     TensorProductInternalHomCompatibilityMorphism( cat,
                             [ a, unit, unit, b ] ),
                     
                     InternalHomOnMorphisms( cat,
                             RightUnitorInverse( cat, a ),
                             LeftUnitor( cat, b ) ) ],
                   internal_hom );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( EvaluationMorphismWithGivenSource,
                    "EvaluationMorphismWithGivenSource using the tensor hom adjunction on the identity",
                    [ [ InternalHomToTensorProductAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ InternalHomOnObjects, 1 ] ],
                    
  function( cat, a, b, tensor_object )

    # Adjoint( id_Hom(a,b): Hom(a,b) → Hom(a,b) ) = ( Hom(a,b) ⊗ a → b )
    
    return InternalHomToTensorProductAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, InternalHomOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( CoevaluationMorphismWithGivenRange,
                    "CoevaluationMorphismWithGivenRange using the tensor hom adjunction on the identity",
                    [ [ TensorProductToInternalHomAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    
    # Adjoint( id_(a ⊗ b): a ⊗ b → a ⊗ b ) = ( a → Hom(b, a ⊗ b) )

    return TensorProductToInternalHomAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, TensorProductOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                    "MonoidalPreComposeMorphismWithGivenObjects using associator, braiding, evaluation, and tensor hom adjunction",
                    [ [ InternalHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ EvaluationMorphism, 2 ],
                      [ TensorProductToInternalHomAdjunctionMapWithGivenInternalHom, 1 ],
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

    hom_a_b := InternalHomOnObjects( cat, a, b );
    
    hom_b_c := InternalHomOnObjects( cat, b, c );
    
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
                                  EvaluationMorphism( cat, a, b ),
                                  IdentityMorphism( cat, hom_b_c ) ),
                          
                          Braiding( cat, b, hom_b_c ),
                          
                          EvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToInternalHomAdjunctionMapWithGivenInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    "MonoidalPostComposeMorphismWithGivenObjects using associator, evaluation, and tensor hom adjunction",
                    [ [ InternalHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ EvaluationMorphism, 2 ],
                      [ TensorProductToInternalHomAdjunctionMapWithGivenInternalHom, 1 ],
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
    
    hom_a_b := InternalHomOnObjects( cat, a, b );
    
    hom_b_c := InternalHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a ),
                        [ AssociatorLeftToRight( cat, hom_b_c, hom_a_b, a ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, hom_b_c ),
                                  EvaluationMorphism( cat, a, b ) ),
                          
                          EvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToInternalHomAdjunctionMapWithGivenInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    "MonoidalPostComposeMorphismWithGivenObjects using MonoidalPreComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ InternalHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ MonoidalPreComposeMorphism, 1 ] ],
                    
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
    
    braiding := Braiding( cat, InternalHomOnObjects( cat, b, c ), InternalHomOnObjects( cat, a, b ) );
    
    return PreCompose( cat, braiding, MonoidalPreComposeMorphism( cat, a, b, c ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                    "MonoidalPreComposeMorphismWithGivenObjects using MonoidalPostComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ InternalHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ MonoidalPostComposeMorphism, 1 ] ],
                    
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
    
    braiding := Braiding( cat, InternalHomOnObjects( cat, a, b ), InternalHomOnObjects( cat, b, c ) );
    
    return PreCompose( cat, braiding, MonoidalPostComposeMorphism( cat, a, b, c ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                    "TensorProductInternalHomCompatibilityMorphismWithGivenObjects using braiding and the evaluation morphism",
                    [ [ InternalHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 5 ],
                      [ Braiding, 1 ],
                      [ EvaluationMorphism, 2 ],
                      [ TensorProductToInternalHomAdjunctionMapWithGivenInternalHom, 1 ] ],
                    
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
    
    int_hom_a1_b1 := InternalHomOnObjects( cat, a1, b1 );
    
    int_hom_a2_b2 := InternalHomOnObjects( cat, a2, b2 );
    
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
                                          EvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, int_hom_a2_b2 ) ),
                                  id_a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b1 ),
                                  EvaluationMorphism( cat, a2, b2 ) ) ],
                        TensorProductOnObjects( cat, b1, b2 ) );
    
    return TensorProductToInternalHomAdjunctionMapWithGivenInternalHom( cat,
                   source,
                   a1a2,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( TensorProductDualityCompatibilityMorphismWithGivenObjects,
                    "TensorProductDualityCompatibilityMorphismWithGivenObjects using compatibility of tensor product and internal hom",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit, 2 ],
                      [ TensorProductInternalHomCompatibilityMorphism, 1 ],
                      [ IsomorphismFromInternalHomIntoTensorUnitToDualObject, 1 ] ],
                    
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
                                IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ),
                                IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, b ) ),
                          
                          TensorProductInternalHomCompatibilityMorphism( cat, [ a, unit, b, unit ] ),
                          
                          IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat,
                                  TensorProductOnObjects( cat, a, b ) ) ],
                        range );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                    "MonoidalPreComposeMorphismWithGivenObjects using, braiding, evaluation, and tensor hom adjunction",
                    [ [ InternalHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ EvaluationMorphism, 2 ],
                      [ TensorProductToInternalHomAdjunctionMapWithGivenInternalHom, 1 ],
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
    
    hom_a_b := InternalHomOnObjects( cat, a, b );
    
    hom_b_c := InternalHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, hom_a_b ),
                                Braiding( cat, hom_b_c, a ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  EvaluationMorphism( cat, a, b ),
                                  IdentityMorphism( cat, hom_b_c ) ),
                          
                          Braiding( cat, b, hom_b_c ),
                          
                          EvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToInternalHomAdjunctionMapWithGivenInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    "MonoidalPostComposeMorphismWithGivenObjects using evaluation, and tensor hom adjunction",
                    [ [ InternalHomOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ EvaluationMorphism, 2 ],
                      [ TensorProductToInternalHomAdjunctionMapWithGivenInternalHom, 1 ],
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
                                IdentityMorphism( cat, InternalHomOnObjects( cat, b, c ) ),
                                EvaluationMorphism( cat, a, b ) ),
                          
                          EvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToInternalHomAdjunctionMapWithGivenInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );
