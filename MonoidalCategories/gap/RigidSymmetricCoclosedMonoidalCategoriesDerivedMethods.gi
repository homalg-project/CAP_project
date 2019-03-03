##
AddDerivationToCAP( InternalCoHomOnObjects,
                  
  function( object_1, object_2 )
    
    return Source( IsomorphismFromInternalCoHomToTensorProduct( object_1, object_2 ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomOnObjects as the source of IsomorphismFromInternalCoHomToTensorProduct" );

##
AddDerivationToCAP( InternalCoHomOnObjects,
                  
  function( object_1, object_2 )
    
    return Range( IsomorphismFromTensorProductToInternalCoHom( object_1, object_2 ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalCoHomOnObjects as the range of IsomorphismFromTensorProductToInternalCoHom" );

##
AddDerivationToCAP( InternalCoHomOnMorphismsWithGivenInternalCoHoms,
                  
  function( internal_cohom_source, morphism_1, morphism_2, internal_cohom_range )
    local codual_morphism;
    
    codual_morphism := CoDualOnMorphisms( morphism_2 );
    
    return PreCompose( [
             IsomorphismFromInternalCoHomToTensorProduct( Source( morphism_1 ), Range( morphism_2 ) ),
             TensorProductOnMorphisms( morphism_1, codual_morphism ),
             IsomorphismFromTensorProductToInternalCoHom( Range( morphism_1 ), Source( morphism_2 ) ) 
           ] );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomOnMorphismsWithGivenInternalCoHoms using functoriality of CoDual and TensorProduct" );

##
AddDerivationToCAP( MorphismToCoBidualWithGivenCoBidual,
                  
  function( object, cobidual )
    
    return Inverse( MorphismFromCoBidualWithGivenCoBidual( object, cobidual ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "MorphismToCoBidualWithGivenCoBidual as the inverse of MorphismFromCoBidualWithGivenCoBidual" );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,
                  
  function( object, cobidual )
    
    return Inverse( MorphismToCoBidualWithGivenCoBidual( object, cobidual ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "MorphismFromCoBidualWithGivenCoBidual as the inverse of MorphismToCoBidualWithGivenCoBidual" );

##
AddDerivationToCAP( CoEvaluationMorphismWithGivenRange,
                  
  function( object_1, object_2, object_2_tensored_internal_cohom )
    local morphism;
    
    morphism := PreCompose( [
                  LeftUnitorInverse( object_1 ),
                  
                  TensorProductOnMorphisms(
                    CoEvaluationForCoDual( object_2 ),
                    IdentityMorphism( object_1 ) ),
                  
                  AssociatorLeftToRight( object_2, CoDualOnObjects( object_2 ), object_1 ),
                  
                  TensorProductOnMorphisms(
                    IdentityMorphism( object_2 ),
                    Braiding( CoDualOnObjects( object_2 ), object_1 ) ),
                  
                  TensorProductOnMorphisms( 
                    IdentityMorphism( object_2 ),
                    IsomorphismFromTensorProductToInternalCoHom( object_1, object_2 ) ) 
                ] );
                    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "CoEvaluationMorphismWithGivenRange using the rigidity of the monoidal category" );

##
AddDerivationToCAP( CoEvaluationMorphismWithGivenRange,
                    
  function( object_1, object_2, object_2_tensored_internal_cohom )
    local morphism;
    
    morphism := PreCompose( [
                  TensorProductOnMorphisms(
                    CoEvaluationForCoDual( object_2 ),
                    IdentityMorphism( object_1 ) ),
                  
                  TensorProductOnMorphisms(
                    IdentityMorphism( object_2 ),
                    Braiding( CoDualOnObjects( object_2 ), object_1 ) ),
                  
                  TensorProductOnMorphisms( 
                    IdentityMorphism( object_2 ),
                    IsomorphismFromTensorProductToInternalCoHom( object_1, object_2 ) ) 
                ] );
                    
    return morphism;
      
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "CoEvaluationMorphismWithGivenRange using the rigidity and strictness of the monoidal category" );

##
AddDerivationToCAP( DualCoEvaluationMorphismWithGivenSource,
                    
  function( object_1, object_2, internal_cohom )
    local morphism, codual_1, id_2;
    
    codual_1 := CoDualOnObjects( object_1 );
    
    id_2 := IdentityMorphism( object_2 );
    
    morphism := PreCompose( [
                  IsomorphismFromInternalCoHomToTensorProduct(
                    TensorProductOnObjects( object_1, object_2 ),
                    object_1),
                    
                  TensorProductOnMorphisms(
                    Braiding( object_1, object_2 ),
                    IdentityMorphism( codual_1 ) ),
                    
                  AssociatorLeftToRight( object_2, object_1, codual_1 ),
                    
                  TensorProductOnMorphisms(
                    id_2,
                    Braiding( object_1, codual_1 ) ),
                    
                  TensorProductOnMorphisms(
                    id_2,
                    DualCoEvaluationForCoDual( object_1 ) ),
                    
                  RightUnitor( object_2 ) 
                ] );
                    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "DualCoEvaluationMorphismWithGivenSource using the rigidity of the monoidal category" );

##
AddDerivationToCAP( DualCoEvaluationMorphismWithGivenSource,
                    
  function( object_1, object_2, internal_cohom )
    local morphism, codual_1, id_2;
    
    codual_1 := CoDualOnObjects( object_1 );
    
    id_2 := IdentityMorphism( object_2 );
    
    morphism := PreCompose( [
                  IsomorphismFromInternalCoHomToTensorProduct(
                    TensorProductOnObjects( object_1, object_2 ),
                    object_1),
                    
                  TensorProductOnMorphisms(
                    Braiding( object_1, object_2 ),
                    IdentityMorphism( codual_1 ) ),
                    
                  TensorProductOnMorphisms(
                    id_2,
                    Braiding( object_1, codual_1 ) ),
                    
                  TensorProductOnMorphisms(
                    id_2,
                    DualCoEvaluationForCoDual( object_1 ) ) 
                ] );
                    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "DualCoEvaluationMorphismWithGivenSource using the rigidity of the monoidal category" );

##
AddDerivationToCAP( MorphismFromInternalCoHomToTensorProductWithGivenObjects,
                  
  function( internal_cohom, object_1, object_2, tensor_object )
    
    return IsomorphismFromInternalCoHomToTensorProduct( object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromInternalCoHomToTensorProductWithGivenObjects using IsomorphismFromInternalCoHomToTensorProduct" );


##
AddDerivationToCAP( MorphismFromTensorProductToInternalCoHomWithGivenObjects,
                  
  function( tensor_object, object_1, object_2, internal_hom )
    
    return IsomorphismFromTensorProductToInternalCoHom( object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromTensorProductToInternalCoHomWithGivenObjects using IsomorphismFromTensorProductToInternalCoHom" );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToTensorProduct,
                    
  function( object_1, object_2 )
    
    return MorphismFromInternalCoHomToTensorProduct( object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalCoHomToTensorProduct using MorphismFromInternalCoHomToTensorProduct" );

##
AddDerivationToCAP( IsomorphismFromTensorProductToInternalCoHom,
                    
  function( object_1, object_2 )
    
    return MorphismFromTensorProductToInternalCoHom( object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromTensorProductToInternalCoHom using MorphismFromTensorProductToInternalCoHom" );

AddDerivationToCAP( DualCoEvaluationForCoDualWithGivenTensorProduct,
                    
  function( tensor_object, object, unit )
    local morphism;
    
    morphism := IdentityMorphism( object );
    
    morphism := PreCompose( [
                  Braiding( CoDualOnObjects( object ), object ),
                  IsomorphismFromTensorProductToInternalCoHom( object, object ),
                  CoLambdaIntroduction( morphism ) 
                ] );
                            
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "DualCoEvaluationForCoDualWithGivenTensorProduct using CoLambdaIntroduction on the identity and IsomorphismFromTensorProductToInternalCoHom" );

##
AddDerivationToCAP( CoTraceMap,
                    
  function( morphism )
    local object;
    
    object := Source( morphism );
    
    return PreCompose( [
             CoEvaluationForCoDual( object ) ,
             IsomorphismFromTensorProductToInternalCoHom( object, object ),
             CoLambdaIntroduction( morphism )
           ] );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "CoTraceMap using CoEvaluationForCoDual and CoLambdaIntroduction" );

##
AddDerivationToCAP( CoRankMorphism,
                    
  function( object )
    
    return CoTraceMap( IdentityMorphism( object ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "Corank of an object as the cotrace of its identity" );

##
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects,
                    
  function( a1, a2, b1, b2, new_source_and_range_list )
    
    return Inverse( InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects( a1, a2, b1, b2, new_source_and_range_list ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects as the inverse of TensorProductInternalCoHomCompatibilityMorphismWithGivenObjects" );

####################################
## Final derived methods
####################################

## Final methods for InternalCoHom

##
AddFinalDerivation( IsomorphismFromTensorProductToInternalCoHom,
                    [ [ IdentityMorphism, 1 ],
                      [ CoDualOnObjects, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    [ InternalCoHomOnObjects,
                      InternalCoHomOnMorphismsWithGivenInternalCoHoms,
                      CoEvaluationMorphismWithGivenRange,
                      DualCoEvaluationMorphismWithGivenSource,
                      TensorProductToInternalCoHomAdjunctionMap,
                      InternalCoHomToTensorProductAdjunctionMap,
                      MonoidalPreCoComposeMorphismWithGivenObjects,
                      MonoidalPostCoComposeMorphismWithGivenObjects,
                      InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                      CoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                      MorphismFromTensorProductToInternalCoHomWithGivenObjects,
                      MorphismFromInternalCoHomToTensorProductWithGivenObjects,
                      IsomorphismFromTensorProductToInternalCoHom,
                      IsomorphismFromInternalCoHomToTensorProduct ],
                    
  function( object_1, object_2 )
    
    return IdentityMorphism( TensorProductOnObjects( object_1, CoDualOnObjects( object_2 ) ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromTensorProductToInternalCoHom as the identity of (a tensored CoDual(b))" );

##
AddFinalDerivation( IsomorphismFromInternalCoHomToTensorProduct,
                    [ [ IdentityMorphism, 1 ],
                      [ CoDualOnObjects, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    [ InternalCoHomOnObjects,
                      InternalCoHomOnMorphismsWithGivenInternalCoHoms,
                      CoEvaluationMorphismWithGivenRange,
                      DualCoEvaluationMorphismWithGivenSource,
                      TensorProductToInternalCoHomAdjunctionMap,
                      InternalCoHomToTensorProductAdjunctionMap,
                      MonoidalPreCoComposeMorphismWithGivenObjects,
                      MonoidalPostCoComposeMorphismWithGivenObjects,
                      InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                      CoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                      MorphismFromTensorProductToInternalCoHomWithGivenObjects,
                      MorphismFromInternalCoHomToTensorProductWithGivenObjects,
                      IsomorphismFromTensorProductToInternalCoHom,
                      IsomorphismFromInternalCoHomToTensorProduct ],
                    
  function( object_1, object_2 )
    
    return IdentityMorphism( TensorProductOnObjects( object_1, CoDualOnObjects( object_2 ) ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromInternalCoHomToTensorProduct as the identity of (a tensored CoDual(b))" );

## The next to derivations have the same conditions as IsomorphismFromInternalHomToTensorProduct,
## because if the InternalHom is constructed via the final derivation, these
## final derivation shall also be implemented
##
AddFinalDerivation( IsomorphismFromInternalCoHomToCoDual,
                    [ [ IdentityMorphism, 1 ],
                      [ CoDualOnObjects, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    [ InternalCoHomOnObjects,
                      InternalCoHomOnMorphismsWithGivenInternalCoHoms,
                      CoEvaluationMorphismWithGivenRange,
                      DualCoEvaluationMorphismWithGivenSource,
                      TensorProductToInternalCoHomAdjunctionMap,
                      InternalCoHomToTensorProductAdjunctionMap,
                      MonoidalPreCoComposeMorphismWithGivenObjects,
                      MonoidalPostCoComposeMorphismWithGivenObjects,
                      InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                      CoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                      MorphismFromTensorProductToInternalCoHomWithGivenObjects,
                      MorphismFromInternalCoHomToTensorProductWithGivenObjects,
                      IsomorphismFromTensorProductToInternalCoHom,
                      IsomorphismFromInternalCoHomToTensorProduct ],
                    
  function( object )
    
    return IdentityMorphism( CoDualOnObjects( object ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromInternalCoHomToCoDual as the identity of the CoDual" );
      
##
AddFinalDerivation( IsomorphismFromCoDualToInternalCoHom,
                    [ [ IdentityMorphism, 1 ],
                      [ CoDualOnObjects, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    [ InternalCoHomOnObjects,
                      InternalCoHomOnMorphismsWithGivenInternalCoHoms,
                      CoEvaluationMorphismWithGivenRange,
                      DualCoEvaluationMorphismWithGivenSource,
                      TensorProductToInternalCoHomAdjunctionMap,
                      InternalCoHomToTensorProductAdjunctionMap,
                      MonoidalPreCoComposeMorphismWithGivenObjects,
                      MonoidalPostCoComposeMorphismWithGivenObjects,
                      InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                      CoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                      MorphismFromTensorProductToInternalCoHomWithGivenObjects,
                      MorphismFromInternalCoHomToTensorProductWithGivenObjects,
                      IsomorphismFromTensorProductToInternalCoHom,
                      IsomorphismFromInternalCoHomToTensorProduct ],
                    
  function( object )
    
    return IdentityMorphism( CoDualOnObjects( object ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromCoDualToInternalCoHom as the identity of the CoDual" );
