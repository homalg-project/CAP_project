# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( InternalHomOnObjects,
                  
  function( cat, object_1, object_2 )
    
    return Source( IsomorphismFromInternalHomToTensorProduct( cat, object_1, object_2 ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalHomOnObjects as the source of IsomorphismFromInternalHomToTensorProduct" );

##
AddDerivationToCAP( InternalHomOnObjects,
                  
  function( cat, object_1, object_2 )
    
    return Range( IsomorphismFromTensorProductToInternalHom( cat, object_1, object_2 ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalHomOnObjects as the range of IsomorphismFromTensorProductToInternalHom" );

##
AddDerivationToCAP( InternalHomOnMorphismsWithGivenInternalHoms,
                  
  function( cat, internal_hom_source, morphism_1, morphism_2, internal_hom_range )
    local dual_morphism;
    
    dual_morphism := DualOnMorphisms( cat, morphism_1 );
    
    return PreComposeList( cat, [
             IsomorphismFromInternalHomToTensorProduct( cat, Range( morphism_1 ), Source( morphism_2 ) ),
             TensorProductOnMorphisms( cat, dual_morphism, morphism_2 ),
             IsomorphismFromTensorProductToInternalHom( cat, Source( morphism_1 ), Range( morphism_2 ) )
           ] );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalHomOnMorphismsWithGivenInternalHoms using functoriality of Dual and TensorProduct" );

##
AddDerivationToCAP( MorphismFromBidualWithGivenBidual,
                  
  function( cat, object, bidual )
    
    return InverseForMorphisms( cat, MorphismToBidualWithGivenBidual( cat, object, bidual ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromBidualWithGivenBidual as the inverse of MorphismToBidualWithGivenBidual" );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                  
  function( cat, object, bidual )
    
    return InverseForMorphisms( cat, MorphismFromBidualWithGivenBidual( cat, object, bidual ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismToBidualWithGivenBidual as the inverse of MorphismFromBidualWithGivenBidual" );

##
AddDerivationToCAP( EvaluationMorphismWithGivenSource,
                  
  function( cat, object_1, object_2, internal_hom_tensored_object_1 )
    local morphism;
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat, 
                    IsomorphismFromInternalHomToTensorProduct( cat, object_1, object_2 ),
                    IdentityMorphism( cat, object_1 ) ),
                    
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, DualOnObjects( cat, object_1 ), object_2 ),
                    IdentityMorphism( cat, object_1 ) ),
                    
                  AssociatorLeftToRight( cat, object_2, DualOnObjects( cat, object_1 ), object_1 ),
                  
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, object_2 ),
                    EvaluationForDual( cat, object_1 ) ),
                    
                  RightUnitor( cat, object_2 )
                ] );
      
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "EvaluationMorphismWithGivenSource using the rigidity of the monoidal category" );

##
AddDerivationToCAP( EvaluationMorphismWithGivenSource,
                    
  function( cat, object_1, object_2, internal_hom_tensored_object_1 )
    local morphism;
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat, 
                    IsomorphismFromInternalHomToTensorProduct( cat, object_1, object_2 ),
                    IdentityMorphism( cat, object_1 ) ),
                    
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, DualOnObjects( cat, object_1 ), object_2 ),
                    IdentityMorphism( cat, object_1 ) ),
                    
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, object_2 ),
                    EvaluationForDual( cat, object_1 ) )
                ] );
                    
    return morphism;
      
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "EvaluationMorphismWithGivenSource using the rigidity and strictness of the monoidal category" );

##
AddDerivationToCAP( CoevaluationMorphismWithGivenRange,
                    
  function( cat, object_1, object_2, internal_hom )
    local morphism, dual_2, id_1;
    
    dual_2 := DualOnObjects( cat, object_2 );
    
    id_1 := IdentityMorphism( cat, object_1 );
    
    morphism := PreComposeList( cat, [
                  LeftUnitorInverse( cat, object_1 ),
                    
                  TensorProductOnMorphisms( cat,
                    CoevaluationForDual( cat, object_2 ),
                    id_1 ),
                    
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, object_2, dual_2 ),
                    id_1 ),
                    
                  AssociatorLeftToRight( cat, dual_2, object_2, object_1 ),
                    
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, dual_2 ),
                    Braiding( cat, object_2, object_1 ) ),
                    
                  IsomorphismFromTensorProductToInternalHom( cat,
                    object_2,
                    TensorProductOnObjects( cat, object_1, object_2 ) )
                ] );
                    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "CoevaluationMorphismWithGivenRange using the rigidity of the monoidal category" );

##
AddDerivationToCAP( CoevaluationMorphismWithGivenRange,
                    
  function( cat, object_1, object_2, internal_hom )
    local morphism, dual_2, id_1;
    
    dual_2 := DualOnObjects( cat, object_2 );
    
    id_1 := IdentityMorphism( cat, object_1 );
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    CoevaluationForDual( cat, object_2 ),
                    id_1 ),
                    
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, object_2, dual_2 ),
                    id_1 ),
                    
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, dual_2 ),
                    Braiding( cat, object_2, object_1 ) ),
                    
                  IsomorphismFromTensorProductToInternalHom( cat,
                    object_2,
                    TensorProductOnObjects( cat, object_1, object_2 ) )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "CoevaluationMorphismWithGivenRange using the rigidity of the monoidal category" );

##
AddDerivationToCAP( MorphismFromTensorProductToInternalHomWithGivenObjects,
                  
  function( cat, tensor_object, object_1, object_2, internal_hom )
    
    return IsomorphismFromTensorProductToInternalHom( cat, object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromTensorProductToInternalHomWithGivenObjects using IsomorphismFromTensorProductToInternalHom" );

##
AddDerivationToCAP( MorphismFromInternalHomToTensorProductWithGivenObjects,
                  
  function( cat, tensor_object, object_1, object_2, internal_hom )
    
    return IsomorphismFromInternalHomToTensorProduct( cat, object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromInternalHomToTensorProductWithGivenObjects using IsomorphismFromInternalHomToTensorProduct" );

##
AddDerivationToCAP( IsomorphismFromInternalHomToTensorProduct,
                    
  function( cat, object_1, object_2 )
    
    return MorphismFromInternalHomToTensorProduct( cat, object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalHomToTensorProduct using MorphismFromInternalHomToTensorProduct" );

##
AddDerivationToCAP( IsomorphismFromTensorProductToInternalHom,
                    
  function( cat, object_1, object_2 )
    
    return MorphismFromTensorProductToInternalHom( cat, object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromTensorProductToInternalHom using MorphismFromTensorProductToInternalHom" );

##
AddDerivationToCAP( CoevaluationForDualWithGivenTensorProduct,
                    
  function( cat, unit, object, tensor_object )
    local morphism;
    
    morphism := IdentityMorphism( cat, object );
    
    morphism := PreComposeList( cat, [
                  LambdaIntroduction( cat, morphism ),
                  IsomorphismFromInternalHomToTensorProduct( cat, object, object ),
                  Braiding( cat, DualOnObjects( cat, object ), object )
                ] );
                            
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "CoevaluationForDualWithGivenTensorProduct using LambdaIntroduction on the identity and IsomorphismFromInternalHomToTensorProduct" );

##
AddDerivationToCAP( TraceMap,
                    
  function( cat, morphism )
    local result_morphism, object;
    
    object := Source( morphism );
    
    result_morphism := PreComposeList( cat, [
                         LambdaIntroduction( cat, morphism ),
                         IsomorphismFromInternalHomToTensorProduct( cat, object, object ),
                         EvaluationForDual( cat, object )
                       ] );
    
    return result_morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "TraceMap using LambdaIntroduction and EvaluationForDual" );

##
AddDerivationToCAP( RankMorphism,
                    
  function( cat, object )
    
    return TraceMap( cat, IdentityMorphism( cat, object ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "Rank of an object as the trace of its identity" );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects,
                    
  function( cat, source, list, range )
    
    return InverseForMorphisms( cat, TensorProductInternalHomCompatibilityMorphismWithGivenObjects( cat, source, list, range ) );
    
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
                    
  function( cat, object_1, object_2 )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, DualOnObjects( cat, object_1 ), object_2 ) );
    
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
                    
  function( cat, object_1, object_2 )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, DualOnObjects( cat, object_1 ), object_2 ) );
    
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
                    
  function( cat, object )
    
    return IdentityMorphism( cat, DualOnObjects( cat, object ) );
    
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
                    
  function( cat, object )
    
    return IdentityMorphism( cat, DualOnObjects( cat, object ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromDualToInternalHom as the identity of the Dual" );
