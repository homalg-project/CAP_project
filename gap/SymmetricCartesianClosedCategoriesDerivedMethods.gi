#
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( DirectProductToExponentialAdjunctionMap,
                    
  function( object_1, object_2, morphism )
    
    return PreCompose( 
             CartesianCoevaluationMorphism( object_1, object_2 ), 
             ExponentialOnMorphisms( IdentityMorphism( object_2 ), morphism ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "DirectProductToExponentialAdjunctionMap using CartesianCoevaluationMorphism and Exponential" );

##
AddDerivationToCAP( ExponentialToDirectProductAdjunctionMap,
                    
  function( object_1, object_2, morphism )
    
    return PreCompose( 
             DirectProductOnMorphisms( morphism, IdentityMorphism( object_1 ) ),
             CartesianEvaluationMorphism( object_1, object_2 ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "ExponentialToDirectProductAdjunctionMap using DirectProductOnMorphisms and CartesianEvaluationMorphism" );

##
AddDerivationToCAP( UniversalPropertyOfCartesianDual,
                    
  function( object_1, object_2, test_morphism )
    
    return PreCompose( 
             DirectProductToExponentialAdjunctionMap( object_1, object_2, test_morphism ),
             IsomorphismFromExponentialToCartesianDual( object_2 ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "UniversalPropertyOfCartesianDual using the direct product-exponential adjunction" );

##
AddDerivationToCAP( MorphismToCartesianBidualWithGivenCartesianBidual,
                  
  function( object, bidual )
    local morphism;

    morphism := PreCompose( CartesianBraiding( object, CartesianDualOnObjects( object ) ),
                            CartesianEvaluationForCartesianDual( object ) );
    
    return UniversalPropertyOfCartesianDual( object, CartesianDualOnObjects( object ), morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "MorphismToCartesianBidualWithGivenCartesianBidual using the braiding and the universal property of the dual" );

##
AddDerivationToCAP( MorphismToCartesianBidualWithGivenCartesianBidual,
                    
  function( object, bidual )
    local morphism, dual_object, tensor_unit;
    
    dual_object := CartesianDualOnObjects( object );
    
    tensor_unit := TerminalObject( CapCategory( object ) );
    
    morphism := PreCompose( [
                  CartesianCoevaluationMorphism( object, dual_object ),
                  
                  ExponentialOnMorphisms(
                    IdentityMorphism( dual_object ),
                    CartesianBraiding( object, dual_object ) ),
                  
                  ExponentialOnMorphisms(
                    IdentityMorphism( dual_object ),
                    CartesianEvaluationMorphism( object, tensor_unit ) )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "MorphismToCartesianBidualWithGivenCartesianBidual using CartesianCoevaluation, Exponential, and CartesianEvaluation" );

##
AddDerivationToCAP( CartesianDualOnObjects,
                  
  function( object )
    
    return Source( IsomorphismFromCartesianDualToExponential( object ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianDualOnObjects as the source of IsomorphismFromCartesianDualToExponential" );

##
AddDerivationToCAP( CartesianDualOnObjects,
                  
  function( object )
    
    return Range( IsomorphismFromExponentialToCartesianDual( object ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianDualOnObjects as the range of IsomorphismFromExponentialToCartesianDual" );

##
AddDerivationToCAP( CartesianDualOnMorphismsWithGivenCartesianDuals,
                  
  function( new_source, morphism, new_range )
    local category;
    
    category := CapCategory( morphism );
    
    return PreCompose( [ 
             IsomorphismFromCartesianDualToExponential( Range( morphism ) ),
             
             ExponentialOnMorphisms( 
               morphism,
               IdentityMorphism( TerminalObject( category ) ) ),
               
             IsomorphismFromExponentialToCartesianDual( Source( morphism ) ) 
           ] );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianDualOnMorphismsWithGivenCartesianDuals using ExponentialOnMorphisms and IsomorphismFromCartesianDualToExponential" );

##
AddDerivationToCAP( CartesianEvaluationForCartesianDualWithGivenDirectProduct,
                  
  function( direct_product_object, object, unit )
    
    return ExponentialToDirectProductAdjunctionMap( object, unit,
                                                    IsomorphismFromCartesianDualToExponential( object ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianEvaluationForCartesianDualWithGivenDirectProduct using the direct product-exponential adjunction and IsomorphismFromCartesianDualToExponential" );

##
AddDerivationToCAP( CartesianLambdaIntroduction,
                  
  function( morphism )
    local result_morphism, category, source;
    
    category := CapCategory( morphism );
    
    source := Source( morphism );
    
    result_morphism := PreCompose( CartesianLeftUnitor( source ), morphism );
    
    return DirectProductToExponentialAdjunctionMap( TerminalObject( category ), source, result_morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianLambdaIntroduction using the direct product-exponential adjunction and left unitor" );

##
AddDerivationToCAP( CartesianLambdaElimination,
                  
  function( object_1, object_2, morphism )
    local result_morphism;
    
    result_morphism := ExponentialToDirectProductAdjunctionMap( object_1, object_2, morphism );
    
    return PreCompose( CartesianLeftUnitorInverse( object_1 ), result_morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianLambdaElimination using the direct product-exponential adjunction and left unitor" );

##
AddDerivationToCAP( DirectProductExponentialCompatibilityMorphismWithGivenObjects,
                    
  function( a1, b1, a2, b2, new_source_and_range_list )
    local morphism, int_hom_a1_b1, int_hom_a2_b2, id_a2, direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2;
    
    int_hom_a1_b1 := ExponentialOnObjects( a1, b1 );
    
    int_hom_a2_b2 := ExponentialOnObjects( a2, b2 );
    
    id_a2 := IdentityMorphism( a2 );
    
    direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2 := 
      DirectProduct( int_hom_a1_b1, int_hom_a2_b2 );
    
    morphism := PreCompose( [
                  CartesianAssociatorRightToLeft(
                    direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
                    a1, a2 ),
                  
                  DirectProductOnMorphisms(
                    CartesianAssociatorLeftToRight( int_hom_a1_b1, int_hom_a2_b2, a1 ),
                    id_a2 ),
                  
                  DirectProductOnMorphisms(
                    DirectProductOnMorphisms(
                      IdentityMorphism( int_hom_a1_b1 ),
                      CartesianBraiding( int_hom_a2_b2, a1 ) ),
                    id_a2 ),
                  
                  DirectProductOnMorphisms(
                    CartesianAssociatorRightToLeft( int_hom_a1_b1, a1, int_hom_a2_b2 ),
                    id_a2 ),
                  
                  DirectProductOnMorphisms(
                    DirectProductOnMorphisms(
                      CartesianEvaluationMorphism( a1, b1 ),
                      IdentityMorphism( int_hom_a2_b2 ) ),
                    id_a2 ),
                  
                  CartesianAssociatorLeftToRight( b1, int_hom_a2_b2, a2 ),
                  
                  DirectProductOnMorphisms(
                    IdentityMorphism( b1 ),
                    CartesianEvaluationMorphism( a2, b2 ) )
                ] );
    
    return DirectProductToExponentialAdjunctionMap(
             direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
             DirectProduct( a1, a2 ),
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "DirectProductExponentialCompatibilityMorphismWithGivenObjects using associator, braiding an the evaluation morphism" );

##
AddDerivationToCAP( DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects,
                  
  function( new_source, object_1, object_2, new_range )
    local morphism, unit, direct_product_on_object_1_and_object_2;
    
    unit := TerminalObject( CapCategory( object_1 ) );
    
    direct_product_on_object_1_and_object_2 := DirectProduct( object_1, object_2 );
    
    morphism := PreCompose( [
                  DirectProductOnMorphisms(
                    IsomorphismFromCartesianDualToExponential( object_1 ),
                    IsomorphismFromCartesianDualToExponential( object_2 ) ),
                  
                  DirectProductExponentialCompatibilityMorphism( object_1, unit, object_2, unit ),
                  
                  ExponentialOnMorphisms(
                    IdentityMorphism( direct_product_on_object_1_and_object_2 ),
                    CartesianLeftUnitor( unit ) ),
                  
                  IsomorphismFromExponentialToCartesianDual( direct_product_on_object_1_and_object_2 )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of direct product and internal hom" );

##
AddDerivationToCAP( IsomorphismFromObjectToExponentialWithGivenExponential,
                  
  function( object, internal_hom )
    local unit;
    
    unit := TerminalObject( CapCategory( object ) );
    
    return PreCompose(
             CartesianCoevaluationMorphism( object, unit ),
             ExponentialOnMorphisms(
               IdentityMorphism( unit ),
               CartesianRightUnitor( object ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "IsomorphismFromObjectToExponentialWithGivenExponential using the coevaluation morphism" );

##
AddDerivationToCAP( IsomorphismFromObjectToExponentialWithGivenExponential,
                  
  function( object, internal_hom )
    local unit;
    
    unit := TerminalObject( CapCategory( object ) );
    
    return DirectProductToExponentialAdjunctionMap(
             object,
             unit,
             CartesianRightUnitor( object ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "IsomorphismFromObjectToExponentialWithGivenExponential as the adjoint of the right unitor" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromExponentialToObjectWithGivenExponential,
#                     
#   function( object, internal_hom )
#     
#     return Inverse( IsomorphismFromObjectToExponential( object ) );
#     
# end : CategoryFilter := IsCartesianClosedCategory,
#       Description := "IsomorphismFromExponentialToObjectWithGivenExponential as the inverse of IsomorphismFromObjectToExponential" );

##
AddDerivationToCAP( IsomorphismFromExponentialToObjectWithGivenExponential,
                  
  function( object, internal_hom )
    local unit;
    
    unit := TerminalObject( CapCategory( object ) );
    
    return PreCompose( CartesianRightUnitorInverse( internal_hom ),
                       CartesianEvaluationMorphism( unit, object ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "IsomorphismFromExponentialToObjectWithGivenExponential using the evaluation morphism" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToExponentialWithGivenExponential,
#                     
#   function( object, internal_hom )
#     
#     return Inverse( IsomorphismFromExponentialToObject( object ) );
#     
# end : CategoryFilter := IsCartesianClosedCategory,
#       Description := "IsomorphismFromObjectToExponential as the inverse of IsomorphismFromExponentialToObject" );

##
AddDerivationToCAP( MorphismFromDirectProductToExponentialWithGivenObjects,
                    
  function( direct_product_object, object_1, object_2, internal_hom )
    local unit;
    
    unit := TerminalObject( CapCategory( object_1 ) );
    
    return PreCompose( [ 
             DirectProductOnMorphisms(
               IsomorphismFromCartesianDualToExponential( object_1 ),
               IsomorphismFromObjectToExponential( object_2 ) ),
                
             DirectProductExponentialCompatibilityMorphism(
               object_1, unit, unit, object_2 ),
                
             ExponentialOnMorphisms(
               CartesianRightUnitor( object_1 ),
               CartesianLeftUnitor( object_2 ) ),
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
                  
  function( object_1, object_2, direct_product_object )
    
    return ExponentialToDirectProductAdjunctionMap(
             object_1,
             object_2,
             IdentityMorphism( ExponentialOnObjects( object_1, object_2 ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianEvaluationMorphismWithGivenSource using the direct product-exponential adjunction on the identity" );

##
AddDerivationToCAP( CartesianCoevaluationMorphismWithGivenRange,
                  
  function( object_1, object_2, internal_hom )
    
    return DirectProductToExponentialAdjunctionMap(
             object_1,
             object_2,
             IdentityMorphism( DirectProduct( object_1, object_2 ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianCoevaluationMorphismWithGivenRange using the direct product-exponential adjunction on the identity" );

##
AddDerivationToCAP( CartesianPreComposeMorphismWithGivenObjects,
                  
  function( new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := ExponentialOnObjects( x, y );
    
    hom_y_z := ExponentialOnObjects( y, z );
    
    morphism := PreCompose( [ 
                  CartesianAssociatorLeftToRight( hom_x_y, hom_y_z, x ),
                  
                  DirectProductOnMorphisms(
                    IdentityMorphism( hom_x_y ),
                    CartesianBraiding( hom_y_z, x ) ),
                  
                  CartesianAssociatorRightToLeft( hom_x_y, x, hom_y_z ),
                  
                  DirectProductOnMorphisms(
                    CartesianEvaluationMorphism( x, y ),
                    IdentityMorphism( hom_y_z ) ),
                  
                  CartesianBraiding( y, hom_y_z ),
                  
                  CartesianEvaluationMorphism( y, z ) 
                ] );
    
    return DirectProductToExponentialAdjunctionMap(
             DirectProduct( hom_x_y, hom_y_z ),
             x,
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianPreComposeMorphismWithGivenObjects using associator, braiding, evaluation, and direct product-exponential adjunction" );

##
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := ExponentialOnObjects( x, y );
    
    hom_y_z := ExponentialOnObjects( y, z );
    
    morphism := PreCompose( [ 
                  CartesianAssociatorLeftToRight( hom_y_z, hom_x_y, x ),
                  
                  DirectProductOnMorphisms(
                    IdentityMorphism( hom_y_z ),
                    CartesianEvaluationMorphism( x, y ) ),
                  
                  CartesianEvaluationMorphism( y, z )
                ] );
    
    return DirectProductToExponentialAdjunctionMap(
             DirectProduct( hom_y_z, hom_x_y ),
             x,
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianPostComposeMorphismWithGivenObjects using associator, evaluation, and direct product-exponential adjunction" );

##
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local braiding;
    
    braiding := CartesianBraiding( ExponentialOnObjects( y, z ), ExponentialOnObjects( x, y ) );
    
    return PreCompose( braiding, CartesianPreComposeMorphism( x, y, z ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianPostComposeMorphismWithGivenObjects using CartesianPreComposeMorphism and braiding" );

##
AddDerivationToCAP( CartesianPreComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local braiding;
    
    braiding := CartesianBraiding( ExponentialOnObjects( x, y ), ExponentialOnObjects( y, z ) );
    
    return PreCompose( braiding, CartesianPostComposeMorphism( x, y, z ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianPreComposeMorphismWithGivenObjects using CartesianPostComposeMorphism and braiding" );

##
AddDerivationToCAP( DirectProductExponentialCompatibilityMorphismWithGivenObjects,
                    
  function( a1, b1, a2, b2, new_source_and_range_list )
    local morphism, int_hom_a1_b1, int_hom_a2_b2, id_a2, direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2;
    
    int_hom_a1_b1 := ExponentialOnObjects( a1, b1 );
    
    int_hom_a2_b2 := ExponentialOnObjects( a2, b2 );
    
    id_a2 := IdentityMorphism( a2 );
    
    direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2 := 
      DirectProduct( int_hom_a1_b1, int_hom_a2_b2 );
    
    morphism := PreCompose( [
                  DirectProductOnMorphisms(
                    DirectProductOnMorphisms(
                      IdentityMorphism( int_hom_a1_b1 ),
                      CartesianBraiding( int_hom_a2_b2, a1 ) ),
                    id_a2 ),
                  
                  DirectProductOnMorphisms(
                    DirectProductOnMorphisms(
                      CartesianEvaluationMorphism( a1, b1 ),
                      IdentityMorphism( int_hom_a2_b2 ) ),
                    id_a2 ),
                  
                  DirectProductOnMorphisms(
                    IdentityMorphism( b1 ),
                    CartesianEvaluationMorphism( a2, b2 ) )
                ] );
    
    return DirectProductToExponentialAdjunctionMap(
             direct_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
             DirectProduct( a1, a2 ),
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory and IsStrictCartesianCategory,
      Description := "DirectProductExponentialCompatibilityMorphismWithGivenObjects using braiding and the evaluation morphism" );

##
AddDerivationToCAP( DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects,
                  
  function( new_source, object_1, object_2, new_range )
    local morphism, unit, direct_product_on_object_1_and_object_2;
    
    unit := TerminalObject( CapCategory( object_1 ) );
    
    direct_product_on_object_1_and_object_2 := DirectProduct( object_1, object_2 );
    
    morphism := PreCompose( [
                  DirectProductOnMorphisms(
                    IsomorphismFromCartesianDualToExponential( object_1 ),
                    IsomorphismFromCartesianDualToExponential( object_2 ) ),
                  
                  DirectProductExponentialCompatibilityMorphism( object_1, unit, object_2, unit ),
                  
                  IsomorphismFromExponentialToCartesianDual( direct_product_on_object_1_and_object_2 ) 
                ] );
    
    return morphism;
    
end : CategoryFilter := IsCartesianClosedCategory and IsStrictCartesianCategory,
      Description := "DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects using compatibility of direct product and internal hom" );

##
AddDerivationToCAP( CartesianPreComposeMorphismWithGivenObjects,
                  
  function( new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := ExponentialOnObjects( x, y );
    
    hom_y_z := ExponentialOnObjects( y, z );
    
    morphism := PreCompose( [ 
                  DirectProductOnMorphisms(
                    IdentityMorphism( hom_x_y ),
                    CartesianBraiding( hom_y_z, x ) ),
                  
                  DirectProductOnMorphisms(
                    CartesianEvaluationMorphism( x, y ),
                    IdentityMorphism( hom_y_z ) ),
                  
                  CartesianBraiding( y, hom_y_z ),
                  
                  CartesianEvaluationMorphism( y, z )
                ] );
    
    return DirectProductToExponentialAdjunctionMap(
             DirectProduct( hom_x_y, hom_y_z ),
             x,
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory and IsStrictCartesianCategory,
      Description := "CartesianPreComposeMorphismWithGivenObjects using, braiding, evaluation, and direct product-exponential adjunction" );

##
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := ExponentialOnObjects( x, y );
    
    hom_y_z := ExponentialOnObjects( y, z );
    
    morphism := PreCompose( [ 
                  DirectProductOnMorphisms(
                    IdentityMorphism( hom_y_z ),
                    CartesianEvaluationMorphism( x, y ) ),
                  
                  CartesianEvaluationMorphism( y, z )
                ] );
    
    return DirectProductToExponentialAdjunctionMap(
             DirectProduct( hom_y_z, hom_x_y ),
             x,
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory and IsStrictCartesianCategory,
      Description := "CartesianPostComposeMorphismWithGivenObjects using evaluation, and direct product-exponential adjunction" );
