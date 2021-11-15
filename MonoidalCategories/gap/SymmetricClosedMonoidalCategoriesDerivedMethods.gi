# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToInternalHomAdjunctionMap,
                    
  function( cat, object_1, object_2, morphism )
    
    return PreCompose( cat,
             CoevaluationMorphism( cat, object_1, object_2 ),
             InternalHomOnMorphisms( cat, IdentityMorphism( cat, object_2 ), morphism ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "TensorProductToInternalHomAdjunctionMap using CoevaluationMorphism and InternalHom" );

##
AddDerivationToCAP( InternalHomToTensorProductAdjunctionMap,
                    
  function( cat, object_1, object_2, morphism )
    
    return PreCompose( cat,
             TensorProductOnMorphisms( cat, morphism, IdentityMorphism( cat, object_1 ) ),
             EvaluationMorphism( cat, object_1, object_2 ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "InternalHomToTensorProductAdjunctionMap using TensorProductOnMorphisms and EvaluationMorphism" );

##
AddDerivationToCAP( UniversalPropertyOfDual,
                    
  function( cat, object_1, object_2, test_morphism )
    
    return PreCompose( cat,
             TensorProductToInternalHomAdjunctionMap( cat, object_1, object_2, test_morphism ),
             IsomorphismFromInternalHomToDual( cat, object_2 ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "UniversalPropertyOfDual using the tensor hom adjunction" );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                  
  function( cat, object, bidual )
    local morphism;

    morphism := PreCompose( cat, Braiding( cat, object, DualOnObjects( cat, object ) ),
                            EvaluationForDual( cat, object ) );
    
    return UniversalPropertyOfDual( cat, object, DualOnObjects( cat, object ), morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MorphismToBidualWithGivenBidual using the braiding and the universal property of the dual" );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                    
  function( cat, object, bidual )
    local morphism, dual_object, tensor_unit;
    
    dual_object := DualOnObjects( cat, object );
    
    tensor_unit := TensorUnit( cat );
    
    morphism := PreComposeList( cat, [
                  CoevaluationMorphism( cat, object, dual_object ),
                  
                  InternalHomOnMorphisms( cat,
                    IdentityMorphism( cat, dual_object ),
                    Braiding( cat, object, dual_object ) ),
                  
                  InternalHomOnMorphisms( cat,
                    IdentityMorphism( cat, dual_object ),
                    EvaluationMorphism( cat, object, tensor_unit ) )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MorphismToBidualWithGivenBidual using Coevaluation, InternalHom, and Evaluation" );

##
AddDerivationToCAP( DualOnObjects,
                  
  function( cat, object )
    
    return Source( IsomorphismFromDualToInternalHom( cat, object ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "DualOnObjects as the source of IsomorphismFromDualToInternalHom" );

##
AddDerivationToCAP( DualOnObjects,
                  
  function( cat, object )
    
    return Range( IsomorphismFromInternalHomToDual( cat, object ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "DualOnObjects as the range of IsomorphismFromInternalHomToDual" );

##
AddDerivationToCAP( DualOnMorphismsWithGivenDuals,
                  
  function( cat, new_source, morphism, new_range )
    
    return PreComposeList( cat, [
             IsomorphismFromDualToInternalHom( cat, Range( morphism ) ),
             
             InternalHomOnMorphisms( cat,
               morphism,
               IdentityMorphism( cat, TensorUnit( cat ) ) ),
               
             IsomorphismFromInternalHomToDual( cat, Source( morphism ) )
           ] );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "DualOnMorphismsWithGivenDuals using InternalHomOnMorphisms and IsomorphismFromDualToInternalHom" );

##
AddDerivationToCAP( EvaluationForDualWithGivenTensorProduct,
                  
  function( cat, tensor_object, object, unit )
    
    return InternalHomToTensorProductAdjunctionMap( cat, object, unit,
                                                    IsomorphismFromDualToInternalHom( cat, object ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "EvaluationForDualWithGivenTensorProduct using the tensor hom adjunction and IsomorphismFromDualToInternalHom" );

##
AddDerivationToCAP( LambdaIntroduction,
                  
  function( cat, morphism )
    local result_morphism, source;
    
    source := Source( morphism );
    
    result_morphism := PreCompose( cat, LeftUnitor( cat, source ), morphism );
    
    return TensorProductToInternalHomAdjunctionMap( cat, TensorUnit( cat ), source, result_morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "LambdaIntroduction using the tensor hom adjunction and left unitor" );

##
AddDerivationToCAP( LambdaElimination,
                  
  function( cat, object_1, object_2, morphism )
    local result_morphism;
    
    result_morphism := InternalHomToTensorProductAdjunctionMap( cat, object_1, object_2, morphism );
    
    return PreCompose( cat, LeftUnitorInverse( cat, object_1 ), result_morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "LambdaElimination using the tensor hom adjunction and left unitor" );

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
      Description := "TensorProductInternalHomCompatibilityMorphismWithGivenObjects using associator, braiding an the evaluation morphism" );

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
                  
                  InternalHomOnMorphisms( cat,
                    IdentityMorphism( cat, tensor_product_on_object_1_and_object_2 ),
                    LeftUnitor( cat, unit ) ),
                  
                  IsomorphismFromInternalHomToDual( cat, tensor_product_on_object_1_and_object_2 )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "TensorProductDualityCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of tensor product and internal hom" );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
                  
  function( cat, object, internal_hom )
    local unit;
    
    unit := TensorUnit( cat );
    
    return PreCompose( cat,
             CoevaluationMorphism( cat, object, unit ),
             InternalHomOnMorphisms( cat,
               IdentityMorphism( cat, unit ),
               RightUnitor( cat, object ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromObjectToInternalHomWithGivenInternalHom using the coevaluation morphism" );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
                  
  function( cat, object, internal_hom )
    local unit;
    
    unit := TensorUnit( cat );
    
    return TensorProductToInternalHomAdjunctionMap( cat,
             object,
             unit,
             RightUnitor( cat, object ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromObjectToInternalHomWithGivenInternalHom as the adjoint of the right unitor" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromInternalHomToObjectWithGivenInternalHom,
#                     
#   function( cat, object, internal_hom )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToInternalHom( cat, object ) );
#     
# end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
#       Description := "IsomorphismFromInternalHomToObjectWithGivenInternalHom as the inverse of IsomorphismFromObjectToInternalHom" );

##
AddDerivationToCAP( IsomorphismFromInternalHomToObjectWithGivenInternalHom,
                  
  function( cat, object, internal_hom )
    local unit;
    
    unit := TensorUnit( cat );
    
    return PreCompose( cat, RightUnitorInverse( cat, internal_hom ),
                       EvaluationMorphism( cat, unit, object ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalHomToObjectWithGivenInternalHom using the evaluation morphism" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
#                     
#   function( cat, object, internal_hom )
#     
#     return InverseForMorphisms( cat, IsomorphismFromInternalHomToObject( cat, object ) );
#     
# end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
#       Description := "IsomorphismFromObjectToInternalHom as the inverse of IsomorphismFromInternalHomToObject" );

##
AddDerivationToCAP( MorphismFromTensorProductToInternalHomWithGivenObjects,
                    
  function( cat, tensor_object, object_1, object_2, internal_hom )
    local unit;
    
    unit := TensorUnit( cat );
    
    return PreComposeList( cat, [
             TensorProductOnMorphisms( cat,
               IsomorphismFromDualToInternalHom( cat, object_1 ),
               IsomorphismFromObjectToInternalHom( cat, object_2 ) ),
                
             TensorProductInternalHomCompatibilityMorphism( cat,
               [ object_1, unit, unit, object_2 ] ),
                
             InternalHomOnMorphisms( cat,
               RightUnitor( cat, object_1 ),
               LeftUnitor( cat, object_2 ) ),
           ] );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MorphismFromTensorProductToInternalHomWithGivenObjects using TensorProductInternalHomCompatibilityMorphism" );

##
# AddDerivationToCAP( MorphismFromTensorProductToInternalHomWithGivenObjects,
#                     
#   function( )
#   
# end : CategoryFilter := IsSymmetricClosedMonoidalCategory 

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
