# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( InternalCoHomOnObjects,
                  
  function( cat, a, b )

    # Source( Cohom(a,b) -> b_v x a )
    
    return Source( IsomorphismFromInternalCoHomToTensorProduct( cat, a, b ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomOnObjects as the source of IsomorphismFromInternalCoHomToTensorProduct" );

##
AddDerivationToCAP( InternalCoHomOnObjects,
                  
  function( cat, a, b )

    # Range( b_v x a -> Cohom(a,b) )
    
    return Range( IsomorphismFromTensorProductToInternalCoHom( cat, b, a ) );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "InternalCoHomOnObjects as the range of IsomorphismFromTensorProductToInternalCoHom" );

##
AddDerivationToCAP( InternalCoHomOnMorphismsWithGivenInternalCoHoms,
                  
  function( cat, internal_cohom_source, alpha, beta, internal_cohom_range )
    local codual_beta;

    # alpha: a -> a'
    # beta: b -> b'
    #
    # Cohom(a,b')
    #     |
    #     |
    #     v
    # b'^v x a
    #     |
    #     | Codual(beta) x alpha
    #     v
    # b^v x a'
    #     |
    #     |
    #     v
    # Cohom(a',b)
    
    codual_beta := CoDualOnMorphisms( cat, beta );
    
    return PreComposeList( cat, [
             IsomorphismFromInternalCoHomToTensorProduct( cat, Source( alpha ), Range( beta ) ),
             TensorProductOnMorphisms( cat, codual_beta, alpha ),
             IsomorphismFromTensorProductToInternalCoHom( cat, Range( alpha ), Source( beta ) )
           ] );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomOnMorphismsWithGivenInternalCoHoms using functoriality of CoDual and TensorProduct" );

##
AddDerivationToCAP( MorphismToCoBidualWithGivenCoBidual,
                  
  function( cat, a, cobidual )

    # Inverse( (a_v)_v -> a )
    
    return InverseForMorphisms( cat, MorphismFromCoBidualWithGivenCoBidual( cat, a, cobidual ) );
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "MorphismToCoBidualWithGivenCoBidual as the inverse of MorphismFromCoBidualWithGivenCoBidual" );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,
                  
  function( cat, a, cobidual )

    # Inverse( a -> (a_v)_v )
    
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
    #    a x 1
    #      |
    #      | id_a x coclev_b
    #      v
    # a x (b_v x b)
    #      |
    #      | α_( a, ( b_v, b ) )
    #      v
    # (a x b_v) x b
    #      |
    #      | B_( a, Codual(b) ) x id_b
    #      v
    # (b_v x a) x b
    #      |
    #      | Isomorphism x id_b
    #      v
    # Cohom(a,b) x b
    
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
                    IsomorphismFromTensorProductToInternalCoHom( cat, b, a ),
                    IdentityMorphism( cat, b ) )
                ] );
                    
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "CoclosedEvaluationMorphismWithGivenRange using the rigidity of the monoidal category" );

##
AddDerivationToCAP( CoclosedEvaluationMorphismWithGivenRange,
                    
  function( cat, a, b, internal_cohom_tensored_b )
    local morphism;

    #    a x 1
    #      |
    #      | id_a x coclev_b
    #      v
    # a x b_v x b
    #      |
    #      | B_( a, Codual(b) ) x id_b
    #      v
    # b_v x a x b
    #      |
    #      | Isomorphism x id_b
    #      v
    # Cohom(a,b) x b
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, a ),
                    CoclosedEvaluationForCoDual( cat, b ) ),
                  
                  TensorProductOnMorphisms( cat,
                    Braiding( cat, a, CoDualOnObjects( cat, b ) ),
                    IdentityMorphism( cat, b ) ),
                  
                  TensorProductOnMorphisms( cat,
                    IsomorphismFromTensorProductToInternalCoHom( cat, b, a ),
                    IdentityMorphism( cat, b ) )
                ] );
                    
    return morphism;
      
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "CoclosedEvaluationMorphismWithGivenRange using the rigidity and strictness of the monoidal category" );

##
AddDerivationToCAP( CoclosedCoevaluationMorphismWithGivenSource,
                    
  function( cat, a, b, internal_cohom )
    local morphism, codual_b, id_a;

    # Cohom(a x b, b)
    #       |
    #       | Isomorphism
    #       v
    #  b_v x (a x b)
    #       |
    #       | id_(b_v) x B_( a, b )
    #       v
    #  b_v x (b x a)
    #       |
    #       | α_( b_v, ( b, a ) )
    #       v
    #  (b_v x b) x a
    #       |
    #       | B_( b_v, b ) x id_a
    #       v
    # (b x b_v) x a
    #       |
    #       | coclcoev_b x id_a
    #       v
    #     1 x a
    #       |
    #       | λ_a
    #       v
    #       a
    
    codual_b := CoDualOnObjects( cat, b );
    
    id_a := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat, [
                  IsomorphismFromInternalCoHomToTensorProduct( cat,
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

    # Cohom(a x b, b)
    #       |
    #       | Isomorphism
    #       v
    #  b_v x (a x b)
    #       |
    #       | id_(b_v) x B_( a, b )
    #       v
    #  b_v x (b x a)
    #       |
    #       | B_( b_v, b ) x id_a
    #       v
    # (b x b_v) x a
    #       |
    #       | coclcoev_b x id_a
    #       v
    #     1 x a
    
    codual_b := CoDualOnObjects( cat, b );
    
    id_a := IdentityMorphism( cat, a );
    
    morphism := PreComposeList( cat, [
                  IsomorphismFromInternalCoHomToTensorProduct( cat,
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
    
    return IsomorphismFromInternalCoHomToTensorProduct( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromInternalCoHomToTensorProductWithGivenObjects using IsomorphismFromInternalCoHomToTensorProduct" );


##
AddDerivationToCAP( MorphismFromTensorProductToInternalCoHomWithGivenObjects,
                  
  function( cat, tensor_object, a, b, internal_hom )
    
    return IsomorphismFromTensorProductToInternalCoHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "MorphismFromTensorProductToInternalCoHomWithGivenObjects using IsomorphismFromTensorProductToInternalCoHom" );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToTensorProduct,
                    
  function( cat, a, b )
    
    return MorphismFromInternalCoHomToTensorProduct( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromInternalCoHomToTensorProduct using MorphismFromInternalCoHomToTensorProduct" );

##
AddDerivationToCAP( IsomorphismFromTensorProductToInternalCoHom,
                    
  function( cat, a, b )
    
    return MorphismFromTensorProductToInternalCoHom( cat, a, b );
    
end : CategoryFilter := IsRigidSymmetricClosedMonoidalCategory,
      Description := "IsomorphismFromTensorProductToInternalCoHom using MorphismFromTensorProductToInternalCoHom" );

AddDerivationToCAP( CoclosedCoevaluationForCoDualWithGivenTensorProduct,
                    
  function( cat, tensor_object, a, unit )
    local morphism;

    # a x a_v
    #    |
    #    | B_( a, a_v )
    #    v
    # a_v x a
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
                  IsomorphismFromTensorProductToInternalCoHom( cat, a, a ),
                  CoLambdaIntroduction( cat, morphism ) 
                ] );
                            
    return morphism;
    
end : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
      Description := "CoclosedCoevaluationForCoDualWithGivenTensorProduct using CoLambdaIntroduction on the identity and IsomorphismFromTensorProductToInternalCoHom" );

##
AddDerivationToCAP( CoTraceMap,
                    
  function( cat, alpha )
    local a;

    # alpha: a -> a
    #
    #    1
    #    |
    #    | coclev_a
    #    v
    # a_v x a
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
             IsomorphismFromTensorProductToInternalCoHom( cat, a, a ),
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

    # Inverse( Cohom( a x a', b x b') -> Cohom(a,b) x Cohom(a',b') )
    
    return InverseForMorphisms( cat, InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects( cat, source, list, range ) );
    
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
                      IsomorphismFromTensorProductToInternalCoHom,
                      IsomorphismFromInternalCoHomToTensorProduct ],
                    
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, a, CoDualOnObjects( cat, b ) ) );
    
  end,
[
  IsomorphismFromInternalCoHomToTensorProduct,
  function( cat, a, b )
    
    return IdentityMorphism( cat, TensorProductOnObjects( cat, a, CoDualOnObjects( cat, b ) ) );
    
  end
],
[
  IsomorphismFromInternalCoHomToCoDual,
  function( cat, object )
    
    return LeftUnitor( cat, CoDualOnObjects( cat, object ) );
    
  end
],
[
  IsomorphismFromCoDualToInternalCoHom,
  function( cat, object )
    
    return LeftUnitorInverse( cat, CoDualOnObjects( cat, object ) );
    
  end
] : CategoryFilter := IsRigidSymmetricCoclosedMonoidalCategory,
    Description := "deriving the internal cohom by tensoring with the codual object"
);
