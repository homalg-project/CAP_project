# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CoproductToCoexponentialRightAdjunctionMapWithGivenCoexponential,
                    "CoproductToCoexponentialRightAdjunctionMapWithGivenCoexponential using CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential and the braiding",
                    [ [ Coproduct, 1 ],
                      [ CocartesianBraidingWithGivenCoproducts, 1 ],
                      [ PreCompose, 1 ],
                      [ CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential, 1 ] ],
                    
  function( cat, b, c, g, i )
    
    ## Coexp( a, b ) = i → c
    return CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential( cat,
                   c,
                   b,
                   ## a → c ⊔ b
                   PreCompose( cat,
                           ## g: a → b ⊔ c
                           g,
                           ## b ⊔ c → c ⊔ b
                           CocartesianBraidingWithGivenCoproducts( cat,
                                   Range( g ),
                                   b,
                                   c,
                                   BinaryCoproduct( cat, c, b ) ) ),
                   ## Coexp( a, b )
                   i );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential,
                    "CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential using CoproductToCoexponentialRightAdjunctionMapWithGivenCoexponential and the braiding",
                    [ [ Coproduct, 1 ],
                      [ CocartesianBraidingWithGivenCoproducts, 1 ],
                      [ PreCompose, 1 ],
                      [ CoproductToCoexponentialRightAdjunctionMapWithGivenCoexponential, 1 ] ],
                    
  function( cat, b, c, g, i )
    
    ## Coexp( a, c ) = i → b
    return CoproductToCoexponentialRightAdjunctionMapWithGivenCoexponential( cat,
                   c,
                   b,
                   ## a → c ⊔ b
                   PreCompose( cat,
                           ## g: a → b ⊔ c
                           g,
                           ## b ⊔ c → c ⊔ b
                           CocartesianBraidingWithGivenCoproducts( cat,
                                   Range( g ),
                                   b,
                                   c,
                                   BinaryCoproduct( cat, c, b ) ) ),
                   ## Coexp( a, c )
                   i );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CoexponentialToCoproductRightAdjunctionMapWithGivenCoproduct,
                    "CoexponentialToCoproductRightAdjunctionMapWithGivenCoproduct using CoexponentialToCoproductLeftAdjunctionMapWithGivenCoproduct and the braiding",
                    [ [ Coproduct, 1 ],
                      [ CocartesianBraidingInverseWithGivenCoproducts, 1 ],
                      [ CoexponentialToCoproductLeftAdjunctionMapWithGivenCoproduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, a, b, f, t )
    local c, c_tensor_b;
    
    ## f: Coexp(a,b) → c
    c := Range( f );
    
    ## c ⊔ b
    c_tensor_b := BinaryCoproduct( cat, c, b );
    
    ## a → b ⊔ c
    return PreCompose( cat,
                   ## a → c ⊔ b
                   CoexponentialToCoproductLeftAdjunctionMapWithGivenCoproduct( cat,
                           a,
                           b,
                           f,
                           c_tensor_b ),
                   ## c ⊔ b → b ⊔ c
                   CocartesianBraidingInverseWithGivenCoproducts( cat,
                           c_tensor_b,
                           b,
                           c,
                           # b ⊔ c
                           t ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CoexponentialToCoproductLeftAdjunctionMapWithGivenCoproduct,
                    "CoexponentialToCoproductLeftAdjunctionMapWithGivenCoproduct using CoexponentialToCoproductRightAdjunctionMapWithGivenCoproduct and the braiding",
                    [ [ Coproduct, 1 ],
                      [ CocartesianBraidingInverseWithGivenCoproducts, 1 ],
                      [ CoexponentialToCoproductRightAdjunctionMapWithGivenCoproduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, a, c, f, t )
    local b, c_tensor_b;
    
    ## f: Coexp(a,c) → b
    b := Range( f );
    
    ## c ⊔ b
    c_tensor_b := BinaryCoproduct( cat, c, b );
    
    ## a → b ⊔ c
    return PreCompose( cat,
                   ## a → c ⊔ b
                   CoexponentialToCoproductRightAdjunctionMapWithGivenCoproduct( cat,
                           a,
                           c,
                           f,
                           c_tensor_b ),
                   ## c ⊔ b → b ⊔ c
                   CocartesianBraidingInverseWithGivenCoproducts( cat,
                           c_tensor_b,
                           b,
                           c,
                           # b ⊔ c
                           t ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( MorphismFromCocartesianBidualWithGivenCocartesianBidual,
                    "MorphismFromCocartesianBidualWithGivenCocartesianBidual using the braiding and the universal property of the codual",
                    [ [ PreCompose, 1 ],
                      [ CocartesianEvaluationForCocartesianDual, 1 ],
                      [ CocartesianBraiding, 1 ],
                      [ CocartesianDualOnObjects, 2 ],
                      [ UniversalPropertyOfCocartesianDual, 1 ] ],
                    
  function( cat, a, avv )
    local alpha;
    
    #    1
    #    |
    #    | cocaev_a
    #    v
    # a_v ⊔ a
    #    |
    #    | B_(a_v,a)
    #    v
    #  a ⊔ a_v
    #
    # UniversalPropertyOfCocartesianDual( 1 → a ⊔ a_v) = ( a_v_v → a )

    alpha := PreCompose( cat,
                  CocartesianEvaluationForCocartesianDual( cat, a ),
                  CocartesianBraiding( cat, CocartesianDualOnObjects( cat, a ), a ) );
                  
    return UniversalPropertyOfCocartesianDual( cat, a, CocartesianDualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( MorphismFromCocartesianBidualWithGivenCocartesianBidual,
                    "MorphismFromCocartesianBidualWithGivenCocartesianBidual using CocartesianEvaluation, Coexponential, and CocartesianCoevaluation",
                    [ [ CocartesianDualOnObjects, 1 ],
                      [ InitialObject, 1 ],
                      [ PreComposeList, 1 ],
                      [ CoexponentialOnMorphisms, 2 ],
                      [ CocartesianLeftEvaluationMorphism, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ CocartesianBraiding, 1 ],
                      [ CocartesianLeftCoevaluationMorphism, 1 ] ],
                    
  function( cat, a, avv )
    local av, morphism;
    
    #     Coexp(1, a_v)
    #          |
    #          | Coexp( cocaev_(a,1), id_(a_v) )
    #          v
    # Coexp(a_v ⊔ a, a_v)
    #          |
    #          | Coexp( B_( a_v, a), id_(a_v) )
    #          v
    # Coexp(a ⊔ a_v, a_v)
    #          |
    #          | cocacoev_(a_v,a)
    #          v
    #          a
    
    av := CocartesianDualOnObjects( cat, a );
    
    morphism := PreComposeList( cat,
                        avv,
                        [ CoexponentialOnMorphisms( cat,
                                CocartesianLeftEvaluationMorphism( cat, a, InitialObject( cat ) ),
                                IdentityMorphism( cat, av ) ),
                          
                          CoexponentialOnMorphisms( cat,
                                  CocartesianBraiding( cat, av, a ),
                                  IdentityMorphism( cat, av ) ),
                          
                          CocartesianLeftCoevaluationMorphism( cat, av, a ) ],
                        a );
    
    return morphism;
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CoexponentialCoproductCompatibilityMorphismWithGivenObjects,
                    "CoexponentialCoproductCompatibilityMorphismWithGivenObjects using associator, braiding and the cocartesian evaluation morphism",
                    [ [ CoexponentialOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ Coproduct, 3 ],
                      [ PreComposeList, 1 ],
                      [ CoproductOnMorphisms, 7 ],
                      [ CocartesianLeftEvaluationMorphism, 2 ],
                      [ CocartesianAssociatorRightToLeft, 2 ],
                      [ CocartesianAssociatorLeftToRight, 2 ],
                      [ CocartesianBraiding, 1 ],
                      [ CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, a2, b1, b2, b1b2, coexp_a1_b1, coexp_a2_b2, id_b2, morphism;
    
    #                   a1 ⊔ a2
    #                      |
    #                      | id_a1 ⊔ cocaev_(a2,b2)
    #                      v
    #          a1 ⊔ (Coexp(a2,b2) ⊔ b2)
    #                      |
    #                      | α_( a1, (Coexp(a2,b2), b2) )
    #                      v
    #          (a1 ⊔ Coexp(a2,b2)) ⊔ b2
    #                      |
    #                      | ( cocaev_(a1,b1) ⊔ id_Coexp(a2,b2) ) ⊔ id_b2
    #                      v
    # ((Coexp(a1,b1) ⊔ b1) ⊔ Coexp(a2,b2)) ⊔ b2
    #                      |
    #                      | α_( (Coexp(a1,b1), b1), Coexp(a2,b2) ) ) ⊔ id_b2
    #                      v
    #  (Coexp(a1,b1) ⊔ (b1 ⊔ Coexp(a2,b2))) ⊔ b2
    #                      |
    #                      | ( id_Coexp(a1,b1) ⊔ B_( b1, Coexp(a2,b2) ) ) ⊔ id_b2
    #                      v
    #  (Coexp(a1,b1) ⊔ (Coexp(a2,b2) ⊔ b1)) ⊔ b2
    #                      |
    #                      | α_( Coexp(a1,b1), (Coexp(a2,b2), b1) ) ⊔ id_b2
    #                      v
    #  ((Coexp(a1,b1) ⊔ Coexp(a2,b2)) ⊔ b1) ⊔ b2
    #                      |
    #                      | α_( (Coexp(a1,b1) ⊔ Coexp(a2,b2), b1), b2 )
    #                      v
    #  (Coexp(a1,b1) ⊔ Coexp(a2,b2)) ⊔ (b1 ⊔ b2)
    #
    #
    # Adjoint[ a1 ⊔ a2 → (Coexp(a1,b1) ⊔ Coexp(a2,b2)) ⊔ (b1 ⊔ b2) ] = [ Coexp(a1 ⊔ a2, b1 ⊔ b2) → Coexp(a1,b1) ⊔ Coexp(a2,b2) ]
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    b1b2 := BinaryCoproduct( cat, b1, b2 );
    
    coexp_a1_b1 := CoexponentialOnObjects( cat, a1, b1 );
    
    coexp_a2_b2 := CoexponentialOnObjects( cat, a2, b2 );
    
    id_b2 := IdentityMorphism( cat, b2 );
    
    morphism := PreComposeList( cat,
                        BinaryCoproduct( cat, a1, a2 ),
                        [ CoproductOnMorphisms( cat,
                                IdentityMorphism( cat, a1 ),
                                CocartesianLeftEvaluationMorphism( cat, b2, a2 ) ),
                          
                          CocartesianAssociatorRightToLeft( cat, a1, coexp_a2_b2, b2 ),
                          
                          CoproductOnMorphisms( cat,
                                  CoproductOnMorphisms( cat,
                                          CocartesianLeftEvaluationMorphism( cat, b1, a1 ),
                                          IdentityMorphism( cat, coexp_a2_b2 ) ),
                                  id_b2 ),
                          
                          CoproductOnMorphisms( cat,
                                  CocartesianAssociatorLeftToRight( cat, coexp_a1_b1, b1, coexp_a2_b2 ),
                                  id_b2 ),
                          
                          CoproductOnMorphisms( cat,
                                  CoproductOnMorphisms( cat,
                                          IdentityMorphism( cat, coexp_a1_b1 ),
                                          CocartesianBraiding( cat, b1, coexp_a2_b2 ) ),
                                  id_b2 ),
                          
                          CoproductOnMorphisms( cat,
                                  CocartesianAssociatorRightToLeft( cat, coexp_a1_b1, coexp_a2_b2, b1 ),
                                  id_b2 ),
                          
                          CocartesianAssociatorLeftToRight( cat,
                                  range,
                                  b1, b2 ) ],
                        BinaryCoproduct( cat,
                                range,
                                b1b2 ) );
    
    return CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential( cat,
                   range,
                   b1b2,
                   morphism,
                   source );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                    "CocartesianPreCoComposeMorphismWithGivenObjects using associator, braiding, cocartesian evaluation, and coexponential-coproduct adjunction",
                    [ [ CoexponentialOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CocartesianLeftEvaluationMorphism, 2 ],
                      [ CocartesianBraiding, 2 ],
                      [ CoproductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ CocartesianAssociatorLeftToRight, 1 ],
                      [ CocartesianAssociatorRightToLeft, 1 ],
                      [ CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential, 1 ],
                      [ Coproduct, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local coexp_a_b, coexp_b_c, morphism;
    
    #           a
    #           |
    #           | cocaev_ab
    #           v
    #    Coexp(a,b) ⊔ b
    #           |
    #           | B_( Coexp(a,b), b )
    #           v
    #      b ⊔ Coexp(a,b)
    #           |
    #           | cocaev_bc ⊔ id_Coexp(a,b)
    #           v
    # (Coexp(b,c) ⊔ c) ⊔ Coexp(a,b)
    #           |
    #           | α_( ( Coexp(b,c), c ), Coexp(a,b) )
    #           v
    # Coexp(b,c) ⊔ (c ⊔ Coexp(a,b))
    #           |
    #           | id_Coexp(b,c) ⊔ B_( c, Coexp(a,b) )
    #           v
    # Coexp(b,c) ⊔ (Coexp(a,b) ⊔ c)
    #           |
    #           | α_( Coexp(b,c), ( Coexp(a,b), c ) )
    #           v
    # (Coexp(b,c) ⊔ Coexp(a,b)) ⊔ c
    #
    #
    # Adjoint( a → (Coexp(b,c) ⊔ Coexp(a,b)) ⊔ c ) = ( Coexp(a,c) → Coexp(b,c) ⊔ Coexp(a,b) )
    
    coexp_a_b := CoexponentialOnObjects( cat, a, b );
    
    coexp_b_c := CoexponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ CocartesianLeftEvaluationMorphism( cat, b, a ),
                          
                          CocartesianBraiding( cat, coexp_a_b, b ),
                          
                          CoproductOnMorphisms( cat,
                                  CocartesianLeftEvaluationMorphism( cat, c, b ),
                                  IdentityMorphism( cat, coexp_a_b ) ),
                          
                          CocartesianAssociatorLeftToRight( cat, coexp_b_c, c, coexp_a_b ),
                          
                          CoproductOnMorphisms( cat,
                                  IdentityMorphism( cat, coexp_b_c ),
                                  CocartesianBraiding( cat, c, coexp_a_b ) ),
                          
                          CocartesianAssociatorRightToLeft( cat, coexp_b_c, coexp_a_b, c ) ],
                        BinaryCoproduct( cat,
                                range,
                                c ) );
    
    return CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianPostCoComposeMorphismWithGivenObjects,
                    "CocartesianPostCoComposeMorphismWithGivenObjects using CocartesianPreCoComposeMorphism and braiding",
                    [ [ CocartesianBraiding, 1 ],
                      [ CoexponentialOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ CocartesianPreCoComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;
    
    #       Coexp(a,c)
    #            |
    #            | PreCoCompose
    #            v
    # Coexp(b,c) ⊔ Coexp(a,b)
    #            |
    #            | B_( Coexp(b,c), Coexp(a,b) )
    #            v
    # Coexp(a,b) ⊔ Coexp(b,c)
    
    braiding := CocartesianBraiding( cat, CoexponentialOnObjects( cat, b, c ), CoexponentialOnObjects( cat, a, b ) );
    
    return PreCompose( cat, CocartesianPreCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                    "CocartesianPreCoComposeMorphismWithGivenObjects using CocartesianPostCoComposeMorphism and braiding",
                    [ [ CocartesianBraiding, 1 ],
                      [ CoexponentialOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ CocartesianPostCoComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;
    
    #       Coexp(a,c)
    #            |
    #            | PostCoCompose
    #            v
    # Coexp(a,b) ⊔ Coexp(b,c)
    #            |
    #            | B_( Coexp(a,b), Coexp(b,c) )
    #            v
    # Coexp(b,c) ⊔ Coexp(a,b)

    braiding := CocartesianBraiding( cat, CoexponentialOnObjects( cat, a, b ), CoexponentialOnObjects( cat, b, c ) );
    
    return PreCompose( cat, CocartesianPostCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CoexponentialCoproductCompatibilityMorphismWithGivenObjects,
                    "CoexponentialCoproductCompatibilityMorphismWithGivenObjects using braiding and the cocartesian evaluation morphism",
                    [ [ CoexponentialOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ Coproduct, 3 ],
                      [ PreComposeList, 1 ],
                      [ CoproductOnMorphisms, 5 ],
                      [ CocartesianLeftEvaluationMorphism, 2 ],
                      [ CocartesianBraiding, 1 ],
                      [ CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, a2, b1, b2, b1b2, coexp_a1_b1, coexp_a2_b2, id_b2, morphism;
    
    #           a1 ⊔ a2
    #              |
    #              | id_a1 ⊔ cocaev_(a2,b2)
    #              v
    #    a1 ⊔ Coexp(a2,b2) ⊔ b2
    #              |
    #              | cocaev_(a1,b1) ⊔ id_Coexp(a2,b2) ⊔ id_b2
    #              v
    # Coexp(a1,b1) ⊔ b1 ⊔ Coexp(a2,b2) ⊔ b2
    #              |
    #              | id_Coexp(a1,b1) ⊔ B_( b1, Coexp(a2,b2) )  ⊔ id_b2
    #              v
    # Coexp(a1,b1) ⊔ Coexp(a2,b2) ⊔ b1 ⊔ b2
    #
    #
    # Adjoint[ a1 ⊔ a2 → Coexp(a1,b1) ⊔ Coexp(a2,b2) ⊔ b1 ⊔ b2 ] = [ Coexp(a1 ⊔ a2, b1 ⊔ b2) → Coexp(a1,b1) ⊔ Coexp(a2,b2) ]
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    b1b2 := BinaryCoproduct( cat, b1, b2 );
    
    coexp_a1_b1 := CoexponentialOnObjects( cat, a1, b1 );
    
    coexp_a2_b2 := CoexponentialOnObjects( cat, a2, b2 );

    id_b2 := IdentityMorphism( cat, b2 );
    
    morphism := PreComposeList( cat,
                        BinaryCoproduct( cat, a1, a2 ),
                        [ CoproductOnMorphisms( cat,
                                IdentityMorphism( cat, a1 ),
                                CocartesianLeftEvaluationMorphism( cat, b2, a2 ) ),
                          
                          CoproductOnMorphisms( cat,
                                  CoproductOnMorphisms( cat,
                                          CocartesianLeftEvaluationMorphism( cat, b1, a1 ),
                                          IdentityMorphism( cat, coexp_a2_b2 ) ),
                                  id_b2 ),
                          
                          CoproductOnMorphisms( cat,
                                  CoproductOnMorphisms( cat,
                                          IdentityMorphism( cat, coexp_a1_b1 ),
                                          CocartesianBraiding( cat, b1, coexp_a2_b2 ) ),
                                  id_b2 ) ],
                        BinaryCoproduct( cat,
                                range,
                                b1b2 ) );
    
    return CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential( cat,
                   range,
                   b1b2,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsCocartesianCoclosedCategory( cat ) and IsCocartesianCoclosedCategory( cat ) and HasIsStrictCocartesianCategory( cat ) and IsStrictCocartesianCategory( cat ) );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                    "CocartesianPreCoComposeMorphismWithGivenObjects using braiding, cocartesian evaluation, and coexponential-coproduct adjunction",
                    [ [ CoexponentialOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CocartesianLeftEvaluationMorphism, 2 ],
                      [ CocartesianBraiding, 2 ],
                      [ CoproductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Coproduct, 1 ],
                      [ CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local coexp_a_b, coexp_b_c, morphism;
    
    #            a
    #            |
    #            | cocaev_ab
    #            v
    #      Coexp(a,b) ⊔ b
    #            |
    #            | B_( Coexp(a,b), b )
    #            v
    #      b ⊔ Coexp(a,b)
    #            |
    #            | cocaev_bc ⊔ id_Coexp(a,b)
    #            v
    # Coexp(b,c) ⊔ c ⊔ Coexp(a,b)
    #            |
    #            | id_Coexp(b,c) ⊔ B_( c, Coexp(a,b) )
    #            v
    # Coexp(b,c) ⊔ Coexp(a,b) ⊔ c
    #
    #
    # Adjoint( a → (Coexp(b,c) ⊔ Coexp(a,b)) ⊔ c ) = ( Coexp(a,c) → Coexp(b,c) ⊔ Coexp(a,b) )
    
    coexp_a_b := CoexponentialOnObjects( cat, a, b );
    
    coexp_b_c := CoexponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ CocartesianLeftEvaluationMorphism( cat, b, a ),
                          
                          CocartesianBraiding( cat, coexp_a_b, b ),
                          
                          CoproductOnMorphisms( cat,
                                  CocartesianLeftEvaluationMorphism( cat, c, b ),
                                  IdentityMorphism( cat, coexp_a_b ) ),
                          
                          CoproductOnMorphisms( cat,
                                  IdentityMorphism( cat, coexp_b_c ),
                                  CocartesianBraiding( cat, c, coexp_a_b ) ) ],
                        BinaryCoproduct( cat,
                                range,
                                c ) );
    
    return CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsCocartesianCoclosedCategory( cat ) and IsCocartesianCoclosedCategory( cat ) and HasIsStrictCocartesianCategory( cat ) and IsStrictCocartesianCategory( cat ) );
