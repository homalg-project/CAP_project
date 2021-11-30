# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( InternalHomOnObjects,
                  
  function( cat, a, b )
    
    # Source( Hom(a,b) -> a^v x b )

    return Source( IsomorphismFromInternalHomToTensorProduct( cat, a, b ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalHomOnObjects as the source of IsomorphismFromInternalHomToTensorProduct" );

##
AddDerivationToCAP( InternalHomOnObjects,
                  
  function( cat, a, b )

    # Range( a^v x b -> Hom(a,b) )
    
    return Range( IsomorphismFromTensorProductToInternalHom( cat, a, b ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalHomOnObjects as the range of IsomorphismFromTensorProductToInternalHom" );

##
AddDerivationToCAP( InternalHomOnMorphismsWithGivenInternalHoms,
                  
  function( cat, internal_hom_source, alpha, beta, internal_hom_range )
    local dual_alpha;

    # alpha: a -> a'
    # beta: b -> b'
    #
    # Hom(a',b)
    #     |
    #     |
    #     v
    # a'^v x b
    #     |
    #     | Dual(alpha) x beta
    #     v
    # a^v x b'
    #     |
    #     |
    #     v
    # Hom(a,b')
    
    dual_alpha := DualOnMorphisms( cat, alpha );
    
    return PreComposeList( cat, [
             IsomorphismFromInternalHomToTensorProduct( cat, Range( alpha ), Source( beta ) ),
             TensorProductOnMorphisms( cat, dual_alpha, beta ),
             IsomorphismFromTensorProductToInternalHom( cat, Source( alpha ), Range( beta ) )
           ] );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalHomOnMorphismsWithGivenInternalHoms using functoriality of Dual and TensorProduct" );

##
AddDerivationToCAP( MorphismFromBidualWithGivenBidual,
                  
  function( cat, a, bidual )

    # Inverse( a -> (a^v)^v )
    
    return InverseForMorphisms( cat, MorphismToBidualWithGivenBidual( cat, a, bidual ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromBidualWithGivenBidual as the inverse of MorphismToBidualWithGivenBidual" );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                  
  function( cat, a, bidual )

    # Inverse( (a^v)^v -> a )
    
    return InverseForMorphisms( cat, MorphismFromBidualWithGivenBidual( cat, a, bidual ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismToBidualWithGivenBidual as the inverse of MorphismFromBidualWithGivenBidual" );

##
AddDerivationToCAP( EvaluationMorphismWithGivenSource,
                  
  function( cat, a, b, internal_hom_tensored_a )
    local morphism;

    # Hom(a,b) x a
    #      |
    #      | Isomorphism x id_a
    #      v
    # (a^v x b) x a
    #      |
    #      | B_( Dual(a), b ) x id_a
    #      v
    # (b x a^v) x a
    #      |
    #      | α_( ( b, a^v ), a )
    #      v
    # b x (a^v x a)
    #      |
    #      | id_b x ev_a
    #      v
    #    b x 1
    #      |
    #      | ρ_b
    #      v
    #      b
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat, 
                    IsomorphismFromInternalHomToTensorProduct( cat, a, b ),
                    IdentityMorphism( cat, a ) ),
                    
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, DualOnObjects( cat, a ), b ),
                    IdentityMorphism( cat, a ) ),
                    
                  AssociatorLeftToRight( cat, b, DualOnObjects( cat, a ), a ),
                  
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, b ),
                    EvaluationForDual( cat, a ) ),
                    
                  RightUnitor( cat, b )
                ] );
      
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "EvaluationMorphismWithGivenSource using the rigidity of the monoidal category" );

##
AddDerivationToCAP( EvaluationMorphismWithGivenSource,
                    
  function( cat, a, b, internal_hom_tensored_a )
    local morphism;

    # Hom(a,b) x a
    #      |
    #      | Isomorphism x id_a
    #      v
    # a^v x b x a
    #      |
    #      | B_( Dual(a), b ) x id_a
    #      v
    # b x a^v x a
    #      |
    #      | id_b x ev_a
    #      v
    #    b x 1
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat, 
                    IsomorphismFromInternalHomToTensorProduct( cat, a, b ),
                    IdentityMorphism( cat, a ) ),
                    
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, DualOnObjects( cat, a ), b ),
                    IdentityMorphism( cat, a ) ),
                    
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, b ),
                    EvaluationForDual( cat, a ) )
                ] );
                    
    return morphism;
      
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "EvaluationMorphismWithGivenSource using the rigidity and strictness of the monoidal category" );

##
AddDerivationToCAP( CoevaluationMorphismWithGivenRange,
                    
  function( cat, a, b, internal_hom )
    local morphism, dual_b, id_a;

    #      a
    #      |
    #      | (λ_a)^-1
    #      v
    #    1 x a
    #      |
    #      | coev_b x id_a
    #      v
    # (b x b^v) x a
    #      |
    #      | B_( b, b^v ) x id_a
    #      v
    # (b^v x b) x a
    #      |
    #      | α_( ( b^v, b ), a )
    #      v
    # b^v x (b x a)
    #      |
    #      | id_(b^v) x B_( b, a )
    #      v
    # b^v x (a x b)
    #      |
    #      | Isomorphism
    #      v
    # Hom(b, a x b)
    
    dual_b := DualOnObjects( cat, b );
    
    id_a := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat, [
                  LeftUnitorInverse( cat, a ),
                    
                  TensorProductOnMorphisms( cat,
                    CoevaluationForDual( cat, b ),
                    id_a ),
                    
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, b, dual_b ),
                    id_a ),
                    
                  AssociatorLeftToRight( cat, dual_b, b, a ),
                    
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, dual_b ),
                    Braiding( cat, b, a ) ),
                    
                  IsomorphismFromTensorProductToInternalHom( cat,
                    b,
                    TensorProductOnObjects( cat, a, b ) )
                ] );
                    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "CoevaluationMorphismWithGivenRange using the rigidity of the monoidal category" );

##
AddDerivationToCAP( CoevaluationMorphismWithGivenRange,
                    
  function( cat, a, b, internal_hom )
    local morphism, dual_b, id_a;

    # 1 x a
    #   |
    #   | coev_b x id_a
    #   v
    # b x b^v x a
    #   |
    #   | B_( b, b^v ) x id_a
    #   v
    # b^v x b x a
    #   |
    #   | id_(b^v) x B_( b, a )
    #   v
    # b^v x a x b
    #   |
    #   | Isomorphism
    #   v
    # Hom(b, a x b)
    
    dual_b := DualOnObjects( cat, b );
    
    id_a := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    CoevaluationForDual( cat, b ),
                    id_a ),
                    
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, b, dual_b ),
                    id_a ),
                    
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, dual_b ),
                    Braiding( cat, b, a ) ),
                    
                  IsomorphismFromTensorProductToInternalHom( cat,
                    b,
                    TensorProductOnObjects( cat, a, b ) )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "CoevaluationMorphismWithGivenRange using the rigidity of the monoidal category" );

##
AddDerivationToCAP( MorphismFromTensorProductToInternalHomWithGivenObjects,
                  
  function( cat, tensor_object, a, b, internal_hom )
    
    return IsomorphismFromTensorProductToInternalHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromTensorProductToInternalHomWithGivenObjects using IsomorphismFromTensorProductToInternalHom" );

##
AddDerivationToCAP( MorphismFromInternalHomToTensorProductWithGivenObjects,
                  
  function( cat, tensor_object, a, b, internal_hom )
    
    return IsomorphismFromInternalHomToTensorProduct( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromInternalHomToTensorProductWithGivenObjects using IsomorphismFromInternalHomToTensorProduct" );

##
AddDerivationToCAP( IsomorphismFromInternalHomToTensorProduct,
                    
  function( cat, a, b )
    
    return MorphismFromInternalHomToTensorProduct( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalHomToTensorProduct using MorphismFromInternalHomToTensorProduct" );

##
AddDerivationToCAP( IsomorphismFromTensorProductToInternalHom,
                    
  function( cat, a, b )
    
    return MorphismFromTensorProductToInternalHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromTensorProductToInternalHom using MorphismFromTensorProductToInternalHom" );

##
AddDerivationToCAP( CoevaluationForDualWithGivenTensorProduct,
                    
  function( cat, unit, a, tensor_object )
    local morphism;

    #    1
    #    |
    #    | LambdaIntro( id_a )
    #    v
    # Hom(a,a)
    #    |
    #    | Isomorphism
    #    v
    # a^v x a
    #    |
    #    | B_( a^v, a )
    #    v
    # a x a^v
    
    morphism := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat, [
                  LambdaIntroduction( cat, morphism ),
                  IsomorphismFromInternalHomToTensorProduct( cat, a, a ),
                  Braiding( cat, DualOnObjects( cat, a ), a )
                ] );
                            
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "CoevaluationForDualWithGivenTensorProduct using LambdaIntroduction on the identity and IsomorphismFromInternalHomToTensorProduct" );

##
AddDerivationToCAP( TraceMap,
                    
  function( cat, alpha )
    local result_morphism, a;

    # alpha: a -> a
    #
    #    1
    #    |
    #    | LambdaIntro( alpha )
    #    v
    # Hom(a,a)
    #    |
    #    | Isomorphism
    #    v
    # a^v x a
    #    |
    #    | ev_a
    #    v
    #    1
    
    a := Source( alpha );
    
    result_morphism := PreComposeList( cat, [
                         LambdaIntroduction( cat, alpha ),
                         IsomorphismFromInternalHomToTensorProduct( cat, a, a ),
                         EvaluationForDual( cat, a )
                       ] );
    
    return result_morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "TraceMap using LambdaIntroduction and EvaluationForDual" );

##
AddDerivationToCAP( RankMorphism,
                    
  function( cat, a )
    
    return TraceMap( cat, IdentityMorphism( cat, a ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "Rank of an object as the trace of its identity" );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects,
                    
  function( cat, source, list, range )

    # Inverse( Hom(a,a') x Hom(b,b') -> Hom(a x b, a' x b') )
    
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
                    
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, DualOnObjects( cat, a ), b ) );
    
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
                    
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, DualOnObjects( cat, a ), b ) );
    
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
