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
    
    # Source( Cohom(a,b) → b_v ⊗ a )
    
    return Source( IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat, a, b ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( InternalCoHomOnObjects,
                    "InternalCoHomOnObjects as the range of IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom",
                    [ [ IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom, 1 ] ],
                    
  function( cat, a, b )
    
    # Range( b_v ⊗ a → Cohom(a,b) )
    
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
    # Cohom(a,b')
    #     |
    #     |
    #     v
    # b'^v ⊗ a
    #     |
    #     | Codual(beta) ⊗ alpha
    #     v
    # b^v ⊗ a'
    #     |
    #     |
    #     v
    # Cohom(a',b)
    
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
AddDerivationToCAP( CoclosedEvaluationMorphismWithGivenRange,
                    "CoclosedEvaluationMorphismWithGivenRange using the rigidity of the monoidal category",
                    [ [ PreComposeList, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ IdentityMorphism, 3 ],
                      [ CoclosedEvaluationForCoDual, 1 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ CoDualOnObjects, 2 ],
                      [ Braiding, 1 ],
                      [ IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom, 1 ] ],
                    
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
    #      | B_( a, Codual(b) ) ⊗ id_b
    #      v
    # (b_v ⊗ a) ⊗ b
    #      |
    #      | Isomorphism ⊗ id_b
    #      v
    # Cohom(a,b) ⊗ b
    
    morphism := PreComposeList( cat,
                        a,
                        [  RightUnitorInverse( cat, a ),
                           
                           TensorProductOnMorphisms( cat,
                                   IdentityMorphism( cat, a ),
                                   CoclosedEvaluationForCoDual( cat, b ) ),
                           
                           AssociatorRightToLeft( cat, a, CoDualOnObjects( cat, b ), b ),
                           
                           TensorProductOnMorphisms( cat,
                                   Braiding( cat, a, CoDualOnObjects( cat, b ) ),
                                   IdentityMorphism( cat, b ) ),
                           
                           TensorProductOnMorphisms( cat,
                                   IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, b, a ),
                                   IdentityMorphism( cat, b ) ) ],
                        internal_cohom_tensored_b );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoclosedEvaluationMorphismWithGivenRange,
                    "CoclosedEvaluationMorphismWithGivenRange using the rigidity and strictness of the monoidal category",
                    [ [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ IdentityMorphism, 3 ],
                      [ CoclosedEvaluationForCoDual, 1 ],
                      [ Braiding, 1 ],
                      [ CoDualOnObjects, 1 ],
                      [ IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom, 1 ] ],
                    
  function( cat, a, b, internal_cohom_tensored_b )
    local morphism;
    
    #    a ⊗ 1
    #      |
    #      | id_a ⊗ coclev_b
    #      v
    # a ⊗ b_v ⊗ b
    #      |
    #      | B_( a, Codual(b) ) ⊗ id_b
    #      v
    # b_v ⊗ a ⊗ b
    #      |
    #      | Isomorphism ⊗ id_b
    #      v
    # Cohom(a,b) ⊗ b
    
    morphism := PreComposeList( cat,
                        a,
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, a ),
                                CoclosedEvaluationForCoDual( cat, b ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, a, CoDualOnObjects( cat, b ) ),
                                  IdentityMorphism( cat, b ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, b, a ),
                                  IdentityMorphism( cat, b ) ) ],
                        internal_cohom_tensored_b );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsRigidSymmetricCoclosedMonoidalCategory( cat ) and IsRigidSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( CoclosedCoevaluationMorphismWithGivenSource,
                    "CoclosedCoevaluationMorphismWithGivenSource using the rigidity of the monoidal category",
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
    local codual_b, id_a, morphism;
    
    # Cohom(a ⊗ b, b)
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
    
    codual_b := CoDualOnObjects( cat, b );
    
    id_a := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat,
                        internal_cohom,
                        [ IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat,
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
                                  CoclosedCoevaluationForCoDual( cat, b ),
                                  id_a ),
                          
                          LeftUnitor( cat, a ) ],
                        a );
    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( CoclosedCoevaluationMorphismWithGivenSource,
                    "CoclosedCoevaluationMorphismWithGivenSource using the rigidity of the monoidal category",
                    [ [ CoDualOnObjects, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromInternalCoHomToTensorProductWithCoDualObject, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ TensorProductOnMorphisms, 3 ],
                      [ Braiding, 2 ],
                      [ CoclosedCoevaluationForCoDual, 1 ] ],
                    
  function( cat, a, b, internal_cohom )
    local codual_b, id_a, morphism;
    
    # Cohom(a ⊗ b, b)
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
    
    codual_b := CoDualOnObjects( cat, b );
    
    id_a := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat,
                        internal_cohom,
                        [ IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat,
                                TensorProductOnObjects( cat, a, b ),
                                b ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, codual_b ),
                                  Braiding( cat, a, b ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  Braiding( cat, codual_b, b ),
                                  id_a ),
                          
                          TensorProductOnMorphisms( cat,
                                  CoclosedCoevaluationForCoDual( cat, b ),
                                  id_a ) ],
                        a );
    
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
    # Cohom(a,a)
    #    |
    #    | CoLambdaIntro( id_a )
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
    # Cohom(a,a)
    #    |
    #    | CoLambdaIntro( alpha )
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
    
    # Inverse( Cohom( a ⊗ a', b ⊗ b') → Cohom(a,b) ⊗ Cohom(a',b') )
    
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
