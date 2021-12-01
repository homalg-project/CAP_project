# THIS FILE WAS AUTOMATICALLY GENERATED
# FROM MonoidalCategories v2021.11-04
# USING CategoryConstructor v2021.11-07

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( CoproductToCoexponentialAdjunctionMap,

  function( cat, object_1, object_2, morphism )
    
    return PreCompose( cat,
             CoexponentialOnMorphisms( cat, morphism, IdentityMorphism( cat, object_1 ) ),
             CocartesianCoevaluationMorphism( cat, object_1, object_2 ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CoproductToCoexponentialAdjunctionMap using CocartesianCoevaluationMorphism and Coexponential" );

##
AddDerivationToCAP( CoexponentialToCoproductAdjunctionMap,

  function( cat, object_1, object_2, morphism )
    
    return PreCompose( cat,
             CocartesianEvaluationMorphism( cat, object_1, object_2 ),
             CoproductOnMorphisms( cat, IdentityMorphism( cat, object_2 ), morphism ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CoexponentialToCoproductAdjunctionMap using CoproductOnMorphisms and CocartesianEvaluationMorphism" );

##
AddDerivationToCAP( UniversalPropertyOfCocartesianDual,

  function( cat, object_1, object_2, test_morphism )
    
    return PreCompose( cat,
             IsomorphismFromCocartesianDualToCoexponential( cat, object_2 ),
             CoproductToCoexponentialAdjunctionMap( cat, object_1, object_2, test_morphism ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "UniversalPropertyOfCocartesianDual using the cohom tensor adjunction" );

##
AddDerivationToCAP( MorphismFromCocartesianBidualWithGivenCocartesianBidual,

  function( cat, cobidual, object )
    local morphism;

    morphism := PreCompose( cat,
                  CocartesianEvaluationForCocartesianDual( cat, object ),
                  CocartesianBraiding( cat, object, CocartesianDualOnObjects( cat, object ) ) );
                  
    return UniversalPropertyOfCocartesianDual( cat, CocartesianDualOnObjects( cat, object ), object, morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "MorphismFromCocartesianBidualWithGivenCocartesianBidual using the braiding and the universal property of the codual" );

##
AddDerivationToCAP( MorphismFromCocartesianBidualWithGivenCocartesianBidual,

  function( cat, cobidual, object )
    local morphism, codual_object, tensor_unit;
    
    codual_object := CocartesianDualOnObjects( cat, object );
    
    tensor_unit := InitialObject( cat );
    
    morphism := PreComposeList( cat, [
                  CoexponentialOnMorphisms( cat,
                    CocartesianEvaluationMorphism( cat, tensor_unit, object ),
                    IdentityMorphism( cat, codual_object ) ),
                  
                  CoexponentialOnMorphisms( cat,
                    CocartesianBraiding( cat, object, codual_object ),
                    IdentityMorphism( cat, codual_object ) ),
                  
                  CocartesianCoevaluationMorphism( cat, codual_object, object )
                ] );
    
    return morphism;

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "MorphismFromCocartesianBidualWithGivenCocartesianBidual using CocartesianEvaluation, Coexponential, and CocartesianCoevaluation" );

##
AddDerivationToCAP( CocartesianDualOnObjects,

  function( cat, object )
    
    return Source( IsomorphismFromCocartesianDualToCoexponential( cat, object ) );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianDualOnObjects as the source of IsomorphismFromCocartesianDualToCoexponential" );

##
AddDerivationToCAP( CocartesianDualOnObjects,

  function( cat, object )
    
    return Range( IsomorphismFromCoexponentialToCocartesianDual( cat, object ) );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianDualOnObjects as the range of IsomorphismFromCoexponentialToCocartesianDual" );

##
AddDerivationToCAP( CocartesianDualOnMorphismsWithGivenCocartesianDuals,

  function( cat, new_source, morphism, new_range )
    local result_morphism;
    
    result_morphism := PreComposeList( cat, [
                         IsomorphismFromCocartesianDualToCoexponential( cat, Range( morphism ) ),
                         
                         CoexponentialOnMorphisms( cat,
                           IdentityMorphism( cat, InitialObject( cat ) ),
                           morphism ),
                           
                         IsomorphismFromCoexponentialToCocartesianDual( cat, Source( morphism ) )
                       ] );
                       
    return result_morphism;
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianDualOnMorphismsWithGivenCocartesianDuals using CoexponentialOnMorphisms and IsomorphismFromCocartesianDualToCoexponential" );

##
AddDerivationToCAP( CocartesianEvaluationForCocartesianDualWithGivenCoproduct,

  function( cat, unit, object, coproduct_object )

    return CoexponentialToCoproductAdjunctionMap( cat,
            unit,
            object,
            IsomorphismFromCoexponentialToCocartesianDual( cat, object ) );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianEvaluationForCocartesianDualWithGivenCoproduct using the cohom tensor adjunction and IsomorphismFromCoexponentialToCocartesianDual" );

##
AddDerivationToCAP( CocartesianLambdaIntroduction,

  function( cat, morphism )
    local result_morphism, range;

    range := Range( morphism );

    result_morphism := PreCompose( cat, morphism, CocartesianRightUnitorInverse( cat, range ) );

    return CoproductToCoexponentialAdjunctionMap( cat,
             range,
             InitialObject( cat ),
             result_morphism );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianLambdaIntroduction using the cohom tensor adjunction and right unitor" );

##
AddDerivationToCAP( CocartesianLambdaElimination,

  function( cat, object_1, object_2, morphism )
    local result_morphism;
    
    result_morphism := CoexponentialToCoproductAdjunctionMap( cat, object_1, object_2, morphism );
    
    return PreCompose( cat, result_morphism, CocartesianRightUnitor( cat, object_2 ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianLambdaElimination using the cohom tensor adjunction and right unitor" );

##
AddDerivationToCAP( CoexponentialCoproductCompatibilityMorphismWithGivenObjects,

  function( cat, source, list, range )
    local a1, a2, b1, b2, morphism, coproduct_b1_b2, int_cohom_a1_b1, int_cohom_a2_b2, id_int_cohom_a1_b1, id_int_cohom_a2_b2;
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    coproduct_b1_b2 := Coproduct( b1, b2 );
    
    int_cohom_a1_b1 := CoexponentialOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := CoexponentialOnObjects( cat, a2, b2 );
    
    id_int_cohom_a1_b1 := IdentityMorphism( cat, int_cohom_a1_b1 );
    
    id_int_cohom_a2_b2 := IdentityMorphism( cat, int_cohom_a2_b2 );
    
    morphism := PreComposeList( cat, [
                  CoproductOnMorphisms( cat,
                    IdentityMorphism( cat, a1 ),
                    CocartesianEvaluationMorphism( cat, a2, b2 ) ),
                  
                  CocartesianAssociatorRightToLeft( cat, a1, b2,  int_cohom_a2_b2),
                  
                  CoproductOnMorphisms( cat,
                    CoproductOnMorphisms( cat,
                      CocartesianEvaluationMorphism( cat, a1, b1 ),
                      IdentityMorphism( cat, b2 ) ),
                     id_int_cohom_a2_b2),
                  
                  CoproductOnMorphisms( cat,
                    CocartesianAssociatorLeftToRight( cat, b1, int_cohom_a1_b1, b2 ),
                    id_int_cohom_a2_b2 ),
                  
                  CoproductOnMorphisms( cat,
                    CoproductOnMorphisms( cat,
                      IdentityMorphism( cat, b1 ),
                      CocartesianBraiding( cat, b2, int_cohom_a1_b1 ) ),
                    id_int_cohom_a2_b2 ),
                  
                  CoproductOnMorphisms( cat,
                    CocartesianAssociatorRightToLeft( cat, b1, b2, int_cohom_a1_b1 ),
                    id_int_cohom_a2_b2 ),
                  
                  CocartesianAssociatorLeftToRight( cat,
                    coproduct_b1_b2,
                    int_cohom_a1_b1,
                    int_cohom_a2_b2 )
                ] );

    return CoproductToCoexponentialAdjunctionMap( cat,
             coproduct_b1_b2,
             Coproduct( int_cohom_a1_b1, int_cohom_a2_b2 ),
             morphism );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CoexponentialCoproductCompatibilityMorphismWithGivenObjects using associator, braiding and the coclosed evaluation morphism" );

##
AddDerivationToCAP( CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects,

  function( cat, new_source, object_1, object_2, new_range )
    local morphism, unit, coproduct_on_object_1_and_object_2;
    
    unit := InitialObject( cat );
    
    coproduct_on_object_1_and_object_2 := Coproduct( object_1, object_2 );
    
    morphism := PreComposeList( cat, [
                  IsomorphismFromCocartesianDualToCoexponential( cat, coproduct_on_object_1_and_object_2 ),
                  
                  CoexponentialOnMorphisms( cat,
                    CocartesianLeftUnitorInverse( cat, unit ),
                    IdentityMorphism( cat, coproduct_on_object_1_and_object_2 ) ),
                  
                  CoexponentialCoproductCompatibilityMorphism( cat, [ unit, unit, object_1, object_2 ] ),
                  
                  CoproductOnMorphisms( cat,
                    IsomorphismFromCoexponentialToCocartesianDual( cat, object_1 ),
                    IsomorphismFromCoexponentialToCocartesianDual( cat, object_2 ) )
                ] );

    return morphism;

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of internal cohom and coproduct" );

##
AddDerivationToCAP( IsomorphismFromCoexponentialToObjectWithGivenCoexponential,
                  
  function( cat, object, internal_cohom )
    local unit;
    
    unit := InitialObject( cat );
    
    return PreCompose( cat,
             CoexponentialOnMorphisms( cat,
               CocartesianLeftUnitorInverse( cat, object ),
               IdentityMorphism( cat, unit ) ),
               
             CocartesianCoevaluationMorphism( cat, unit, object ));
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "IsomorphismFromCoexponentialToObjectWithGivenCoexponential using the coclosed coevaluation morphism" );

##
AddDerivationToCAP( IsomorphismFromCoexponentialToObjectWithGivenCoexponential,
                  
  function( cat, object, internal_cohom )
    local unit;
    
    unit := InitialObject( cat );
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             unit,
             object,
             CocartesianLeftUnitorInverse( cat, object ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "IsomorphismFromCoexponentialToObjectWithGivenCoexponential as the adjoint of the left inverse unitor" );

## TODO: modify for the coclosed case and enable
# ##
# AddDerivationToCAP( IsomorphismFromInternalHomToObjectWithGivenInternalHom,
#                     
#   function( cat, object, internal_hom )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToInternalHom( cat, object ) );
#     
# end : CategoryFilter := IsSymmetricClosedCocartesianCategory,
#       Description := "IsomorphismFromInternalHomToObjectWithGivenInternalHom as the inverse of IsomorphismFromObjectToInternalHom" );

##
AddDerivationToCAP( IsomorphismFromObjectToCoexponentialWithGivenCoexponential,
                  
  function( cat, object, internal_cohom )
    local unit;
    
    unit := InitialObject( cat );
    
    return PreCompose( cat, CocartesianEvaluationMorphism( cat, object, unit ),
                       CocartesianLeftUnitor( cat, internal_cohom ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "IsomorphismFromObjectToCoexponentialWithGivenCoexponential using the coclosed evaluation morphism" );

## TODO: modify for the coclosed case and enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
#                     
#   function( cat, object, internal_hom )
#     
#     return InverseForMorphisms( cat, IsomorphismFromInternalHomToObject( cat, object ) );
#     
# end : CategoryFilter := IsSymmetricClosedCocartesianCategory,
#       Description := "IsomorphismFromObjectToInternalHom as the inverse of IsomorphismFromInternalHomToObject" );

##
AddDerivationToCAP( MorphismFromCoexponentialToCoproductWithGivenObjects,
                    
  function( cat, internal_cohom, object_1, object_2, coproduct_object )
    local unit;
    
    unit := InitialObject( cat );
    
    return PreComposeList( cat, [
             CoexponentialOnMorphisms( cat,
               CocartesianRightUnitorInverse( cat, object_1 ),
               CocartesianLeftUnitorInverse( cat, object_2 ) ),
              
             CoexponentialCoproductCompatibilityMorphism( cat,
               [ object_1, unit, unit, object_2 ] ),
              
             CoproductOnMorphisms( cat,
               IsomorphismFromCoexponentialToObject( cat, object_1 ),
               IsomorphismFromCoexponentialToCocartesianDual( cat, object_2 ) )
           ] );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "MorphismFromCoexponentialToCoproductWithGivenObjects using CoexponentialCoproductCompatibilityMorphism" );

##
AddDerivationToCAP( CocartesianEvaluationMorphismWithGivenRange,
                  
  function( cat, object_1, object_2, coproduct_object )
    
    return CoexponentialToCoproductAdjunctionMap( cat,
             object_1,
             object_2,
             IdentityMorphism( cat, CoexponentialOnObjects( cat, object_1, object_2 ) )
           );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianEvaluationMorphismWithGivenRange using the cohom tensor adjunction on the identity" );

AddDerivationToCAP( CocartesianCoevaluationMorphismWithGivenSource,
                  
  function( cat, object_1, object_2, internal_cohom )
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             object_1,
             object_2,
             IdentityMorphism( cat, Coproduct( object_1, object_2 ) )
           );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianCoevaluationMorphismWithGivenSource using the cohom tensor adjunction on the identity" );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                  
  function( cat, new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := CoexponentialOnObjects( cat, x, y );
    
    cohom_y_z := CoexponentialOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  CocartesianEvaluationMorphism( cat, x, y ),
                  
                  CocartesianBraiding( cat, y, cohom_x_y ),
                  
                  CoproductOnMorphisms( cat,
                    IdentityMorphism( cat, cohom_x_y ),
                    CocartesianEvaluationMorphism( cat, y, z ) ),
                  
                  CocartesianAssociatorRightToLeft( cat, cohom_x_y, z, cohom_y_z ),
                  
                  CoproductOnMorphisms( cat,
                    CocartesianBraiding( cat, cohom_x_y, z ),
                    IdentityMorphism( cat, cohom_y_z ) ),
                  
                  CocartesianAssociatorLeftToRight( cat, z, cohom_x_y, x, cohom_y_z ),
                ] );
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             z,
             Coproduct( cohom_x_y, cohom_y_z ),
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianPreCoComposeMorphismWithGivenObjects using associator, braiding, coclosed evaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( CocartesianPostCoComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := CoexponentialOnObjects( cat, x, y );
    
    cohom_y_z := CoexponentialOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  CocartesianEvaluationMorphism( cat, x, y ),
                  
                  CoproductOnMorphisms( cat,
                    CocartesianEvaluationMorphism( cat, y, z ),
                    IdentityMorphism( cat, cohom_x_y )
                  ),
                  
                  CocartesianAssociatorLeftToRight( cat, z, cohom_y_z, cohom_x_y )
                ] );
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             z,
             Coproduct( cohom_y_z, cohom_x_y ),
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianPostCoComposeMorphismWithGivenObjects using associator, coclosed evaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( CocartesianPostCoComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local braiding;
    
    braiding := CocartesianBraiding( cat, CoexponentialOnObjects( cat, x, y ), CoexponentialOnObjects( cat, y, z ) );
    
    return PreCompose( cat, CocartesianPreCoComposeMorphism( cat, x, y, z ), braiding );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianPostCoComposeMorphismWithGivenObjects using CocartesianPreCoComposeMorphism and braiding" );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local braiding;
    
    braiding := CocartesianBraiding( cat, CoexponentialOnObjects( cat, y, z ), CoexponentialOnObjects( cat, x, y ) );
    
    return PreCompose( cat, CocartesianPostCoComposeMorphism( cat, x, y, z ), braiding );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianPreCoComposeMorphismWithGivenObjects using CocartesianPostCoComposeMorphism and braiding" );

##
AddDerivationToCAP( CoexponentialCoproductCompatibilityMorphismWithGivenObjects,
                    
  function( cat, source, list, range )
    local a1, a2, b1, b2, morphism, int_cohom_a1_b1, int_cohom_a2_b2, id_int_cohom_a2_b2, coproduct_b1_b2;
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    int_cohom_a1_b1 := CoexponentialOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := CoexponentialOnObjects( cat, a2, b2 );
    
    id_int_cohom_a2_b2 := IdentityMorphism( cat, int_cohom_a2_b2 );
    
    coproduct_b1_b2 := Coproduct( b1, b2 );
    
    morphism := PreComposeList( cat, [
                  CoproductOnMorphisms( cat,
                    IdentityMorphism( cat, a1 ),
                    CocartesianEvaluationMorphism( cat, a2, b2 ) ),
                  
                  CoproductOnMorphisms( cat,
                    CoproductOnMorphisms( cat,
                      CocartesianEvaluationMorphism( cat, a1, b1 ),
                      IdentityMorphism( cat, b2 ) ),
                    id_int_cohom_a2_b2 ),
                  
                  CoproductOnMorphisms( cat,
                    CoproductOnMorphisms( cat,
                      IdentityMorphism( cat, b1 ),
                      CocartesianBraiding( cat, int_cohom_a1_b1, b2 ) ),
                    id_int_cohom_a2_b2 )
                ] );
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             coproduct_b1_b2,
             Coproduct( int_cohom_a1_b1, int_cohom_a2_b2 ),
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory and IsStrictCocartesianCategory,
      Description := "CoexponentialCoproductCompatibilityMorphismWithGivenObjects using braiding and the coclosed evaluation morphism" );

##
AddDerivationToCAP( CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects,
                  
  function( cat, new_source, object_1, object_2, new_range )
    local morphism, unit, coproduct_on_object_1_and_object_2;
    
    unit := InitialObject( cat );
    
    coproduct_on_object_1_and_object_2 := Coproduct( object_1, object_2 );
    
    morphism := PreComposeList( cat, [
                  IsomorphismFromCocartesianDualToCoexponential( cat, coproduct_on_object_1_and_object_2 ),
                  
                  CoexponentialCoproductCompatibilityMorphism( cat, [ unit, unit, object_1, object_2 ] ),
                  
                  CoproductOnMorphisms( cat,
                    IsomorphismFromCoexponentialToCocartesianDual( cat, object_1 ),
                    IsomorphismFromCoexponentialToCocartesianDual( cat, object_2 ) )
                ] );
              
    return morphism;
    
end : CategoryFilter := IsCocartesianCoclosedCategory and IsStrictCocartesianCategory,
      Description := "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects using compatibility of internal cohom and coproduct" );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                  
  function( cat, new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := CoexponentialOnObjects( cat, x, y );
    
    cohom_y_z := CoexponentialOnObjects( cat, y, z );
    
    morphism := PreComposeList( [
                  CocartesianEvaluationMorphism( cat, x, y ),
                  
                  CocartesianBraiding( cat, y, cohom_x_y),
                  
                  CoproductOnMorphisms( cat,
                    IdentityMorphism( cat, cohom_x_y ),
                    CocartesianEvaluationMorphism( cat, y, z ) ),
                  
                  CoproductOnMorphisms( cat,
                    CocartesianBraiding( cat, cohom_x_y, z ),
                    IdentityMorphism( cat, cohom_y_z ) )
                ] );
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             z,
             Coproduct( cohom_x_y, cohom_y_z ),
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory and IsStrictCocartesianCategory,
      Description := "CocartesianPreCoComposeMorphismWithGivenObjects using braiding, coclosed evaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( CocartesianPostCoComposeMorphismWithGivenObjects,
                    
  function( cat, new_source, x, y, z, new_range )
    local cohom_x_y, cohom_y_z, morphism;
    
    cohom_x_y := CoexponentialOnObjects( cat, x, y );
    
    cohom_y_z := CoexponentialOnObjects( cat, y, z );
    
    morphism := PreComposeList( cat, [
                  CocartesianEvaluationMorphism( cat, x, y ),
                  
                  CoproductOnMorphisms( cat,
                    CocartesianEvaluationMorphism( cat, y, z ),
                    IdentityMorphism( cat, cohom_x_y ) )
                ] );
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             z,
             Coproduct( cohom_y_z, cohom_x_y ),
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory and IsStrictCocartesianCategory,
      Description := "CocartesianPostCoComposeMorphismWithGivenObjects using coclosed evaluation, and cohom tensor adjunction" );
