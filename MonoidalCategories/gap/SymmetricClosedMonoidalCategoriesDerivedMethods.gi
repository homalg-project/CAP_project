# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToInternalHomAdjunctionMap,
                    
  function( cat, a, b, f )

    # f: a x b -> c
    #
    #      a
    #      |
    #      | coev_ab
    #      v
    # Hom(b,a x b)
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

    # g: a -> Hom(b,c)
    #
    #    a x b
    #      |
    #      | g x id_b
    #      v
    # Hom(b,c) x b
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

    # alpha: t x a -> 1
    #
    # Adjoint( alpha ) = ( t -> Hom(a,1) ) -> a^v
    
    return PreCompose( cat,
             TensorProductToInternalHomAdjunctionMap( cat, t, a, alpha ),
             IsomorphismFromInternalHomToDual( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "UniversalPropertyOfDual using the tensor hom adjunction" );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                  
  function( cat, a, avv )
    local alpha;

    #    a x a^v
    #      |
    #      | B_(a,a^v)
    #      v
    #  a^v x a
    #      |
    #      | ev_a
    #      v
    #      1
    #
    # UniversalProperty( a x a^v -> 1 ) = ( a -> a^v^v)

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
    #  Hom(av, a x a^v)
    #        |
    #        | Hom(id_av, B_(a,a^v))
    #        v
    # Hom(av, a^v x a)
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

    # Source( a^v -> Hom(a,1) )
    
    return Source( IsomorphismFromDualToInternalHom( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "DualOnObjects as the source of IsomorphismFromDualToInternalHom" );

##
AddDerivationToCAP( DualOnObjects,
                  
  function( cat, a )

    # Range( Hom(a,1) -> a^v )
    
    return Range( IsomorphismFromInternalHomToDual( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "DualOnObjects as the range of IsomorphismFromInternalHomToDual" );

##
AddDerivationToCAP( DualOnMorphismsWithGivenDuals,
                  
  function( cat, s, alpha, r )

    # alpha: a->b
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
             IsomorphismFromDualToInternalHom( cat, Range( alpha ) ),
             
             InternalHomOnMorphisms( cat,
               alpha,
               IdentityMorphism( cat, TensorUnit( cat ) ) ),
               
             IsomorphismFromInternalHomToDual( cat, Source( alpha ) )
           ] );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "DualOnMorphismsWithGivenDuals using InternalHomOnMorphisms and IsomorphismFromDualToInternalHom" );

##
AddDerivationToCAP( EvaluationForDualWithGivenTensorProduct,
                  
  function( cat, s, a, r )

    # r := 1
    #
    # Adjoint( a^v -> Hom(a,1) ) = ( a^v x a -> 1 )
    
    return InternalHomToTensorProductAdjunctionMap( cat, a, r,
                                                    IsomorphismFromDualToInternalHom( cat, a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "EvaluationForDualWithGivenTensorProduct using the tensor hom adjunction and IsomorphismFromDualToInternalHom" );

##
AddDerivationToCAP( LambdaIntroduction,
                  
  function( cat, alpha )
    local result_morphism, source;

    # 1 x a
    #   |
    #   | λ_a
    #   v
    #   a
    #   |
    #   | alpha
    #   v
    #   b
    #
    # Adjoint( 1 x a -> b) = ( 1 -> Hom(a,b) )
    
    source := Source( alpha );
    
    result_morphism := PreCompose( cat, LeftUnitor( cat, source ), alpha );
    
    return TensorProductToInternalHomAdjunctionMap( cat, TensorUnit( cat ), source, result_morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "LambdaIntroduction using the tensor hom adjunction and left unitor" );

##
AddDerivationToCAP( LambdaElimination,
                  
  function( cat, a, b, alpha )
    local result_morphism;

    # alpha: 1 -> Hom(a,b)
    # Adjoint( alpha ) = ( 1 x a -> b)
    #
    #   a
    #   |
    #   | (λ_a)^-1
    #   v
    # 1 x a
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
    
    # (Hom(a1,b1) x Hom(a2,b2)) x (a1 x a2)
    #                  |
    #                  | α_( Hom(a1,b1) x Hom(a2,b2), (a1, a2) )
    #                  v
    # ((Hom(a1,b1) x Hom(a2,b2)) x a1) x a2
    #                  |
    #                  | α_( ( Hom(a1,b1), Hom(a2,b2) ), a1 ) x id_a2
    #                  v
    # (Hom(a1,b1) x (Hom(a2,b2) x a1)) x a2
    #                  |
    #                  | ( id_Hom(a1,b1) x B_( Hom(a2,b2), a1 ) ) x id_a2
    #                  v
    # (Hom(a1,b1) x (a1 x Hom(a2,b2))) x a2
    #                  |
    #                  | α_( Hom(a1,b1), ( a1, Hom(a2,b2) ) ) x id_a2
    #                  v
    # ((Hom(a1,b1) x a1) x Hom(a2,b2)) x a2
    #                  |
    #                  | ( ev_(a1,b1) x id_Hom(a2,b2) ) x id_a2
    #                  v
    #       (b1 x Hom(a2,b2)) x a2
    #                  |
    #                  | α_( ( b1,Hom(a2,b2) ), a2 )
    #                  v
    #       b1 x (Hom(a2,b2) x a2)
    #                  |
    #                  | id_b1 x ev_(a2,b2)
    #                  v
    #               b1 x b2
    #
    #
    # Adjoint[ (Hom(a1,b1) x Hom(a2,b2)) x (a1 x a2) -> b1 x b2 ] = [ Hom(a1,b1) x Hom(a2,b2) -> Hom(a1 x a2, b1 x b2) ]

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

    #      a^v x b^v
    #          |
    #          v
    # Hom(a,1) x Hom(b,1)
    #          |
    #          | CompatMorphism(a,1,b,1)
    #          V
    #  Hom(a x b, 1 x 1)
    #          |
    #          | Hom(id_(a x b), λ_1)
    #          V
    #    Hom(a x b, 1)
    #          |
    #          V
    #       (a x b)^v

    
    unit := TensorUnit( cat );
    
    tensor_product_on_a_and_b := TensorProductOnObjects( cat, a, b );
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IsomorphismFromDualToInternalHom( cat, a ),
                    IsomorphismFromDualToInternalHom( cat, b ) ),
                  
                  TensorProductInternalHomCompatibilityMorphism( cat, [ a, unit, b, unit ] ),
                  
                  InternalHomOnMorphisms( cat,
                    IdentityMorphism( cat, tensor_product_on_a_and_b ),
                    LeftUnitor( cat, unit ) ),
                  
                  IsomorphismFromInternalHomToDual( cat, tensor_product_on_a_and_b )
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
    # Hom(1, a x 1)
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

    # ρ_a: a x 1 -> a
    #
    # Adjoint( ρ_a ) = ( a -> Hom(1,a) )
    
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
#     # Inverse( a -> Hom(1,a) )
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
    # Hom(1,a) x 1
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
#     # Inverse( a -> Hom(1,a))
#     
#     return InverseForMorphisms( cat, IsomorphismFromInternalHomToObject( cat, object ) );
#     
# end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
#       Description := "IsomorphismFromObjectToInternalHom as the inverse of IsomorphismFromInternalHomToObject" );

##
AddDerivationToCAP( MorphismFromTensorProductToInternalHomWithGivenObjects,
                    
  function( cat, tensor_object, a, b, internal_hom )
    local unit;

    #      a^v x b
    #          |
    #          v
    # Hom(a,1) x Hom(1,b)
    #          |
    #          | CompatMorphism
    #          v
    # Hom(a x 1, 1 x b)
    #          |
    #          | Hom(ρ_a, λ_b)
    #          v
    #       Hom(a,b)

    unit := TensorUnit( cat );
    
    return PreComposeList( cat, [
             TensorProductOnMorphisms( cat,
               IsomorphismFromDualToInternalHom( cat, a ),
               IsomorphismFromObjectToInternalHom( cat, b ) ),
                
             TensorProductInternalHomCompatibilityMorphism( cat,
               [ a, unit, unit, b ] ),
                
             InternalHomOnMorphisms( cat,
               RightUnitor( cat, a ),
               LeftUnitor( cat, b ) ),
           ] );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MorphismFromTensorProductToInternalHomWithGivenObjects using TensorProductInternalHomCompatibilityMorphism" );

##
AddDerivationToCAP( EvaluationMorphismWithGivenSource,
                  
  function( cat, object_1, object_2, tensor_object )
    
    return InternalHomToTensorProductAdjunctionMap( cat,
             object_1,
             object_2,
             IdentityMorphism( cat, InternalHomOnObjects( cat, object_1, object_2 ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "EvaluationMorphismWithGivenSource using the tensor hom adjunction on the identity" );

##
AddDerivationToCAP( CoevaluationMorphismWithGivenRange,
                  
  function( cat, object_1, object_2, internal_hom )
    
    return TensorProductToInternalHomAdjunctionMap( cat,
             object_1,
             object_2,
             IdentityMorphism( cat, TensorProductOnObjects( cat, object_1, object_2 ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "CoevaluationMorphismWithGivenRange using the tensor hom adjunction on the identity" );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                  
  function( cat, new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := InternalHomOnObjects( cat, x, y );
    
    hom_y_z := InternalHomOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  AssociatorLeftToRight( cat, hom_x_y, hom_y_z, x ),
                  
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, hom_x_y ),
                    Braiding( cat, hom_y_z, x ) ),
                  
                  AssociatorRightToLeft( cat, hom_x_y, x, hom_y_z ),
                  
                  TensorProductOnMorphisms( cat,
                    EvaluationMorphism( cat, x, y ),
                    IdentityMorphism( cat, hom_y_z ) ),
                  
                  Braiding( cat, y, hom_y_z ),
                  
                  EvaluationMorphism( cat, y, z )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap( cat,
             TensorProductOnObjects( cat, hom_x_y, hom_y_z ),
             x,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPreComposeMorphismWithGivenObjects using associator, braiding, evaluation, and tensor hom adjunction" );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := InternalHomOnObjects( cat, x, y );
    
    hom_y_z := InternalHomOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  AssociatorLeftToRight( cat, hom_y_z, hom_x_y, x ),
                  
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, hom_y_z ),
                    EvaluationMorphism( cat, x, y ) ),
                  
                  EvaluationMorphism( cat, y, z )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap( cat,
             TensorProductOnObjects( cat, hom_y_z, hom_x_y ),
             x,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPostComposeMorphismWithGivenObjects using associator, evaluation, and tensor hom adjunction" );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local braiding;
    
    braiding := Braiding( cat, InternalHomOnObjects( cat, y, z ), InternalHomOnObjects( cat, x, y ) );
    
    return PreCompose( cat, braiding, MonoidalPreComposeMorphism( cat, x, y, z ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPostComposeMorphismWithGivenObjects using MonoidalPreComposeMorphism and braiding" );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local braiding;
    
    braiding := Braiding( cat, InternalHomOnObjects( cat, x, y ), InternalHomOnObjects( cat, y, z ) );
    
    return PreCompose( cat, braiding, MonoidalPostComposeMorphism( cat, x, y, z ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPreComposeMorphismWithGivenObjects using MonoidalPostComposeMorphism and braiding" );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                    
  function( cat, source, list, range )
    local a1, b1, a2, b2, morphism, int_hom_a1_b1, int_hom_a2_b2, id_a2, tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2;
    
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
                  
  function( cat, new_source, object_1, object_2, new_range )
    local morphism, unit, tensor_product_on_object_1_and_object_2;
    
    unit := TensorUnit( cat );
    
    tensor_product_on_object_1_and_object_2 := TensorProductOnObjects( cat, object_1, object_2 );
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IsomorphismFromDualToInternalHom( cat, object_1 ),
                    IsomorphismFromDualToInternalHom( cat, object_2 ) ),
                  
                  TensorProductInternalHomCompatibilityMorphism( cat, [ object_1, unit, object_2, unit ] ),
                  
                  IsomorphismFromInternalHomToDual( cat, tensor_product_on_object_1_and_object_2 )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "TensorProductDualityCompatibilityMorphismWithGivenObjects using compatibility of tensor product and internal hom" );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                  
  function( cat, new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := InternalHomOnObjects( cat, x, y );
    
    hom_y_z := InternalHomOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, hom_x_y ),
                    Braiding( cat, hom_y_z, x ) ),
                  
                  TensorProductOnMorphisms( cat,
                    EvaluationMorphism( cat, x, y ),
                    IdentityMorphism( cat, hom_y_z ) ),
                  
                  Braiding( cat, y, hom_y_z ),
                  
                  EvaluationMorphism( cat, y, z )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap( cat,
             TensorProductOnObjects( cat, hom_x_y, hom_y_z ),
             x,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "MonoidalPreComposeMorphismWithGivenObjects using, braiding, evaluation, and tensor hom adjunction" );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := InternalHomOnObjects( cat, x, y );
    
    hom_y_z := InternalHomOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, hom_y_z ),
                    EvaluationMorphism( cat, x, y ) ),
                  
                  EvaluationMorphism( cat, y, z )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap( cat,
             TensorProductOnObjects( cat, hom_y_z, hom_x_y ),
             x,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "MonoidalPostComposeMorphismWithGivenObjects using evaluation, and tensor hom adjunction" );
