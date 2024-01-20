# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( MorphismFromLeftCoBidualWithGivenLeftCoBidual,
                    "MorphismFromLeftCoBidualWithGivenLeftCoBidual using the braiding and the universal property of the codual",
                    [ [ PreCompose, 1 ],
                      [ LeftCoclosedMonoidalEvaluationForLeftCoDual, 1 ],
                      [ Braiding, 1 ],
                      [ LeftCoDualOnObjects, 2 ],
                      [ UniversalPropertyOfLeftCoDual, 1 ] ],
                    
  function( cat, a, avv )
    local alpha;
    
    #    1
    #    |
    #    | coclev_a
    #    v
    # a_v ⊗ a
    #    |
    #    | B_(a_v,a)
    #    v
    #  a ⊗ a_v
    #
    # UniversalPropertyOfLeftCoDual( 1 → a ⊗ a_v) = ( a_v_v → a )

    alpha := PreCompose( cat,
                  LeftCoclosedMonoidalEvaluationForLeftCoDual( cat, a ),
                  Braiding( cat, LeftCoDualOnObjects( cat, a ), a ) );
                  
    return UniversalPropertyOfLeftCoDual( cat, a, LeftCoDualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromLeftCoBidualWithGivenLeftCoBidual,
                    "MorphismFromLeftCoBidualWithGivenLeftCoBidual using LeftCoclosedMonoidalEvaluation, LeftInternalCoHom, and LeftCoclosedMonoidalCoevaluation",
                    [ [ LeftCoDualOnObjects, 1 ],
                      [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ LeftInternalCoHomOnMorphisms, 2 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 1 ],
                      [ LeftCoclosedMonoidalCoevaluationMorphism, 1 ] ],
                    
  function( cat, a, avv )
    local av, morphism;
    
    #     coHom(1, a_v)
    #          |
    #          | coHom( coclev_(1,a), id_(a_v) )
    #          v
    # coHom(a_v ⊗ a, a_v)
    #          |
    #          | coHom( B_( a_v, a), id_(a_v) )
    #          v
    # coHom(a ⊗ a_v, a_v)
    #          |
    #          | coclcoev_(a, a_v)
    #          v
    #          a
    
    av := LeftCoDualOnObjects( cat, a );
    
    morphism := PreComposeList( cat,
                        avv,
                        [ LeftInternalCoHomOnMorphisms( cat,
                                LeftCoclosedMonoidalEvaluationMorphism( cat, TensorUnit( cat ), a ),
                                IdentityMorphism( cat, av ) ),
                          
                          LeftInternalCoHomOnMorphisms( cat,
                                  Braiding( cat, av, a ),
                                  IdentityMorphism( cat, av ) ),
                          
                          LeftCoclosedMonoidalCoevaluationMorphism( cat, a, av ) ],
                        a );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                    "LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using associator, braiding and the coclosed evaluation morphism",
                    [ [ LeftInternalCoHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 7 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 2 ],
                      [ AssociatorRightToLeft, 2 ],
                      [ AssociatorLeftToRight, 2 ],
                      [ Braiding, 1 ],
                      [ TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, a2, b1, b2, b1b2, int_cohom_a1_b1, int_cohom_a2_b2, id_b2, morphism;
    
    #                   a1 ⊗ a2
    #                      |
    #                      | id_a1 ⊗ coclev_(a2,b2)
    #                      v
    #          a1 ⊗ (coHom(a2,b2) ⊗ b2)
    #                      |
    #                      | α_( a1, (coHom(a2,b2), b2) )
    #                      v
    #          (a1 ⊗ coHom(a2,b2)) ⊗ b2
    #                      |
    #                      | ( coclev_(a1,b1) ⊗ id_coHom(a2,b2) ) ⊗ id_b2
    #                      v
    # ((coHom(a1,b1) ⊗ b1) ⊗ coHom(a2,b2)) ⊗ b2
    #                      |
    #                      | α_( (coHom(a1,b1), b1), coHom(a2,b2) ) ) ⊗ id_b2
    #                      v
    #  (coHom(a1,b1) ⊗ (b1 ⊗ coHom(a2,b2))) ⊗ b2
    #                      |
    #                      | ( id_coHom(a1,b1) ⊗ B_( b1, coHom(a2,b2) ) ) ⊗ id_b2
    #                      v
    #  (coHom(a1,b1) ⊗ (coHom(a2,b2) ⊗ b1)) ⊗ b2
    #                      |
    #                      | α_( coHom(a1,b1), (coHom(a2,b2), b1) ) ⊗ id_b2
    #                      v
    #  ((coHom(a1,b1) ⊗ coHom(a2,b2)) ⊗ b1) ⊗ b2
    #                      |
    #                      | α_( (coHom(a1,b1) ⊗ coHom(a2,b2), b1), b2 )
    #                      v
    #  (coHom(a1,b1) ⊗ coHom(a2,b2)) ⊗ (b1 ⊗ b2)
    #
    #
    # Adjoint[ a1 ⊗ a2 → (coHom(a1,b1) ⊗ coHom(a2,b2)) ⊗ (b1 ⊗ b2) ] = [ coHom(a1 ⊗ a2, b1 ⊗ b2) → coHom(a1,b1) ⊗ coHom(a2,b2) ]
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    b1b2 := TensorProductOnObjects( cat, b1, b2 );
    
    int_cohom_a1_b1 := LeftInternalCoHomOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := LeftInternalCoHomOnObjects( cat, a2, b2 );
    
    id_b2 := IdentityMorphism( cat, b2 );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat, a1, a2 ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, a1 ),
                                LeftCoclosedMonoidalEvaluationMorphism( cat, a2, b2 ) ),
                          
                          AssociatorRightToLeft( cat, a1, int_cohom_a2_b2, b2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          LeftCoclosedMonoidalEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, int_cohom_a2_b2 ) ),
                                  id_b2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  AssociatorLeftToRight( cat, int_cohom_a1_b1, b1, int_cohom_a2_b2 ),
                                  id_b2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          IdentityMorphism( cat, int_cohom_a1_b1 ),
                                          Braiding( cat, b1, int_cohom_a2_b2 ) ),
                                  id_b2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  AssociatorRightToLeft( cat, int_cohom_a1_b1, int_cohom_a2_b2, b1 ),
                                  id_b2 ),
                          
                          AssociatorLeftToRight( cat,
                                  range,
                                  b1, b2 ) ],
                        TensorProductOnObjects( cat,
                                range,
                                b1b2 ) );
    
    return TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom( cat,
                   range,
                   b1b2,
                   morphism,
                   source );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects,
                    "LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects using associator, braiding, coclosed evaluation, and cohom tensor adjunction",
                    [ [ LeftInternalCoHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local cohom_a_b, cohom_b_c, morphism;
    
    #           a
    #           |
    #           | coclev_ab
    #           v
    #    coHom(a,b) ⊗ b
    #           |
    #           | B_( coHom(a,b), b )
    #           v
    #      b ⊗ coHom(a,b)
    #           |
    #           | coclev_bc ⊗ id_coHom(a,b)
    #           v
    # (coHom(b,c) ⊗ c) ⊗ coHom(a,b)
    #           |
    #           | α_( ( coHom(b,c), c ), coHom(a,b) )
    #           v
    # coHom(b,c) ⊗ (c ⊗ coHom(a,b))
    #           |
    #           | id_coHom(b,c) ⊗ B_( c, coHom(a,b) )
    #           v
    # coHom(b,c) ⊗ (coHom(a,b) ⊗ c)
    #           |
    #           | α_( coHom(b,c), ( coHom(a,b), c ) )
    #           v
    # (coHom(b,c) ⊗ coHom(a,b)) ⊗ c
    #
    #
    # Adjoint( a → (coHom(b,c) ⊗ coHom(a,b)) ⊗ c ) = ( coHom(a,c) → coHom(b,c) ⊗ coHom(a,b) )
    
    cohom_a_b := LeftInternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := LeftInternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ LeftCoclosedMonoidalEvaluationMorphism( cat, a, b ),
                          
                          Braiding( cat, cohom_a_b, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  LeftCoclosedMonoidalEvaluationMorphism( cat, b, c ),
                                  IdentityMorphism( cat, cohom_a_b ) ),
                          
                          AssociatorLeftToRight( cat, cohom_b_c, c, cohom_a_b ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, cohom_b_c ),
                                  Braiding( cat, c, cohom_a_b ) ),
                          
                          AssociatorRightToLeft( cat, cohom_b_c, cohom_a_b, c ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects,
                    "LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects using LeftCoclosedMonoidalPreCoComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ LeftInternalCoHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ LeftCoclosedMonoidalPreCoComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;
    
    #       coHom(a,c)
    #            |
    #            | PreCoCompose
    #            v
    # coHom(b,c) ⊗ coHom(a,b)
    #            |
    #            | B_( coHom(b,c), coHom(a,b) )
    #            v
    # coHom(a,b) ⊗ coHom(b,c)
    
    braiding := Braiding( cat, LeftInternalCoHomOnObjects( cat, b, c ), LeftInternalCoHomOnObjects( cat, a, b ) );
    
    return PreCompose( cat, LeftCoclosedMonoidalPreCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects,
                    "LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects using LeftCoclosedMonoidalPostCoComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ LeftInternalCoHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ LeftCoclosedMonoidalPostCoComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;
    
    #       coHom(a,c)
    #            |
    #            | PostCoCompose
    #            v
    # coHom(a,b) ⊗ coHom(b,c)
    #            |
    #            | B_( coHom(a,b), coHom(b,c) )
    #            v
    # coHom(b,c) ⊗ coHom(a,b)

    braiding := Braiding( cat, LeftInternalCoHomOnObjects( cat, a, b ), LeftInternalCoHomOnObjects( cat, b, c ) );
    
    return PreCompose( cat, LeftCoclosedMonoidalPostCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                    "LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using braiding and the coclosed evaluation morphism",
                    [ [ LeftInternalCoHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 5 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 2 ],
                      [ Braiding, 1 ],
                      [ TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, a2, b1, b2, b1b2, int_cohom_a1_b1, int_cohom_a2_b2, id_b2, morphism;
    
    #           a1 ⊗ a2
    #              |
    #              | id_a1 ⊗ coclev_(a2,b2)
    #              v
    #    a1 ⊗ coHom(a2,b2) ⊗ b2
    #              |
    #              | coclev_(a1,b1) ⊗ id_coHom(a2,b2) ⊗ id_b2
    #              v
    # coHom(a1,b1) ⊗ b1 ⊗ coHom(a2,b2) ⊗ b2
    #              |
    #              | id_coHom(a1,b1) ⊗ B_( b1, coHom(a2,b2) )  ⊗ id_b2
    #              v
    # coHom(a1,b1) ⊗ coHom(a2,b2) ⊗ b1 ⊗ b2
    #
    #
    # Adjoint[ a1 ⊗ a2 → coHom(a1,b1) ⊗ coHom(a2,b2) ⊗ b1 ⊗ b2 ] = [ coHom(a1 ⊗ a2, b1 ⊗ b2) → coHom(a1,b1) ⊗ coHom(a2,b2) ]
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    b1b2 := TensorProductOnObjects( cat, b1, b2 );
    
    int_cohom_a1_b1 := LeftInternalCoHomOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := LeftInternalCoHomOnObjects( cat, a2, b2 );

    id_b2 := IdentityMorphism( cat, b2 );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat, a1, a2 ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, a1 ),
                                LeftCoclosedMonoidalEvaluationMorphism( cat, a2, b2 ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          LeftCoclosedMonoidalEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, int_cohom_a2_b2 ) ),
                                  id_b2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          IdentityMorphism( cat, int_cohom_a1_b1 ),
                                          Braiding( cat, b1, int_cohom_a2_b2 ) ),
                                  id_b2 ) ],
                        TensorProductOnObjects( cat,
                                range,
                                b1b2 ) );
    
    return TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom( cat,
                   range,
                   b1b2,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsSymmetricCoclosedMonoidalCategory( cat ) and IsSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects,
                    "LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects using braiding, coclosed evaluation, and cohom tensor adjunction",
                    [ [ LeftInternalCoHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ TensorProductOnObjects, 1 ],
                      [ TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local cohom_a_b, cohom_b_c, morphism;
    
    #            a
    #            |
    #            | coclev_ab
    #            v
    #      coHom(a,b) ⊗ b
    #            |
    #            | B_( coHom(a,b), b )
    #            v
    #      b ⊗ coHom(a,b)
    #            |
    #            | coclev_bc ⊗ id_coHom(a,b)
    #            v
    # coHom(b,c) ⊗ c ⊗ coHom(a,b)
    #            |
    #            | id_coHom(b,c) ⊗ B_( c, coHom(a,b) )
    #            v
    # coHom(b,c) ⊗ coHom(a,b) ⊗ c
    #
    #
    # Adjoint( a → (coHom(b,c) ⊗ coHom(a,b)) ⊗ c ) = ( coHom(a,c) → coHom(b,c) ⊗ coHom(a,b) )
    
    cohom_a_b := LeftInternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := LeftInternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ LeftCoclosedMonoidalEvaluationMorphism( cat, a, b ),
                          
                          Braiding( cat, cohom_a_b, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  LeftCoclosedMonoidalEvaluationMorphism( cat, b, c ),
                                  IdentityMorphism( cat, cohom_a_b ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, cohom_b_c ),
                                  Braiding( cat, c, cohom_a_b ) ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsSymmetricCoclosedMonoidalCategory( cat ) and IsSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );
