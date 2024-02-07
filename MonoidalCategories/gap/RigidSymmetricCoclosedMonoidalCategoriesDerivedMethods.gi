# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( InternalCoHomOnObjects,
                    "InternalCoHomOnObjects as the source of IsomorphismFromInternalCoHomToTensorProductWithCoDualObject",
                    [ [ IsomorphismFromInternalCoHomToTensorProductWithCoDualObject, 1 ] ],
                    
  function( cat, a, b )
    
    # Source( coHom(a,b) → b_v ⊗ a )
    
    return Source( IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat, a, b ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( InternalCoHomOnObjects,
                    "InternalCoHomOnObjects as the range of IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom",
                    [ [ IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom, 1 ] ],
                    
  function( cat, a, b )
    
    # Range( b_v ⊗ a → coHom(a,b) )
    
    return Range( IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, b, a ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( InternalCoHomOnMorphismsWithGivenInternalCoHoms,
                    "InternalCoHomOnMorphismsWithGivenInternalCoHoms using functoriality of CoDual and TensorProduct",
                    [ [ CoDualOnMorphisms, 1 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromInternalCoHomToTensorProductWithCoDualObject, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom, 1 ] ],
                    
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
    #     | coDual(beta) ⊗ alpha
    #     v
    # b^v ⊗ a'
    #     |
    #     |
    #     v
    # coHom(a',b)
    
    codual_beta := CoDualOnMorphisms( cat, beta );
    
    return PreComposeList( cat,
                   internal_cohom_source,
                   [ IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat, Source( alpha ), Range( beta ) ),
                     TensorProductOnMorphisms( cat, codual_beta, alpha ),
                     IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, Range( alpha ), Source( beta ) ) ],
                   internal_cohom_range );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MorphismToCoBidualWithGivenCoBidual,
                    "MorphismToCoBidualWithGivenCoBidual as the inverse of MorphismFromCoBidualWithGivenCoBidual",
                    [ [ InverseForMorphisms, 1 ],
                      [ MorphismFromCoBidualWithGivenCoBidual, 1 ] ],
                    
  function( cat, a, cobidual )
    
    # Inverse( (a_v)_v → a )
    
    return InverseForMorphisms( cat, MorphismFromCoBidualWithGivenCoBidual( cat, a, cobidual ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,
                    "MorphismFromCoBidualWithGivenCoBidual as the inverse of MorphismToCoBidualWithGivenCoBidual",
                    [ [ InverseForMorphisms, 1 ],
                      [ MorphismToCoBidualWithGivenCoBidual, 1 ] ],
                    
  function( cat, a, cobidual )
    
    # Inverse( a → (a_v)_v )
    
    return InverseForMorphisms( cat, MorphismToCoBidualWithGivenCoBidual( cat, a, cobidual ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoclosedMonoidalLeftEvaluationMorphismWithGivenRange,
                    "CoclosedMonoidalLeftEvaluationMorphismWithGivenRange using the rigidity of the monoidal category",
                    [ [ PreComposeList, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ IdentityMorphism, 3 ],
                      [ CoclosedEvaluationForCoDual, 1 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ CoDualOnObjects, 2 ],
                      [ Braiding, 1 ],
                      [ IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom, 1 ] ],
                    
  function( cat, a, b, internal_cohom_tensored_a )
    local morphism;
    
    #      b
    #      |
    #      | (ρ_b)^-1
    #      v
    #    b ⊗ 1
    #      |
    #      | id_b ⊗ coclev_a
    #      v
    # b ⊗ (a_v ⊗ a)
    #      |
    #      | α_( b, ( a_v, a ) )
    #      v
    # (b ⊗ a_v) ⊗ a
    #      |
    #      | B_( b, coDual(a) ) ⊗ id_a
    #      v
    # (a_v ⊗ b) ⊗ a
    #      |
    #      | Isomorphism ⊗ id_a
    #      v
    # coHom(b,a) ⊗ a
    
    morphism := PreComposeList( cat,
                        b,
                        [  RightUnitorInverse( cat, b ),
                           
                           TensorProductOnMorphisms( cat,
                                   IdentityMorphism( cat, b ),
                                   CoclosedEvaluationForCoDual( cat, a ) ),
                           
                           AssociatorRightToLeft( cat, b, CoDualOnObjects( cat, a ), a ),
                           
                           TensorProductOnMorphisms( cat,
                                   Braiding( cat, b, CoDualOnObjects( cat, a ) ),
                                   IdentityMorphism( cat, a ) ),
                           
                           TensorProductOnMorphisms( cat,
                                   IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, a, b ),
                                   IdentityMorphism( cat, a ) ) ],
                        internal_cohom_tensored_a );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoclosedMonoidalLeftEvaluationMorphismWithGivenRange,
                    "CoclosedMonoidalLeftEvaluationMorphismWithGivenRange using the rigidity and strictness of the monoidal category",
                    [ [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ IdentityMorphism, 3 ],
                      [ CoclosedEvaluationForCoDual, 1 ],
                      [ Braiding, 1 ],
                      [ CoDualOnObjects, 1 ],
                      [ IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom, 1 ] ],
                    
  function( cat, a, b, internal_cohom_tensored_a )
    local morphism;
    
    #    b ⊗ 1
    #      |
    #      | id_b ⊗ coclev_a
    #      v
    # b ⊗ a_v ⊗ a
    #      |
    #      | B_( b, coDual(b) ) ⊗ id_a
    #      v
    # a_v ⊗ b ⊗ a
    #      |
    #      | Isomorphism ⊗ id_a
    #      v
    # coHom(b,a) ⊗ a
    
    morphism := PreComposeList( cat,
                        b,
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, b ),
                                CoclosedEvaluationForCoDual( cat, a ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, b, CoDualOnObjects( cat, a ) ),
                                  IdentityMorphism( cat, a ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, a, b ),
                                  IdentityMorphism( cat, a ) ) ],
                        internal_cohom_tensored_a );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsRigidSymmetricCoclosedMonoidalCategory( cat ) and IsRigidSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( CoclosedMonoidalLeftCoevaluationMorphismWithGivenSource,
                    "CoclosedMonoidalLeftCoevaluationMorphismWithGivenSource using the rigidity of the monoidal category",
                    [ [ CoDualOnObjects, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromInternalCoHomToTensorProductWithCoDualObject, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ Braiding, 2 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ CoclosedCoevaluationForCoDual, 1 ],
                      [ LeftUnitor, 1 ] ],
                    
  function( cat, a, b, internal_cohom )
    local codual_a, id_b, morphism;
    
    # coHom(b ⊗ a, a)
    #       |
    #       | Isomorphism
    #       v
    #  a_v ⊗ (b ⊗ a)
    #       |
    #       | id_(a_v) ⊗ B_( b, a )
    #       v
    #  a_v ⊗ (a ⊗ b)
    #       |
    #       | α_( a_v, ( a, b ) )
    #       v
    #  (a_v ⊗ a) ⊗ b
    #       |
    #       | B_( a_v, a ) ⊗ id_b
    #       v
    # (a ⊗ a_v) ⊗ b
    #       |
    #       | coclcoev_a ⊗ id_b
    #       v
    #     1 ⊗ b
    #       |
    #       | λ_b
    #       v
    #       b
    
    codual_a := CoDualOnObjects( cat, a );
    
    id_b := IdentityMorphism( cat, b );
    
    morphism := PreComposeList( cat,
                        internal_cohom,
                        [ IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat,
                                TensorProductOnObjects( cat, b, a ),
                                a ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, codual_a ),
                                  Braiding( cat, b, a ) ),
                          
                          AssociatorRightToLeft( cat, codual_a, a, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, codual_a, a ),
                                  id_b ),
                          
                          TensorProductOnMorphisms( cat,
                                  CoclosedCoevaluationForCoDual( cat, a ),
                                  id_b ),
                          
                          LeftUnitor( cat, b ) ],
                        b );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoclosedMonoidalLeftCoevaluationMorphismWithGivenSource,
                    "CoclosedMonoidalLeftCoevaluationMorphismWithGivenSource using the rigidity of the monoidal category",
                    [ [ CoDualOnObjects, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromInternalCoHomToTensorProductWithCoDualObject, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ Braiding, 2 ],
                      [ CoclosedCoevaluationForCoDual, 1 ] ],
                    
  function( cat, a, b, internal_cohom )
    local codual_a, id_b, morphism;
    
    # coHom(b ⊗ a, a)
    #       |
    #       | Isomorphism
    #       v
    #  a_v ⊗ (b ⊗ a)
    #       |
    #       | id_(a_v) ⊗ B_( b, a )
    #       v
    #  a_v ⊗ (a ⊗ b)
    #       |
    #       | B_( a_v, a ) ⊗ id_b
    #       v
    # (a ⊗ a_v) ⊗ b
    #       |
    #       | coclcoev_a ⊗ id_b
    #       v
    #     1 ⊗ b
    
    codual_a := CoDualOnObjects( cat, a );
    
    id_b := IdentityMorphism( cat, b );
    
    morphism := PreComposeList( cat,
                        internal_cohom,
                        [ IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat,
                                TensorProductOnObjects( cat, b, a ),
                                a ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, codual_a ),
                                  Braiding( cat, b, a ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, codual_a, a ),
                                  id_b ),
                          
                          TensorProductOnMorphisms( cat,
                                  CoclosedCoevaluationForCoDual( cat, a ),
                                  id_b ) ],
                        b );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsRigidSymmetricCoclosedMonoidalCategory( cat ) and IsRigidSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( MorphismFromInternalCoHomToTensorProductWithGivenObjects,
                    "MorphismFromInternalCoHomToTensorProductWithGivenObjects using IsomorphismFromInternalCoHomToTensorProductWithCoDualObject",
                    [ [ IsomorphismFromInternalCoHomToTensorProductWithCoDualObject, 1 ] ],
                    
  function( cat, internal_cohom, a, b, tensor_object )
    
    return IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );


##
AddDerivationToCAP( MorphismFromTensorProductToInternalCoHomWithGivenObjects,
                    "MorphismFromTensorProductToInternalCoHomWithGivenObjects using IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom",
                    [ [ IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom, 1 ] ],
                    
  function( cat, tensor_object, a, b, internal_hom )
    
    return IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToTensorProductWithCoDualObject,
                    "IsomorphismFromInternalCoHomToTensorProductWithCoDualObject using MorphismFromInternalCoHomToTensorProduct",
                    [ [ MorphismFromInternalCoHomToTensorProduct, 1 ] ],
                    
  function( cat, a, b )
    
    return MorphismFromInternalCoHomToTensorProduct( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom,
                    "IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom using MorphismFromTensorProductToInternalCoHom",
                    [ [ MorphismFromTensorProductToInternalCoHom, 1 ] ],
                    
  function( cat, a, b )
    
    return MorphismFromTensorProductToInternalCoHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory );

AddDerivationToCAP( CoclosedCoevaluationForCoDualWithGivenTensorProduct,
                    "CoclosedCoevaluationForCoDualWithGivenTensorProduct using CoLambdaIntroduction on the identity and IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom",
                    [ [ IdentityMorphism, 1 ],
                      [ PreComposeList, 1 ],
                      [ Braiding, 1 ],
                      [ CoDualOnObjects, 1 ],
                      [ IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom, 1 ],
                      [ CoLambdaIntroduction, 1 ] ],
                    
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
    #    | CoclosedMonoidalLambdaIntro( id_a )
    #    v
    #    1
    
    morphism := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat,
                        tensor_object,
                        [ Braiding( cat, a, CoDualOnObjects( cat, a ) ),
                          IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, a, a ),
                          CoLambdaIntroduction( cat, morphism ) ],
                        unit );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoTraceMap,
                    "CoTraceMap using CoclosedEvaluationForCoDual and CoLambdaIntroduction",
                    [ [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ CoclosedEvaluationForCoDual, 1 ],
                      [ IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom, 1 ],
                      [ CoLambdaIntroduction, 1 ] ],
                    
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
    #    | CoclosedMonoidalLambdaIntro( alpha )
    #    v
    #    1
    
    a := Source( alpha );
    
    unit := TensorUnit( cat );
    
    return PreComposeList( cat,
                   unit,
                   [ CoclosedEvaluationForCoDual( cat, a ) ,
                     IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, a, a ),
                     CoLambdaIntroduction( cat, alpha ) ],
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
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects,
                    "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects as the inverse of TensorProductInternalCoHomCompatibilityMorphismWithGivenObjects",
                    [ [ InverseForMorphisms, 1 ],
                      [ InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects, 1 ] ],
                    
  function( cat, source, list, range )
    
    # Inverse( coHom( a ⊗ a', b ⊗ b') → coHom(a,b) ⊗ coHom(a',b') )
    
    return InverseForMorphisms( cat, InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects( cat, range, list, source ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

####################################
## Final derived methods
####################################

## Final methods for InternalCoHom

##
AddFinalDerivationBundle( "deriving the internal cohom by tensoring with the codual object",
                    [ [ IdentityMorphism, 1 ],
                      [ CoDualOnObjects, 1 ],
                      [ LeftUnitor, 1 ],
                      [ LeftUnitorInverse, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    [ InternalCoHomOnObjects,
                      InternalCoHomOnMorphismsWithGivenInternalCoHoms,
                      CoclosedMonoidalLeftEvaluationMorphismWithGivenRange,
                      CoclosedMonoidalLeftCoevaluationMorphismWithGivenSource,
                      TensorProductToInternalCoHomLeftAdjunctMorphism,
                      InternalCoHomToTensorProductLeftAdjunctMorphism,
                      MonoidalPreCoComposeMorphismWithGivenObjects,
                      MonoidalPostCoComposeMorphismWithGivenObjects,
                      InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                      CoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                      MorphismFromTensorProductToInternalCoHomWithGivenObjects,
                      MorphismFromInternalCoHomToTensorProductWithGivenObjects,
                      IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom,
                      IsomorphismFromInternalCoHomToTensorProductWithCoDualObject,
                      IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject,
                      IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit,
                    ],
[
  IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom,
  [ [ IdentityMorphism, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ CoDualOnObjects, 1 ] ],
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, a, CoDualOnObjects( cat, b ) ) );
    
  end
],
[
  IsomorphismFromInternalCoHomToTensorProductWithCoDualObject,
  [ [ IdentityMorphism, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ CoDualOnObjects, 1 ] ],
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, a, CoDualOnObjects( cat, b ) ) );
    
  end
],
[
  IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject,
  [ [ LeftUnitor, 1 ],
    [ CoDualOnObjects, 1 ] ],
  function( cat, object )
    
    return LeftUnitor( cat, CoDualOnObjects( cat, object ) );
    
  end
],
[
  IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit,
  [ [ LeftUnitorInverse, 1 ],
    [ CoDualOnObjects, 1 ] ],
  function( cat, object )
    
    return LeftUnitorInverse( cat, CoDualOnObjects( cat, object ) );
    
  end
] : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );
