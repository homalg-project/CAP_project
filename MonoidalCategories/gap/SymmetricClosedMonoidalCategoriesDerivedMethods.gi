##
AddDerivationToCAP( TensorProductToInternalHomAdjunctionMap,
                    
  function( object_1, object_2, morphism )
    
    return PreCompose( 
             CoevaluationMorphism( object_1, object_2 ), 
             InternalHomOnMorphisms( IdentityMorphism( object_2 ), morphism ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "TensorProductToInternalHomAdjunctionMap using CoevaluationMorphism and InternalHom" );

##
AddDerivationToCAP( InternalHomToTensorProductAdjunctionMap,
                    
  function( object_1, object_2, morphism )
    
    return PreCompose( 
             TensorProductOnMorphisms( morphism, IdentityMorphism( object_1 ) ),
             EvaluationMorphism( object_1, object_2 ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "InternalHomToTensorProductAdjunctionMap using TensorProductOnMorphisms and EvaluationMorphism" );

##
AddDerivationToCAP( UniversalPropertyOfDual,
                    
  function( object_1, object_2, test_morphism )
    
    return PreCompose( 
             TensorProductToInternalHomAdjunctionMap( object_1, object_2, test_morphism ),
             IsomorphismFromInternalHomToDual( object_2 ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "UniversalPropertyOfDual using the tensor hom adjunction" );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                  
  function( object, bidual )
    local morphism;

    morphism := PreCompose( Braiding( object, DualOnObjects( object ) ),
                            EvaluationForDual( object ) );
    
    return UniversalPropertyOfDual( object, DualOnObjects( object ), morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MorphismToBidualWithGivenBidual using the braiding and the universal property of the dual" );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                    
  function( object, bidual )
    local morphism, dual_object, tensor_unit;
    
    dual_object := DualOnObjects( object );
    
    tensor_unit := TensorUnit( CapCategory( object ) );
    
    morphism := PreCompose( [
                  CoevaluationMorphism( object, dual_object ),
                  
                  InternalHomOnMorphisms(
                    IdentityMorphism( dual_object ),
                    Braiding( object, dual_object ) ),
                  
                  InternalHomOnMorphisms(
                    IdentityMorphism( dual_object ),
                    EvaluationMorphism( object, tensor_unit ) )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MorphismToBidualWithGivenBidual using Coevaluation, InternalHom, and Evaluation" );

##
AddDerivationToCAP( DualOnObjects,
                  
  function( object )
    
    return Source( IsomorphismFromDualToInternalHom( object ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "DualOnObjects as the source of IsomorphismFromDualToInternalHom" );

##
AddDerivationToCAP( DualOnObjects,
                  
  function( object )
    
    return Range( IsomorphismFromInternalHomToDual( object ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "DualOnObjects as the range of IsomorphismFromInternalHomToDual" );

##
AddDerivationToCAP( DualOnMorphismsWithGivenDuals,
                  
  function( new_source, morphism, new_range )
    local category;
    
    category := CapCategory( morphism );
    
    return PreCompose( [ 
             IsomorphismFromDualToInternalHom( Range( morphism ) ),
             
             InternalHomOnMorphisms( 
               morphism,
               IdentityMorphism( TensorUnit( category ) ) ),
               
             IsomorphismFromInternalHomToDual( Source( morphism ) ) 
           ] );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "DualOnMorphismsWithGivenDuals using InternalHomOnMorphisms and IsomorphismFromDualToInternalHom" );

##
AddDerivationToCAP( EvaluationForDualWithGivenTensorProduct,
                  
  function( tensor_object, object, unit )
    
    return InternalHomToTensorProductAdjunctionMap( object, unit,
                                                    IsomorphismFromDualToInternalHom( object ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "EvaluationForDualWithGivenTensorProduct using the tensor hom adjunction and IsomorphismFromDualToInternalHom" );

##
AddDerivationToCAP( LambdaIntroduction,
                  
  function( morphism )
    local result_morphism, category, source;
    
    category := CapCategory( morphism );
    
    source := Source( morphism );
    
    result_morphism := PreCompose( LeftUnitor( source ), morphism );
    
    return TensorProductToInternalHomAdjunctionMap( TensorUnit( category ), source, result_morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "LambdaIntroduction using the tensor hom adjunction and left unitor" );

##
AddDerivationToCAP( LambdaElimination,
                  
  function( object_1, object_2, morphism )
    local result_morphism;
    
    result_morphism := InternalHomToTensorProductAdjunctionMap( object_1, object_2, morphism );
    
    return PreCompose( LeftUnitorInverse( object_1 ), result_morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "LambdaElimination using the tensor hom adjunction and left unitor" );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                    
  function( a1, b1, a2, b2, new_source_and_range_list )
    local morphism, int_hom_a1_b1, int_hom_a2_b2, id_a2, tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2;
    
    int_hom_a1_b1 := InternalHomOnObjects( a1, b1 );
    
    int_hom_a2_b2 := InternalHomOnObjects( a2, b2 );
    
    id_a2 := IdentityMorphism( a2 );
    
    tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2 := 
      TensorProductOnObjects( int_hom_a1_b1, int_hom_a2_b2 );
    
    morphism := PreCompose( [
                  AssociatorRightToLeft(
                    tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
                    a1, a2 ),
                  
                  TensorProductOnMorphisms(
                    AssociatorLeftToRight( int_hom_a1_b1, int_hom_a2_b2, a1 ),
                    id_a2 ),
                  
                  TensorProductOnMorphisms(
                    TensorProductOnMorphisms(
                      IdentityMorphism( int_hom_a1_b1 ),
                      Braiding( int_hom_a2_b2, a1 ) ),
                    id_a2 ),
                  
                  TensorProductOnMorphisms(
                    AssociatorRightToLeft( int_hom_a1_b1, a1, int_hom_a2_b2 ),
                    id_a2 ),
                  
                  TensorProductOnMorphisms(
                    TensorProductOnMorphisms(
                      EvaluationMorphism( a1, b1 ),
                      IdentityMorphism( int_hom_a2_b2 ) ),
                    id_a2 ),
                  
                  AssociatorLeftToRight( b1, int_hom_a2_b2, a2 ),
                  
                  TensorProductOnMorphisms(
                    IdentityMorphism( b1 ),
                    EvaluationMorphism( a2, b2 ) )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap(
             tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
             TensorProductOnObjects( a1, a2 ),
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "TensorProductInternalHomCompatibilityMorphismWithGivenObjects using associator, braiding an the evaluation morphism" );

##
AddDerivationToCAP( TensorProductDualityCompatibilityMorphismWithGivenObjects,
                  
  function( new_source, object_1, object_2, new_range )
    local morphism, unit, tensor_product_on_object_1_and_object_2;
    
    unit := TensorUnit( CapCategory( object_1 ) );
    
    tensor_product_on_object_1_and_object_2 := TensorProductOnObjects( object_1, object_2 );
    
    morphism := PreCompose( [
                  TensorProductOnMorphisms(
                    IsomorphismFromDualToInternalHom( object_1 ),
                    IsomorphismFromDualToInternalHom( object_2 ) ),
                  
                  TensorProductInternalHomCompatibilityMorphism( object_1, unit, object_2, unit ),
                  
                  InternalHomOnMorphisms(
                    IdentityMorphism( tensor_product_on_object_1_and_object_2 ),
                    LeftUnitor( unit ) ),
                  
                  IsomorphismFromInternalHomToDual( tensor_product_on_object_1_and_object_2 )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "TensorProductDualityCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of tensor product and internal hom" );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
                  
  function( object, internal_hom )
    local unit;
    
    unit := TensorUnit( CapCategory( object ) );
    
    return PreCompose(
             CoevaluationMorphism( object, unit ),
             InternalHomOnMorphisms(
               IdentityMorphism( unit ),
               RightUnitor( object ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromObjectToInternalHomWithGivenInternalHom using the coevaluation morphism" );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
                  
  function( object, internal_hom )
    local unit;
    
    unit := TensorUnit( CapCategory( object ) );
    
    return TensorProductToInternalHomAdjunctionMap(
             object,
             unit,
             RightUnitor( object ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromObjectToInternalHomWithGivenInternalHom as the adjoint of the right unitor" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromInternalHomToObjectWithGivenInternalHom,
#                     
#   function( object, internal_hom )
#     
#     return Inverse( IsomorphismFromObjectToInternalHom( object ) );
#     
# end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
#       Description := "IsomorphismFromInternalHomToObjectWithGivenInternalHom as the inverse of IsomorphismFromObjectToInternalHom" );

##
AddDerivationToCAP( IsomorphismFromInternalHomToObjectWithGivenInternalHom,
                  
  function( object, internal_hom )
    local unit;
    
    unit := TensorUnit( CapCategory( object ) );
    
    return PreCompose( RightUnitorInverse( internal_hom ),
                       EvaluationMorphism( unit, object ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalHomToObjectWithGivenInternalHom using the evaluation morphism" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
#                     
#   function( object, internal_hom )
#     
#     return Inverse( IsomorphismFromInternalHomToObject( object ) );
#     
# end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
#       Description := "IsomorphismFromObjectToInternalHom as the inverse of IsomorphismFromInternalHomToObject" );

##
AddDerivationToCAP( MorphismFromTensorProductToInternalHomWithGivenObjects,
                    
  function( tensor_object, object_1, object_2, internal_hom )
    local unit;
    
    unit := TensorUnit( CapCategory( object_1 ) );
    
    return PreCompose( [ 
             TensorProductOnMorphisms(
               IsomorphismFromDualToInternalHom( object_1 ),
               IsomorphismFromObjectToInternalHom( object_2 ) ),
                
             TensorProductInternalHomCompatibilityMorphism(
               object_1, unit, unit, object_2 ),
                
             InternalHomOnMorphisms(
               RightUnitor( object_1 ),
               LeftUnitor( object_2 ) ),
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
                  
  function( object_1, object_2, tensor_object )
    
    return InternalHomToTensorProductAdjunctionMap(
             object_1,
             object_2,
             IdentityMorphism( InternalHomOnObjects( object_1, object_2 ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "EvaluationMorphismWithGivenSource using the tensor hom adjunction on the identity" );

##
AddDerivationToCAP( CoevaluationMorphismWithGivenRange,
                  
  function( object_1, object_2, internal_hom )
    
    return TensorProductToInternalHomAdjunctionMap(
             object_1,
             object_2,
             IdentityMorphism( TensorProductOnObjects( object_1, object_2 ) ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "CoevaluationMorphismWithGivenRange using the tensor hom adjunction on the identity" );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                  
  function( new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := InternalHomOnObjects( x, y );
    
    hom_y_z := InternalHomOnObjects( y, z );
    
    morphism := PreCompose( [ 
                  AssociatorLeftToRight( hom_x_y, hom_y_z, x ),
                  
                  TensorProductOnMorphisms(
                    IdentityMorphism( hom_x_y ),
                    Braiding( hom_y_z, x ) ),
                  
                  AssociatorRightToLeft( hom_x_y, x, hom_y_z ),
                  
                  TensorProductOnMorphisms(
                    EvaluationMorphism( x, y ),
                    IdentityMorphism( hom_y_z ) ),
                  
                  Braiding( y, hom_y_z ),
                  
                  EvaluationMorphism( y, z ) 
                ] );
    
    return TensorProductToInternalHomAdjunctionMap(
             TensorProductOnObjects( hom_x_y, hom_y_z ),
             x,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPreComposeMorphismWithGivenObjects using associator, braiding, evaluation, and tensor hom adjunction" );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := InternalHomOnObjects( x, y );
    
    hom_y_z := InternalHomOnObjects( y, z );
    
    morphism := PreCompose( [ 
                  AssociatorLeftToRight( hom_y_z, hom_x_y, x ),
                  
                  TensorProductOnMorphisms(
                    IdentityMorphism( hom_y_z ),
                    EvaluationMorphism( x, y ) ),
                  
                  EvaluationMorphism( y, z )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap(
             TensorProductOnObjects( hom_y_z, hom_x_y ),
             x,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPostComposeMorphismWithGivenObjects using associator, evaluation, and tensor hom adjunction" );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local braiding;
    
    braiding := Braiding( InternalHomOnObjects( y, z ), InternalHomOnObjects( x, y ) );
    
    return PreCompose( braiding, MonoidalPreComposeMorphism( x, y, z ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPostComposeMorphismWithGivenObjects using MonoidalPreComposeMorphism and braiding" );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local braiding;
    
    braiding := Braiding( InternalHomOnObjects( x, y ), InternalHomOnObjects( y, z ) );
    
    return PreCompose( braiding, MonoidalPostComposeMorphism( x, y, z ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPreComposeMorphismWithGivenObjects using MonoidalPostComposeMorphism and braiding" );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                    
  function( a1, b1, a2, b2, new_source_and_range_list )
    local morphism, int_hom_a1_b1, int_hom_a2_b2, id_a2, tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2;
    
    int_hom_a1_b1 := InternalHomOnObjects( a1, b1 );
    
    int_hom_a2_b2 := InternalHomOnObjects( a2, b2 );
    
    id_a2 := IdentityMorphism( a2 );
    
    tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2 := 
      TensorProductOnObjects( int_hom_a1_b1, int_hom_a2_b2 );
    
    morphism := PreCompose( [
                  TensorProductOnMorphisms(
                    TensorProductOnMorphisms(
                      IdentityMorphism( int_hom_a1_b1 ),
                      Braiding( int_hom_a2_b2, a1 ) ),
                    id_a2 ),
                  
                  TensorProductOnMorphisms(
                    TensorProductOnMorphisms(
                      EvaluationMorphism( a1, b1 ),
                      IdentityMorphism( int_hom_a2_b2 ) ),
                    id_a2 ),
                  
                  TensorProductOnMorphisms(
                    IdentityMorphism( b1 ),
                    EvaluationMorphism( a2, b2 ) )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap(
             tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
             TensorProductOnObjects( a1, a2 ),
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "TensorProductInternalHomCompatibilityMorphismWithGivenObjects using braiding and the evaluation morphism" );

##
AddDerivationToCAP( TensorProductDualityCompatibilityMorphismWithGivenObjects,
                  
  function( new_source, object_1, object_2, new_range )
    local morphism, unit, tensor_product_on_object_1_and_object_2;
    
    unit := TensorUnit( CapCategory( object_1 ) );
    
    tensor_product_on_object_1_and_object_2 := TensorProductOnObjects( object_1, object_2 );
    
    morphism := PreCompose( [
                  TensorProductOnMorphisms(
                    IsomorphismFromDualToInternalHom( object_1 ),
                    IsomorphismFromDualToInternalHom( object_2 ) ),
                  
                  TensorProductInternalHomCompatibilityMorphism( object_1, unit, object_2, unit ),
                  
                  IsomorphismFromInternalHomToDual( tensor_product_on_object_1_and_object_2 ) 
                ] );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "TensorProductDualityCompatibilityMorphismWithGivenObjects using compatibility of tensor product and internal hom" );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                  
  function( new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := InternalHomOnObjects( x, y );
    
    hom_y_z := InternalHomOnObjects( y, z );
    
    morphism := PreCompose( [ 
                  TensorProductOnMorphisms(
                    IdentityMorphism( hom_x_y ),
                    Braiding( hom_y_z, x ) ),
                  
                  TensorProductOnMorphisms(
                    EvaluationMorphism( x, y ),
                    IdentityMorphism( hom_y_z ) ),
                  
                  Braiding( y, hom_y_z ),
                  
                  EvaluationMorphism( y, z )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap(
             TensorProductOnObjects( hom_x_y, hom_y_z ),
             x,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "MonoidalPreComposeMorphismWithGivenObjects using, braiding, evaluation, and tensor hom adjunction" );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := InternalHomOnObjects( x, y );
    
    hom_y_z := InternalHomOnObjects( y, z );
    
    morphism := PreCompose( [ 
                  TensorProductOnMorphisms(
                    IdentityMorphism( hom_y_z ),
                    EvaluationMorphism( x, y ) ),
                  
                  EvaluationMorphism( y, z )
                ] );
    
    return TensorProductToInternalHomAdjunctionMap(
             TensorProductOnObjects( hom_y_z, hom_x_y ),
             x,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "MonoidalPostComposeMorphismWithGivenObjects using evaluation, and tensor hom adjunction" );
