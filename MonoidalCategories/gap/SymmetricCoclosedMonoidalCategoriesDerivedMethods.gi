# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToInternalCoHomRightAdjunctMorphismWithGivenInternalCoHom,
                    "TensorProductToInternalCoHomRightAdjunctMorphismWithGivenInternalCoHom using TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom and the braiding",
                    [ [ TensorProductOnObjects, 1 ],
                      [ BraidingWithGivenTensorProducts, 1 ],
                      [ PreCompose, 1 ],
                      [ TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom, 1 ] ],
                    
  function( cat, b, c, g, i )
    
    ## coHom( a, b ) = i → c
    return TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom( cat,
                   c,
                   b,
                   ## a → c ⊗ b
                   PreCompose( cat,
                           ## g: a → b ⊗ c
                           g,
                           ## b ⊗ c → c ⊗ b
                           BraidingWithGivenTensorProducts( cat,
                                   Range( g ),
                                   b,
                                   c,
                                   TensorProductOnObjects( cat, c, b ) ) ),
                   ## coHom( a, b )
                   i );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom,
                    "TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom using TensorProductToInternalCoHomRightAdjunctMorphismWithGivenInternalCoHom and the braiding",
                    [ [ TensorProductOnObjects, 1 ],
                      [ BraidingWithGivenTensorProducts, 1 ],
                      [ PreCompose, 1 ],
                      [ TensorProductToInternalCoHomRightAdjunctMorphismWithGivenInternalCoHom, 1 ] ],
                    
  function( cat, b, c, g, i )
    
    ## coHom( a, c ) = i → b
    return TensorProductToInternalCoHomRightAdjunctMorphismWithGivenInternalCoHom( cat,
                   c,
                   b,
                   ## a → c ⊗ b
                   PreCompose( cat,
                           ## g: a → b ⊗ c
                           g,
                           ## b ⊗ c → c ⊗ b
                           BraidingWithGivenTensorProducts( cat,
                                   Range( g ),
                                   b,
                                   c,
                                   TensorProductOnObjects( cat, c, b ) ) ),
                   ## coHom( a, c )
                   i );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( InternalCoHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct,
                    "InternalCoHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct using InternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct and the braiding",
                    [ [ TensorProductOnObjects, 1 ],
                      [ BraidingInverseWithGivenTensorProducts, 1 ],
                      [ InternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, a, b, f, t )
    local c, c_tensor_b;
    
    ## f: coHom(a,b) → c
    c := Range( f );
    
    ## c ⊗ b
    c_tensor_b := TensorProductOnObjects( cat, c, b );
    
    ## a → b ⊗ c
    return PreCompose( cat,
                   ## a → c ⊗ b
                   InternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( cat,
                           a,
                           b,
                           f,
                           c_tensor_b ),
                   ## c ⊗ b → b ⊗ c
                   BraidingInverseWithGivenTensorProducts( cat,
                           c_tensor_b,
                           b,
                           c,
                           # b ⊗ c
                           t ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( InternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct,
                    "InternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct using InternalCoHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct and the braiding",
                    [ [ TensorProductOnObjects, 1 ],
                      [ BraidingInverseWithGivenTensorProducts, 1 ],
                      [ InternalCoHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, a, c, f, t )
    local b, c_tensor_b;
    
    ## f: coHom(a,c) → b
    b := Range( f );
    
    ## c ⊗ b
    c_tensor_b := TensorProductOnObjects( cat, c, b );
    
    ## a → b ⊗ c
    return PreCompose( cat,
                   ## a → c ⊗ b
                   InternalCoHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct( cat,
                           a,
                           c,
                           f,
                           c_tensor_b ),
                   ## c ⊗ b → b ⊗ c
                   BraidingInverseWithGivenTensorProducts( cat,
                           c_tensor_b,
                           b,
                           c,
                           # b ⊗ c
                           t ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,
                    "MorphismFromCoBidualWithGivenCoBidual using the braiding and the universal property of the codual",
                    [ [ PreCompose, 1 ],
                      [ CoclosedEvaluationForCoDual, 1 ],
                      [ Braiding, 1 ],
                      [ CoDualOnObjects, 2 ],
                      [ UniversalPropertyOfCoDual, 1 ] ],
                    
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
    # UniversalPropertyOfCoDual( 1 → a ⊗ a_v) = ( a_v_v → a )

    alpha := PreCompose( cat,
                  CoclosedEvaluationForCoDual( cat, a ),
                  Braiding( cat, CoDualOnObjects( cat, a ), a ) );
                  
    return UniversalPropertyOfCoDual( cat, a, CoDualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,
                    "MorphismFromCoBidualWithGivenCoBidual using CoclosedMonoidalEvaluation, InternalCoHom, and CoclosedMonoidalCoevaluation",
                    [ [ CoDualOnObjects, 1 ],
                      [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ InternalCoHomOnMorphisms, 2 ],
                      [ CoclosedMonoidalLeftEvaluationMorphism, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 1 ],
                      [ CoclosedMonoidalLeftCoevaluationMorphism, 1 ] ],
                    
  function( cat, a, avv )
    local av, morphism;
    
    #     coHom(1, a_v)
    #          |
    #          | coHom( coclev_(a,1), id_(a_v) )
    #          v
    # coHom(a_v ⊗ a, a_v)
    #          |
    #          | coHom( B_( a_v, a), id_(a_v) )
    #          v
    # coHom(a ⊗ a_v, a_v)
    #          |
    #          | coclcoev_(a_v,a)
    #          v
    #          a
    
    av := CoDualOnObjects( cat, a );
    
    morphism := PreComposeList( cat,
                        avv,
                        [ InternalCoHomOnMorphisms( cat,
                                CoclosedMonoidalLeftEvaluationMorphism( cat, a, TensorUnit( cat ) ),
                                IdentityMorphism( cat, av ) ),
                          
                          InternalCoHomOnMorphisms( cat,
                                  Braiding( cat, av, a ),
                                  IdentityMorphism( cat, av ) ),
                          
                          CoclosedMonoidalLeftCoevaluationMorphism( cat, av, a ) ],
                        a );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                    "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using associator, braiding and the coclosed evaluation morphism",
                    [ [ InternalCoHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 7 ],
                      [ CoclosedMonoidalLeftEvaluationMorphism, 2 ],
                      [ AssociatorRightToLeft, 2 ],
                      [ AssociatorLeftToRight, 2 ],
                      [ Braiding, 1 ],
                      [ TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom, 1 ] ],
                    
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
    
    int_cohom_a1_b1 := InternalCoHomOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := InternalCoHomOnObjects( cat, a2, b2 );
    
    id_b2 := IdentityMorphism( cat, b2 );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat, a1, a2 ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, a1 ),
                                CoclosedMonoidalLeftEvaluationMorphism( cat, b2, a2 ) ),
                          
                          AssociatorRightToLeft( cat, a1, int_cohom_a2_b2, b2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          CoclosedMonoidalLeftEvaluationMorphism( cat, b1, a1 ),
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
    
    return TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom( cat,
                   range,
                   b1b2,
                   morphism,
                   source );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                    "MonoidalPreCoComposeMorphismWithGivenObjects using associator, braiding, coclosed evaluation, and cohom tensor adjunction",
                    [ [ InternalCoHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CoclosedMonoidalLeftEvaluationMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom, 1 ],
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
    
    cohom_a_b := InternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := InternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ CoclosedMonoidalLeftEvaluationMorphism( cat, b, a ),
                          
                          Braiding( cat, cohom_a_b, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  CoclosedMonoidalLeftEvaluationMorphism( cat, c, b ),
                                  IdentityMorphism( cat, cohom_a_b ) ),
                          
                          AssociatorLeftToRight( cat, cohom_b_c, c, cohom_a_b ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, cohom_b_c ),
                                  Braiding( cat, c, cohom_a_b ) ),
                          
                          AssociatorRightToLeft( cat, cohom_b_c, cohom_a_b, c ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    "MonoidalPostCoComposeMorphismWithGivenObjects using MonoidalPreCoComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ InternalCoHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ MonoidalPreCoComposeMorphism, 1 ] ],
                    
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
    
    braiding := Braiding( cat, InternalCoHomOnObjects( cat, b, c ), InternalCoHomOnObjects( cat, a, b ) );
    
    return PreCompose( cat, MonoidalPreCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                    "MonoidalPreCoComposeMorphismWithGivenObjects using MonoidalPostCoComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ InternalCoHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ MonoidalPostCoComposeMorphism, 1 ] ],
                    
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

    braiding := Braiding( cat, InternalCoHomOnObjects( cat, a, b ), InternalCoHomOnObjects( cat, b, c ) );
    
    return PreCompose( cat, MonoidalPostCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory );

##
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                    "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using braiding and the coclosed evaluation morphism",
                    [ [ InternalCoHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 5 ],
                      [ CoclosedMonoidalLeftEvaluationMorphism, 2 ],
                      [ Braiding, 1 ],
                      [ TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom, 1 ] ],
                    
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
    
    int_cohom_a1_b1 := InternalCoHomOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := InternalCoHomOnObjects( cat, a2, b2 );

    id_b2 := IdentityMorphism( cat, b2 );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat, a1, a2 ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, a1 ),
                                CoclosedMonoidalLeftEvaluationMorphism( cat, b2, a2 ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          CoclosedMonoidalLeftEvaluationMorphism( cat, b1, a1 ),
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
    
    return TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom( cat,
                   range,
                   b1b2,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsSymmetricCoclosedMonoidalCategory( cat ) and IsSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                    "MonoidalPreCoComposeMorphismWithGivenObjects using braiding, coclosed evaluation, and cohom tensor adjunction",
                    [ [ InternalCoHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CoclosedMonoidalLeftEvaluationMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ TensorProductOnObjects, 1 ],
                      [ TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom, 1 ] ],
                    
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
    
    cohom_a_b := InternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := InternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ CoclosedMonoidalLeftEvaluationMorphism( cat, b, a ),
                          
                          Braiding( cat, cohom_a_b, b ),
                          
                          TensorProductOnMorphisms( cat,
                                  CoclosedMonoidalLeftEvaluationMorphism( cat, c, b ),
                                  IdentityMorphism( cat, cohom_a_b ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, cohom_b_c ),
                                  Braiding( cat, c, cohom_a_b ) ) ],
                        TensorProductOnObjects( cat,
                                range,
                                c ) );
    
    return TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsSymmetricCoclosedMonoidalCategory( cat ) and IsSymmetricCoclosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );
