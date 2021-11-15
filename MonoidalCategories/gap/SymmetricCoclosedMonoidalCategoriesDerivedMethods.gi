# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToInternalCoHomAdjunctionMap,

  function( cat, object_1, object_2, morphism )
    
    return PreCompose( cat,
             InternalCoHomOnMorphisms( cat, morphism, IdentityMorphism( cat, object_1 ) ),
             CoclosedCoevaluationMorphism( cat, object_1, object_2 ) );
             
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "TensorProductToInternalCoHomAdjunctionMap using CoclosedCoevaluationMorphism and InternalCoHom" );

##
AddDerivationToCAP( InternalCoHomToTensorProductAdjunctionMap,

  function( cat, object_1, object_2, morphism )
    
    return PreCompose( cat,
             CoclosedEvaluationMorphism( cat, object_1, object_2 ),
             TensorProductOnMorphisms( cat, IdentityMorphism( cat, object_2 ), morphism ) );
             
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomToTensorProductAdjunctionMap using TensorProductOnMorphisms and CoclosedEvaluationMorphism" );

##
AddDerivationToCAP( UniversalPropertyOfCoDual,

  function( cat, object_1, object_2, test_morphism )
    
    return PreCompose( cat,
             IsomorphismFromCoDualToInternalCoHom( cat, object_2 ),
             TensorProductToInternalCoHomAdjunctionMap( cat, object_1, object_2, test_morphism ) );
             
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "UniversalPropertyOfCoDual using the cohom tensor adjunction" );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,

  function( cat, cobidual, object )
    local morphism;

    morphism := PreCompose( cat,
                  CoclosedEvaluationForCoDual( cat, object ),
                  Braiding( cat, object, CoDualOnObjects( cat, object ) ) );
                  
    return UniversalPropertyOfCoDual( cat, CoDualOnObjects( cat, object ), object, morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MorphismFromCoBidualWithGivenCoBidual using the braiding and the universal property of the codual" );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,

  function( cat, cobidual, object )
    local morphism, codual_object, tensor_unit;
    
    codual_object := CoDualOnObjects( cat, object );
    
    tensor_unit := TensorUnit( cat );
    
    morphism := PreComposeList( cat, [
                  InternalCoHomOnMorphisms( cat,
                    CoclosedEvaluationMorphism( cat, tensor_unit, object ),
                    IdentityMorphism( cat, codual_object ) ),
                  
                  InternalCoHomOnMorphisms( cat,
                    Braiding( cat, object, codual_object ),
                    IdentityMorphism( cat, codual_object ) ),
                  
                  CoclosedCoevaluationMorphism( cat, codual_object, object )
                ] );
    
    return morphism;

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MorphismFromCoBidualWithGivenCoBidual using CoclosedEvaluation, InternalCoHom, and CoclosedCoevaluation" );

##
AddDerivationToCAP( CoDualOnObjects,

  function( cat, object )
    
    return Source( IsomorphismFromCoDualToInternalCoHom( cat, object ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoDualOnObjects as the source of IsomorphismFromCoDualToInternalCoHom" );

##
AddDerivationToCAP( CoDualOnObjects,

  function( cat, object )
    
    return Range( IsomorphismFromInternalCoHomToCoDual( cat, object ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoDualOnObjects as the range of IsomorphismFromInternalCoHomToCoDual" );

##
AddDerivationToCAP( CoDualOnMorphismsWithGivenCoDuals,

  function( cat, new_source, morphism, new_range )
    local result_morphism;
    
    result_morphism := PreComposeList( cat, [
                         IsomorphismFromCoDualToInternalCoHom( cat, Range( morphism ) ),
                         
                         InternalCoHomOnMorphisms( cat,
                           IdentityMorphism( cat, TensorUnit( cat ) ),
                           morphism ),
                           
                         IsomorphismFromInternalCoHomToCoDual( cat, Source( morphism ) )
                       ] );
                       
    return result_morphism;
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoDualOnMorphismsWithGivenCoDuals using InternalCoHomOnMorphisms and IsomorphismFromCoDualToInternalCoHom" );

##
AddDerivationToCAP( CoclosedEvaluationForCoDualWithGivenTensorProduct,

  function( cat, unit, object, tensor_object )

    return InternalCoHomToTensorProductAdjunctionMap( cat,
            unit,
            object,
            IsomorphismFromInternalCoHomToCoDual( cat, object ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoclosedEvaluationForCoDualWithGivenTensorProduct using the cohom tensor adjunction and IsomorphismFromInternalCoHomToCoDual" );

##
AddDerivationToCAP( CoLambdaIntroduction,

  function( cat, morphism )
    local result_morphism, range;

    range := Range( morphism );

    result_morphism := PreCompose( cat, morphism, RightUnitorInverse( cat, range ) );

    return TensorProductToInternalCoHomAdjunctionMap( cat,
             range,
             TensorUnit( cat ),
             result_morphism );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoLambdaIntroduction using the cohom tensor adjunction and right unitor" );

##
AddDerivationToCAP( CoLambdaElimination,

  function( cat, object_1, object_2, morphism )
    local result_morphism;
    
    result_morphism := InternalCoHomToTensorProductAdjunctionMap( cat, object_1, object_2, morphism );
    
    return PreCompose( cat, result_morphism, RightUnitor( cat, object_2 ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoLambdaElimination using the cohom tensor adjunction and right unitor" );

##
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,

  function( cat, source, list, range )
    local a1, a2, b1, b2, morphism, tensor_product_b1_b2, int_cohom_a1_b1, int_cohom_a2_b2, id_int_cohom_a1_b1, id_int_cohom_a2_b2;
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    tensor_product_b1_b2 := TensorProductOnObjects( cat, b1, b2 );
    
    int_cohom_a1_b1 := InternalCoHomOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := InternalCoHomOnObjects( cat, a2, b2 );
    
    id_int_cohom_a1_b1 := IdentityMorphism( cat, int_cohom_a1_b1 );
    
    id_int_cohom_a2_b2 := IdentityMorphism( cat, int_cohom_a2_b2 );
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, a1 ),
                    CoclosedEvaluationMorphism( cat, a2, b2 ) ),
                  
                  AssociatorRightToLeft( cat, a1, b2,  int_cohom_a2_b2),
                  
                  TensorProductOnMorphisms( cat,
                    TensorProductOnMorphisms( cat,
                      CoclosedEvaluationMorphism( cat, a1, b1 ),
                      IdentityMorphism( cat, b2 ) ),
                     id_int_cohom_a2_b2),
                  
                  TensorProductOnMorphisms( cat,
                    AssociatorLeftToRight( cat, b1, int_cohom_a1_b1, b2 ),
                    id_int_cohom_a2_b2 ),
                  
                  TensorProductOnMorphisms( cat,
                    TensorProductOnMorphisms( cat,
                      IdentityMorphism( cat, b1 ),
                      Braiding( cat, b2, int_cohom_a1_b1 ) ),
                    id_int_cohom_a2_b2 ),
                  
                  TensorProductOnMorphisms( cat,
                    AssociatorRightToLeft( cat, b1, b2, int_cohom_a1_b1 ),
                    id_int_cohom_a2_b2 ),
                  
                  AssociatorLeftToRight( cat,
                    tensor_product_b1_b2,
                    int_cohom_a1_b1,
                    int_cohom_a2_b2 )
                ] );

    return TensorProductToInternalCoHomAdjunctionMap( cat,
             tensor_product_b1_b2,
             TensorProductOnObjects( cat, int_cohom_a1_b1, int_cohom_a2_b2 ),
             morphism );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using associator, braiding and the coclosed evaluation morphism" );

##
AddDerivationToCAP( CoDualityTensorProductCompatibilityMorphismWithGivenObjects,

  function( cat, new_source, object_1, object_2, new_range )
    local morphism, unit, tensor_product_on_object_1_and_object_2;
    
    unit := TensorUnit( cat );
    
    tensor_product_on_object_1_and_object_2 := TensorProductOnObjects( cat, object_1, object_2 );
    
    morphism := PreComposeList( cat, [
                  IsomorphismFromCoDualToInternalCoHom( cat, tensor_product_on_object_1_and_object_2 ),
                  
                  InternalCoHomOnMorphisms( cat,
                    LeftUnitorInverse( cat, unit ),
                    IdentityMorphism( cat, tensor_product_on_object_1_and_object_2 ) ),
                  
                  InternalCoHomTensorProductCompatibilityMorphism( cat, [ unit, unit, object_1, object_2 ] ),
                  
                  TensorProductOnMorphisms( cat,
                    IsomorphismFromInternalCoHomToCoDual( cat, object_1 ),
                    IsomorphismFromInternalCoHomToCoDual( cat, object_2 ) )
                ] );

    return morphism;

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoDualityTensorProductCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of internal cohom and tensor product" );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom,
                  
  function( cat, object, internal_cohom )
    local unit;
    
    unit := TensorUnit( cat );
    
    return PreCompose( cat,
             InternalCoHomOnMorphisms( cat,
               LeftUnitorInverse( cat, object ),
               IdentityMorphism( cat, unit ) ),
               
             CoclosedCoevaluationMorphism( cat, unit, object ));
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom using the coclosed coevaluation morphism" );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom,
                  
  function( cat, object, internal_cohom )
    local unit;
    
    unit := TensorUnit( cat );
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             unit,
             object,
             LeftUnitorInverse( cat, object ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom as the adjoint of the left inverse unitor" );

## TODO: modify for the coclosed case and enable
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
AddDerivationToCAP( IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom,
                  
  function( cat, object, internal_cohom )
    local unit;
    
    unit := TensorUnit( cat );
    
    return PreCompose( cat, CoclosedEvaluationMorphism( cat, object, unit ),
                       LeftUnitor( cat, internal_cohom ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom using the coclosed evaluation morphism" );

## TODO: modify for the coclosed case and enable
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
AddDerivationToCAP( MorphismFromInternalCoHomToTensorProductWithGivenObjects,
                    
  function( cat, internal_cohom, object_1, object_2, tensor_object )
    local unit;
    
    unit := TensorUnit( cat );
    
    return PreComposeList( cat, [
             InternalCoHomOnMorphisms( cat,
               RightUnitorInverse( cat, object_1 ),
               LeftUnitorInverse( cat, object_2 ) ),
              
             InternalCoHomTensorProductCompatibilityMorphism( cat,
               [ object_1, unit, unit, object_2 ] ),
              
             TensorProductOnMorphisms( cat,
               IsomorphismFromInternalCoHomToObject( cat, object_1 ),
               IsomorphismFromInternalCoHomToCoDual( cat, object_2 ) )
           ] );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MorphismFromInternalCoHomToTensorProductWithGivenObjects using InternalCoHomTensorProductCompatibilityMorphism" );

##
AddDerivationToCAP( CoclosedEvaluationMorphismWithGivenRange,
                  
  function( cat, object_1, object_2, tensor_object )
    
    return InternalCoHomToTensorProductAdjunctionMap( cat,
             object_1,
             object_2,
             IdentityMorphism( cat, InternalCoHomOnObjects( cat, object_1, object_2 ) )
           );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoclosedEvaluationMorphismWithGivenRange using the cohom tensor adjunction on the identity" );

AddDerivationToCAP( CoclosedCoevaluationMorphismWithGivenSource,
                  
  function( cat, object_1, object_2, internal_cohom )
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             object_1,
             object_2,
             IdentityMorphism( cat, TensorProductOnObjects( cat, object_1, object_2 ) )
           );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoclosedCoevaluationMorphismWithGivenSource using the cohom tensor adjunction on the identity" );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                  
  function( cat, new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := InternalCoHomOnObjects( cat, x, y );
    
    cohom_y_z := InternalCoHomOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  CoclosedEvaluationMorphism( cat, x, y ),
                  
                  Braiding( cat, y, cohom_x_y ),
                  
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, cohom_x_y ),
                    CoclosedEvaluationMorphism( cat, y, z ) ),
                  
                  AssociatorRightToLeft( cat, cohom_x_y, z, cohom_y_z ),
                  
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, cohom_x_y, z ),
                    IdentityMorphism( cat, cohom_y_z ) ),
                  
                  AssociatorLeftToRight( cat, z, cohom_x_y, x, cohom_y_z ),
                ] );
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             z,
             TensorProductOnObjects( cat, cohom_x_y, cohom_y_z ),
             morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MonoidalPreCoComposeMorphismWithGivenObjects using associator, braiding, coclosed evaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := InternalCoHomOnObjects( cat, x, y );
    
    cohom_y_z := InternalCoHomOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  CoclosedEvaluationMorphism( cat, x, y ),
                  
                  TensorProductOnMorphisms( cat,
                    CoclosedEvaluationMorphism( cat, y, z ),
                    IdentityMorphism( cat, cohom_x_y )
                  ),
                  
                  AssociatorLeftToRight( cat, z, cohom_y_z, cohom_x_y )
                ] );
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             z,
             TensorProductOnObjects( cat, cohom_y_z, cohom_x_y ),
             morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MonoidalPostCoComposeMorphismWithGivenObjects using associator, coclosed evaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local braiding;
    
    braiding := Braiding( cat, InternalCoHomOnObjects( cat, x, y ), InternalCoHomOnObjects( cat, y, z ) );
    
    return PreCompose( cat, MonoidalPreCoComposeMorphism( cat, x, y, z ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MonoidalPostCoComposeMorphismWithGivenObjects using MonoidalPreCoComposeMorphism and braiding" );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local braiding;
    
    braiding := Braiding( cat, InternalCoHomOnObjects( cat, y, z ), InternalCoHomOnObjects( cat, x, y ) );
    
    return PreCompose( cat, MonoidalPostCoComposeMorphism( cat, x, y, z ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MonoidalPreCoComposeMorphismWithGivenObjects using MonoidalPostCoComposeMorphism and braiding" );

##
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                    
  function( cat, source, list, range )
    local a1, a2, b1, b2, morphism, int_cohom_a1_b1, int_cohom_a2_b2, id_int_cohom_a2_b2, tensor_product_b1_b2;
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    int_cohom_a1_b1 := InternalCoHomOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := InternalCoHomOnObjects( cat, a2, b2 );
    
    id_int_cohom_a2_b2 := IdentityMorphism( cat, int_cohom_a2_b2 );
    
    tensor_product_b1_b2 := TensorProductOnObjects( cat, b1, b2 );
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, a1 ),
                    CoclosedEvaluationMorphism( cat, a2, b2 ) ),
                  
                  TensorProductOnMorphisms( cat,
                    TensorProductOnMorphisms( cat,
                      CoclosedEvaluationMorphism( cat, a1, b1 ),
                      IdentityMorphism( cat, b2 ) ),
                    id_int_cohom_a2_b2 ),
                  
                  TensorProductOnMorphisms( cat,
                    TensorProductOnMorphisms( cat,
                      IdentityMorphism( cat, b1 ),
                      Braiding( cat, int_cohom_a1_b1, b2 ) ),
                    id_int_cohom_a2_b2 )
                ] );
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             tensor_product_b1_b2,
             TensorProductOnObjects( cat, int_cohom_a1_b1, int_cohom_a2_b2 ),
             morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using braiding and the coclosed evaluation morphism" );

##
AddDerivationToCAP( CoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                  
  function( cat, new_source, object_1, object_2, new_range )
    local morphism, unit, tensor_product_on_object_1_and_object_2;
    
    unit := TensorUnit( cat );
    
    tensor_product_on_object_1_and_object_2 := TensorProductOnObjects( cat, object_1, object_2 );
    
    morphism := PreComposeList( cat, [
                  IsomorphismFromCoDualToInternalCoHom( cat, tensor_product_on_object_1_and_object_2 ),
                  
                  InternalCoHomTensorProductCompatibilityMorphism( cat, [ unit, unit, object_1, object_2 ] ),
                  
                  TensorProductOnMorphisms( cat,
                    IsomorphismFromInternalCoHomToCoDual( cat, object_1 ),
                    IsomorphismFromInternalCoHomToCoDual( cat, object_2 ) )
                ] );
              
    return morphism;
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "CoDualityTensorProductCompatibilityMorphismWithGivenObjects using compatibility of internal cohom and tensor product" );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                  
  function( cat, new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := InternalCoHomOnObjects( cat, x, y );
    
    cohom_y_z := InternalCoHomOnObjects( cat, y, z );
    
    morphism := PreComposeList( [
                  CoclosedEvaluationMorphism( cat, x, y ),
                  
                  Braiding( cat, y, cohom_x_y),
                  
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, cohom_x_y ),
                    CoclosedEvaluationMorphism( cat, y, z ) ),
                  
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, cohom_x_y, z ),
                    IdentityMorphism( cat, cohom_y_z ) )
                ] );
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             z,
             TensorProductOnObjects( cat, cohom_x_y, cohom_y_z ),
             morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "MonoidalPreCoComposeMorphismWithGivenObjects using braiding, coclosed evaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := InternalCoHomOnObjects( cat, x, y );
    
    cohom_y_z := InternalCoHomOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  CoclosedEvaluationMorphism( cat, x, y ),
                  
                  TensorProductOnMorphisms( cat,
                    CoclosedEvaluationMorphism( cat, y, z ),
                    IdentityMorphism( cat, cohom_x_y ) )
                ] );
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             z,
             TensorProductOnObjects( cat, cohom_y_z, cohom_x_y ),
             morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "MonoidalPostCoComposeMorphismWithGivenObjects using coclosed evaluation, and cohom tensor adjunction" );
