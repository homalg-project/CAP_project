##
AddDerivationToCAP( InternalCoHomOnObjects,
                  
  function( cat, object_1, object_2 )
    
    return Source( IsomorphismFromInternalCoHomToTensorProduct( object_1, object_2 ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomOnObjects as the source of IsomorphismFromInternalCoHomToTensorProduct" );

##
AddDerivationToCAP( InternalCoHomOnObjects,
                  
  function( cat, object_1, object_2 )
    
    return Range( IsomorphismFromTensorProductToInternalCoHom( object_1, object_2 ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalCoHomOnObjects as the range of IsomorphismFromTensorProductToInternalCoHom" );

##
AddDerivationToCAP( InternalCoHomOnMorphismsWithGivenInternalCoHoms,
                  
  function( cat, internal_cohom_source, morphism_1, morphism_2, internal_cohom_range )
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
                  
  function( cat, object, cobidual )
    
    return Inverse( MorphismFromCoBidualWithGivenCoBidual( object, cobidual ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "MorphismToCoBidualWithGivenCoBidual as the inverse of MorphismFromCoBidualWithGivenCoBidual" );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,
                  
  function( cat, object, cobidual )
    
    return Inverse( MorphismToCoBidualWithGivenCoBidual( object, cobidual ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "MorphismFromCoBidualWithGivenCoBidual as the inverse of MorphismToCoBidualWithGivenCoBidual" );

##
AddDerivationToCAP( CoclosedEvaluationMorphismWithGivenRange,
                  
  function( cat, object_1, object_2, object_2_tensored_internal_cohom )
    local morphism;
    
    morphism := PreCompose( [
                  LeftUnitorInverse( object_1 ),
                  
                  TensorProductOnMorphisms(
                    CoclosedEvaluationForCoDual( object_2 ),
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
      Description := "CoclosedEvaluationMorphismWithGivenRange using the rigidity of the monoidal category" );

##
AddDerivationToCAP( CoclosedEvaluationMorphismWithGivenRange,
                    
  function( cat, object_1, object_2, object_2_tensored_internal_cohom )
    local morphism;
    
    morphism := PreCompose( [
                  TensorProductOnMorphisms(
                    CoclosedEvaluationForCoDual( object_2 ),
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
      Description := "CoclosedEvaluationMorphismWithGivenRange using the rigidity and strictness of the monoidal category" );

##
AddDerivationToCAP( CoclosedCoevaluationMorphismWithGivenSource,
                    
  function( cat, object_1, object_2, internal_cohom )
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
                    CoclosedCoevaluationForCoDual( object_1 ) ),
                    
                  RightUnitor( object_2 ) 
                ] );
                    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "CoclosedCoevaluationMorphismWithGivenSource using the rigidity of the monoidal category" );

##
AddDerivationToCAP( CoclosedCoevaluationMorphismWithGivenSource,
                    
  function( cat, object_1, object_2, internal_cohom )
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
                    CoclosedCoevaluationForCoDual( object_1 ) ) 
                ] );
                    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "CoclosedCoevaluationMorphismWithGivenSource using the rigidity of the monoidal category" );

##
AddDerivationToCAP( MorphismFromInternalCoHomToTensorProductWithGivenObjects,
                  
  function( cat, internal_cohom, object_1, object_2, tensor_object )
    
    return IsomorphismFromInternalCoHomToTensorProduct( object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromInternalCoHomToTensorProductWithGivenObjects using IsomorphismFromInternalCoHomToTensorProduct" );


##
AddDerivationToCAP( MorphismFromTensorProductToInternalCoHomWithGivenObjects,
                  
  function( cat, tensor_object, object_1, object_2, internal_hom )
    
    return IsomorphismFromTensorProductToInternalCoHom( object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromTensorProductToInternalCoHomWithGivenObjects using IsomorphismFromTensorProductToInternalCoHom" );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToTensorProduct,
                    
  function( cat, object_1, object_2 )
    
    return MorphismFromInternalCoHomToTensorProduct( object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalCoHomToTensorProduct using MorphismFromInternalCoHomToTensorProduct" );

##
AddDerivationToCAP( IsomorphismFromTensorProductToInternalCoHom,
                    
  function( cat, object_1, object_2 )
    
    return MorphismFromTensorProductToInternalCoHom( object_1, object_2 );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromTensorProductToInternalCoHom using MorphismFromTensorProductToInternalCoHom" );

AddDerivationToCAP( CoclosedCoevaluationForCoDualWithGivenTensorProduct,
                    
  function( cat, tensor_object, object, unit )
    local morphism;
    
    morphism := IdentityMorphism( object );
    
    morphism := PreCompose( [
                  Braiding( CoDualOnObjects( object ), object ),
                  IsomorphismFromTensorProductToInternalCoHom( object, object ),
                  CoLambdaIntroduction( morphism ) 
                ] );
                            
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "CoclosedCoevaluationForCoDualWithGivenTensorProduct using CoLambdaIntroduction on the identity and IsomorphismFromTensorProductToInternalCoHom" );

##
AddDerivationToCAP( CoTraceMap,
                    
  function( cat, morphism )
    local object;
    
    object := Source( morphism );
    
    return PreCompose( [
             CoclosedEvaluationForCoDual( object ) ,
             IsomorphismFromTensorProductToInternalCoHom( object, object ),
             CoLambdaIntroduction( morphism )
           ] );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "CoTraceMap using CoclosedEvaluationForCoDual and CoLambdaIntroduction" );

##
AddDerivationToCAP( CoRankMorphism,
                    
  function( cat, object )
    
    return CoTraceMap( IdentityMorphism( object ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "Corank of an object as the cotrace of its identity" );

##
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects,
                    
  function( cat, source, list, range )
    
    return Inverse( InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects( source, list, range ) );
    
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
                      CoclosedEvaluationMorphismWithGivenRange,
                      CoclosedCoevaluationMorphismWithGivenSource,
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
                    
  function( cat, object_1, object_2 )
    
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
                      CoclosedEvaluationMorphismWithGivenRange,
                      CoclosedCoevaluationMorphismWithGivenSource,
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
                    
  function( cat, object_1, object_2 )
    
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
                      CoclosedEvaluationMorphismWithGivenRange,
                      CoclosedCoevaluationMorphismWithGivenSource,
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
                    
  function( cat, object )
    
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
                      CoclosedEvaluationMorphismWithGivenRange,
                      CoclosedCoevaluationMorphismWithGivenSource,
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
                    
  function( cat, object )
    
    return IdentityMorphism( CoDualOnObjects( object ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromCoDualToInternalCoHom as the identity of the CoDual" );
