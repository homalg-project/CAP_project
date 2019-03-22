##
AddDerivationToCAP( CoproductToCoexponentialAdjunctionMap,

  function( object_1, object_2, morphism )
    local coclosed_coevaluation, internal_cohom_on_morphisms;
    
    internal_cohom_on_morphisms := CoexponentialOnMorphisms( morphism, IdentityMorphism( object_1 ) );
    
    coclosed_coevaluation := CocartesianCoevaluationMorphism( object_1, object_2 );
    
    return PreCompose( internal_cohom_on_morphisms, coclosed_coevaluation );
    
    return PreCompose( 
             CoexponentialOnMorphisms( morphism, IdentityMorphism( object_1 ) ),
             CocartesianCoevaluationMorphism( object_1, object_2 ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CoproductToCoexponentialAdjunctionMap using CocartesianCoevaluationMorphism and Coexponential" );

##
AddDerivationToCAP( CoexponentialToCoproductAdjunctionMap,

  function( object_1, object_2, morphism )
    
    return PreCompose(
             CocartesianEvaluationMorphism( object_1, object_2 ),
             CoproductOnMorphisms( IdentityMorphism( object_2 ), morphism ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CoexponentialToCoproductAdjunctionMap using CoproductOnMorphisms and CocartesianEvaluationMorphism" );

##
AddDerivationToCAP( UniversalPropertyOfCocartesianDual,

  function( object_1, object_2, test_morphism )
    
    return PreCompose( 
             IsomorphismFromCocartesianDualToCoexponential( object_2 ),
             CoproductToCoexponentialAdjunctionMap( object_1, object_2, test_morphism ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "UniversalPropertyOfCocartesianDual using the cohom tensor adjunction" );

##
AddDerivationToCAP( MorphismFromCocartesianBidualWithGivenCocartesianBidual,

  function( cobidual, object )
    local morphism;

    morphism := PreCompose( 
                  CocartesianEvaluationForCocartesianDual( object ),
                  CocartesianBraiding( object, CocartesianDualOnObjects( object ) ) );
                  
    return UniversalPropertyOfCocartesianDual( CocartesianDualOnObjects( object ), object, morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "MorphismFromCocartesianBidualWithGivenCocartesianBidual using the braiding and the universal property of the codual" );

##
AddDerivationToCAP( MorphismFromCocartesianBidualWithGivenCocartesianBidual,

  function( cobidual, object )
    local morphism, codual_object, tensor_unit;
    
    codual_object := CocartesianDualOnObjects( object );
    
    tensor_unit := InitialObject( CapCategory( object ) );
    
    morphism := PreCompose( [
                  CoexponentialOnMorphisms(
                    CocartesianEvaluationMorphism( tensor_unit, object ),
                    IdentityMorphism( codual_object ) ),
                  
                  CoexponentialOnMorphisms(
                    CocartesianBraiding( object, codual_object ),
                    IdentityMorphism( codual_object ) ),
                  
                  CocartesianCoevaluationMorphism( codual_object, object )
                ] );
    
    return morphism;

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "MorphismFromCocartesianBidualWithGivenCocartesianBidual using CocartesianEvaluation, Coexponential, and CocartesianCoevaluation" );

##
AddDerivationToCAP( CocartesianDualOnObjects,

  function( object )
    
    return Source( IsomorphismFromCocartesianDualToCoexponential( object ) );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianDualOnObjects as the source of IsomorphismFromCocartesianDualToCoexponential" );

##
AddDerivationToCAP( CocartesianDualOnObjects,

  function( object )
    
    return Range( IsomorphismFromCoexponentialToCocartesianDual( object ) );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianDualOnObjects as the range of IsomorphismFromCoexponentialToCocartesianDual" );

##
AddDerivationToCAP( CocartesianDualOnMorphismsWithGivenCocartesianDuals,

  function( new_source, morphism, new_range )
    local category, result_morphism;
    
    category := CapCategory( morphism );
    
    result_morphism := CoexponentialOnMorphisms( IdentityMorphism( InitialObject( category ) ), morphism );
    
    result_morphism := PreCompose( [
                         IsomorphismFromCocartesianDualToCoexponential( Range( morphism ) ),
                         
                         CoexponentialOnMorphisms( 
                           IdentityMorphism( InitialObject( category ) ),
                           morphism ),
                           
                         IsomorphismFromCoexponentialToCocartesianDual( Source( morphism ) ) 
                       ] );
                       
    return result_morphism;
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianDualOnMorphismsWithGivenCocartesianDuals using CoexponentialOnMorphisms and IsomorphismFromCocartesianDualToCoexponential" );

##
AddDerivationToCAP( CocartesianEvaluationForCocartesianDualWithGivenCoproduct,

  function( unit, object, coproduct_object )

    return CoexponentialToCoproductAdjunctionMap( 
            unit, 
            object,
            IsomorphismFromCoexponentialToCocartesianDual( object ) );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianEvaluationForCocartesianDualWithGivenCoproduct using the cohom tensor adjunction and IsomorphismFromCoexponentialToCocartesianDual" );

##
AddDerivationToCAP( CocartesianLambdaIntroduction,

  function( morphism )
    local result_morphism, category, range;

    category := CapCategory( morphism );

    range := Range( morphism );

    result_morphism := PreCompose( morphism, CocartesianRightUnitorInverse( range ) );

    return CoproductToCoexponentialAdjunctionMap( 
             range, 
             InitialObject( category ), 
             result_morphism );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianLambdaIntroduction using the cohom tensor adjunction and right unitor" );

##
AddDerivationToCAP( CocartesianLambdaElimination,

  function( object_1, object_2, morphism )
    local result_morphism;
    
    result_morphism := CoexponentialToCoproductAdjunctionMap( object_1, object_2, morphism );
    
    return PreCompose( result_morphism, CocartesianRightUnitor( object_2 ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianLambdaElimination using the cohom tensor adjunction and right unitor" );

##
AddDerivationToCAP( CoexponentialCoproductCompatibilityMorphismWithGivenObjects,

  function( a1, a2, b1, b2, new_source_and_range_list )
    local morphism, coproduct_b1_b2, int_cohom_a1_b1, int_cohom_a2_b2, id_int_cohom_a1_b1, id_int_cohom_a2_b2;
    
    coproduct_b1_b2 := Coproduct( b1, b2 );
    
    int_cohom_a1_b1 := CoexponentialOnObjects( a1, b1 );
    
    int_cohom_a2_b2 := CoexponentialOnObjects( a2, b2 );
    
    id_int_cohom_a1_b1 := IdentityMorphism( int_cohom_a1_b1 );
    
    id_int_cohom_a2_b2 := IdentityMorphism( int_cohom_a2_b2 );
    
    morphism := PreCompose( [
                  CoproductOnMorphisms( 
                    IdentityMorphism( a1 ),
                    CocartesianEvaluationMorphism( a2, b2 ) ),
                  
                  CocartesianAssociatorRightToLeft( a1, b2,  int_cohom_a2_b2),
                  
                  CoproductOnMorphisms(
                    CoproductOnMorphisms(
                      CocartesianEvaluationMorphism( a1, b1 ),
                      IdentityMorphism( b2 ) ),
                     id_int_cohom_a2_b2),
                  
                  CoproductOnMorphisms(
                    CocartesianAssociatorLeftToRight( b1, int_cohom_a1_b1, b2 ),
                    id_int_cohom_a2_b2 ),
                  
                  CoproductOnMorphisms(
                    CoproductOnMorphisms(
                      IdentityMorphism( b1 ),
                      CocartesianBraiding( b2, int_cohom_a1_b1 ) ),
                    id_int_cohom_a2_b2 ),
                  
                  CoproductOnMorphisms(
                    CocartesianAssociatorRightToLeft( b1, b2, int_cohom_a1_b1 ),
                    id_int_cohom_a2_b2 ),
                  
                  CocartesianAssociatorLeftToRight(
                    coproduct_b1_b2,
                    int_cohom_a1_b1,
                    int_cohom_a2_b2 )
                ] );

    return CoproductToCoexponentialAdjunctionMap(
             coproduct_b1_b2,
             Coproduct( int_cohom_a1_b1, int_cohom_a2_b2 ),
             morphism );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CoexponentialCoproductCompatibilityMorphismWithGivenObjects using associator, braiding and the coclosed evaluation morphism" );

##
AddDerivationToCAP( CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects,

  function( new_source, object_1, object_2, new_range )
    local morphism, unit, coproduct_on_object_1_and_object_2;
    
    unit := InitialObject( CapCategory( object_1 ) );
    
    coproduct_on_object_1_and_object_2 := Coproduct( object_1, object_2 );
    
    morphism := PreCompose( [
                  IsomorphismFromCocartesianDualToCoexponential( coproduct_on_object_1_and_object_2 ),
                  
                  CoexponentialOnMorphisms(
                    CocartesianLeftUnitorInverse( unit ),
                    IdentityMorphism( coproduct_on_object_1_and_object_2 ) ),
                  
                  CoexponentialCoproductCompatibilityMorphism( unit, unit, object_1, object_2 ),
                  
                  CoproductOnMorphisms(
                    IsomorphismFromCoexponentialToCocartesianDual( object_1 ),
                    IsomorphismFromCoexponentialToCocartesianDual( object_2 ) )
                ] );

    return morphism;

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of internal cohom and coproduct" );

##
AddDerivationToCAP( IsomorphismFromCoexponentialToObjectWithGivenCoexponential,
                  
  function( object, internal_cohom )
    local unit;
    
    unit := InitialObject( CapCategory( object ) );
    
    return PreCompose(
             CoexponentialOnMorphisms(
               CocartesianLeftUnitorInverse( object ),
               IdentityMorphism( unit ) ),
               
             CocartesianCoevaluationMorphism( unit, object ));
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "IsomorphismFromCoexponentialToObjectWithGivenCoexponential using the coclosed coevaluation morphism" );

##
AddDerivationToCAP( IsomorphismFromCoexponentialToObjectWithGivenCoexponential,
                  
  function( object, internal_cohom )
    local unit;
    
    unit := InitialObject( CapCategory( object ) );
    
    return CoproductToCoexponentialAdjunctionMap(
             unit,
             object,
             CocartesianLeftUnitorInverse( object ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "IsomorphismFromCoexponentialToObjectWithGivenCoexponential as the adjoint of the left inverse unitor" );

## TODO: modify for the coclosed case and enable
# ##
# AddDerivationToCAP( IsomorphismFromInternalHomToObjectWithGivenInternalHom,
#                     
#   function( object, internal_hom )
#     
#     return Inverse( IsomorphismFromObjectToInternalHom( object ) );
#     
# end : CategoryFilter := IsCocartesianCoclosedCategory,
#       Description := "IsomorphismFromInternalHomToObjectWithGivenInternalHom as the inverse of IsomorphismFromObjectToInternalHom" );

##
AddDerivationToCAP( IsomorphismFromObjectToCoexponentialWithGivenCoexponential,
                  
  function( object, internal_cohom )
    local unit;
    
    unit := InitialObject( CapCategory( object ) );
    
    return PreCompose( CocartesianEvaluationMorphism( object, unit ),
                       CocartesianLeftUnitor( internal_cohom ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "IsomorphismFromObjectToCoexponentialWithGivenCoexponential using the coclosed evaluation morphism" );

## TODO: modify for the coclosed case and enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
#                     
#   function( object, internal_hom )
#     
#     return Inverse( IsomorphismFromInternalHomToObject( object ) );
#     
# end : CategoryFilter := IsSymmetricClosedCocartesianCategory,
#       Description := "IsomorphismFromObjectToInternalHom as the inverse of IsomorphismFromInternalHomToObject" );

##
AddDerivationToCAP( MorphismFromCoexponentialToCoproductWithGivenObjects,
                    
  function( internal_cohom, object_1, object_2, coproduct_object )
    local unit;
    
    unit := InitialObject( CapCategory( object_1 ) );
    
    return PreCompose( [ 
             CoexponentialOnMorphisms( 
               CocartesianRightUnitorInverse( object_1 ),
               CocartesianLeftUnitorInverse( object_2 ) ),
              
             CoexponentialCoproductCompatibilityMorphism(
               object_1, unit, unit, object_2 ),
              
             CoproductOnMorphisms(
               IsomorphismFromCoexponentialToObject( object_1 ),
               IsomorphismFromCoexponentialToCocartesianDual( object_2 ) )
           ] );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "MorphismFromCoexponentialToCoproductWithGivenObjects using CoexponentialCoproductCompatibilityMorphism" );

##
AddDerivationToCAP( CocartesianEvaluationMorphismWithGivenRange,
                  
  function( object_1, object_2, coproduct_object )
    
    return CoexponentialToCoproductAdjunctionMap(
             object_1,
             object_2,
             IdentityMorphism( CoexponentialOnObjects( object_1, object_2 ) )
           );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianEvaluationMorphismWithGivenRange using the cohom tensor adjunction on the identity" );

AddDerivationToCAP( CocartesianCoevaluationMorphismWithGivenSource,
                  
  function( object_1, object_2, internal_cohom )
    
    return CoproductToCoexponentialAdjunctionMap(
             object_1,
             object_2,
             IdentityMorphism( Coproduct( object_1, object_2 ) )
           );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianCoevaluationMorphismWithGivenSource using the cohom tensor adjunction on the identity" );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                  
  function( new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := CoexponentialOnObjects( x, y );
    
    cohom_y_z := CoexponentialOnObjects( y, z );
    
    morphism := PreCompose( [
                  CocartesianEvaluationMorphism( x, y ),
                  
                  CocartesianBraiding( y, cohom_x_y ),
                  
                  CoproductOnMorphisms(
                    IdentityMorphism( cohom_x_y ),
                    CocartesianEvaluationMorphism( y, z ) ),
                  
                  CocartesianAssociatorRightToLeft( cohom_x_y, z, cohom_y_z ),
                  
                  CoproductOnMorphisms(
                    CocartesianBraiding( cohom_x_y, z ),
                    IdentityMorphism( cohom_y_z ) ),
                  
                  CocartesianAssociatorLeftToRight( z, cohom_x_y, x, cohom_y_z ),
                ] );
    
    return CoproductToCoexponentialAdjunctionMap(
             z,
             Coproduct( cohom_x_y, cohom_y_z ),
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianPreCoComposeMorphismWithGivenObjects using associator, braiding, coclosed evaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( CocartesianPostCoComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := CoexponentialOnObjects( x, y );
    
    cohom_y_z := CoexponentialOnObjects( y, z );
    
    morphism := PreCompose( [ 
                  CocartesianEvaluationMorphism( x, y ),
                  
                  CoproductOnMorphisms(
                    CocartesianEvaluationMorphism( y, z ),
                    IdentityMorphism( cohom_x_y )
                  ),
                  
                  CocartesianAssociatorLeftToRight( z, cohom_y_z, cohom_x_y )
                ] );
    
    return CoproductToCoexponentialAdjunctionMap(
             z,
             Coproduct( cohom_y_z, cohom_x_y ),
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianPostCoComposeMorphismWithGivenObjects using associator, coclosed evaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( CocartesianPostCoComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local braiding;
    
    braiding := CocartesianBraiding( CoexponentialOnObjects( x, y ), CoexponentialOnObjects( y, z ) );
    
    return PreCompose( CocartesianPreCoComposeMorphism( x, y, z ), braiding );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianPostCoComposeMorphismWithGivenObjects using CocartesianPreCoComposeMorphism and braiding" );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local braiding;
    
    braiding := CocartesianBraiding( CoexponentialOnObjects( y, z ), CoexponentialOnObjects( x, y ) );
    
    return PreCompose( CocartesianPostCoComposeMorphism( x, y, z ), braiding );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianPreCoComposeMorphismWithGivenObjects using CocartesianPostCoComposeMorphism and braiding" );

##
AddDerivationToCAP( CoexponentialCoproductCompatibilityMorphismWithGivenObjects,
                    
  function( a1, a2, b1, b2, new_source_and_range_list )
    local morphism, int_cohom_a1_b1, int_cohom_a2_b2, id_int_cohom_a2_b2, coproduct_b1_b2;
    
    int_cohom_a1_b1 := CoexponentialOnObjects( a1, b1 );
    
    int_cohom_a2_b2 := CoexponentialOnObjects( a2, b2 );
    
    id_int_cohom_a2_b2 := IdentityMorphism( int_cohom_a2_b2 );
    
    coproduct_b1_b2 := Coproduct( b1, b2 );
    
    morphism := PreCompose( [
                  CoproductOnMorphisms(
                    IdentityMorphism( a1 ),
                    CocartesianEvaluationMorphism( a2, b2 ) ),
                  
                  CoproductOnMorphisms(
                    CoproductOnMorphisms(
                      CocartesianEvaluationMorphism( a1, b1 ),
                      IdentityMorphism( b2 ) ),
                    id_int_cohom_a2_b2 ),
                  
                  CoproductOnMorphisms(
                    CoproductOnMorphisms(
                      IdentityMorphism( b1 ),
                      CocartesianBraiding( int_cohom_a1_b1, b2 ) ),
                    id_int_cohom_a2_b2 )
                ] );
    
    return CoproductToCoexponentialAdjunctionMap(
             coproduct_b1_b2,
             Coproduct( int_cohom_a1_b1, int_cohom_a2_b2 ),
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory and IsStrictCocartesianCategory,
      Description := "CoexponentialCoproductCompatibilityMorphismWithGivenObjects using braiding and the coclosed evaluation morphism" );

##
AddDerivationToCAP( CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects,
                  
  function( new_source, object_1, object_2, new_range )
    local morphism, unit, coproduct_on_object_1_and_object_2;
    
    unit := InitialObject( CapCategory( object_1 ) );
    
    coproduct_on_object_1_and_object_2 := Coproduct( object_1, object_2 );
    
    morphism := PreCompose( [
                  IsomorphismFromCocartesianDualToCoexponential( coproduct_on_object_1_and_object_2 ),
                  
                  CoexponentialCoproductCompatibilityMorphism( unit, unit, object_1, object_2 ),
                  
                  CoproductOnMorphisms(
                    IsomorphismFromCoexponentialToCocartesianDual( object_1 ),
                    IsomorphismFromCoexponentialToCocartesianDual( object_2 ) )
                ] );
              
    return morphism;
    
end : CategoryFilter := IsCocartesianCoclosedCategory and IsStrictCocartesianCategory,
      Description := "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects using compatibility of internal cohom and coproduct" );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                  
  function( new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := CoexponentialOnObjects( x, y );
    
    cohom_y_z := CoexponentialOnObjects( y, z );
    
    morphism := PreCompose( [ 
                  CocartesianEvaluationMorphism( x, y ),
                  
                  CocartesianBraiding( y, cohom_x_y),
                  
                  CoproductOnMorphisms(
                    IdentityMorphism( cohom_x_y ),
                    CocartesianEvaluationMorphism( y, z ) ),
                  
                  CoproductOnMorphisms(
                    CocartesianBraiding( cohom_x_y, z ),
                    IdentityMorphism( cohom_y_z ) )
                ] );
    
    return CoproductToCoexponentialAdjunctionMap(
             z,
             Coproduct( cohom_x_y, cohom_y_z ),
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory and IsStrictCocartesianCategory,
      Description := "CocartesianPreCoComposeMorphismWithGivenObjects using braiding, coclosed evaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( CocartesianPostCoComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := CoexponentialOnObjects( x, y );
    
    cohom_y_z := CoexponentialOnObjects( y, z );
    
    morphism := PreCompose(   [ 
                  CocartesianEvaluationMorphism( x, y ),
                  
                  CoproductOnMorphisms(
                    CocartesianEvaluationMorphism( y, z ),
                    IdentityMorphism( cohom_x_y ) )
                ] );
    
    return CoproductToCoexponentialAdjunctionMap(
             z,
             Coproduct( cohom_y_z, cohom_x_y ),
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory and IsStrictCocartesianCategory,
      Description := "CocartesianPostCoComposeMorphismWithGivenObjects using coclosed evluation, and cohom tensor adjunction" );
