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
