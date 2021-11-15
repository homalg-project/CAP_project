# THIS FILE WAS AUTOMATICALLY GENERATED FROM MonoidalCategories v2021.11-02

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( DirectProductToExponentialAdjunctionMap,
                    
  function( cat, object_1, object_2, morphism )
    
    return PreCompose( cat,
             CartesianCoevaluationMorphism( cat, object_1, object_2 ),
             ExponentialOnMorphisms( cat, IdentityMorphism( cat, object_2 ), morphism ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "DirectProductToExponentialAdjunctionMap using CartesianCoevaluationMorphism and Exponential" );

##
AddDerivationToCAP( ExponentialToDirectProductAdjunctionMap,
                    
  function( cat, object_1, object_2, morphism )
    
    return PreCompose( cat,
             DirectProductOnMorphisms( cat, morphism, IdentityMorphism( cat, object_1 ) ),
             CartesianEvaluationMorphism( cat, object_1, object_2 ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "ExponentialToDirectProductAdjunctionMap using DirectProductOnMorphisms and CartesianEvaluationMorphism" );

##
AddDerivationToCAP( UniversalPropertyOfCartesianDual,
                    
  function( cat, object_1, object_2, test_morphism )
    
    return PreCompose( cat,
             DirectProductToExponentialAdjunctionMap( cat, object_1, object_2, test_morphism ),
             IsomorphismFromExponentialToCartesianDual( cat, object_2 ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "UniversalPropertyOfCartesianDual using the direct product-exponential adjunction" );

##
AddDerivationToCAP( MorphismToCartesianBidualWithGivenCartesianBidual,
                  
  function( cat, object, bidual )
    local morphism;

    morphism := PreCompose( cat, CartesianBraiding( cat, object, CartesianDualOnObjects( cat, object ) ),
                            CartesianEvaluationForCartesianDual( cat, object ) );
    
    return UniversalPropertyOfCartesianDual( cat, object, CartesianDualOnObjects( cat, object ), morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "MorphismToCartesianBidualWithGivenCartesianBidual using the braiding and the universal property of the dual" );

##
AddDerivationToCAP( MorphismToCartesianBidualWithGivenCartesianBidual,
                    
  function( cat, object, bidual )
    local morphism, dual_object, tensor_unit;
    
    dual_object := CartesianDualOnObjects( cat, object );
    
    tensor_unit := TerminalObject( cat );
    
    morphism := PreComposeList( cat, [
                  CartesianCoevaluationMorphism( cat, object, dual_object ),
                  
                  ExponentialOnMorphisms( cat,
                    IdentityMorphism( cat, dual_object ),
                    CartesianBraiding( cat, object, dual_object ) ),
                  
                  ExponentialOnMorphisms( cat,
                    IdentityMorphism( cat, dual_object ),
                    CartesianEvaluationMorphism( cat, object, tensor_unit ) )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "MorphismToCartesianBidualWithGivenCartesianBidual using CartesianCoevaluation, Exponential, and CartesianEvaluation" );

##
AddDerivationToCAP( CartesianDualOnObjects,
                  
  function( cat, object )
    
    return Source( IsomorphismFromCartesianDualToExponential( cat, object ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianDualOnObjects as the source of IsomorphismFromCartesianDualToExponential" );

##
AddDerivationToCAP( CartesianDualOnObjects,
                  
  function( cat, object )
    
    return Range( IsomorphismFromExponentialToCartesianDual( cat, object ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianDualOnObjects as the range of IsomorphismFromExponentialToCartesianDual" );

##
AddDerivationToCAP( CartesianDualOnMorphismsWithGivenCartesianDuals,
                  
  function( cat, new_source, morphism, new_range )
    
    return PreComposeList( cat, [
             IsomorphismFromCartesianDualToExponential( cat, Range( morphism ) ),
             
             ExponentialOnMorphisms( cat,
               morphism,
               IdentityMorphism( cat, TerminalObject( cat ) ) ),
               
             IsomorphismFromExponentialToCartesianDual( cat, Source( morphism ) )
           ] );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianDualOnMorphismsWithGivenCartesianDuals using ExponentialOnMorphisms and IsomorphismFromCartesianDualToExponential" );

##
AddDerivationToCAP( CartesianEvaluationForCartesianDualWithGivenDirectProduct,
                  
  function( cat, direct_product_object, object, unit )
    
    return ExponentialToDirectProductAdjunctionMap( cat, object, unit,
                                                    IsomorphismFromCartesianDualToExponential( cat, object ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianEvaluationForCartesianDualWithGivenDirectProduct using the direct product-exponential adjunction and IsomorphismFromCartesianDualToExponential" );

##
AddDerivationToCAP( CartesianLambdaIntroduction,
                  
  function( cat, morphism )
    local result_morphism, source;
    
    source := Source( morphism );
    
    result_morphism := PreCompose( cat, CartesianLeftUnitor( cat, source ), morphism );
    
    return DirectProductToExponentialAdjunctionMap( cat, TerminalObject( cat ), source, result_morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianLambdaIntroduction using the direct product-exponential adjunction and left unitor" );

##
AddDerivationToCAP( CartesianLambdaElimination,
                  
  function( cat, object_1, object_2, morphism )
    local result_morphism;
    
    result_morphism := ExponentialToDirectProductAdjunctionMap( cat, object_1, object_2, morphism );
    
    return PreCompose( cat, CartesianLeftUnitorInverse( cat, object_1 ), result_morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianLambdaElimination using the direct product-exponential adjunction and left unitor" );

##
AddDerivationToCAP( DirectProductExponentialCompatibilityMorphismWithGivenObjects,
                    
  function( cat, source, list, range )
    local a1, b1, a2, b2, morphism, int_hom_a1_b1, int_hom_a2_b2, id_a2, direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2;
    
    a1 := list[1];
    b1 := list[2];
    a2 := list[3];
    b2 := list[4];
    
    int_hom_a1_b1 := ExponentialOnObjects( cat, a1, b1 );
    
    int_hom_a2_b2 := ExponentialOnObjects( cat, a2, b2 );
    
    id_a2 := IdentityMorphism( cat, a2 );
    
    direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2 := 
      DirectProduct( int_hom_a1_b1, int_hom_a2_b2 );
    
    morphism := PreComposeList( cat, [
                  CartesianAssociatorRightToLeft( cat,
                    direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
                    a1, a2 ),
                  
                  DirectProductOnMorphisms( cat,
                    CartesianAssociatorLeftToRight( cat, int_hom_a1_b1, int_hom_a2_b2, a1 ),
                    id_a2 ),
                  
                  DirectProductOnMorphisms( cat,
                    DirectProductOnMorphisms( cat,
                      IdentityMorphism( cat, int_hom_a1_b1 ),
                      CartesianBraiding( cat, int_hom_a2_b2, a1 ) ),
                    id_a2 ),
                  
                  DirectProductOnMorphisms( cat,
                    CartesianAssociatorRightToLeft( cat, int_hom_a1_b1, a1, int_hom_a2_b2 ),
                    id_a2 ),
                  
                  DirectProductOnMorphisms( cat,
                    DirectProductOnMorphisms( cat,
                      CartesianEvaluationMorphism( cat, a1, b1 ),
                      IdentityMorphism( cat, int_hom_a2_b2 ) ),
                    id_a2 ),
                  
                  CartesianAssociatorLeftToRight( cat, b1, int_hom_a2_b2, a2 ),
                  
                  DirectProductOnMorphisms( cat,
                    IdentityMorphism( cat, b1 ),
                    CartesianEvaluationMorphism( cat, a2, b2 ) )
                ] );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
             DirectProduct( a1, a2 ),
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "DirectProductExponentialCompatibilityMorphismWithGivenObjects using associator, braiding an the evaluation morphism" );

##
AddDerivationToCAP( DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects,
                  
  function( cat, new_source, object_1, object_2, new_range )
    local morphism, unit, direct_product_on_object_1_and_object_2;
    
    unit := TerminalObject( cat );
    
    direct_product_on_object_1_and_object_2 := DirectProduct( object_1, object_2 );
    
    morphism := PreComposeList( cat, [
                  DirectProductOnMorphisms( cat,
                    IsomorphismFromCartesianDualToExponential( cat, object_1 ),
                    IsomorphismFromCartesianDualToExponential( cat, object_2 ) ),
                  
                  DirectProductExponentialCompatibilityMorphism( cat, [ object_1, unit, object_2, unit ] ),
                  
                  ExponentialOnMorphisms( cat,
                    IdentityMorphism( cat, direct_product_on_object_1_and_object_2 ),
                    CartesianLeftUnitor( cat, unit ) ),
                  
                  IsomorphismFromExponentialToCartesianDual( cat, direct_product_on_object_1_and_object_2 )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of direct product and internal hom" );

##
AddDerivationToCAP( IsomorphismFromObjectToExponentialWithGivenExponential,
                  
  function( cat, object, internal_hom )
    local unit;
    
    unit := TerminalObject( cat );
    
    return PreCompose( cat,
             CartesianCoevaluationMorphism( cat, object, unit ),
             ExponentialOnMorphisms( cat,
               IdentityMorphism( cat, unit ),
               CartesianRightUnitor( cat, object ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "IsomorphismFromObjectToExponentialWithGivenExponential using the coevaluation morphism" );

##
AddDerivationToCAP( IsomorphismFromObjectToExponentialWithGivenExponential,
                  
  function( cat, object, internal_hom )
    local unit;
    
    unit := TerminalObject( cat );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             object,
             unit,
             CartesianRightUnitor( cat, object ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "IsomorphismFromObjectToExponentialWithGivenExponential as the adjoint of the right unitor" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromExponentialToObjectWithGivenExponential,
#                     
#   function( cat, object, internal_hom )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToExponential( cat, object ) );
#     
# end : CategoryFilter := IsCartesianClosedCategory,
#       Description := "IsomorphismFromExponentialToObjectWithGivenExponential as the inverse of IsomorphismFromObjectToExponential" );

##
AddDerivationToCAP( IsomorphismFromExponentialToObjectWithGivenExponential,
                  
  function( cat, object, internal_hom )
    local unit;
    
    unit := TerminalObject( cat );
    
    return PreCompose( cat, CartesianRightUnitorInverse( cat, internal_hom ),
                       CartesianEvaluationMorphism( cat, unit, object ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "IsomorphismFromExponentialToObjectWithGivenExponential using the evaluation morphism" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToExponentialWithGivenExponential,
#                     
#   function( cat, object, internal_hom )
#     
#     return InverseForMorphisms( cat, IsomorphismFromExponentialToObject( cat, object ) );
#     
# end : CategoryFilter := IsCartesianClosedCategory,
#       Description := "IsomorphismFromObjectToExponential as the inverse of IsomorphismFromExponentialToObject" );

##
AddDerivationToCAP( MorphismFromDirectProductToExponentialWithGivenObjects,
                    
  function( cat, direct_product_object, object_1, object_2, internal_hom )
    local unit;
    
    unit := TerminalObject( cat );
    
    return PreComposeList( cat, [
             DirectProductOnMorphisms( cat,
               IsomorphismFromCartesianDualToExponential( cat, object_1 ),
               IsomorphismFromObjectToExponential( cat, object_2 ) ),
                
             DirectProductExponentialCompatibilityMorphism( cat,
               [ object_1, unit, unit, object_2 ] ),
                
             ExponentialOnMorphisms( cat,
               CartesianRightUnitor( cat, object_1 ),
               CartesianLeftUnitor( cat, object_2 ) ),
           ] );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "MorphismFromDirectProductToExponentialWithGivenObjects using DirectProductExponentialCompatibilityMorphism" );

##
# AddDerivationToCAP( MorphismFromDirectProductToExponentialWithGivenObjects,
#                     
#   function( )
#   
# end : CategoryFilter := IsCartesianClosedCategory 

##
AddDerivationToCAP( CartesianEvaluationMorphismWithGivenSource,
                  
  function( cat, object_1, object_2, direct_product_object )
    
    return ExponentialToDirectProductAdjunctionMap( cat,
             object_1,
             object_2,
             IdentityMorphism( cat, ExponentialOnObjects( cat, object_1, object_2 ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianEvaluationMorphismWithGivenSource using the direct product-exponential adjunction on the identity" );

##
AddDerivationToCAP( CartesianCoevaluationMorphismWithGivenRange,
                  
  function( cat, object_1, object_2, internal_hom )
    
    return DirectProductToExponentialAdjunctionMap( cat,
             object_1,
             object_2,
             IdentityMorphism( cat, DirectProduct( object_1, object_2 ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianCoevaluationMorphismWithGivenRange using the direct product-exponential adjunction on the identity" );

##
AddDerivationToCAP( CartesianPreComposeMorphismWithGivenObjects,
                  
  function( cat, new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := ExponentialOnObjects( cat, x, y );
    
    hom_y_z := ExponentialOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  CartesianAssociatorLeftToRight( cat, hom_x_y, hom_y_z, x ),
                  
                  DirectProductOnMorphisms( cat,
                    IdentityMorphism( cat, hom_x_y ),
                    CartesianBraiding( cat, hom_y_z, x ) ),
                  
                  CartesianAssociatorRightToLeft( cat, hom_x_y, x, hom_y_z ),
                  
                  DirectProductOnMorphisms( cat,
                    CartesianEvaluationMorphism( cat, x, y ),
                    IdentityMorphism( cat, hom_y_z ) ),
                  
                  CartesianBraiding( cat, y, hom_y_z ),
                  
                  CartesianEvaluationMorphism( cat, y, z )
                ] );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             DirectProduct( hom_x_y, hom_y_z ),
             x,
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianPreComposeMorphismWithGivenObjects using associator, braiding, evaluation, and direct product-exponential adjunction" );

##
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := ExponentialOnObjects( cat, x, y );
    
    hom_y_z := ExponentialOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  CartesianAssociatorLeftToRight( cat, hom_y_z, hom_x_y, x ),
                  
                  DirectProductOnMorphisms( cat,
                    IdentityMorphism( cat, hom_y_z ),
                    CartesianEvaluationMorphism( cat, x, y ) ),
                  
                  CartesianEvaluationMorphism( cat, y, z )
                ] );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             DirectProduct( hom_y_z, hom_x_y ),
             x,
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianPostComposeMorphismWithGivenObjects using associator, evaluation, and direct product-exponential adjunction" );

##
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local braiding;
    
    braiding := CartesianBraiding( cat, ExponentialOnObjects( cat, y, z ), ExponentialOnObjects( cat, x, y ) );
    
    return PreCompose( cat, braiding, CartesianPreComposeMorphism( cat, x, y, z ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianPostComposeMorphismWithGivenObjects using CartesianPreComposeMorphism and braiding" );

##
AddDerivationToCAP( CartesianPreComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local braiding;
    
    braiding := CartesianBraiding( cat, ExponentialOnObjects( cat, x, y ), ExponentialOnObjects( cat, y, z ) );
    
    return PreCompose( cat, braiding, CartesianPostComposeMorphism( cat, x, y, z ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianPreComposeMorphismWithGivenObjects using CartesianPostComposeMorphism and braiding" );

##
AddDerivationToCAP( DirectProductExponentialCompatibilityMorphismWithGivenObjects,
                    
  function( cat, source, list, range )
    local a1, b1, a2, b2, morphism, int_hom_a1_b1, int_hom_a2_b2, id_a2, direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2;
    
    a1 := list[1];
    b1 := list[2];
    a2 := list[3];
    b2 := list[4];
    
    int_hom_a1_b1 := ExponentialOnObjects( cat, a1, b1 );
    
    int_hom_a2_b2 := ExponentialOnObjects( cat, a2, b2 );
    
    id_a2 := IdentityMorphism( cat, a2 );
    
    direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2 := 
      DirectProduct( int_hom_a1_b1, int_hom_a2_b2 );
    
    morphism := PreComposeList( cat, [
                  DirectProductOnMorphisms( cat,
                    DirectProductOnMorphisms( cat,
                      IdentityMorphism( cat, int_hom_a1_b1 ),
                      CartesianBraiding( cat, int_hom_a2_b2, a1 ) ),
                    id_a2 ),
                  
                  DirectProductOnMorphisms( cat,
                    DirectProductOnMorphisms( cat,
                      CartesianEvaluationMorphism( cat, a1, b1 ),
                      IdentityMorphism( cat, int_hom_a2_b2 ) ),
                    id_a2 ),
                  
                  DirectProductOnMorphisms( cat,
                    IdentityMorphism( cat, b1 ),
                    CartesianEvaluationMorphism( cat, a2, b2 ) )
                ] );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
             DirectProduct( a1, a2 ),
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory and IsStrictCartesianCategory,
      Description := "DirectProductExponentialCompatibilityMorphismWithGivenObjects using braiding and the evaluation morphism" );

##
AddDerivationToCAP( DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects,
                  
  function( cat, new_source, object_1, object_2, new_range )
    local morphism, unit, direct_product_on_object_1_and_object_2;
    
    unit := TerminalObject( cat );
    
    direct_product_on_object_1_and_object_2 := DirectProduct( object_1, object_2 );
    
    morphism := PreComposeList( cat, [
                  DirectProductOnMorphisms( cat,
                    IsomorphismFromCartesianDualToExponential( cat, object_1 ),
                    IsomorphismFromCartesianDualToExponential( cat, object_2 ) ),
                  
                  DirectProductExponentialCompatibilityMorphism( cat, [ object_1, unit, object_2, unit ] ),
                  
                  IsomorphismFromExponentialToCartesianDual( cat, direct_product_on_object_1_and_object_2 )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsCartesianClosedCategory and IsStrictCartesianCategory,
      Description := "DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects using compatibility of direct product and internal hom" );

##
AddDerivationToCAP( CartesianPreComposeMorphismWithGivenObjects,
                  
  function( cat, new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := ExponentialOnObjects( cat, x, y );
    
    hom_y_z := ExponentialOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  DirectProductOnMorphisms( cat,
                    IdentityMorphism( cat, hom_x_y ),
                    CartesianBraiding( cat, hom_y_z, x ) ),
                  
                  DirectProductOnMorphisms( cat,
                    CartesianEvaluationMorphism( cat, x, y ),
                    IdentityMorphism( cat, hom_y_z ) ),
                  
                  CartesianBraiding( cat, y, hom_y_z ),
                  
                  CartesianEvaluationMorphism( cat, y, z )
                ] );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             DirectProduct( hom_x_y, hom_y_z ),
             x,
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory and IsStrictCartesianCategory,
      Description := "CartesianPreComposeMorphismWithGivenObjects using, braiding, evaluation, and direct product-exponential adjunction" );

##
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := ExponentialOnObjects( cat, x, y );
    
    hom_y_z := ExponentialOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  DirectProductOnMorphisms( cat,
                    IdentityMorphism( cat, hom_y_z ),
                    CartesianEvaluationMorphism( cat, x, y ) ),
                  
                  CartesianEvaluationMorphism( cat, y, z )
                ] );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             DirectProduct( hom_y_z, hom_x_y ),
             x,
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory and IsStrictCartesianCategory,
      Description := "CartesianPostComposeMorphismWithGivenObjects using evaluation, and direct product-exponential adjunction" );
