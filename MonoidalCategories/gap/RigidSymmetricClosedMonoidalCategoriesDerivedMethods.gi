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
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalHomOnObjects as the range of IsomorphismFromTensorProductToInternalHom" );

##
AddDerivationToCAP( InternalHomOnMorphismsWithGivenInternalHoms,
                  
  function( internal_hom_source, morphism_1, morphism_2, internal_hom_range )
    local dual_morphism;
    
    dual_morphism := DualOnMorphisms( morphism_1 );
    
    return PreCompose( [
             IsomorphismFromInternalHomToTensorProduct( Range( morphism_1 ), Source( morphism_2 ) ),
             TensorProductOnMorphisms( dual_morphism, morphism_2 ),
             IsomorphismFromTensorProductToInternalHom( Source( morphism_1 ), Range( morphism_2 ) )
           ] );
    
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
    
    morphism := PreCompose( [
                  TensorProductOnMorphisms( 
                    IsomorphismFromInternalHomToTensorProduct( object_1, object_2 ),
                    IdentityMorphism( object_1 ) ),
                    
                  TensorProductOnMorphisms(
                    Braiding( DualOnObjects( object_1 ), object_2 ),
                    IdentityMorphism( object_1 ) ),
                    
                  AssociatorLeftToRight( object_2, DualOnObjects( object_1 ), object_1 ),
                  
                  TensorProductOnMorphisms(
                    IdentityMorphism( object_2 ),
                    EvaluationForDual( object_1 ) ),
                    
                  RightUnitor( object_2 )
                ] );
      
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "EvaluationMorphismWithGivenSource using the rigidity of the monoidal category" );

##
AddDerivationToCAP( EvaluationMorphismWithGivenSource,
                    
  function( object_1, object_2, internal_hom_tensored_object_1 )
    local morphism;
    
    morphism := PreCompose( [
                  TensorProductOnMorphisms( 
                    IsomorphismFromInternalHomToTensorProduct( object_1, object_2 ),
                    IdentityMorphism( object_1 ) ),
                    
                  TensorProductOnMorphisms(
                    Braiding( DualOnObjects( object_1 ), object_2 ),
                    IdentityMorphism( object_1 ) ),
                    
                  TensorProductOnMorphisms(
                    IdentityMorphism( object_2 ),
                    EvaluationForDual( object_1 ) )
                ] );
                    
    return morphism;
      
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "EvaluationMorphismWithGivenSource using the rigidity and strictness of the monoidal category" );

##
AddDerivationToCAP( CoevaluationMorphismWithGivenRange,
                    
  function( object_1, object_2, internal_hom )
    local morphism, dual_2, id_1;
    
    dual_2 := DualOnObjects( object_2 );
    
    id_1 := IdentityMorphism( object_1 );
    
    morphism := PreCompose( [
                  LeftUnitorInverse( object_1 ),
                    
                  TensorProductOnMorphisms(
                    CoevaluationForDual( object_2 ),
                    id_1 ),
                    
                  TensorProductOnMorphisms(
                    Braiding( object_2, dual_2 ),
                    id_1 ),
                    
                  AssociatorLeftToRight( dual_2, object_2, object_1 ),
                    
                  TensorProductOnMorphisms(
                    IdentityMorphism( dual_2 ),
                    Braiding( object_2, object_1 ) ),
                    
                  IsomorphismFromTensorProductToInternalHom(
                    object_2,
                    TensorProductOnObjects( object_1, object_2 ) )
                ] );
                    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "CoevaluationMorphismWithGivenRange using the rigidity of the monoidal category" );

##
AddDerivationToCAP( CoevaluationMorphismWithGivenRange,
                    
  function( object_1, object_2, internal_hom )
    local morphism, dual_2, id_1;
    
    dual_2 := DualOnObjects( object_2 );
    
    id_1 := IdentityMorphism( object_1 );
    
    morphism := PreCompose( [
                  TensorProductOnMorphisms(
                    CoevaluationForDual( object_2 ),
                    id_1 ),
                    
                  TensorProductOnMorphisms(
                    Braiding( object_2, dual_2 ),
                    id_1 ),
                    
                  TensorProductOnMorphisms(
                    IdentityMorphism( dual_2 ),
                    Braiding( object_2, object_1 ) ),
                    
                  IsomorphismFromTensorProductToInternalHom(
                    object_2,
                    TensorProductOnObjects( object_1, object_2 ) )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "CoevaluationMorphismWithGivenRange using the rigidity of the monoidal category" );

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
AddDerivationToCAP( CoevaluationForDualWithGivenTensorProduct,
                    
  function( unit, object, tensor_object )
    local morphism;
    
    morphism := IdentityMorphism( object );
    
    morphism := PreCompose( [
                  LambdaIntroduction( morphism ),
                  IsomorphismFromInternalHomToTensorProduct( object, object ),
                  Braiding( DualOnObjects( object ), object )
                ] );
                            
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "CoevaluationForDualWithGivenTensorProduct using LambdaIntroduction on the identity and IsomorphismFromInternalHomToTensorProduct" );

##
AddDerivationToCAP( TraceMap,
                    
  function( morphism )
    local result_morphism, object;
    
    object := Source( morphism );
    
    result_morphism := PreCompose( [
                         LambdaIntroduction( morphism ),
                         IsomorphismFromInternalHomToTensorProduct( object, object ),
                         EvaluationForDual( object )
                       ] );
    
    return result_morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "TraceMap using LambdaIntroduction and EvaluationForDual" );

##
AddDerivationToCAP( RankMorphism,
                    
  function( object )
    
    return TraceMap( IdentityMorphism( object ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "Rank of an object as the trace of its identity" );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects,
                    
  function( a1, a2, b1, b2, new_source_and_range_list )
    
    return Inverse( TensorProductInternalHomCompatibilityMorphismWithGivenObjects( a1, a2, b1, b2, new_source_and_range_list ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects as the inverse of TensorProductInternalHomCompatibilityMorphismWithGivenObjects" );

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
