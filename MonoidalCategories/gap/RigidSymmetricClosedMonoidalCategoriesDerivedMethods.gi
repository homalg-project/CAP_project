# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( InternalHomOnObjects,
                    "InternalHomOnObjects as the source of IsomorphismFromInternalHomToTensorProductWithDualObject",
                    [ [ IsomorphismFromInternalHomToTensorProductWithDualObject, 1 ] ],
                    
  function( cat, a, b )
    
    # Source( Hom(a,b) → a^v ⊗ b )

    return Source( IsomorphismFromInternalHomToTensorProductWithDualObject( cat, a, b ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( InternalHomOnObjects,
                    "InternalHomOnObjects as the range of IsomorphismFromTensorProductWithDualObjectToInternalHom",
                    [ [ IsomorphismFromTensorProductWithDualObjectToInternalHom, 1 ] ],
                    
  function( cat, a, b )
    
    # Range( a^v ⊗ b → Hom(a,b) )
    
    return Range( IsomorphismFromTensorProductWithDualObjectToInternalHom( cat, a, b ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( InternalHomOnMorphismsWithGivenInternalHoms,
                    "InternalHomOnMorphismsWithGivenInternalHoms using functoriality of Dual and TensorProduct",
                    [ [ DualOnMorphisms, 1 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromInternalHomToTensorProductWithDualObject, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromTensorProductWithDualObjectToInternalHom, 1 ] ],
                    
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
    
    return PreComposeList( cat,
                   internal_hom_source,
                   [ IsomorphismFromInternalHomToTensorProductWithDualObject( cat, Range( alpha ), Source( beta ) ),
                     TensorProductOnMorphisms( cat, dual_alpha, beta ),
                     IsomorphismFromTensorProductWithDualObjectToInternalHom( cat, Source( alpha ), Range( beta ) ) ],
                   internal_hom_range );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromBidualWithGivenBidual,
                    "MorphismFromBidualWithGivenBidual as the inverse of MorphismToBidualWithGivenBidual",
                    [ [ InverseForMorphisms, 1 ],
                      [ MorphismToBidualWithGivenBidual, 1 ] ],
                    
  function( cat, a, bidual )
    
    # Inverse( a → (a^v)^v )
    
    return InverseForMorphisms( cat, MorphismToBidualWithGivenBidual( cat, a, bidual ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                    "MorphismToBidualWithGivenBidual as the inverse of MorphismFromBidualWithGivenBidual",
                    [ [ InverseForMorphisms, 1 ],
                      [ MorphismFromBidualWithGivenBidual, 1 ] ],
                    
  function( cat, a, bidual )
    
    # Inverse( (a^v)^v → a )
    
    return InverseForMorphisms( cat, MorphismFromBidualWithGivenBidual( cat, a, bidual ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( ClosedMonoidalLeftEvaluationMorphismWithGivenSource,
                    "ClosedMonoidalLeftEvaluationMorphismWithGivenSource using the rigidity of the monoidal category",
                    [ [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ IsomorphismFromInternalHomToTensorProductWithDualObject, 1 ],
                      [ IdentityMorphism, 3 ],
                      [ Braiding, 1 ],
                      [ DualOnObjects, 2 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ EvaluationForDual, 1 ],
                      [ RightUnitor, 1 ] ],
                    
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
    
    morphism := PreComposeList( cat,
                        internal_hom_tensored_a,
                        [ TensorProductOnMorphisms( cat,
                                IsomorphismFromInternalHomToTensorProductWithDualObject( cat, a, b ),
                                IdentityMorphism( cat, a ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, DualOnObjects( cat, a ), b ),
                                  IdentityMorphism( cat, a ) ),
                          AssociatorLeftToRight( cat, b, DualOnObjects( cat, a ), a ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b ),
                                  EvaluationForDual( cat, a ) ),
                          
                          RightUnitor( cat, b ) ],
                        b );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( ClosedMonoidalLeftEvaluationMorphismWithGivenSource,
                    "ClosedMonoidalLeftEvaluationMorphismWithGivenSource using the rigidity and strictness of the monoidal category",
                    [ [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ IsomorphismFromInternalHomToTensorProductWithDualObject, 1 ],
                      [ IdentityMorphism, 3 ],
                      [ Braiding, 1 ],
                      [ DualOnObjects, 1 ],
                      [ EvaluationForDual, 1 ] ],
                    
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
    
    morphism := PreComposeList( cat,
                        internal_hom_tensored_a,
                        [ TensorProductOnMorphisms( cat,
                                IsomorphismFromInternalHomToTensorProductWithDualObject( cat, a, b ),
                                IdentityMorphism( cat, a ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, DualOnObjects( cat, a ), b ),
                                  IdentityMorphism( cat, a ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b ),
                                  EvaluationForDual( cat, a ) ) ],
                        b );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsRigidSymmetricClosedMonoidalCategory( cat ) and IsRigidSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( ClosedMonoidalLeftCoevaluationMorphismWithGivenRange,
                    "ClosedMonoidalLeftCoevaluationMorphismWithGivenRange using the rigidity of the monoidal category",
                    [ [ DualOnObjects, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ PreComposeList, 1 ],
                      [ LeftUnitorInverse, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ CoevaluationForDual, 1 ],
                      [ Braiding, 2 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ IsomorphismFromTensorProductWithDualObjectToInternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    local dual_a, id_b, morphism;
    
    #      b
    #      |
    #      | (λ_b)^-1
    #      v
    #    1 ⊗ b
    #      |
    #      | coev_a ⊗ id_b
    #      v
    # (a ⊗ a^v) ⊗ b
    #      |
    #      | B_( a, a^v ) ⊗ id_b
    #      v
    # (a^v ⊗ a) ⊗ b
    #      |
    #      | α_( ( a^v, a ), b )
    #      v
    # a^v ⊗ (a ⊗ b)
    #      |
    #      | id_(a^v) ⊗ B_( a, b )
    #      v
    # a^v ⊗ (b ⊗ a)
    #      |
    #      | Isomorphism
    #      v
    # Hom(a, b ⊗ a)
    
    dual_a := DualOnObjects( cat, a );
    
    id_b := IdentityMorphism( cat, b );
    
    morphism := PreComposeList( cat,
                        b,
                        [ LeftUnitorInverse( cat, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  CoevaluationForDual( cat, a ),
                                  id_b ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, a, dual_a ),
                                  id_b ),
                          
                          AssociatorLeftToRight( cat, dual_a, a, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, dual_a ),
                                  Braiding( cat, a, b ) ),
                          
                          IsomorphismFromTensorProductWithDualObjectToInternalHom( cat,
                                  a,
                                  TensorProductOnObjects( cat, b, a ) ) ],
                        internal_hom );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( ClosedMonoidalLeftCoevaluationMorphismWithGivenRange,
                    "ClosedMonoidalLeftCoevaluationMorphismWithGivenRange using the rigidity of the monoidal category",
                    [ [ DualOnObjects, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ CoevaluationForDual, 1 ],
                      [ Braiding, 2 ],
                      [ IsomorphismFromTensorProductWithDualObjectToInternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    local dual_a, id_b, morphism;
    
    # 1 ⊗ b
    #   |
    #   | coev_a ⊗ id_b
    #   v
    # a ⊗ a^v ⊗ b
    #   |
    #   | B_( a, a^v ) ⊗ id_b
    #   v
    # a^v ⊗ a ⊗ b
    #   |
    #   | id_(a^v) ⊗ B_( a, b )
    #   v
    # a^v ⊗ b ⊗ a
    #   |
    #   | Isomorphism
    #   v
    # Hom(a, b ⊗ a)
    
    dual_a := DualOnObjects( cat, a );
    
    id_b := IdentityMorphism( cat, b );
    
    morphism := PreComposeList( cat,
                        b,
                        [ TensorProductOnMorphisms( cat,
                                CoevaluationForDual( cat, a ),
                                id_b ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, a, dual_a ),
                                  id_b ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, dual_a ),
                                  Braiding( cat, a, b ) ),
                          
                          IsomorphismFromTensorProductWithDualObjectToInternalHom( cat,
                                  a,
                                  TensorProductOnObjects( cat, b, a ) ) ],
                        internal_hom );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsRigidSymmetricClosedMonoidalCategory( cat ) and IsRigidSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( MorphismFromTensorProductToInternalHomWithGivenObjects,
                    "MorphismFromTensorProductToInternalHomWithGivenObjects using IsomorphismFromTensorProductWithDualObjectToInternalHom",
                    [ [ IsomorphismFromTensorProductWithDualObjectToInternalHom, 1 ] ],
                    
  function( cat, tensor_object, a, b, internal_hom )
    
    return IsomorphismFromTensorProductWithDualObjectToInternalHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromInternalHomToTensorProductWithGivenObjects,
                    "MorphismFromInternalHomToTensorProductWithGivenObjects using IsomorphismFromInternalHomToTensorProductWithDualObject",
                    [ [ IsomorphismFromInternalHomToTensorProductWithDualObject, 1 ] ],
                    
  function( cat, tensor_object, a, b, internal_hom )
    
    return IsomorphismFromInternalHomToTensorProductWithDualObject( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromInternalHomToTensorProductWithDualObject,
                    "IsomorphismFromInternalHomToTensorProductWithDualObject using MorphismFromInternalHomToTensorProduct",
                    [ [ MorphismFromInternalHomToTensorProduct, 1 ] ],
                    
  function( cat, a, b )
    
    return MorphismFromInternalHomToTensorProduct( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromTensorProductWithDualObjectToInternalHom,
                    "IsomorphismFromTensorProductWithDualObjectToInternalHom using MorphismFromTensorProductToInternalHom",
                    [ [ MorphismFromTensorProductToInternalHom, 1 ] ],
                    
  function( cat, a, b )
    
    return MorphismFromTensorProductToInternalHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromInternalHomToTensorProductWithGivenObjects,
                    "MorphismFromInternalHomToTensorProductWithGivenObjects using TensorProductInternalHomCompatibilityMorphismInverse",
                    [ [ TensorUnit, 1 ],
                      [ PostComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromInternalHomIntoTensorUnitToDualObject, 1 ],
                      [ IsomorphismFromInternalHomToObject, 1 ],
                      [ TensorProductInternalHomCompatibilityMorphismInverse, 1 ],
                      [ InternalHomOnMorphisms, 1 ],
                      [ RightUnitor, 1 ],
                      [ LeftUnitorInverse, 1 ] ],
                    
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
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( CoevaluationForDualWithGivenTensorProduct,
                    "CoevaluationForDualWithGivenTensorProduct using LambdaIntroduction on the identity and IsomorphismFromInternalHomToTensorProductWithDualObject",
                    [ [ IdentityMorphism, 1 ],
                      [ PreComposeList, 1 ],
                      [ LambdaIntroduction, 1 ],
                      [ IsomorphismFromInternalHomToTensorProductWithDualObject, 1 ],
                      [ Braiding, 1 ],
                      [ DualOnObjects, 1 ] ],
                    
  function( cat, unit, a, tensor_object )
    local morphism;
    
    #    1
    #    |
    #    | ClosedMonoidalLambdaIntro( id_a )
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
                        [ LambdaIntroduction( cat, morphism ),
                          IsomorphismFromInternalHomToTensorProductWithDualObject( cat, a, a ),
                          Braiding( cat, DualOnObjects( cat, a ), a ) ],
                        tensor_object );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( TraceMap,
                    "TraceMap using LambdaIntroduction and EvaluationForDual",
                    [ [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ LambdaIntroduction, 1 ],
                      [ IsomorphismFromInternalHomToTensorProductWithDualObject, 1 ],
                      [ EvaluationForDual, 1 ] ],
                    
  function( cat, alpha )
    local a, unit, result_morphism;
    
    # alpha: a → a
    #
    #    1
    #    |
    #    | ClosedMonoidalLambdaIntro( alpha )
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
                               [ LambdaIntroduction( cat, alpha ),
                                 IsomorphismFromInternalHomToTensorProductWithDualObject( cat, a, a ),
                                 EvaluationForDual( cat, a ) ],
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
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects,
                    "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects as the inverse of TensorProductInternalHomCompatibilityMorphismWithGivenObjects",
                    [ [ InverseForMorphisms, 1 ],
                      [ TensorProductInternalHomCompatibilityMorphismWithGivenObjects, 1 ] ],
                    
  function( cat, source, list, range )
    
    # Inverse( Hom(a,a') ⊗ Hom(b,b') → Hom(a ⊗ b, a' ⊗ b') )
    
    return InverseForMorphisms( cat, TensorProductInternalHomCompatibilityMorphismWithGivenObjects( cat, range, list, source ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( DualOnMorphismsWithGivenDuals,
                    "DualOnMorphismsWithGivenDuals via coevaluation and evaluation for duals",
                    [ [ PreComposeList, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ TensorProductOnMorphisms, 4 ],
                      [ IdentityMorphism, 4 ],
                      [ CoevaluationForDual, 1 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ EvaluationForDual, 1 ],
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
                     TensorProductOnMorphisms( cat, IdentityMorphism( cat, bv ), CoevaluationForDual( cat, a ) ),
                     TensorProductOnMorphisms( cat, IdentityMorphism( cat, bv ), TensorProductOnMorphisms( cat, alpha, IdentityMorphism( cat, av ) ) ),
                     AssociatorRightToLeft( cat, bv, b, av ),
                     TensorProductOnMorphisms( cat, EvaluationForDual( cat, b ), IdentityMorphism( cat, av ) ),
                     LeftUnitor( cat, av ) ],
                   range );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

####################################
## Final derived methods
####################################

## Final methods for InternalHom

##
AddFinalDerivationBundle( "deriving the internal hom by tensoring with the dual object",
                    [ [ IdentityMorphism, 1 ],
                      [ DualOnObjects, 1 ],
                      [ RightUnitor, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    [ InternalHomOnObjects,
                      InternalHomOnMorphismsWithGivenInternalHoms,
                      ClosedMonoidalLeftEvaluationMorphismWithGivenSource,
                      ClosedMonoidalLeftCoevaluationMorphismWithGivenRange,
                      TensorProductToInternalHomLeftAdjunctMorphism,
                      InternalHomToTensorProductLeftAdjunctMorphism,
                      MonoidalPreComposeMorphismWithGivenObjects,
                      MonoidalPostComposeMorphismWithGivenObjects,
                      TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                      TensorProductDualityCompatibilityMorphismWithGivenObjects,
                      MorphismFromTensorProductToInternalHomWithGivenObjects,
                      MorphismFromInternalHomToTensorProductWithGivenObjects,
                      IsomorphismFromTensorProductWithDualObjectToInternalHom,
                      IsomorphismFromInternalHomToTensorProductWithDualObject,
                      IsomorphismFromInternalHomIntoTensorUnitToDualObject,
                      IsomorphismFromDualObjectToInternalHomIntoTensorUnit,
                    ],
[
  IsomorphismFromTensorProductWithDualObjectToInternalHom,
  [ [ IdentityMorphism, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ DualOnObjects, 1 ] ],
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, DualOnObjects( cat, a ), b ) );
    
  end
],
[
  IsomorphismFromInternalHomToTensorProductWithDualObject,
  [ [ IdentityMorphism, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ DualOnObjects, 1 ] ],
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, DualOnObjects( cat, a ), b ) );
    
  end
],
[
  IsomorphismFromInternalHomIntoTensorUnitToDualObject,
  [ [ RightUnitor, 1 ],
    [ DualOnObjects, 1 ] ],
  function( cat, object )
    
    return RightUnitor( cat, DualOnObjects( cat, object ) );
    
  end
],
[
  IsomorphismFromDualObjectToInternalHomIntoTensorUnit,
  [ [ RightUnitorInverse, 1 ],
    [ DualOnObjects, 1 ] ],
  function( cat, object )
    
    return RightUnitorInverse( cat, DualOnObjects( cat, object ) );
    
  end
] : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );
