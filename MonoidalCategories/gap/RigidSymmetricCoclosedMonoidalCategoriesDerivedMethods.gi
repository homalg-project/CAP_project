# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( InternalCoHomOnObjects,
                  
  function( cat, a, b )

    # Source( Cohom(a,b) → b_v ⊗ a )
    
    return Source( IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat, a, b ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomOnObjects as the source of IsomorphismFromInternalCoHomToTensorProductWithCoDualObject" );

##
AddDerivationToCAP( InternalCoHomOnObjects,
                  
  function( cat, a, b )

    # Range( b_v ⊗ a → Cohom(a,b) )
    
    return Range( IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, b, a ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalCoHomOnObjects as the range of IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom" );

##
AddDerivationToCAP( InternalCoHomOnMorphismsWithGivenInternalCoHoms,
                  
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
    
    return PreComposeList( cat, [
             IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat, Source( alpha ), Range( beta ) ),
             TensorProductOnMorphisms( cat, codual_beta, alpha ),
             IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, Range( alpha ), Source( beta ) )
           ] );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomOnMorphismsWithGivenInternalCoHoms using functoriality of CoDual and TensorProduct" );

##
AddDerivationToCAP( MorphismToCoBidualWithGivenCoBidual,
                  
  function( cat, a, cobidual )

    # Inverse( (a_v)_v → a )
    
    return InverseForMorphisms( cat, MorphismFromCoBidualWithGivenCoBidual( cat, a, cobidual ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "MorphismToCoBidualWithGivenCoBidual as the inverse of MorphismFromCoBidualWithGivenCoBidual" );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,
                  
  function( cat, a, cobidual )

    # Inverse( a → (a_v)_v )
    
    return InverseForMorphisms( cat, MorphismToCoBidualWithGivenCoBidual( cat, a, cobidual ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "MorphismFromCoBidualWithGivenCoBidual as the inverse of MorphismToCoBidualWithGivenCoBidual" );

##
AddDerivationToCAP( CoclosedEvaluationMorphismWithGivenRange,
                  
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
    
    morphism := PreComposeList( cat, [
                  RightUnitorInverse( cat, a ),
                  
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, a ),
                    CoclosedEvaluationForCoDual( cat, b ) ),

                  AssociatorRightToLeft( cat, a, CoDualOnObjects( cat, b ), b ),
                  
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, a, CoDualOnObjects( cat, b ) ),
                    IdentityMorphism( cat, b ) ),
                  
                  TensorProductOnMorphisms( cat,
                    IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, b, a ),
                    IdentityMorphism( cat, b ) )
                ] );
                    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "CoclosedEvaluationMorphismWithGivenRange using the rigidity of the monoidal category" );

##
AddDerivationToCAP( CoclosedEvaluationMorphismWithGivenRange,
                    
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
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, a ),
                    CoclosedEvaluationForCoDual( cat, b ) ),
                  
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, a, CoDualOnObjects( cat, b ) ),
                    IdentityMorphism( cat, b ) ),
                  
                  TensorProductOnMorphisms( cat,
                    IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, b, a ),
                    IdentityMorphism( cat, b ) )
                ] );
                    
    return morphism;
      
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "CoclosedEvaluationMorphismWithGivenRange using the rigidity and strictness of the monoidal category" );

##
AddDerivationToCAP( CoclosedCoevaluationMorphismWithGivenSource,
                    
  function( cat, a, b, internal_cohom )
    local morphism, codual_b, id_a;

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
    
    morphism := PreComposeList( cat, [
                  IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat,
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
                  
                  LeftUnitor( cat, a )
                ] );
                    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "CoclosedCoevaluationMorphismWithGivenSource using the rigidity of the monoidal category" );

##
AddDerivationToCAP( CoclosedCoevaluationMorphismWithGivenSource,
                    
  function( cat, a, b, internal_cohom )
    local morphism, codual_b, id_a;

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
    
    morphism := PreComposeList( cat, [
                  IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat,
                    TensorProductOnObjects( cat, a, b ),
                    b),
                  
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, codual_b ),
                    Braiding( cat, a, b ) ),
                  
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, codual_b, b ),
                    id_a ),
                  
                  TensorProductOnMorphisms( cat,
                    CoclosedCoevaluationForCoDual( cat, b ),
                    id_a ),
                ] );
                    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "CoclosedCoevaluationMorphismWithGivenSource using the rigidity of the monoidal category" );

##
AddDerivationToCAP( MorphismFromInternalCoHomToTensorProductWithGivenObjects,
                  
  function( cat, internal_cohom, a, b, tensor_object )
    
    return IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromInternalCoHomToTensorProductWithGivenObjects using IsomorphismFromInternalCoHomToTensorProductWithCoDualObject" );


##
AddDerivationToCAP( MorphismFromTensorProductToInternalCoHomWithGivenObjects,
                  
  function( cat, tensor_object, a, b, internal_hom )
    
    return IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromTensorProductToInternalCoHomWithGivenObjects using IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom" );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToTensorProductWithCoDualObject,
                    
  function( cat, a, b )
    
    return MorphismFromInternalCoHomToTensorProduct( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalCoHomToTensorProductWithCoDualObject using MorphismFromInternalCoHomToTensorProduct" );

##
AddDerivationToCAP( IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom,
                    
  function( cat, a, b )
    
    return MorphismFromTensorProductToInternalCoHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom using MorphismFromTensorProductToInternalCoHom" );

AddDerivationToCAP( CoclosedCoevaluationForCoDualWithGivenTensorProduct,
                    
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
    
    morphism := PreComposeList( cat, [
                  Braiding( cat, a, CoDualOnObjects( cat, a ) ),
                  IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, a, a ),
                  CoLambdaIntroduction( cat, morphism ) 
                ] );
                            
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "CoclosedCoevaluationForCoDualWithGivenTensorProduct using CoLambdaIntroduction on the identity and IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom" );

##
AddDerivationToCAP( CoTraceMap,
                    
  function( cat, alpha )
    local a;

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
    
    return PreComposeList( cat, [
             CoclosedEvaluationForCoDual( cat, a ) ,
             IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat, a, a ),
             CoLambdaIntroduction( cat, alpha )
           ] );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "CoTraceMap using CoclosedEvaluationForCoDual and CoLambdaIntroduction" );

##
AddDerivationToCAP( CoRankMorphism,
                    
  function( cat, a )
    
    return CoTraceMap( cat, IdentityMorphism( cat, a ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "Corank of an object as the cotrace of its identity" );

##
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects,
                    
  function( cat, source, list, range )

    # Inverse( Cohom( a ⊗ a', b ⊗ b') → Cohom(a,b) ⊗ Cohom(a',b') )
    
    return InverseForMorphisms( cat, InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects( cat, source, list, range ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects as the inverse of TensorProductInternalCoHomCompatibilityMorphismWithGivenObjects" );

####################################
## Final derived methods
####################################

## Final methods for InternalCoHom

##
AddFinalDerivation( IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom,
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
                      IsomorphismFromInternalCoHomToTensorProductWithCoDualObject ],
                    
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, a, CoDualOnObjects( cat, b ) ) );
    
  end,
[
  IsomorphismFromInternalCoHomToTensorProductWithCoDualObject,
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, a, CoDualOnObjects( cat, b ) ) );
    
  end
],
[
  IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject,
  function( cat, object )
    
    return LeftUnitor( cat, CoDualOnObjects( cat, object ) );
    
  end
],
[
  IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit,
  function( cat, object )
    
    return LeftUnitorInverse( cat, CoDualOnObjects( cat, object ) );
    
  end
] : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
    Description := "deriving the internal cohom by tensoring with the codual object"
);
