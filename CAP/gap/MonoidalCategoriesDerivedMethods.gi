#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

####################################
## Derived Methods for Monoidal Categories
####################################

##
AddDerivationToCAP( LeftDistributivityExpandingWithGivenObjects,
                    
  function( factored_object, object, summands, expanded_object )
    local nr_summands, projection_list, id, diagram;
    
    nr_summands := Size( summands );
    
    projection_list := List( [ 1 .. nr_summands ], i -> ProjectionInFactorOfDirectSum( summands, i ) );
    
    id := IdentityMorphism( object );
    
    projection_list := List( projection_list, mor -> TensorProductOnMorphisms( id, mor ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( object, summand ) );
    
    return UniversalMorphismIntoDirectSum( diagram, projection_list );
    
end : CategoryFilter := IsMonoidalCategory and IsAdditiveCategory,
      Description := "LeftDistributivityExpandingWithGivenObjects using the universal property of the direct sum" );

##
AddDerivationToCAP( LeftDistributivityFactoringWithGivenObjects,
                    
  function( expanded_object, object, summands, factored_object )
    local nr_summands, injection_list, id, diagram;
    
    nr_summands := Size( summands );
    
    injection_list := List( [ 1 .. nr_summands ], i -> InjectionOfCofactorOfDirectSum( summands, i ) );
    
    id := IdentityMorphism( object );
    
    injection_list := List( injection_list, mor -> TensorProductOnMorphisms( id, mor ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( object, summand ) );
    
    return UniversalMorphismFromDirectSum( diagram, injection_list );
    
end : CategoryFilter := IsMonoidalCategory and IsAdditiveCategory,
      Description := "LeftDistributivityFactoringWithGivenObjects using the universal property of the direct sum" );

##
AddDerivationToCAP( RightDistributivityExpandingWithGivenObjects,
                    
  function( factored_object, summands, object, expanded_object )
    local nr_summands, projection_list, id, diagram;
    
    nr_summands := Size( summands );
    
    projection_list := List( [ 1 .. nr_summands ], i -> ProjectionInFactorOfDirectSum( summands, i ) );
    
    id := IdentityMorphism( object );
    
    projection_list := List( projection_list, mor -> TensorProductOnMorphisms( mor, id ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( summand, object ) );
    
    return UniversalMorphismIntoDirectSum( diagram, projection_list );
    
end : CategoryFilter := IsMonoidalCategory and IsAdditiveCategory,
      Description := "RightDistributivityExpandingWithGivenObjects using the universal property of the direct sum" );

##
AddDerivationToCAP( RightDistributivityFactoringWithGivenObjects,
                    
  function( expanded_object, summands, object, factored_object )
    local nr_summands, injection_list, id, diagram;
    
    nr_summands := Size( summands );
    
    injection_list := List( [ 1 .. nr_summands ], i -> InjectionOfCofactorOfDirectSum( summands, i ) );
    
    id := IdentityMorphism( object );
    
    injection_list := List( injection_list, mor -> TensorProductOnMorphisms( mor, id ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( summand, object ) );
    
    return UniversalMorphismFromDirectSum( diagram, injection_list );
    
end : CategoryFilter := IsMonoidalCategory and IsAdditiveCategory,
      Description := "RightDistributivityFactoringWithGivenObjects using the universal property of the direct sum" );



##
AddDerivationToCAP( AssociatorLeftToRightWithGivenTensorProducts,
                    
  function( left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return IdentityMorphism( left_associated_object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "AssociatorLeftToRightWithGivenTensorProducts as the identity morphism" );

##
AddDerivationToCAP( AssociatorRightToLeftWithGivenTensorProducts,
                    
  function( right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return IdentityMorphism( right_associated_object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "AssociatorRightToLeft as the identity morphism" );

##
AddDerivationToCAP( LeftUnitorWithGivenTensorProduct,
                    
  function( object, unit_tensored_object )
    
    return IdentityMorphism( object );
      
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "LeftUnitorWithGivenTensorProduct as the identity morphism" );

##
AddDerivationToCAP( LeftUnitorInverseWithGivenTensorProduct,
                  
  function( object, unit_tensored_object )
    
    return IdentityMorphism( object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "LeftUnitorInverseWithGivenTensorProduct as the identity morphism" );

##
AddDerivationToCAP( RightUnitorWithGivenTensorProduct,
                    
  function( object, object_tensored_unit )
    
    return IdentityMorphism( object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "RightUnitorWithGivenTensorProduct as the identity morphism" );

##
AddDerivationToCAP( RightUnitorInverseWithGivenTensorProduct,
                    
  function( object, object_tensored_unit )
    
    return IdentityMorphism( object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "RightUnitorInverseWithGivenTensorProduct as the identity morphism" );

##
AddDerivationToCAP( AssociatorLeftToRightWithGivenTensorProducts,
                    
  function( left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return Inverse( AssociatorRightToLeftWithGivenTensorProducts(
                      right_associated_object,
                      object_1, object_2, object_3,
                      left_associated_object )
                  );
    
end : Description := "AssociatorLeftToRightWithGivenTensorProducts as the inverse of AssociatorRightToLeftWithGivenTensorProducts" );

##
AddDerivationToCAP( AssociatorRightToLeftWithGivenTensorProducts,
                    
  function( right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return Inverse( AssociatorLeftToRightWithGivenTensorProducts(
                      left_associated_object,
                      object_1, object_2, object_3,
                      right_associated_object )
                  );
    
end : Description := "AssociatorRightToLeftWithGivenTensorProducts as the inverse of AssociatorLeftToRightWithGivenTensorProducts" );

##
AddDerivationToCAP( LeftUnitorWithGivenTensorProduct,
                  
  function( object, unit_tensored_object )
    
    return Inverse( LeftUnitorInverseWithGivenTensorProduct( object, unit_tensored_object ) );
    
end : Description := "LeftUnitorWithGivenTensorProduct as the inverse of LeftUnitorInverseWithGivenTensorProduct" );

##
AddDerivationToCAP( LeftUnitorInverseWithGivenTensorProduct,
                  
  function( object, unit_tensored_object )
    
    return Inverse( LeftUnitorWithGivenTensorProduct( object, unit_tensored_object ) );
    
end : Description := "LeftUnitorInverseWithGivenTensorProduct as the inverse of LeftUnitorWithGivenTensorProduct" );

##
AddDerivationToCAP( RightUnitorWithGivenTensorProduct,
                  
  function( object, object_tensored_unit )
    
    return Inverse( RightUnitorInverseWithGivenTensorProduct( object, object_tensored_unit ) );
    
end : Description := "RightUnitorWithGivenTensorProduct as the inverse of RightUnitorInverseWithGivenTensorProduct" );

##
AddDerivationToCAP( RightUnitorInverseWithGivenTensorProduct,
                  
  function( object, object_tensored_unit )
    
    return Inverse( RightUnitorWithGivenTensorProduct( object, object_tensored_unit ) );
    
end : Description := "RightUnitorInverseWithGivenTensorProduct as the inverse of RightUnitorWithGivenTensorProduct" );

##
AddDerivationToCAP( BraidingWithGivenTensorProducts,
                  
  function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
    
    return BraidingInverseWithGivenTensorProducts(
                            object_1_tensored_object_2,
                            object_2, object_1,
                            object_2_tensored_object_1 );
    
end : CategoryFilter := IsSymmetricMonoidalCategory,
      Description := "BraidingWithGivenTensorProducts using BraidingInverseWithGivenTensorProducts" );

##
AddDerivationToCAP( BraidingInverseWithGivenTensorProducts,
                  
  function( object_2_tensored_object_1, object_1, object_2, object_1_tensored_object_2 )
    
    return BraidingWithGivenTensorProducts(
                     object_2_tensored_object_1,
                     object_2, object_1,
                     object_1_tensored_object_2 );
    
end : CategoryFilter := IsSymmetricMonoidalCategory,
      Description := "BraidingInverseWithGivenTensorProducts using BraidingWithGivenTensorProducts" );

##
AddDerivationToCAP( BraidingInverseWithGivenTensorProducts,
                  
  function( object_2_tensored_object_1, object_1, object_2, object_1_tensored_object_2 )
    ##TODO: Use BraidingWithGiven
    return Inverse( Braiding( object_1, object_2 ) );
    
end : CategoryFilter := IsBraidedMonoidalCategory,
      Description := "BraidingInverseWithGivenTensorProducts as the inverse of the braiding" );

##
AddDerivationToCAP( BraidingWithGivenTensorProducts,
                  
  function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
    ##TODO: Use BraidingInverseWithGiven
    return Inverse( BraidingInverse( object_1, object_2 ) );
    
end : CategoryFilter := IsBraidedMonoidalCategory,
      Description := "BraidingWithGivenTensorProducts as the inverse of BraidingInverse" );


##
AddDerivationToCAP( TensorProductToInternalHomAdjunctionMap,
                    
  function( object_1, object_2, morphism )
    local coevaluation, internal_hom_on_morphisms;
    
    coevaluation := CoevaluationMorphism( object_1, object_2 );
    
    internal_hom_on_morphisms := InternalHomOnMorphisms( IdentityMorphism( object_2 ), morphism );
    
    return PreCompose( coevaluation, internal_hom_on_morphisms );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "TensorProductToInternalHomAdjunctionMap using CoevaluationMorphism and InternalHom" );

##
AddDerivationToCAP( InternalHomToTensorProductAdjunctionMap,
                    
  function( object_1, object_2, morphism )
    local evaluation, tensor_product_on_morphisms;
    
    tensor_product_on_morphisms := TensorProductOnMorphisms( morphism, IdentityMorphism( object_1 ) );
    
    evaluation := EvaluationMorphism( object_1, object_2 );
    
    return PreCompose( tensor_product_on_morphisms, evaluation );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "InternalHomToTensorProductAdjunctionMap using TensorProductOnMorphisms and EvaluationMorphism" );

##
AddDerivationToCAP( InternalHomOnObjects,
                  
  function( object_1, object_2 )
    
    return Source( IsomorphismFromInternalHomToTensorProduct( object_1, object_2 ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalHomOnObjects as the source of IsomorphismFromInternalHomToTensorProduct" );

##
AddDerivationToCAP( InternalHomOnObjects,
                  
  function( object_1, object_2 )
    
    return Range( IsomorphismFromTensorProductToInternalHom( object_1, object_2 ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "InternalHomOnObjects as the range of IsomorphismFromTensorProductToInternalHom" );

##
AddDerivationToCAP( InternalHomOnMorphismsWithGivenInternalHoms,
                  
  function( internal_hom_source, morphism_1, morphism_2, internal_hom_range )
    local dual_morphism;
    
    dual_morphism := DualOnMorphisms( morphism_1 );
    
    return PreCompose( PreCompose( IsomorphismFromInternalHomToTensorProduct( Range( morphism_1 ), Source( morphism_2 ) ),
                       TensorProductOnMorphisms( dual_morphism, morphism_2 ) ),
                       IsomorphismFromTensorProductToInternalHom( Source( morphism_1 ), Range( morphism_2 ) )
                     );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalHomOnMorphismsWithGivenInternalHoms using functoriality of Dual and TensorProduct" );

##
AddDerivationToCAP( MorphismFromBidualWithGivenBidual,
                  
  function( object, bidual )
    
    return Inverse( MorphismToBidualWithGivenBidual( object, bidual ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromBidualWithGivenBidual as the inverse of MorphismToBidualWithGivenBidual" );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                  
  function( object, bidual )
    
    return Inverse( MorphismFromBidualWithGivenBidual( object, bidual ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismToBidualWithGivenBidual as the inverse of MorphismFromBidualWithGivenBidual" );

##
AddDerivationToCAP( EvaluationMorphismWithGivenSource,
                  
  function( object_1, object_2, internal_hom_tensored_object_1 )
    local morphism;
    
    morphism := TensorProductOnMorphisms( 
                  IsomorphismFromInternalHomToTensorProduct( object_1, object_2 ),
                  IdentityMorphism( object_1 )
                );
    
    morphism := PreCompose( morphism,
                  TensorProductOnMorphisms(
                    Braiding( DualOnObjects( object_1 ), object_2 ),
                    IdentityMorphism( object_1 ) )
                );
    
    morphism := PreCompose( morphism,
                  AssociatorLeftToRight( object_2, DualOnObjects( object_1 ), object_1 )
                );
    
    morphism := PreCompose( morphism,
                  TensorProductOnMorphisms(
                    IdentityMorphism( object_2 ),
                    EvaluationForDual( object_1 ) )
                );
    
    morphism := PreCompose( morphism,
                  RightUnitor( object_2 )
                );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "EvaluationMorphismWithGivenSource using the rigidity of the monoidal category" );

##
AddDerivationToCAP( EvaluationMorphismWithGivenSource,
                    
  function( object_1, object_2, internal_hom_tensored_object_1 )
    local morphism;
    
    morphism := TensorProductOnMorphisms( 
                  IsomorphismFromInternalHomToTensorProduct( object_1, object_2 ),
                  IdentityMorphism( object_1 )
                );
    
    morphism := PreCompose( morphism,
                  TensorProductOnMorphisms(
                    Braiding( DualOnObjects( object_1 ), object_2 ),
                    IdentityMorphism( object_1 ) )
                );
    
    morphism := PreCompose( morphism,
                  TensorProductOnMorphisms(
                    IdentityMorphism( object_2 ),
                    EvaluationForDual( object_1 ) )
                );
    
    return morphism;
      
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "EvaluationMorphismWithGivenSource using the rigidity and strictness of the monoidal category" );

##
AddDerivationToCAP( CoevaluationMorphismWithGivenRange,
                    
  function( object_1, object_2, internal_hom )
    local morphism, dual_2, id_1;
    
    dual_2 := DualOnObjects( object_2 );
    
    id_1 := IdentityMorphism( object_1 );
    
    morphism := LeftUnitorInverse( object_1 );
    
    morphism := PreCompose( morphism,
                  TensorProductOnMorphisms(
                    CoevaluationForDual( object_2 ),
                    id_1 )
                );
    
    morphism := PreCompose( morphism,
                  TensorProductOnMorphisms(
                    Braiding( object_2, dual_2 ),
                    id_1 )
                );
    
    morphism := PreCompose( morphism,
                  AssociatorLeftToRight( dual_2, object_2, object_1 )
                );
    
    morphism := PreCompose( morphism,
                  TensorProductOnMorphisms(
                    IdentityMorphism( dual_2 ),
                    Braiding( object_2, object_1 ) )
                );
    
    morphism := PreCompose( morphism,
                  IsomorphismFromTensorProductToInternalHom(
                    object_2,
                    TensorProductOnObjects( object_1, object_2 ) )
                );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "CoevaluationMorphismWithGivenRange using the rigidity of the monoidal category" );

##
AddDerivationToCAP( CoevaluationMorphismWithGivenRange,
                    
  function( object_1, object_2, internal_hom )
    local morphism, dual_2, id_1;
    
    dual_2 := DualOnObjects( object_2 );
    
    id_1 := IdentityMorphism( object_1 );
    
    morphism := TensorProductOnMorphisms(
                    CoevaluationForDual( object_2 ),
                    id_1 );
    
    morphism := PreCompose( morphism,
                  TensorProductOnMorphisms(
                    Braiding( object_2, dual_2 ),
                    id_1 )
                );
    
    morphism := PreCompose( morphism,
                  TensorProductOnMorphisms(
                    IdentityMorphism( dual_2 ),
                    Braiding( object_2, object_1 ) )
                );
    
    morphism := PreCompose( morphism,
                  IsomorphismFromTensorProductToInternalHom(
                    object_2,
                    TensorProductOnObjects( object_1, object_2 ) )
                );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "CoevaluationMorphismWithGivenRange using the rigidity of the monoidal category" );

##
AddDerivationToCAP( UniversalPropertyOfDual,
                    
  function( object_1, object_2, test_morphism )
    local adjoint_morphism;
    
    adjoint_morphism := TensorProductToInternalHomAdjunctionMap( object_1, object_2, test_morphism );
    
    return PreCompose( adjoint_morphism,
                       IsomorphismFromInternalHomToDual( object_2 )
                     );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "UniversalPropertyOfDual using the hom tensor adjunction" );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                  
  function( object, bidual )
    local morphism;
    
    morphism := Braiding( object, DualOnObjects( object ) );
    
    morphism := PreCompose( morphism,
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
    local category, result_morphism;
    
    category := CapCategory( morphism );
    
    result_morphism := InternalHomOnMorphisms( morphism, IdentityMorphism( TensorUnit( category ) ) );
    
    result_morphism := PreCompose( IsomorphismFromDualToInternalHom( Range( morphism ) ),
                                   result_morphism );
    
    result_morphism := PreCompose( result_morphism,
                                   IsomorphismFromInternalHomToDual( Source( morphism ) ) );
    
    return result_morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "DualOnMorphismsWithGivenDuals using InternalHomOnMorphisms and IsomorphismFromDualToInternalHom" );

##
AddDerivationToCAP( MorphismFromTensorProductToInternalHomWithGivenObjects,
                  
  function( tensor_object, object_1, object_2, internal_hom )
    
    return IsomorphismFromTensorProductToInternalHom( object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromTensorProductToInternalHomWithGivenObjects using IsomorphismFromTensorProductToInternalHom" );

##
AddDerivationToCAP( MorphismFromInternalHomToTensorProductWithGivenObjects,
                  
  function( tensor_object, object_1, object_2, internal_hom )
    
    return IsomorphismFromInternalHomToTensorProduct( object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromInternalHomToTensorProductWithGivenObjects using IsomorphismFromInternalHomToTensorProduct" );

##
AddDerivationToCAP( IsomorphismFromInternalHomToTensorProduct,
                    
  function( object_1, object_2 )
    
    return MorphismFromInternalHomToTensorProduct( object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalHomToTensorProduct using MorphismFromInternalHomToTensorProduct" );

##
AddDerivationToCAP( IsomorphismFromTensorProductToInternalHom,
                    
  function( object_1, object_2 )
    
    return MorphismFromTensorProductToInternalHom( object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromTensorProductToInternalHom using MorphismFromTensorProductToInternalHom" );

##
AddDerivationToCAP( EvaluationForDualWithGivenTensorProduct,
                  
  function( tensor_object, object, unit )
    
    return InternalHomToTensorProductAdjunctionMap( object, unit,
                                                    IsomorphismFromDualToInternalHom( object ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "EvaluationForDualWithGivenTensorProduct using the tensor hom adjunction and IsomorphismFromDualToInternalHom" );


##
AddDerivationToCAP( CoevaluationForDualWithGivenTensorProduct,
                    
  function( unit, object, tensor_object )
    local morphism;
    
    morphism := IdentityMorphism( object );
    
    morphism := LambdaIntroduction( morphism );
    
    morphism := PreCompose( morphism,
                            IsomorphismFromInternalHomToTensorProduct( object, object ) );
    
    morphism := PreCompose( morphism,
                            Braiding( DualOnObjects( object ), object ) );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "CoevaluationForDualWithGivenTensorProduct using LambdaIntroduction on the identity and IsomorphismFromInternalHomToTensorProduct" );

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
AddDerivationToCAP( TraceMap,
                    
  function( morphism )
    local result_morphism, object;
    
    result_morphism := LambdaIntroduction( morphism );
    
    object := Source( morphism );
    
    result_morphism := PreCompose( result_morphism,
                                   IsomorphismFromInternalHomToTensorProduct( object, object ) );
    
    return PreCompose( result_morphism,
                       EvaluationForDual( object ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "TraceMap composing the lambda abstraction with the evaluation" );

##
AddDerivationToCAP( RankMorphism,
                    
  function( object )
    
    return TraceMap( IdentityMorphism( object ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "Rank of an object as the trace of its identity" );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects,
                    
  function( a1, b1, a2, b2, new_source_and_range_list )
    
    return Inverse( TensorProductInternalHomCompatibilityMorphismWithGivenObjects( a1, b1, a2, b2, new_source_and_range_list ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects as the inverse of TensorProductInternalHomCompatibilityMorphismWithGivenObjects" );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                    
  function( a1, b1, a2, b2, new_source_and_range_list )
    local morphism, int_hom_a1_b1, int_hom_a2_b2, id_a2, tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2;
    
    int_hom_a1_b1 := InternalHomOnObjects( a1, b1 );
    
    int_hom_a2_b2 := InternalHomOnObjects( a2, b2 );
    
    id_a2 := IdentityMorphism( a2 );
    
    tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2 := 
      TensorProductOnObjects( int_hom_a1_b1, int_hom_a2_b2 );
    
    morphism := PreCompose(
      [
        AssociatorRightToLeft(
          tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
          a1,
          a2 ),
          
          TensorProductOnMorphisms(
            AssociatorLeftToRight( int_hom_a1_b1, int_hom_a2_b2, a1 ),
            id_a2 ),
          
          TensorProductOnMorphisms(
            TensorProductOnMorphisms(
              IdentityMorphism( int_hom_a1_b1 ),
              Braiding( int_hom_a2_b2, a1 )
            ),
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
            EvaluationMorphism( a2, b2 )
          )
      ]
    );
    
    return TensorProductToInternalHomAdjunctionMap(
             tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
             TensorProductOnObjects( a1, a2 ),
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "TensorProductInternalHomCompatibilityMorphismWithGivenObjects using associator, braiding an the evaluation morphism" );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                    
  function( a1, b1, a2, b2, new_source_and_range_list )
    local morphism, int_hom_a1_b1, int_hom_a2_b2, id_a2, tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2;
    
    int_hom_a1_b1 := InternalHomOnObjects( a1, b1 );
    
    int_hom_a2_b2 := InternalHomOnObjects( a2, b2 );
    
    id_a2 := IdentityMorphism( a2 );
    
    tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2 := 
      TensorProductOnObjects( int_hom_a1_b1, int_hom_a2_b2 );
    
    morphism := PreCompose(
      [
          
          TensorProductOnMorphisms(
            TensorProductOnMorphisms(
              IdentityMorphism( int_hom_a1_b1 ),
              Braiding( int_hom_a2_b2, a1 )
            ),
            id_a2 ),
          
          TensorProductOnMorphisms(
            TensorProductOnMorphisms(
              EvaluationMorphism( a1, b1 ),
              IdentityMorphism( int_hom_a2_b2 ) ),
            id_a2 ),
          
          TensorProductOnMorphisms(
            IdentityMorphism( b1 ),
            EvaluationMorphism( a2, b2 )
          )
      ]
    );
    
    return TensorProductToInternalHomAdjunctionMap(
             tensor_product_on_objects_int_hom_a1_b1_int_hom_a2_b2,
             TensorProductOnObjects( a1, a2 ),
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "TensorProductInternalHomCompatibilityMorphismWithGivenObjects using braiding an the evaluation morphism" );

##
AddDerivationToCAP( TensorProductDualityCompatibilityMorphismWithGivenObjects,
                  
  function( new_source, object_1, object_2, new_range )
    local morphism, unit, tensor_product_on_object_1_and_object_2;
    
    unit := TensorUnit( CapCategory( object_1 ) );
    
    tensor_product_on_object_1_and_object_2 := TensorProductOnObjects( object_1, object_2 );
    
    morphism := PreCompose(
      [
        
        TensorProductOnMorphisms(
          IsomorphismFromDualToInternalHom( object_1 ),
          IsomorphismFromDualToInternalHom( object_2 ) ),
        
        TensorProductInternalHomCompatibilityMorphism( object_1, unit, object_2, unit ),
        
        InternalHomOnMorphisms(
          IdentityMorphism( tensor_product_on_object_1_and_object_2 ),
          LeftUnitor( unit ) ),
        
        IsomorphismFromInternalHomToDual( tensor_product_on_object_1_and_object_2 )
        
      ]
    );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "TensorProductDualityCompatibilityMorphismWithGivenObjects using left unitoar, and compatibility of tensor product and internal hom" );

##
AddDerivationToCAP( TensorProductDualityCompatibilityMorphismWithGivenObjects,
                  
  function( new_source, object_1, object_2, new_range )
    local morphism, unit, tensor_product_on_object_1_and_object_2;
    
    unit := TensorUnit( CapCategory( object_1 ) );
    
    tensor_product_on_object_1_and_object_2 := TensorProductOnObjects( object_1, object_2 );
    
    morphism := PreCompose(
      [
        
        TensorProductOnMorphisms(
          IsomorphismFromDualToInternalHom( object_1 ),
          IsomorphismFromDualToInternalHom( object_2 ) ),
        
        TensorProductInternalHomCompatibilityMorphism( object_1, unit, object_2, unit ),
        
        IsomorphismFromInternalHomToDual( tensor_product_on_object_1_and_object_2 )
        
      ]
    );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "TensorProductDualityCompatibilityMorphismWithGivenObjects using compatibility of tensor product and internal hom" );

##
AddDerivationToCAP( IsomorphismFromInternalHomToObjectWithGivenInternalHom,
                  
  function( object, internal_hom )
    local unit;
    
    unit := TensorUnit( CapCategory( object ) );
    
    return PreCompose(
             CoevaluationMorphism( object, unit ),
             InternalHomOnMorphisms(
               IdentityMorphism( unit ),
               RightUnitor( object ) )
           );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalHomToObjectWithGivenInternalHom using the coevaluation morphism" );

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
AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
                  
  function( object, internal_hom )
    local unit, morphism;
    
    unit := TensorUnit( CapCategory( object ) );
    
    morphism := EvaluationMorphism( unit, object );
    
    return PreCompose( RightUnitorInverse( internal_hom ),
                       morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromObjectToInternalHomWithGivenInternalHom using the evaluation morphism" );

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
    local unit, morphism;
    
    unit := TensorUnit( CapCategory( object_1 ) );
    
    morphism := PreCompose(
                  [ 
                    TensorProductOnMorphisms(
                      IsomorphismFromDualToInternalHom( object_1 ),
                      IsomorphismFromObjectToInternalHom( object_2 ) ),
                      
                    TensorProductInternalHomCompatibilityMorphism(
                      object_1, unit, unit, object_2 ),
                      
                    TensorProductOnMorphisms(
                      IdentityMorphism( internal_hom ),
                      IsomorphismFromInternalHomToObject( unit )
                    ),
                    
                    RightUnitor( internal_hom )
                  ]
                );
    
    return morphism;
    
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
             IdentityMorphism( InternalHomOnObjects( object_1, object_2 ) )
           );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "EvaluationMorphismWithGivenSource using the tenor hom adjunction on the identity" );

##
AddDerivationToCAP( CoevaluationMorphismWithGivenRange,
                  
  function( object_1, object_2, internal_hom )
    
    return TensorProductToInternalHomAdjunctionMap(
             object_1,
             object_2,
             IdentityMorphism( TensorProductOnObjects( object_1, object_2 ) )
           );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "CoevaluationMorphismWithGivenRange using the tensor hom adjunction on the identity" );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                  
  function( new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := InternalHomOnObjects( x, y );
    
    hom_y_z := InternalHomOnObjects( y, z );
    
    morphism := PreCompose(
      [ 
        AssociatorLeftToRight( hom_x_y, hom_y_z, x ),
        
        TensorProductOnMorphisms(
          IdentityMorphism( hom_x_y ),
          Braiding( hom_y_z, x )
        ),
        
        AssociatorRightToLeft( hom_x_y, x, hom_y_z ),
        
        TensorProductOnMorphisms(
          EvaluationMorphism( x, y ),
          IdentityMorphism( hom_y_z )
        ),
        
        Braiding( y, hom_y_z ),
        
        EvaluationMorphism( y, z )
        
      ]
    );
    
    return TensorProductToInternalHomAdjunctionMap(
             TensorProductOnObjects( hom_x_y, hom_y_z ),
             x,
             morphism
           );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPreComposeMorphismWithGivenObjects using associator, braiding, evaluation, and tensor hom adjunction" );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                  
  function( new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := InternalHomOnObjects( x, y );
    
    hom_y_z := InternalHomOnObjects( y, z );
    
    morphism := PreCompose(
      [ 
        
        TensorProductOnMorphisms(
          IdentityMorphism( hom_x_y ),
          Braiding( hom_y_z, x )
        ),
        
        TensorProductOnMorphisms(
          EvaluationMorphism( x, y ),
          IdentityMorphism( hom_y_z )
        ),
        
        Braiding( y, hom_y_z ),
        
        EvaluationMorphism( y, z )
        
      ]
    );
    
    return TensorProductToInternalHomAdjunctionMap(
             TensorProductOnObjects( hom_x_y, hom_y_z ),
             x,
             morphism
           );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "MonoidalPreComposeMorphismWithGivenObjects using, braiding, evaluation, and tensor hom adjunction" );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := InternalHomOnObjects( x, y );
    
    hom_y_z := InternalHomOnObjects( y, z );
    
    morphism := PreCompose(
      [ 
        AssociatorLeftToRight( hom_y_z, hom_x_y, x ),
        
        TensorProductOnMorphisms(
          IdentityMorphism( hom_y_z ),
          EvaluationMorphism( x, y )
        ),
        
        EvaluationMorphism( y, z )
      ]
    );
    
    return TensorProductToInternalHomAdjunctionMap(
             TensorProductOnObjects( hom_y_z, hom_x_y ),
             x,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
      Description := "MonoidalPostComposeMorphismWithGivenObjects using associator, evaluation, and tensor hom adjunction" );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    
  function( new_source, x, y, z, new_range )
    local hom_x_y, hom_y_z, morphism;
    
    hom_x_y := InternalHomOnObjects( x, y );
    
    hom_y_z := InternalHomOnObjects( y, z );
    
    morphism := PreCompose(
      [ 
        
        TensorProductOnMorphisms(
          IdentityMorphism( hom_y_z ),
          EvaluationMorphism( x, y )
        ),
        
        EvaluationMorphism( y, z )
      ]
    );
    
    return TensorProductToInternalHomAdjunctionMap(
             TensorProductOnObjects( hom_y_z, hom_x_y ),
             x,
             morphism );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "MonoidalPostComposeMorphismWithGivenObjects using evaluation, and tensor hom adjunction" );

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
AddDerivationToCAP( MorphismFromCoimageToImageWithGivenObjects,
                    
  ##CoimageObject, ImageObject as Assumptions
  function( coimage, morphism, image )
    local coimage_projection, cokernel_projection, kernel_lift;
    
    cokernel_projection := CokernelProjection( morphism );
    
    coimage_projection := CoimageProjection( morphism );
    
    kernel_lift := KernelLift( cokernel_projection , AstrictionToCoimage( morphism ) );
    
    return PreCompose( kernel_lift, IsomorphismFromKernelOfCokernelToImageObject( morphism ) );
    
end : CategoryFilter := IsPreAbelianCategory,
      Description := "MorphismFromCoimageToImageWithGivenObjects using that images are given by kernels of cokernels" );

##
AddDerivationToCAP( InverseMorphismFromCoimageToImageWithGivenObjects,
                    
  function( coimage, morphism, image )
    
    return Inverse( MorphismFromCoimageToImage( morphism ) );
    
end : CategoryFilter := IsAbelianCategory,
      Description := "InverseMorphismFromCoimageToImageWithGivenObjects as the inverse of MorphismFromCoimageToImage" );

####################################
## Final derived methods
####################################

## Final methods for InternalHom

##
AddFinalDerivation( IsomorphismFromTensorProductToInternalHom,
                    [ [ IdentityMorphism, 1 ],
                      [ DualOnObjects, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    [ InternalHomOnObjects,
                      InternalHomOnMorphismsWithGivenInternalHoms,
                      EvaluationMorphismWithGivenSource,
                      CoevaluationMorphismWithGivenRange,
                      TensorProductToInternalHomAdjunctionMap,
                      InternalHomToTensorProductAdjunctionMap,
                      MonoidalPreComposeMorphismWithGivenObjects,
                      MonoidalPostComposeMorphismWithGivenObjects,
                      TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                      TensorProductDualityCompatibilityMorphismWithGivenObjects,
                      MorphismFromTensorProductToInternalHomWithGivenObjects,
                      MorphismFromInternalHomToTensorProductWithGivenObjects,
                      IsomorphismFromTensorProductToInternalHom,
                      IsomorphismFromInternalHomToTensorProduct ],
                    
  function( object_1, object_2 )
    
    return IdentityMorphism( TensorProductOnObjects( DualOnObjects( object_1 ), object_2 ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromTensorProductToInternalHom as the identity of (Dual(a) tensored b)" );

##
AddFinalDerivation( IsomorphismFromInternalHomToTensorProduct,
                    [ [ IdentityMorphism, 1 ],
                      [ DualOnObjects, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    [ InternalHomOnObjects,
                      InternalHomOnMorphismsWithGivenInternalHoms,
                      EvaluationMorphismWithGivenSource,
                      CoevaluationMorphismWithGivenRange,
                      TensorProductToInternalHomAdjunctionMap,
                      InternalHomToTensorProductAdjunctionMap,
                      MonoidalPreComposeMorphismWithGivenObjects,
                      MonoidalPostComposeMorphismWithGivenObjects,
                      TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                      TensorProductDualityCompatibilityMorphismWithGivenObjects,
                      MorphismFromTensorProductToInternalHomWithGivenObjects,
                      MorphismFromInternalHomToTensorProductWithGivenObjects,
                      IsomorphismFromTensorProductToInternalHom,
                      IsomorphismFromInternalHomToTensorProduct ],
                    
  function( object_1, object_2 )
    
    return IdentityMorphism( TensorProductOnObjects( DualOnObjects( object_1 ), object_2 ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalHomToTensorProduct as the identity of (Dual(a) tensored b)" );

## The next to derivations have the same conditions as IsomorphismFromInternalHomToTensorProduct,
## because if the InternalHom is constructed via the final derivation, these
## final derivation shall also be implemented
##
AddFinalDerivation( IsomorphismFromInternalHomToDual,
                    [ [ IdentityMorphism, 1 ],
                      [ DualOnObjects, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    [ InternalHomOnObjects,
                      InternalHomOnMorphismsWithGivenInternalHoms,
                      EvaluationMorphismWithGivenSource,
                      CoevaluationMorphismWithGivenRange,
                      TensorProductToInternalHomAdjunctionMap,
                      InternalHomToTensorProductAdjunctionMap,
                      MonoidalPreComposeMorphismWithGivenObjects,
                      MonoidalPostComposeMorphismWithGivenObjects,
                      TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                      TensorProductDualityCompatibilityMorphismWithGivenObjects,
                      MorphismFromTensorProductToInternalHomWithGivenObjects,
                      MorphismFromInternalHomToTensorProductWithGivenObjects,
                      IsomorphismFromTensorProductToInternalHom,
                      IsomorphismFromInternalHomToTensorProduct ],
                    
  function( object )
    
    return IdentityMorphism( DualOnObjects( object ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalHomToDual as the identity of the Dual" );

##
AddFinalDerivation( IsomorphismFromDualToInternalHom,
                    [ [ IdentityMorphism, 1 ],
                      [ DualOnObjects, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    [ InternalHomOnObjects,
                      InternalHomOnMorphismsWithGivenInternalHoms,
                      EvaluationMorphismWithGivenSource,
                      CoevaluationMorphismWithGivenRange,
                      TensorProductToInternalHomAdjunctionMap,
                      InternalHomToTensorProductAdjunctionMap,
                      MonoidalPreComposeMorphismWithGivenObjects,
                      MonoidalPostComposeMorphismWithGivenObjects,
                      TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                      TensorProductDualityCompatibilityMorphismWithGivenObjects,
                      MorphismFromTensorProductToInternalHomWithGivenObjects,
                      MorphismFromInternalHomToTensorProductWithGivenObjects,
                      IsomorphismFromTensorProductToInternalHom,
                      IsomorphismFromInternalHomToTensorProduct ],
                    
  function( object )
    
    return IdentityMorphism( DualOnObjects( object ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromDualToInternalHom as the identity of the Dual" );

## Final methods for Dual
AddFinalDerivation( IsomorphismFromDualToInternalHom,
                    [ [ IdentityMorphism, 1 ],
                      [ InternalHomOnObjects, 1 ],
                      [ TensorUnit, 1 ] ],
                    [ DualOnObjects,
                      DualOnMorphismsWithGivenDuals,
                      MorphismToBidualWithGivenBidual,
                      MorphismFromBidualWithGivenBidual,
                      IsomorphismFromDualToInternalHom,
                      IsomorphismFromInternalHomToDual,
                      UniversalPropertyOfDual,
                      TensorProductDualityCompatibilityMorphismWithGivenObjects,
                      EvaluationForDualWithGivenTensorProduct,
                      CoevaluationForDualWithGivenTensorProduct,
                      MorphismFromInternalHomToTensorProductWithGivenObjects,
                      MorphismFromTensorProductToInternalHomWithGivenObjects ],
                 
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return IdentityMorphism( InternalHomOnObjects( object, TensorUnit( category ) ) );
    
end : CategoryFilter := IsSymmetricMonoidalCategory,
      Description := "IsomorphismFromDualToInternalHom as the identity of Hom(a,1)" );

AddFinalDerivation( IsomorphismFromInternalHomToDual,
                    [ [ IdentityMorphism, 1 ],
                      [ InternalHomOnObjects, 1 ],
                      [ TensorUnit, 1 ] ],
                    [ DualOnObjects,
                      DualOnMorphismsWithGivenDuals,
                      MorphismToBidualWithGivenBidual,
                      MorphismFromBidualWithGivenBidual,
                      IsomorphismFromDualToInternalHom,
                      IsomorphismFromInternalHomToDual,
                      UniversalPropertyOfDual,
                      TensorProductDualityCompatibilityMorphismWithGivenObjects,
                      EvaluationForDualWithGivenTensorProduct,
                      CoevaluationForDualWithGivenTensorProduct,
                      MorphismFromInternalHomToTensorProductWithGivenObjects,
                      MorphismFromTensorProductToInternalHomWithGivenObjects ],
                 
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return IdentityMorphism( InternalHomOnObjects( object, TensorUnit( category ) ) );
    
end : CategoryFilter := IsSymmetricMonoidalCategory,
      Description := "IsomorphismFromInternalHomToDual as the identity of Hom(a,1)" );