# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( InternalHomOnObjects,
                  
  function( cat, a, b )
    
    # Source( Hom(a,b) → a^v ⊗ b )

    return Source( IsomorphismFromInternalHomToTensorProductWithDualObject( cat, a, b ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalHomOnObjects as the source of IsomorphismFromInternalHomToTensorProductWithDualObject" );

##
AddDerivationToCAP( InternalHomOnObjects,
                  
  function( cat, a, b )

    # Range( a^v ⊗ b → Hom(a,b) )
    
    return Range( IsomorphismFromTensorProductWithDualObjectToInternalHom( cat, a, b ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalHomOnObjects as the range of IsomorphismFromTensorProductWithDualObjectToInternalHom" );

##
AddDerivationToCAP( InternalHomOnMorphismsWithGivenInternalHoms,
                  
  function( cat, internal_hom_source, alpha, beta, internal_hom_range )
    local dual_alpha;

    # alpha: a → a'
    # beta: b → b'
    #
    # Hom(a',b)
    #     |
    #     |
    #     v
    # a'^v ⊗ b
    #     |
    #     | Dual(alpha) ⊗ beta
    #     v
    # a^v ⊗ b'
    #     |
    #     |
    #     v
    # Hom(a,b')
    
    dual_alpha := DualOnMorphisms( cat, alpha );
    
    return PreComposeList( cat, [
             IsomorphismFromInternalHomToTensorProductWithDualObject( cat, Range( alpha ), Source( beta ) ),
             TensorProductOnMorphisms( cat, dual_alpha, beta ),
             IsomorphismFromTensorProductWithDualObjectToInternalHom( cat, Source( alpha ), Range( beta ) )
           ] );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalHomOnMorphismsWithGivenInternalHoms using functoriality of Dual and TensorProduct" );

##
AddDerivationToCAP( MorphismFromBidualWithGivenBidual,
                  
  function( cat, a, bidual )

    # Inverse( a → (a^v)^v )
    
    return InverseForMorphisms( cat, MorphismToBidualWithGivenBidual( cat, a, bidual ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromBidualWithGivenBidual as the inverse of MorphismToBidualWithGivenBidual" );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                  
  function( cat, a, bidual )

    # Inverse( (a^v)^v → a )
    
    return InverseForMorphisms( cat, MorphismFromBidualWithGivenBidual( cat, a, bidual ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismToBidualWithGivenBidual as the inverse of MorphismFromBidualWithGivenBidual" );

##
AddDerivationToCAP( EvaluationMorphismWithGivenSource,
                  
  function( cat, a, b, internal_hom_tensored_a )
    local morphism;

    # Hom(a,b) ⊗ a
    #      |
    #      | Isomorphism ⊗ id_a
    #      v
    # (a^v ⊗ b) ⊗ a
    #      |
    #      | B_( Dual(a), b ) ⊗ id_a
    #      v
    # (b ⊗ a^v) ⊗ a
    #      |
    #      | α_( ( b, a^v ), a )
    #      v
    # b ⊗ (a^v ⊗ a)
    #      |
    #      | id_b ⊗ ev_a
    #      v
    #    b ⊗ 1
    #      |
    #      | ρ_b
    #      v
    #      b
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat, 
                    IsomorphismFromInternalHomToTensorProductWithDualObject( cat, a, b ),
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

    # Hom(a,b) ⊗ a
    #      |
    #      | Isomorphism ⊗ id_a
    #      v
    # a^v ⊗ b ⊗ a
    #      |
    #      | B_( Dual(a), b ) ⊗ id_a
    #      v
    # b ⊗ a^v ⊗ a
    #      |
    #      | id_b ⊗ ev_a
    #      v
    #    b ⊗ 1
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat, 
                    IsomorphismFromInternalHomToTensorProductWithDualObject( cat, a, b ),
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
    #    1 ⊗ a
    #      |
    #      | coev_b ⊗ id_a
    #      v
    # (b ⊗ b^v) ⊗ a
    #      |
    #      | B_( b, b^v ) ⊗ id_a
    #      v
    # (b^v ⊗ b) ⊗ a
    #      |
    #      | α_( ( b^v, b ), a )
    #      v
    # b^v ⊗ (b ⊗ a)
    #      |
    #      | id_(b^v) ⊗ B_( b, a )
    #      v
    # b^v ⊗ (a ⊗ b)
    #      |
    #      | Isomorphism
    #      v
    # Hom(b, a ⊗ b)
    
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
                    
                  IsomorphismFromTensorProductWithDualObjectToInternalHom( cat,
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

    # 1 ⊗ a
    #   |
    #   | coev_b ⊗ id_a
    #   v
    # b ⊗ b^v ⊗ a
    #   |
    #   | B_( b, b^v ) ⊗ id_a
    #   v
    # b^v ⊗ b ⊗ a
    #   |
    #   | id_(b^v) ⊗ B_( b, a )
    #   v
    # b^v ⊗ a ⊗ b
    #   |
    #   | Isomorphism
    #   v
    # Hom(b, a ⊗ b)
    
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
                    
                  IsomorphismFromTensorProductWithDualObjectToInternalHom( cat,
                    b,
                    TensorProductOnObjects( cat, a, b ) )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "CoevaluationMorphismWithGivenRange using the rigidity of the monoidal category" );

##
AddDerivationToCAP( MorphismFromTensorProductToInternalHomWithGivenObjects,
                  
  function( cat, tensor_object, a, b, internal_hom )
    
    return IsomorphismFromTensorProductWithDualObjectToInternalHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromTensorProductToInternalHomWithGivenObjects using IsomorphismFromTensorProductWithDualObjectToInternalHom" );

##
AddDerivationToCAP( MorphismFromInternalHomToTensorProductWithGivenObjects,
                  
  function( cat, tensor_object, a, b, internal_hom )
    
    return IsomorphismFromInternalHomToTensorProductWithDualObject( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromInternalHomToTensorProductWithGivenObjects using IsomorphismFromInternalHomToTensorProductWithDualObject" );

##
AddDerivationToCAP( IsomorphismFromInternalHomToTensorProductWithDualObject,
                    
  function( cat, a, b )
    
    return MorphismFromInternalHomToTensorProduct( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalHomToTensorProductWithDualObject using MorphismFromInternalHomToTensorProduct" );

##
AddDerivationToCAP( IsomorphismFromTensorProductWithDualObjectToInternalHom,
                    
  function( cat, a, b )
    
    return MorphismFromTensorProductToInternalHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromTensorProductWithDualObjectToInternalHom using MorphismFromTensorProductToInternalHom" );

##
AddDerivationToCAP( MorphismFromInternalHomToTensorProductWithGivenObjects,
                    
  function( cat, tensor_object, a, b, internal_hom )
    local unit;
    
    # inverse of the derivation of MorphismFromTensorProductToInternalHomWithGivenObjects using TensorProductInternalHomCompatibilityMorphism
    
    #      a^v ⊗ b
    #          ʌ
    #          |
    # Hom(a,1) ⊗ Hom(1,b)
    #          ʌ
    #          | CompatMorphism
    #          |
    # Hom(a ⊗ 1, 1 ⊗ b)
    #          ʌ
    #          | Hom(ρ_a, (λ_b)^-1)
    #          |
    #       Hom(a,b)

    unit := TensorUnit( cat );
    
    return PostComposeList( cat, [
             TensorProductOnMorphisms( cat,
               IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, a ),
               IsomorphismFromInternalHomToObject( cat, b ) ),
                
             TensorProductInternalHomCompatibilityMorphismInverse( cat,
               [ a, unit, unit, b ] ),
                
             InternalHomOnMorphisms( cat,
               RightUnitor( cat, a ),
               LeftUnitorInverse( cat, b ) ),
           ] );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromInternalHomToTensorProductWithGivenObjects using TensorProductInternalHomCompatibilityMorphismInverse" );

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
    # a^v ⊗ a
    #    |
    #    | B_( a^v, a )
    #    v
    # a ⊗ a^v
    
    morphism := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat, [
                  LambdaIntroduction( cat, morphism ),
                  IsomorphismFromInternalHomToTensorProductWithDualObject( cat, a, a ),
                  Braiding( cat, DualOnObjects( cat, a ), a )
                ] );
                            
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "CoevaluationForDualWithGivenTensorProduct using LambdaIntroduction on the identity and IsomorphismFromInternalHomToTensorProductWithDualObject" );

##
AddDerivationToCAP( TraceMap,
                    
  function( cat, alpha )
    local result_morphism, a;

    # alpha: a → a
    #
    #    1
    #    |
    #    | LambdaIntro( alpha )
    #    v
    # Hom(a,a)
    #    |
    #    | Isomorphism
    #    v
    # a^v ⊗ a
    #    |
    #    | ev_a
    #    v
    #    1
    
    a := Source( alpha );
    
    result_morphism := PreComposeList( cat, [
                         LambdaIntroduction( cat, alpha ),
                         IsomorphismFromInternalHomToTensorProductWithDualObject( cat, a, a ),
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

    # Inverse( Hom(a,a') ⊗ Hom(b,b') → Hom(a ⊗ b, a' ⊗ b') )
    
    return InverseForMorphisms( cat, TensorProductInternalHomCompatibilityMorphismWithGivenObjects( cat, source, list, range ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects as the inverse of TensorProductInternalHomCompatibilityMorphismWithGivenObjects" );

##
AddDerivationToCAP( DualOnMorphismsWithGivenDuals,
                    
  function( cat, source, alpha, range )
    local a, b, av, bv;
    
    # α: a → b
    # source = b^v
    # range = a^v
    
    a := Source( alpha );
    b := Range( alpha );
    av := range;
    bv := source;
    
    # b^v
    #   |
    #   | right unitor inverse of b^v
    #   v
    # b^v ⊗ 1
    #   |
    #   | id_{b^v} ⊗ coev_a
    #   v
    # b^v ⊗ (a ⊗ a^v)
    #   |
    #   | id_{b^v} ⊗ (α ⊗ id_{a^v})
    #   v
    # b^v ⊗ (b ⊗ a^v)
    #   |
    #   | associator
    #   v
    # (b^v ⊗ b) ⊗ a^v
    #   |
    #   | ev_b ⊗ id_{a^v}
    #   v
    # 1 ⊗ a^v
    #   |
    #   | left unitor of a^v
    #   v
    # a^v
    
    return PreComposeList( cat, [
        RightUnitorInverse( cat, bv ),
        TensorProductOnMorphisms( cat, IdentityMorphism( cat, bv ), CoevaluationForDual( cat, a ) ),
        TensorProductOnMorphisms( cat, IdentityMorphism( cat, bv ), TensorProductOnMorphisms( cat, alpha, IdentityMorphism( cat, av ) ) ),
        AssociatorRightToLeft( cat, bv, b, av ),
        TensorProductOnMorphisms( cat, EvaluationForDual( cat, b ), IdentityMorphism( cat, av ) ),
        LeftUnitor( cat, av )
    ] );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "DualOnMorphismsWithGivenDuals via coevaluation and evaluation for duals" );

####################################
## Final derived methods
####################################

## Final methods for InternalHom

##
AddFinalDerivation( IsomorphismFromTensorProductWithDualObjectToInternalHom,
                    [ [ IdentityMorphism, 1 ],
                      [ DualOnObjects, 1 ],
                      [ RightUnitor, 1 ],
                      [ RightUnitorInverse, 1 ],
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
                      IsomorphismFromTensorProductWithDualObjectToInternalHom,
                      IsomorphismFromInternalHomToTensorProductWithDualObject ],
                    
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, DualOnObjects( cat, a ), b ) );
    
  end,
[
  IsomorphismFromInternalHomToTensorProductWithDualObject,
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, DualOnObjects( cat, a ), b ) );
    
  end
],
[
  IsomorphismFromInternalHomIntoTensorUnitToDualObject,
  function( cat, object )
    
    return RightUnitor( cat, DualOnObjects( cat, object ) );
    
  end
],
[
  IsomorphismFromDualObjectToInternalHomIntoTensorUnit,
  function( cat, object )
    
    return RightUnitorInverse( cat, DualOnObjects( cat, object ) );
    
  end
] : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
    Description := "deriving the internal hom by tensoring with the dual object"
);
