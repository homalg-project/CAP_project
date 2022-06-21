# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToInternalHomAdjunctionMap,
                    
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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "TensorProductToInternalHomAdjunctionMap using CoevaluationMorphism and InternalHom" );

##
AddDerivationToCAP( InternalHomToTensorProductAdjunctionMap,
                    
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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "InternalHomToTensorProductAdjunctionMap using TensorProductOnMorphisms and EvaluationMorphism" );

##
AddDerivationToCAP( UniversalPropertyOfDual,
                    
  function( cat, t, a, alpha )

    # alpha: t ⊗ a → 1
    #
    # Adjoint( alpha ) = ( t → Hom(a,1) ) → a^v
    
    return PreCompose( cat,
             TensorProductToInternalHomAdjunctionMap( cat, t, a, alpha ),
             IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "UniversalPropertyOfDual using the tensor hom adjunction" );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                  
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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MorphismToBidualWithGivenBidual using the braiding and the universal property of the dual" );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                    
  function( cat, a, avv )
    local morphism, av, tensor_unit;

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
    
    tensor_unit := TensorUnit( cat );

    morphism := PreComposeList( cat, [
                  CoevaluationMorphism( cat, a, av ),
                  
                  InternalHomOnMorphisms( cat,
                    IdentityMorphism( cat, av ),
                    Braiding( cat, a, av ) ),
                  
                  InternalHomOnMorphisms( cat,
                    IdentityMorphism( cat, av ),
                    EvaluationMorphism( cat, a, tensor_unit ) )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MorphismToBidualWithGivenBidual using Coevaluation, InternalHom, and Evaluation" );

##
AddDerivationToCAP( DualOnObjects,
                  
  function( cat, a )

    # Source( a^v → Hom(a,1) )
    
    return Source( IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "DualOnObjects as the source of IsomorphismFromDualObjectToInternalHomIntoTensorUnit" );

##
AddDerivationToCAP( DualOnObjects,
                  
  function( cat, a )

    # Range( Hom(a,1) → a^v )
    
    return Range( IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "DualOnObjects as the range of IsomorphismFromInternalHomIntoTensorUnitToDualObject" );

##
AddDerivationToCAP( DualOnMorphismsWithGivenDuals,
                  
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
    
    return PreComposeList( cat, [
             IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, Range( alpha ) ),
             
             InternalHomOnMorphisms( cat,
               alpha,
               IdentityMorphism( cat, TensorUnit( cat ) ) ),
               
             IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, Source( alpha ) )
           ] );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "DualOnMorphismsWithGivenDuals using InternalHomOnMorphisms and IsomorphismFromDualObjectToInternalHomIntoTensorUnit" );

##
AddDerivationToCAP( EvaluationForDualWithGivenTensorProduct,
                  
  function( cat, s, a, r )

    # r := 1
    #
    # Adjoint( a^v → Hom(a,1) ) = ( a^v ⊗ a → 1 )
    
    return InternalHomToTensorProductAdjunctionMap( cat, a, r,
                                                    IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "EvaluationForDualWithGivenTensorProduct using the tensor hom adjunction and IsomorphismFromDualObjectToInternalHomIntoTensorUnit" );

##
AddDerivationToCAP( LambdaIntroduction,
                  
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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "LambdaIntroduction using the tensor hom adjunction and left unitor" );

##
AddDerivationToCAP( LambdaElimination,
                  
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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "LambdaElimination using the tensor hom adjunction and left unitor inverse" );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                    
  function( cat, source, list, range )
    local a1, b1, a2, b2, morphism, int_hom_a1_b1, int_hom_a2_b2, id_a2, tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2;
    
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
    
    int_hom_a1_b1 := InternalHomOnObjects( cat, a1, b1 );
    
    int_hom_a2_b2 := InternalHomOnObjects( cat, a2, b2 );
    
    id_a2 := IdentityMorphism( cat, a2 );
    
    tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2 := 
      TensorProductOnObjects( cat, int_hom_a1_b1, int_hom_a2_b2 );

    morphism := PreComposeList( cat, [
                  AssociatorRightToLeft( cat,
                    tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
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
                    EvaluationMorphism( cat, a2, b2 ) )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap( cat,
             tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
             TensorProductOnObjects( cat, a1, a2 ),
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "TensorProductInternalHomCompatibilityMorphismWithGivenObjects using associator, braiding and the evaluation morphism" );

##
AddDerivationToCAP( TensorProductDualityCompatibilityMorphismWithGivenObjects,
                  
  function( cat, s, a, b, r )
    local morphism, unit, tensor_product_on_a_and_b;

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
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ),
                    IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, b ) ),
                  
                  TensorProductInternalHomCompatibilityMorphism( cat, [ a, unit, b, unit ] ),
                  
                  InternalHomOnMorphisms( cat,
                    IdentityMorphism( cat, tensor_product_on_a_and_b ),
                    LeftUnitor( cat, unit ) ),
                  
                  IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, tensor_product_on_a_and_b )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "TensorProductDualityCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of tensor product and internal hom" );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
                  
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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromObjectToInternalHomWithGivenInternalHom using the coevaluation morphism" );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
                  
  function( cat, a, internal_hom )
    local unit;

    # ρ_a: a ⊗ 1 → a
    #
    # Adjoint( ρ_a ) = ( a → Hom(1,a) )
    
    unit := TensorUnit( cat );
    
    return TensorProductToInternalHomAdjunctionMap( cat,
             a,
             unit,
             RightUnitor( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromObjectToInternalHomWithGivenInternalHom as the adjoint of the right unitor" );

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
                  
  function( cat, a, internal_hom )
    local unit;

    #  Hom(1,a)
    #      |
    #      | ( ρ_Hom(1,a) )^-1
    #      v
    # Hom(1,a) ⊗ 1
    #      |
    #      | ev_(1,a)
    #      v
    #      a
    
    unit := TensorUnit( cat );
    
    return PreCompose( cat, RightUnitorInverse( cat, internal_hom ),
                       EvaluationMorphism( cat, unit, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalHomToObjectWithGivenInternalHom using the evaluation morphism" );

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
    
    return PreComposeList( cat, [
             TensorProductOnMorphisms( cat,
               IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ),
               IsomorphismFromObjectToInternalHom( cat, b ) ),
                
             TensorProductInternalHomCompatibilityMorphism( cat,
               [ a, unit, unit, b ] ),
                
             InternalHomOnMorphisms( cat,
               RightUnitorInverse( cat, a ),
               LeftUnitor( cat, b ) ),
           ] );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MorphismFromTensorProductToInternalHomWithGivenObjects using TensorProductInternalHomCompatibilityMorphism" );

##
AddDerivationToCAP( EvaluationMorphismWithGivenSource,
                  
  function( cat, a, b, tensor_object )

    # Adjoint( id_Hom(a,b): Hom(a,b) → Hom(a,b) ) = ( Hom(a,b) ⊗ a → b )
    
    return InternalHomToTensorProductAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, InternalHomOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "EvaluationMorphismWithGivenSource using the tensor hom adjunction on the identity" );

##
AddDerivationToCAP( CoevaluationMorphismWithGivenRange,
                  
  function( cat, a, b, internal_hom )
    
    # Adjoint( id_(a ⊗ b): a ⊗ b → a ⊗ b ) = ( a → Hom(b, a ⊗ b) )

    return TensorProductToInternalHomAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, TensorProductOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "CoevaluationMorphismWithGivenRange using the tensor hom adjunction on the identity" );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                  
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
    
    morphism := PreComposeList( cat, [
                  AssociatorLeftToRight( cat, hom_a_b, hom_b_c, a ),
                  
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, hom_a_b ),
                    Braiding( cat, hom_b_c, a ) ),
                  
                  AssociatorRightToLeft( cat, hom_a_b, a, hom_b_c ),
                  
                  TensorProductOnMorphisms( cat,
                    EvaluationMorphism( cat, a, b ),
                    IdentityMorphism( cat, hom_b_c ) ),
                  
                  Braiding( cat, b, hom_b_c ),
                  
                  EvaluationMorphism( cat, b, c )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap( cat,
             TensorProductOnObjects( cat, hom_a_b, hom_b_c ),
             a,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPreComposeMorphismWithGivenObjects using associator, braiding, evaluation, and tensor hom adjunction" );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    
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
    
    morphism := PreComposeList( cat, [
                  AssociatorLeftToRight( cat, hom_b_c, hom_a_b, a ),
                  
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, hom_b_c ),
                    EvaluationMorphism( cat, a, b ) ),
                  
                  EvaluationMorphism( cat, b, c )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap( cat,
             TensorProductOnObjects( cat, hom_b_c, hom_a_b ),
             a,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPostComposeMorphismWithGivenObjects using associator, evaluation, and tensor hom adjunction" );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    
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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPostComposeMorphismWithGivenObjects using MonoidalPreComposeMorphism and braiding" );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                    
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
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPreComposeMorphismWithGivenObjects using MonoidalPostComposeMorphism and braiding" );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                    
  function( cat, source, list, range )
    local a1, b1, a2, b2, morphism, int_hom_a1_b1, int_hom_a2_b2, id_a2, tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2;

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
    
    int_hom_a1_b1 := InternalHomOnObjects( cat, a1, b1 );
    
    int_hom_a2_b2 := InternalHomOnObjects( cat, a2, b2 );
    
    id_a2 := IdentityMorphism( cat, a2 );
    
    tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2 := 
      TensorProductOnObjects( cat, int_hom_a1_b1, int_hom_a2_b2 );
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
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
                    EvaluationMorphism( cat, a2, b2 ) )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap( cat,
             tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
             TensorProductOnObjects( cat, a1, a2 ),
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "TensorProductInternalHomCompatibilityMorphismWithGivenObjects using braiding and the evaluation morphism" );

##
AddDerivationToCAP( TensorProductDualityCompatibilityMorphismWithGivenObjects,
                  
  function( cat, source, a, b, range )
    local morphism, unit, tensor_product_on_a_and_b;

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
    
    tensor_product_on_a_and_b := TensorProductOnObjects( cat, a, b );
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ),
                    IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, b ) ),
                  
                  TensorProductInternalHomCompatibilityMorphism( cat, [ a, unit, b, unit ] ),
                  
                  IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, tensor_product_on_a_and_b )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "TensorProductDualityCompatibilityMorphismWithGivenObjects using compatibility of tensor product and internal hom" );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                  
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
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, hom_a_b ),
                    Braiding( cat, hom_b_c, a ) ),
                  
                  TensorProductOnMorphisms( cat,
                    EvaluationMorphism( cat, a, b ),
                    IdentityMorphism( cat, hom_b_c ) ),
                  
                  Braiding( cat, b, hom_b_c ),
                  
                  EvaluationMorphism( cat, b, c )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap( cat,
             TensorProductOnObjects( cat, hom_a_b, hom_b_c ),
             a,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "MonoidalPreComposeMorphismWithGivenObjects using, braiding, evaluation, and tensor hom adjunction" );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    
  function( cat, source, a, b, c, range )
    local hom_a_b, hom_b_c, morphism;

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
    
    hom_a_b := InternalHomOnObjects( cat, a, b );
    
    hom_b_c := InternalHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, hom_b_c ),
                    EvaluationMorphism( cat, a, b ) ),
                  
                  EvaluationMorphism( cat, b, c )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap( cat,
             TensorProductOnObjects( cat, hom_b_c, hom_a_b ),
             a,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "MonoidalPostComposeMorphismWithGivenObjects using evaluation, and tensor hom adjunction" );
