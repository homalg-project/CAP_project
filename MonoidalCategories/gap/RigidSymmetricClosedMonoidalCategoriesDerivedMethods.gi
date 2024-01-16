# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( LeftInternalHomOnObjects,
                    "LeftInternalHomOnObjects as the source of IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject",
                    [ [ IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject, 1 ] ],
                    
  function( cat, a, b )
    
    # Source( Hom(a,b) → a^v ⊗ b )

    return Source( IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject( cat, a, b ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalHomOnObjects,
                    "LeftInternalHomOnObjects as the range of IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom",
                    [ [ IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom, 1 ] ],
                    
  function( cat, a, b )
    
    # Range( a^v ⊗ b → Hom(a,b) )
    
    return Range( IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom( cat, a, b ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalHomOnMorphismsWithGivenLeftInternalHoms,
                    "LeftInternalHomOnMorphismsWithGivenLeftInternalHoms using functoriality of LeftDual and TensorProduct",
                    [ [ LeftDualOnMorphisms, 1 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom, 1 ] ],
                    
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
    #     | LeftDual(alpha) ⊗ beta
    #     v
    # a^v ⊗ b'
    #     |
    #     |
    #     v
    # Hom(a,b')
    
    dual_alpha := LeftDualOnMorphisms( cat, alpha );
    
    return PreComposeList( cat,
                   internal_hom_source,
                   [ IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject( cat, Range( alpha ), Source( beta ) ),
                     TensorProductOnMorphisms( cat, dual_alpha, beta ),
                     IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom( cat, Source( alpha ), Range( beta ) ) ],
                   internal_hom_range );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromLeftBidualWithGivenLeftBidual,
                    "MorphismFromLeftBidualWithGivenLeftBidual as the inverse of MorphismToLeftBidualWithGivenLeftBidual",
                    [ [ InverseForMorphisms, 1 ],
                      [ MorphismToLeftBidualWithGivenLeftBidual, 1 ] ],
                    
  function( cat, a, bidual )
    
    # Inverse( a → (a^v)^v )
    
    return InverseForMorphisms( cat, MorphismToLeftBidualWithGivenLeftBidual( cat, a, bidual ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismToLeftBidualWithGivenLeftBidual,
                    "MorphismToLeftBidualWithGivenLeftBidual as the inverse of MorphismFromLeftBidualWithGivenLeftBidual",
                    [ [ InverseForMorphisms, 1 ],
                      [ MorphismFromLeftBidualWithGivenLeftBidual, 1 ] ],
                    
  function( cat, a, bidual )
    
    # Inverse( (a^v)^v → a )
    
    return InverseForMorphisms( cat, MorphismFromLeftBidualWithGivenLeftBidual( cat, a, bidual ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalEvaluationMorphismWithGivenSource,
                    "LeftClosedMonoidalEvaluationMorphismWithGivenSource using the rigidity of the monoidal category",
                    [ [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject, 1 ],
                      [ IdentityMorphism, 3 ],
                      [ Braiding, 1 ],
                      [ LeftDualOnObjects, 2 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ LeftClosedMonoidalEvaluationForLeftDual, 1 ],
                      [ RightUnitor, 1 ] ],
                    
  function( cat, a, b, internal_hom_tensored_a )
    local morphism;
    
    # Hom(a,b) ⊗ a
    #      |
    #      | Isomorphism ⊗ id_a
    #      v
    # (a^v ⊗ b) ⊗ a
    #      |
    #      | B_( LeftDual(a), b ) ⊗ id_a
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
    
    morphism := PreComposeList( cat,
                        internal_hom_tensored_a,
                        [ TensorProductOnMorphisms( cat,
                                IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject( cat, a, b ),
                                IdentityMorphism( cat, a ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, LeftDualOnObjects( cat, a ), b ),
                                  IdentityMorphism( cat, a ) ),
                          AssociatorLeftToRight( cat, b, LeftDualOnObjects( cat, a ), a ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b ),
                                  LeftClosedMonoidalEvaluationForLeftDual( cat, a ) ),
                          
                          RightUnitor( cat, b ) ],
                        b );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalEvaluationMorphismWithGivenSource,
                    "LeftClosedMonoidalEvaluationMorphismWithGivenSource using the rigidity and strictness of the monoidal category",
                    [ [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject, 1 ],
                      [ IdentityMorphism, 3 ],
                      [ Braiding, 1 ],
                      [ LeftDualOnObjects, 1 ],
                      [ LeftClosedMonoidalEvaluationForLeftDual, 1 ] ],
                    
  function( cat, a, b, internal_hom_tensored_a )
    local morphism;
    
    # Hom(a,b) ⊗ a
    #      |
    #      | Isomorphism ⊗ id_a
    #      v
    # a^v ⊗ b ⊗ a
    #      |
    #      | B_( LeftDual(a), b ) ⊗ id_a
    #      v
    # b ⊗ a^v ⊗ a
    #      |
    #      | id_b ⊗ ev_a
    #      v
    #    b ⊗ 1
    
    morphism := PreComposeList( cat,
                        internal_hom_tensored_a,
                        [ TensorProductOnMorphisms( cat,
                                IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject( cat, a, b ),
                                IdentityMorphism( cat, a ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, LeftDualOnObjects( cat, a ), b ),
                                  IdentityMorphism( cat, a ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b ),
                                  LeftClosedMonoidalEvaluationForLeftDual( cat, a ) ) ],
                        b );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsRigidSymmetricClosedMonoidalCategory( cat ) and IsRigidSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( LeftClosedMonoidalCoevaluationMorphismWithGivenRange,
                    "LeftClosedMonoidalCoevaluationMorphismWithGivenRange using the rigidity of the monoidal category",
                    [ [ LeftDualOnObjects, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ PreComposeList, 1 ],
                      [ LeftUnitorInverse, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ CoevaluationForLeftDual, 1 ],
                      [ Braiding, 2 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    local dual_b, id_a, morphism;
    
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
    
    dual_b := LeftDualOnObjects( cat, b );
    
    id_a := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat,
                        a,
                        [ LeftUnitorInverse( cat, a ),
                          
                          TensorProductOnMorphisms( cat,
                                  CoevaluationForLeftDual( cat, b ),
                                  id_a ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, b, dual_b ),
                                  id_a ),
                          
                          AssociatorLeftToRight( cat, dual_b, b, a ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, dual_b ),
                                  Braiding( cat, b, a ) ),
                          
                          IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom( cat,
                                  b,
                                  TensorProductOnObjects( cat, a, b ) ) ],
                        internal_hom );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalCoevaluationMorphismWithGivenRange,
                    "LeftClosedMonoidalCoevaluationMorphismWithGivenRange using the rigidity of the monoidal category",
                    [ [ LeftDualOnObjects, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ CoevaluationForLeftDual, 1 ],
                      [ Braiding, 2 ],
                      [ IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    local dual_b, id_a, morphism;
    
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
    
    dual_b := LeftDualOnObjects( cat, b );
    
    id_a := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat,
                        a,
                        [ TensorProductOnMorphisms( cat,
                                CoevaluationForLeftDual( cat, b ),
                                id_a ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, b, dual_b ),
                                  id_a ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, dual_b ),
                                  Braiding( cat, b, a ) ),
                          
                          IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom( cat,
                                  b,
                                  TensorProductOnObjects( cat, a, b ) ) ],
                        internal_hom );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsRigidSymmetricClosedMonoidalCategory( cat ) and IsRigidSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( MorphismFromTensorProductToLeftInternalHomWithGivenObjects,
                    "MorphismFromTensorProductToLeftInternalHomWithGivenObjects using IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom",
                    [ [ IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom, 1 ] ],
                    
  function( cat, tensor_object, a, b, internal_hom )
    
    return IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromLeftInternalHomToTensorProductWithGivenObjects,
                    "MorphismFromLeftInternalHomToTensorProductWithGivenObjects using IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject",
                    [ [ IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject, 1 ] ],
                    
  function( cat, tensor_object, a, b, internal_hom )
    
    return IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject,
                    "IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject using MorphismFromLeftInternalHomToTensorProduct",
                    [ [ MorphismFromLeftInternalHomToTensorProduct, 1 ] ],
                    
  function( cat, a, b )
    
    return MorphismFromLeftInternalHomToTensorProduct( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom,
                    "IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom using MorphismFromTensorProductToLeftInternalHom",
                    [ [ MorphismFromTensorProductToLeftInternalHom, 1 ] ],
                    
  function( cat, a, b )
    
    return MorphismFromTensorProductToLeftInternalHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromLeftInternalHomToTensorProductWithGivenObjects,
                    "MorphismFromLeftInternalHomToTensorProductWithGivenObjects using TensorProductLeftInternalHomCompatibilityMorphismInverse",
                    [ [ TensorUnit, 1 ],
                      [ PostComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject, 1 ],
                      [ IsomorphismFromLeftInternalHomToObject, 1 ],
                      [ TensorProductLeftInternalHomCompatibilityMorphismInverse, 1 ],
                      [ LeftInternalHomOnMorphisms, 1 ],
                      [ RightUnitor, 1 ],
                      [ LeftUnitorInverse, 1 ] ],
                    
  function( cat, tensor_object, a, b, internal_hom )
    local unit;
    
    # inverse of the derivation of MorphismFromTensorProductToLeftInternalHomWithGivenObjects using TensorProductLeftInternalHomCompatibilityMorphism
    
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
               IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject( cat, a ),
               IsomorphismFromLeftInternalHomToObject( cat, b ) ),
                
             TensorProductLeftInternalHomCompatibilityMorphismInverse( cat,
               [ a, unit, unit, b ] ),
                
             LeftInternalHomOnMorphisms( cat,
               RightUnitor( cat, a ),
               LeftUnitorInverse( cat, b ) ),
           ] );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( CoevaluationForLeftDualWithGivenTensorProduct,
                    "CoevaluationForLeftDualWithGivenTensorProduct using LeftClosedMonoidalLambdaIntroduction on the identity and IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject",
                    [ [ IdentityMorphism, 1 ],
                      [ PreComposeList, 1 ],
                      [ LeftClosedMonoidalLambdaIntroduction, 1 ],
                      [ IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject, 1 ],
                      [ Braiding, 1 ],
                      [ LeftDualOnObjects, 1 ] ],
                    
  function( cat, unit, a, tensor_object )
    local morphism;
    
    #    1
    #    |
    #    | LeftClosedMonoidalLambdaIntro( id_a )
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
    
    morphism := PreComposeList( cat,
                        unit,
                        [ LeftClosedMonoidalLambdaIntroduction( cat, morphism ),
                          IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject( cat, a, a ),
                          Braiding( cat, LeftDualOnObjects( cat, a ), a ) ],
                        tensor_object );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( TraceMap,
                    "TraceMap using LeftClosedMonoidalLambdaIntroduction and LeftClosedMonoidalEvaluationForLeftDual",
                    [ [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ LeftClosedMonoidalLambdaIntroduction, 1 ],
                      [ IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject, 1 ],
                      [ LeftClosedMonoidalEvaluationForLeftDual, 1 ] ],
                    
  function( cat, alpha )
    local a, unit, result_morphism;
    
    # alpha: a → a
    #
    #    1
    #    |
    #    | LeftClosedMonoidalLambdaIntro( alpha )
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
    
    unit := TensorUnit( cat );
    
    result_morphism := PreComposeList( cat,
                               unit,
                               [ LeftClosedMonoidalLambdaIntroduction( cat, alpha ),
                                 IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject( cat, a, a ),
                                 LeftClosedMonoidalEvaluationForLeftDual( cat, a ) ],
                               unit );
    
    return result_morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( RankMorphism,
                    "Rank of an object as the trace of its identity",
                    [ [ TraceMap, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a )
    
    return TraceMap( cat, IdentityMorphism( cat, a ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductLeftInternalHomCompatibilityMorphismInverseWithGivenObjects,
                    "TensorProductLeftInternalHomCompatibilityMorphismInverseWithGivenObjects as the inverse of TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects",
                    [ [ InverseForMorphisms, 1 ],
                      [ TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects, 1 ] ],
                    
  function( cat, source, list, range )
    
    # Inverse( Hom(a,a') ⊗ Hom(b,b') → Hom(a ⊗ b, a' ⊗ b') )
    
    return InverseForMorphisms( cat, TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects( cat, range, list, source ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftDualOnMorphismsWithGivenLeftDuals,
                    "LeftDualOnMorphismsWithGivenLeftDuals via coevaluation and evaluation for duals",
                    [ [ PreComposeList, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ TensorProductOnMorphisms, 4 ],
                      [ IdentityMorphism, 4 ],
                      [ CoevaluationForLeftDual, 1 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ LeftClosedMonoidalEvaluationForLeftDual, 1 ],
                      [ LeftUnitor, 1 ] ],
                    
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
    
    return PreComposeList( cat,
                   source,
                   [ RightUnitorInverse( cat, bv ),
                     TensorProductOnMorphisms( cat, IdentityMorphism( cat, bv ), CoevaluationForLeftDual( cat, a ) ),
                     TensorProductOnMorphisms( cat, IdentityMorphism( cat, bv ), TensorProductOnMorphisms( cat, alpha, IdentityMorphism( cat, av ) ) ),
                     AssociatorRightToLeft( cat, bv, b, av ),
                     TensorProductOnMorphisms( cat, LeftClosedMonoidalEvaluationForLeftDual( cat, b ), IdentityMorphism( cat, av ) ),
                     LeftUnitor( cat, av ) ],
                   range );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

####################################
## Final derived methods
####################################

## Final methods for LeftInternalHom

##
AddFinalDerivationBundle( "deriving the internal hom by tensoring with the dual object",
                    [ [ IdentityMorphism, 1 ],
                      [ LeftDualOnObjects, 1 ],
                      [ RightUnitor, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    [ LeftInternalHomOnObjects,
                      LeftInternalHomOnMorphismsWithGivenLeftInternalHoms,
                      LeftClosedMonoidalEvaluationMorphismWithGivenSource,
                      LeftClosedMonoidalCoevaluationMorphismWithGivenRange,
                      TensorProductToLeftInternalHomAdjunctionMap,
                      LeftInternalHomToTensorProductAdjunctionMap,
                      LeftClosedMonoidalPreComposeMorphismWithGivenObjects,
                      LeftClosedMonoidalPostComposeMorphismWithGivenObjects,
                      TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects,
                      TensorProductLeftDualityCompatibilityMorphismWithGivenObjects,
                      MorphismFromTensorProductToLeftInternalHomWithGivenObjects,
                      MorphismFromLeftInternalHomToTensorProductWithGivenObjects,
                      IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom,
                      IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject,
                      IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject,
                      IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit,
                    ],
[
  IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom,
  [ [ IdentityMorphism, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ LeftDualOnObjects, 1 ] ],
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, LeftDualOnObjects( cat, a ), b ) );
    
  end
],
[
  IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject,
  [ [ IdentityMorphism, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ LeftDualOnObjects, 1 ] ],
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, LeftDualOnObjects( cat, a ), b ) );
    
  end
],
[
  IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject,
  [ [ RightUnitor, 1 ],
    [ LeftDualOnObjects, 1 ] ],
  function( cat, object )
    
    return RightUnitor( cat, LeftDualOnObjects( cat, object ) );
    
  end
],
[
  IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit,
  [ [ RightUnitorInverse, 1 ],
    [ LeftDualOnObjects, 1 ] ],
  function( cat, object )
    
    return RightUnitorInverse( cat, LeftDualOnObjects( cat, object ) );
    
  end
] : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );
