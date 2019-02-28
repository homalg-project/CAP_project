##
AddDerivationToCAP( TensorProductToInternalCoHomAdjunctionMap,

  function( object_1, object_2, morphism )
    
    return PreCompose( 
             InternalCoHomOnMorphisms( morphism, IdentityMorphism( object_1 ) ),
             DualCoEvaluationMorphism( object_1, object_2 ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "TensorProductToInternalCoHomAdjunctionMap using DualCoEvaluationMorphism and InternalCoHom" );

##
AddDerivationToCAP( InternalCoHomToTensorProductAdjunctionMap,

  function( object_1, object_2, morphism )
    
    return PreCompose(
             CoEvaluationMorphism( object_1, object_2 ),
             TensorProductOnMorphisms( IdentityMorphism( object_2 ), morphism ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomToTensorProductAdjunctionMap using TensorProductOnMorphisms and CoEvaluationMorphism" );

##
AddDerivationToCAP( UniversalPropertyOfCoDual,

  function( object_1, object_2, test_morphism )
    
    return PreCompose( 
             IsomorphismFromCoDualToInternalCoHom( object_2 ),
             TensorProductToInternalCoHomAdjunctionMap( object_1, object_2, test_morphism ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "UniversalPropertyOfCoDual using the cohom tensor adjunction" );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,

  function( cobidual, object )
    local morphism;

    morphism := PreCompose( 
                  CoEvaluationForCoDual( object ),
                  Braiding( object, CoDualOnObjects( object ) ) );

    return UniversalPropertyOfCoDual( CoDualOnObjects( object ), object, morphism );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MorphismFromCoBidualWithGivenCoBidual using the braiding and the universal property of the codual" );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,

  function( cobidual, object )
    local morphism, codual_object, tensor_unit;

    codual_object := CoDualOnObjects( object );

    tensor_unit := TensorUnit( CapCategory( object ) );

    morphism := PreCompose( [
                  InternalCoHomOnMorphisms(
                    CoEvaluationMorphism( tensor_unit, object ),
                    IdentityMorphism( codual_object ) ),

                  InternalCoHomOnMorphisms(
                    Braiding( object, codual_object ),
                    IdentityMorphism( codual_object ) ),

                  DualCoEvaluationMorphism( codual_object, object )
                ] );

    return morphism;

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MorphismFromCoBidualWithGivenCoBidual using CoEvaluation, InternalCoHom, and DualCoEvaluation" );

##
AddDerivationToCAP( CoDualOnObjects,

  function( object )

    return Source( IsomorphismFromCoDualToInternalCoHom( object ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoDualOnObjects as the source of IsomorphismFromCoDualToInternalCoHom" );

##
AddDerivationToCAP( CoDualOnObjects,

  function( object )

    return Range( IsomorphismFromInternalCoHomToCoDual( object ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoDualOnObjects as the range of IsomorphismFromInternalCoHomToCoDual" );

##
AddDerivationToCAP( CoDualOnMorphismsWithGivenCoDuals,

  function( new_source, morphism, new_range )
    local category, result_morphism;

    category := CapCategory( morphism );

    result_morphism := InternalCoHomOnMorphisms( IdentityMorphism( TensorUnit( category ) ), morphism );

    result_morphism := PreCompose( [
                         IsomorphismFromCoDualToInternalCoHom( Range( morphism ) ),
                         
                         InternalCoHomOnMorphisms( 
                           IdentityMorphism( TensorUnit( category ) ),
                           morphism ),
                           
                         IsomorphismFromInternalCoHomToCoDual( Source( morphism ) ) 
                       ] );

    return result_morphism;

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoDualOnMorphismsWithGivenCoDuals using InternalCoHomOnMorphisms and IsomorphismFromCoDualToInternalCoHom" );

##
AddDerivationToCAP( CoEvaluationForCoDualWithGivenTensorProduct,

  function( unit, object, tensor_object )

    return InternalCoHomToTensorProductAdjunctionMap( unit, object,
                                                      IsomorphismFromInternalCoHomToCoDual( object ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoEvaluationForCoDualWithGivenTensorProduct using the cohom tensor adjunction and IsomorphismFromInternalCoHomToCoDual" );

##
AddDerivationToCAP( CoLambdaIntroduction,

  function( morphism )
    local result_morphism, category, range;

    category := CapCategory( morphism );

    range := Range( morphism );

    result_morphism := PreCompose( morphism, RightUnitorInverse( range ) );

    return TensorProductToInternalCoHomAdjunctionMap( range, TensorUnit( category ), result_morphism );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoLambdaIntroduction using the cohom tensor adjunction and right unitor" );

##
AddDerivationToCAP( CoLambdaElimination,

  function( object_1, object_2, morphism )
    local result_morphism;

    result_morphism := InternalCoHomToTensorProductAdjunctionMap( object_1, object_2, morphism );

    return PreCompose( result_morphism, RightUnitor( object_2 ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoLambdaElimination using the cohom tensor adjunction and right unitor" );

##
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,

  function( a1, a2, b1, b2, new_source_and_range_list )
    local morphism, tensor_product_b1_b2, int_cohom_a1_b1, int_cohom_a2_b2, id_int_cohom_a1_b1, id_int_cohom_a2_b2;

    tensor_product_b1_b2 := TensorProductOnObjects( b1, b2 );

    int_cohom_a1_b1 := InternalCoHomOnObjects( a1, b1 );

    int_cohom_a2_b2 := InternalCoHomOnObjects( a2, b2 );

    id_int_cohom_a1_b1 := IdentityMorphism( int_cohom_a1_b1 );

    id_int_cohom_a2_b2 := IdentityMorphism( int_cohom_a2_b2 );

    morphism := PreCompose( [
                  TensorProductOnMorphisms( IdentityMorphism( a1 ),
                                            CoEvaluationMorphism( a2, b2 ) ),

                  AssociatorRightToLeft( a1, b2,  int_cohom_a2_b2),

                  TensorProductOnMorphisms(
                    TensorProductOnMorphisms(
                      CoEvaluationMorphism( a1, b1 ),
                      IdentityMorphism( b2 ) ),
                     id_int_cohom_a2_b2),

                  TensorProductOnMorphisms(
                    AssociatorLeftToRight( b1, int_cohom_a1_b1, b2 ),
                    id_int_cohom_a2_b2 ),

                  TensorProductOnMorphisms(
                    TensorProductOnMorphisms(
                      IdentityMorphism( b1 ),
                      Braiding( b2, int_cohom_a1_b1 ) ),
                    id_int_cohom_a2_b2 ),

                  TensorProductOnMorphisms(
                    AssociatorRightToLeft( b1, b2, int_cohom_a1_b1 ),
                    id_int_cohom_a2_b2 ),

                  AssociatorLeftToRight(
                    tensor_product_b1_b2,
                    int_cohom_a1_b1,
                    int_cohom_a2_b2 )
                ] );

    return TensorProductToInternalCoHomAdjunctionMap(
             tensor_product_b1_b2,
             TensorProductOnObjects( int_cohom_a1_b1, int_cohom_a2_b2 ),
             morphism );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using associator, braiding and the CoEvaluation morphism" );

##
AddDerivationToCAP( CoDualityTensorProductCompatibilityMorphismWithGivenObjects,

  function( new_source, object_1, object_2, new_range )
    local morphism, unit, tensor_product_on_object_1_and_object_2;

    unit := TensorUnit( CapCategory( object_1 ) );

    tensor_product_on_object_1_and_object_2 := TensorProductOnObjects( object_1, object_2 );

    morphism := PreCompose( [
                  IsomorphismFromCoDualToInternalCoHom( tensor_product_on_object_1_and_object_2 ),

                  InternalCoHomOnMorphisms(
                    LeftUnitorInverse( unit ),
                    IdentityMorphism( tensor_product_on_object_1_and_object_2 ) ),

                  InternalCoHomTensorProductCompatibilityMorphism( unit, unit, object_1, object_2 ),

                  TensorProductOnMorphisms(
                    IsomorphismFromInternalCoHomToCoDual( object_1 ),
                    IsomorphismFromInternalCoHomToCoDual( object_2 ) )
                ] );

    return morphism;

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoDualityTensorProductCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of internal cohom and tensor product" );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom,
                  
  function( object, internal_cohom )
    local unit;
    
    unit := TensorUnit( CapCategory( object ) );
    
    return PreCompose(
             InternalCoHomOnMorphisms(
               LeftUnitorInverse( object ),
               IdentityMorphism( unit ) ),
             DualCoEvaluationMorphism( unit, object ));
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom using the dualcoevaluation morphism" );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom,
                  
  function( object, internal_cohom )
    local unit;
    
    unit := TensorUnit( CapCategory( object ) );
    
    return TensorProductToInternalCoHomAdjunctionMap(
             unit,
             object,
             LeftUnitorInverse( object ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom as the adjoint of the left inverse unitor" );

## TODO: modify for the coclosed case and enable
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
AddDerivationToCAP( IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom,
                  
  function( object, internal_cohom )
    local unit;
    
    unit := TensorUnit( CapCategory( object ) );
    
    return PreCompose( CoEvaluationMorphism( object, unit ),
                       LeftUnitor( internal_cohom ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom using the CoEvaluation morphism" );

## TODO: IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom as adjoint of right unitor.

## TODO: modify for the coclosed case and enable
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
AddDerivationToCAP( MorphismFromInternalCoHomToTensorProductWithGivenObjects,
                    
  function( internal_cohom, object_1, object_2, tensor_object )
    local unit;
    
    unit := TensorUnit( CapCategory( object_1 ) );
    
    return PreCompose( [ 
             InternalCoHomOnMorphisms( 
               RightUnitorInverse( object_1 ),
               LeftUnitorInverse( object_2 ) ),
              
             InternalCoHomTensorProductCompatibilityMorphism(
               object_1, unit, unit, object_2 ),
              
             TensorProductOnMorphisms(
               IsomorphismFromInternalCoHomToObject( object_1 ),
               IsomorphismFromInternalCoHomToCoDual( object_2 ) )
           ] );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MorphismFromInternalCoHomToTensorProductWithGivenObjects using InternalCoHomTensorProductCompatibilityMorphism" );

##
AddDerivationToCAP( CoEvaluationMorphismWithGivenRange,
                  
  function( object_1, object_2, tensor_object )
    
    return InternalCoHomToTensorProductAdjunctionMap(
             object_1,
             object_2,
             IdentityMorphism( InternalCoHomOnObjects( object_1, object_2 ) )
           );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoEvaluationMorphismWithGivenRange using the cohom tensor adjunction on the identity" );

AddDerivationToCAP( DualCoEvaluationMorphismWithGivenSource,
                  
  function( object_1, object_2, internal_cohom )
    
    return TensorProductToInternalCoHomAdjunctionMap(
             object_1,
             object_2,
             IdentityMorphism( TensorProductOnObjects( object_1, object_2 ) )
           );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "DualCoEvaluationMorphismWithGivenSource using the cohom tensor adjunction on the identity" );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                  
  function( new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := InternalCoHomOnObjects( x, y );
    
    cohom_y_z := InternalCoHomOnObjects( y, z );
    
    morphism := PreCompose( [
                  CoEvaluationMorphism( x, y ),
                  
                  Braiding( y, cohom_x_y ),
                  
                  TensorProductOnMorphisms(
                    IdentityMorphism( cohom_x_y ),
                    CoEvaluationMorphism( y, z ) ),
                  
                  AssociatorRightToLeft( cohom_x_y, z, cohom_y_z ),
                  
                  TensorProductOnMorphisms(
                    Braiding( cohom_x_y, z ),
                    IdentityMorphism( cohom_y_z ) ),
                  
                  AssociatorLeftToRight( z, cohom_x_y, x, cohom_y_z ),
                ] );
    
    return TensorProductToInternalCoHomAdjunctionMap(
             z,
             TensorProductOnObjects( cohom_x_y, cohom_y_z ),
             morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MonoidalPreCoComposeMorphismWithGivenObjects using associator, braiding, CoEvaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := InternalCoHomOnObjects( x, y );
    
    cohom_y_z := InternalCoHomOnObjects( y, z );
    
    morphism := PreCompose( [ 
                  CoEvaluationMorphism( x, y ),
                  
                  TensorProductOnMorphisms(
                    CoEvaluationMorphism( y, z ),
                    IdentityMorphism( cohom_x_y )
                  ),
                  
                  AssociatorLeftToRight( z, cohom_y_z, cohom_x_y )
                ] );
    
    return TensorProductToInternalCoHomAdjunctionMap(
             z,
             TensorProductOnObjects( cohom_y_z, cohom_x_y ),
             morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MonoidalPostCoComposeMorphismWithGivenObjects using associator, CoEvaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local braiding;
    
    braiding := Braiding( InternalCoHomOnObjects( x, y ), InternalCoHomOnObjects( y, z ) );
    
    return PreCompose( MonoidalPreCoComposeMorphism( x, y, z ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MonoidalPostCoComposeMorphismWithGivenObjects using MonoidalPreCoComposeMorphism and braiding" );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local braiding;
    
    braiding := Braiding( InternalCoHomOnObjects( y, z ), InternalCoHomOnObjects( x, y ) );
    
    return PreCompose( MonoidalPostCoComposeMorphism( x, y, z ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MonoidalPreCoComposeMorphismWithGivenObjects using MonoidalPostCoComposeMorphism and braiding" );

##
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                    
  function( a1, a2, b1, b2, new_source_and_range_list )
    local morphism, int_cohom_a1_b1, int_cohom_a2_b2, id_int_cohom_a2_b2, tensor_product_b1_b2;
    
    int_cohom_a1_b1 := InternalCoHomOnObjects( a1, b1 );
    
    int_cohom_a2_b2 := InternalCoHomOnObjects( a2, b2 );
    
    id_int_cohom_a2_b2 := IdentityMorphism( int_cohom_a2_b2 );
    
    tensor_product_b1_b2 := TensorProductOnObjects( b1, b2 );
    
    morphism := PreCompose( [
                  TensorProductOnMorphisms(
                    IdentityMorphism( a1 ),
                    CoEvaluationMorphism( a2, b2 ) ),
                  
                  TensorProductOnMorphisms(
                    TensorProductOnMorphisms(
                      CoEvaluationMorphism( a1, b1 ),
                      IdentityMorphism( b2 ) ),
                    id_int_cohom_a2_b2 ),
                  
                  TensorProductOnMorphisms(
                    TensorProductOnMorphisms(
                      IdentityMorphism( b1 ),
                      Braiding( int_cohom_a1_b1, b2 ) ),
                    id_int_cohom_a2_b2 )
                ] );
    
    return TensorProductToInternalCoHomAdjunctionMap(
             tensor_product_b1_b2,
             TensorProductOnObjects( int_cohom_a1_b1, int_cohom_a2_b2 ),
             morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using braiding and the CoEvaluation morphism" );
