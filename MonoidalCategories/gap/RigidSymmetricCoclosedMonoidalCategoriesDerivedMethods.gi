# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( LeftInternalCoHomOnObjects,
                    "LeftInternalCoHomOnObjects as the source of IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject",
                    [ [ IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject, 1 ] ],
                    
  function( cat, a, b )
    
    # Source( coHom(a,b) → b_v ⊗ a )
    
    return Source( IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject( cat, a, b ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalCoHomOnObjects,
                    "LeftInternalCoHomOnObjects as the range of IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom",
                    [ [ IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom, 1 ] ],
                    
  function( cat, a, b )
    
    # Range( b_v ⊗ a → coHom(a,b) )
    
    return Range( IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom( cat, b, a ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms,
                    "LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms using functoriality of LeftCoDual and TensorProduct",
                    [ [ LeftCoDualOnMorphisms, 1 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom, 1 ] ],
                    
  function( cat, internal_cohom_source, alpha, beta, internal_cohom_range )
    local codual_beta;
    
    # alpha: a → a'
    # beta: b → b'
    #
    # coHom(a,b')
    #     |
    #     |
    #     v
    # b'^v ⊗ a
    #     |
    #     | coLeftDual(beta) ⊗ alpha
    #     v
    # b^v ⊗ a'
    #     |
    #     |
    #     v
    # coHom(a',b)
    
    codual_beta := LeftCoDualOnMorphisms( cat, beta );
    
    return PreComposeList( cat,
                   internal_cohom_source,
                   [ IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject( cat, Source( alpha ), Range( beta ) ),
                     TensorProductOnMorphisms( cat, codual_beta, alpha ),
                     IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom( cat, Range( alpha ), Source( beta ) ) ],
                   internal_cohom_range );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MorphismToLeftCoBidualWithGivenLeftCoBidual,
                    "MorphismToLeftCoBidualWithGivenLeftCoBidual as the inverse of MorphismFromLeftCoBidualWithGivenLeftCoBidual",
                    [ [ InverseForMorphisms, 1 ],
                      [ MorphismFromLeftCoBidualWithGivenLeftCoBidual, 1 ] ],
                    
  function( cat, a, cobidual )
    
    # Inverse( (a_v)_v → a )
    
    return InverseForMorphisms( cat, MorphismFromLeftCoBidualWithGivenLeftCoBidual( cat, a, cobidual ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromLeftCoBidualWithGivenLeftCoBidual,
                    "MorphismFromLeftCoBidualWithGivenLeftCoBidual as the inverse of MorphismToLeftCoBidualWithGivenLeftCoBidual",
                    [ [ InverseForMorphisms, 1 ],
                      [ MorphismToLeftCoBidualWithGivenLeftCoBidual, 1 ] ],
                    
  function( cat, a, cobidual )
    
    # Inverse( a → (a_v)_v )
    
    return InverseForMorphisms( cat, MorphismToLeftCoBidualWithGivenLeftCoBidual( cat, a, cobidual ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalEvaluationMorphismWithGivenRange,
                    "LeftCoclosedMonoidalEvaluationMorphismWithGivenRange using the rigidity of the monoidal category",
                    [ [ PreComposeList, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ IdentityMorphism, 3 ],
                      [ LeftCoclosedMonoidalEvaluationForLeftCoDual, 1 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ LeftCoDualOnObjects, 2 ],
                      [ Braiding, 1 ],
                      [ IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom, 1 ] ],
                    
  function( cat, a, b, internal_cohom_tensored_b )
    local morphism;
    
    #      a
    #      |
    #      | (ρ_a)^-1
    #      v
    #    a ⊗ 1
    #      |
    #      | id_a ⊗ coclev_b
    #      v
    # a ⊗ (b_v ⊗ b)
    #      |
    #      | α_( a, ( b_v, b ) )
    #      v
    # (a ⊗ b_v) ⊗ b
    #      |
    #      | B_( a, coLeftDual(b) ) ⊗ id_b
    #      v
    # (b_v ⊗ a) ⊗ b
    #      |
    #      | Isomorphism ⊗ id_b
    #      v
    # coHom(a,b) ⊗ b
    
    morphism := PreComposeList( cat,
                        a,
                        [  RightUnitorInverse( cat, a ),
                           
                           TensorProductOnMorphisms( cat,
                                   IdentityMorphism( cat, a ),
                                   LeftCoclosedMonoidalEvaluationForLeftCoDual( cat, b ) ),
                           
                           AssociatorRightToLeft( cat, a, LeftCoDualOnObjects( cat, b ), b ),
                           
                           TensorProductOnMorphisms( cat,
                                   Braiding( cat, a, LeftCoDualOnObjects( cat, b ) ),
                                   IdentityMorphism( cat, b ) ),
                           
                           TensorProductOnMorphisms( cat,
                                   IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom( cat, b, a ),
                                   IdentityMorphism( cat, b ) ) ],
                        internal_cohom_tensored_b );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalEvaluationMorphismWithGivenRange,
                    "LeftCoclosedMonoidalEvaluationMorphismWithGivenRange using the rigidity and strictness of the monoidal category",
                    [ [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ IdentityMorphism, 3 ],
                      [ LeftCoclosedMonoidalEvaluationForLeftCoDual, 1 ],
                      [ Braiding, 1 ],
                      [ LeftCoDualOnObjects, 1 ],
                      [ IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom, 1 ] ],
                    
  function( cat, a, b, internal_cohom_tensored_b )
    local morphism;
    
    #    a ⊗ 1
    #      |
    #      | id_a ⊗ coclev_b
    #      v
    # a ⊗ b_v ⊗ b
    #      |
    #      | B_( a, coLeftDual(b) ) ⊗ id_b
    #      v
    # b_v ⊗ a ⊗ b
    #      |
    #      | Isomorphism ⊗ id_b
    #      v
    # coHom(a,b) ⊗ b
    
    morphism := PreComposeList( cat,
                        a,
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, a ),
                                LeftCoclosedMonoidalEvaluationForLeftCoDual( cat, b ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, a, LeftCoDualOnObjects( cat, b ) ),
                                  IdentityMorphism( cat, b ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom( cat, b, a ),
                                  IdentityMorphism( cat, b ) ) ],
                        internal_cohom_tensored_b );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsRigidSymmetricCoclosedMonoidalCategory( cat ) and IsRigidSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource,
                    "LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource using the rigidity of the monoidal category",
                    [ [ LeftCoDualOnObjects, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ Braiding, 2 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ LeftCoclosedMonoidalCoevaluationForLeftCoDual, 1 ],
                      [ LeftUnitor, 1 ] ],
                    
  function( cat, a, b, internal_cohom )
    local codual_b, id_a, morphism;
    
    # coHom(a ⊗ b, b)
    #       |
    #       | Isomorphism
    #       v
    #  b_v ⊗ (a ⊗ b)
    #       |
    #       | id_(b_v) ⊗ B_( a, b )
    #       v
    #  b_v ⊗ (b ⊗ a)
    #       |
    #       | α_( b_v, ( b, a ) )
    #       v
    #  (b_v ⊗ b) ⊗ a
    #       |
    #       | B_( b_v, b ) ⊗ id_a
    #       v
    # (b ⊗ b_v) ⊗ a
    #       |
    #       | coclcoev_b ⊗ id_a
    #       v
    #     1 ⊗ a
    #       |
    #       | λ_a
    #       v
    #       a
    
    codual_b := LeftCoDualOnObjects( cat, b );
    
    id_a := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat,
                        internal_cohom,
                        [ IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject( cat,
                                TensorProductOnObjects( cat, a, b ),
                                b),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, codual_b ),
                                  Braiding( cat, a, b ) ),
                          
                          AssociatorRightToLeft( cat, codual_b, b, a ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, codual_b, b ),
                                  id_a ),
                          
                          TensorProductOnMorphisms( cat,
                                  LeftCoclosedMonoidalCoevaluationForLeftCoDual( cat, b ),
                                  id_a ),
                          
                          LeftUnitor( cat, a ) ],
                        a );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource,
                    "LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource using the rigidity of the monoidal category",
                    [ [ LeftCoDualOnObjects, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ Braiding, 2 ],
                      [ LeftCoclosedMonoidalCoevaluationForLeftCoDual, 1 ] ],
                    
  function( cat, a, b, internal_cohom )
    local codual_b, id_a, morphism;
    
    # coHom(a ⊗ b, b)
    #       |
    #       | Isomorphism
    #       v
    #  b_v ⊗ (a ⊗ b)
    #       |
    #       | id_(b_v) ⊗ B_( a, b )
    #       v
    #  b_v ⊗ (b ⊗ a)
    #       |
    #       | B_( b_v, b ) ⊗ id_a
    #       v
    # (b ⊗ b_v) ⊗ a
    #       |
    #       | coclcoev_b ⊗ id_a
    #       v
    #     1 ⊗ a
    
    codual_b := LeftCoDualOnObjects( cat, b );
    
    id_a := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat,
                        internal_cohom,
                        [ IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject( cat,
                                TensorProductOnObjects( cat, a, b ),
                                b ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, codual_b ),
                                  Braiding( cat, a, b ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, codual_b, b ),
                                  id_a ),
                          
                          TensorProductOnMorphisms( cat,
                                  LeftCoclosedMonoidalCoevaluationForLeftCoDual( cat, b ),
                                  id_a ) ],
                        a );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsRigidSymmetricCoclosedMonoidalCategory( cat ) and IsRigidSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects,
                    "MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects using IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject",
                    [ [ IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject, 1 ] ],
                    
  function( cat, internal_cohom, a, b, tensor_object )
    
    return IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );


##
AddDerivationToCAP( MorphismFromTensorProductToLeftInternalCoHomWithGivenObjects,
                    "MorphismFromTensorProductToLeftInternalCoHomWithGivenObjects using IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom",
                    [ [ IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom, 1 ] ],
                    
  function( cat, tensor_object, a, b, internal_hom )
    
    return IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject,
                    "IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject using MorphismFromLeftInternalCoHomToTensorProduct",
                    [ [ MorphismFromLeftInternalCoHomToTensorProduct, 1 ] ],
                    
  function( cat, a, b )
    
    return MorphismFromLeftInternalCoHomToTensorProduct( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom,
                    "IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom using MorphismFromTensorProductToLeftInternalCoHom",
                    [ [ MorphismFromTensorProductToLeftInternalCoHom, 1 ] ],
                    
  function( cat, a, b )
    
    return MorphismFromTensorProductToLeftInternalCoHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

AddDerivationToCAP( LeftCoclosedMonoidalCoevaluationForLeftCoDualWithGivenTensorProduct,
                    "LeftCoclosedMonoidalCoevaluationForLeftCoDualWithGivenTensorProduct using LeftCoclosedMonoidalLambdaIntroduction on the identity and IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom",
                    [ [ IdentityMorphism, 1 ],
                      [ PreComposeList, 1 ],
                      [ Braiding, 1 ],
                      [ LeftCoDualOnObjects, 1 ],
                      [ IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom, 1 ],
                      [ LeftCoclosedMonoidalLambdaIntroduction, 1 ] ],
                    
  function( cat, tensor_object, a, unit )
    local morphism;
    
    # a ⊗ a_v
    #    |
    #    | B_( a, a_v )
    #    v
    # a_v ⊗ a
    #    |
    #    | Isomorphism
    #    v
    # coHom(a,a)
    #    |
    #    | LeftCoclosedMonoidalLambdaIntro( id_a )
    #    v
    #    1
    
    morphism := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat,
                        tensor_object,
                        [ Braiding( cat, a, LeftCoDualOnObjects( cat, a ) ),
                          IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom( cat, a, a ),
                          LeftCoclosedMonoidalLambdaIntroduction( cat, morphism ) ],
                        unit );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoTraceMap,
                    "CoTraceMap using LeftCoclosedMonoidalEvaluationForLeftCoDual and LeftCoclosedMonoidalLambdaIntroduction",
                    [ [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ LeftCoclosedMonoidalEvaluationForLeftCoDual, 1 ],
                      [ IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom, 1 ],
                      [ LeftCoclosedMonoidalLambdaIntroduction, 1 ] ],
                    
  function( cat, alpha )
    local a, unit;
    
    # alpha: a → a
    #
    #    1
    #    |
    #    | coclev_a
    #    v
    # a_v ⊗ a
    #    |
    #    | Isomorphism
    #    v
    # coHom(a,a)
    #    |
    #    | LeftCoclosedMonoidalLambdaIntro( alpha )
    #    v
    #    1
    
    a := Source( alpha );
    
    unit := TensorUnit( cat );
    
    return PreComposeList( cat,
                   unit,
                   [ LeftCoclosedMonoidalEvaluationForLeftCoDual( cat, a ) ,
                     IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom( cat, a, a ),
                     LeftCoclosedMonoidalLambdaIntroduction( cat, alpha ) ],
                   unit );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoRankMorphism,
                    "Corank of an object as the cotrace of its identity",
                    [ [ CoTraceMap, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a )
    
    return CoTraceMap( cat, IdentityMorphism( cat, a ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects,
                    "LeftInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects as the inverse of TensorProductLeftInternalCoHomCompatibilityMorphismWithGivenObjects",
                    [ [ InverseForMorphisms, 1 ],
                      [ LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects, 1 ] ],
                    
  function( cat, source, list, range )
    
    # Inverse( coHom( a ⊗ a', b ⊗ b') → coHom(a,b) ⊗ coHom(a',b') )
    
    return InverseForMorphisms( cat, LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects( cat, range, list, source ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

####################################
## Final derived methods
####################################

## Final methods for LeftInternalCoHom

##
AddFinalDerivationBundle( "deriving the internal cohom by tensoring with the codual object",
                    [ [ IdentityMorphism, 1 ],
                      [ LeftCoDualOnObjects, 1 ],
                      [ LeftUnitor, 1 ],
                      [ LeftUnitorInverse, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    [ LeftInternalCoHomOnObjects,
                      LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms,
                      LeftCoclosedMonoidalEvaluationMorphismWithGivenRange,
                      LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource,
                      TensorProductToLeftInternalCoHomAdjunctionMap,
                      LeftInternalCoHomToTensorProductAdjunctionMap,
                      LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects,
                      LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects,
                      LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                      LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                      MorphismFromTensorProductToLeftInternalCoHomWithGivenObjects,
                      MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects,
                      IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom,
                      IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject,
                      IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject,
                      IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit,
                    ],
[
  IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom,
  [ [ IdentityMorphism, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ LeftCoDualOnObjects, 1 ] ],
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, a, LeftCoDualOnObjects( cat, b ) ) );
    
  end
],
[
  IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject,
  [ [ IdentityMorphism, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ LeftCoDualOnObjects, 1 ] ],
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, a, LeftCoDualOnObjects( cat, b ) ) );
    
  end
],
[
  IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject,
  [ [ LeftUnitor, 1 ],
    [ LeftCoDualOnObjects, 1 ] ],
  function( cat, object )
    
    return LeftUnitor( cat, LeftCoDualOnObjects( cat, object ) );
    
  end
],
[
  IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit,
  [ [ LeftUnitorInverse, 1 ],
    [ LeftCoDualOnObjects, 1 ] ],
  function( cat, object )
    
    return LeftUnitorInverse( cat, LeftCoDualOnObjects( cat, object ) );
    
  end
] : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );
