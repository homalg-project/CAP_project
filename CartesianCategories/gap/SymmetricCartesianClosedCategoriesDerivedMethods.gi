# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( DirectProductToExponentialRightAdjunctMorphismWithGivenExponential,
                    "DirectProductToExponentialRightAdjunctMorphismWithGivenExponential using DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential and the braiding",
                    [ [ DirectProduct, 1 ],
                      [ CartesianBraidingInverseWithGivenDirectProducts, 1 ],
                      [ PreCompose, 1 ],
                      [ DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential, 1 ] ],
                    
  function( cat, a, b, f, i )
    
    ## b → i = Exp( a, c )
    return DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential( cat,
                   b,
                   a,
                   ## b × a → c
                   PreCompose( cat,
                           ## b × a → a × b
                           CartesianBraidingInverseWithGivenDirectProducts( cat,
                                   BinaryDirectProduct( cat, b, a ),
                                   a,
                                   b,
                                   Source( f ) ),
                           ## f: a × b → c
                           f ),
                   ## Exp( a, c )
                   i );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential,
                    "DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential using DirectProductToExponentialRightAdjunctMorphismWithGivenExponential and the braiding",
                    [ [ DirectProduct, 1 ],
                      [ CartesianBraidingInverseWithGivenDirectProducts, 1 ],
                      [ PreCompose, 1 ],
                      [ DirectProductToExponentialRightAdjunctMorphismWithGivenExponential, 1 ] ],
                    
  function( cat, a, b, f, i )
    
    ## a → i = Exp( b, c )
    return DirectProductToExponentialRightAdjunctMorphismWithGivenExponential( cat,
                   b,
                   a,
                   ## b × a → c
                   PreCompose( cat,
                           ## b × a → a × b
                           CartesianBraidingInverseWithGivenDirectProducts( cat,
                                   BinaryDirectProduct( cat, b, a ),
                                   a,
                                   b,
                                   Source( f ) ),
                           ## f: a × b → c
                           f ),
                   ## Exp( b, c )
                   i );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( ExponentialToDirectProductRightAdjunctMorphismWithGivenDirectProduct,
                    "ExponentialToDirectProductRightAdjunctMorphismWithGivenDirectProduct using ExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct and the braiding",
                    [ [ DirectProduct, 1 ],
                      [ CartesianBraidingWithGivenDirectProducts, 1 ],
                      [ ExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, a, c, g, s )
    local b, b_tensor_a;
    
    ## g: b → Exp(a,c)
    b := Source( g );
    
    ## b × a
    b_tensor_a := BinaryDirectProduct( cat, b, a );
    
    ## a × b → c
    return PreCompose( cat,
                   ## a × b → b × a
                   CartesianBraidingWithGivenDirectProducts( cat,
                           s, # a × b
                           a,
                           b,
                           b_tensor_a ),
                   ## b × a → c
                   ExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct( cat,
                           a,
                           c,
                           g,
                           b_tensor_a ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( ExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct,
                    "ExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct using ExponentialToDirectProductRightAdjunctMorphismWithGivenDirectProduct and the braiding",
                    [ [ DirectProduct, 1 ],
                      [ CartesianBraidingWithGivenDirectProducts, 1 ],
                      [ ExponentialToDirectProductRightAdjunctMorphismWithGivenDirectProduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, b, c, g, s )
    local a, b_tensor_a;

    ## g: a → Exp(b,c)
    a := Source( g );
    
    ## b × a
    b_tensor_a := BinaryDirectProduct( cat, b, a );
    
    ## a × b → c
    return PreCompose( cat,
                   ## a × b → b × a
                   CartesianBraidingWithGivenDirectProducts( cat,
                           s, # a × b
                           a,
                           b,
                           b_tensor_a ),
                   ## b × a → c
                   ExponentialToDirectProductRightAdjunctMorphismWithGivenDirectProduct( cat,
                           b,
                           c,
                           g,
                           b_tensor_a ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( MorphismToCartesianBidualWithGivenCartesianBidual,
                    "MorphismToCartesianBidualWithGivenCartesianBidual using the braiding and the universal property of the dual",
                    [ [ PreCompose, 1 ],
                      [ CartesianBraiding, 1 ],
                      [ CartesianDualOnObjects, 2 ],
                      [ CartesianEvaluationForCartesianDual, 1 ],
                      [ UniversalPropertyOfCartesianDual, 1 ] ],
                    
  function( cat, a, avv )
    local alpha;

    #    a × a^v
    #      |
    #      | B_(a,a^v)
    #      v
    #  a^v × a
    #      |
    #      | ev_a
    #      v
    #      1
    #
    # UniversalProperty( a × a^v → 1 ) = ( a → a^v^v)

    alpha := PreCompose( cat,
                     CartesianBraiding( cat, a, CartesianDualOnObjects( cat, a ) ),
                     CartesianEvaluationForCartesianDual( cat, a ) );
    
    return UniversalPropertyOfCartesianDual( cat, a, CartesianDualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( MorphismToCartesianBidualWithGivenCartesianBidual,
                    "MorphismToCartesianBidualWithGivenCartesianBidual using CartesianCoevaluation, Exponential, and CartesianEvaluation",
                    [ [ CartesianDualOnObjects, 1 ],
                      [ TerminalObject, 1 ],
                      [ PreComposeList, 1 ],
                      [ CartesianLeftCoevaluationMorphism, 1 ],
                      [ ExponentialOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ CartesianBraiding, 1 ],
                      [ CartesianLeftEvaluationMorphism, 1 ] ],
                    
  function( cat, a, avv )
    local av, morphism;
    
    #        a
    #        |
    #        | coev_(a^v,a)
    #        v
    #  Exp(av, a × a^v)
    #        |
    #        | Exp(id_av, B_(a,a^v))
    #        v
    # Exp(av, a^v × a)
    #        |
    #        | Exp(id_(a^v), ev_(a,1))
    #        v
    #    Exp(a^v,1)
    
    av := CartesianDualOnObjects( cat, a );
    
    morphism := PreComposeList( cat,
                        a,
                        [ CartesianLeftCoevaluationMorphism( cat, av, a ),
                          
                          ExponentialOnMorphisms( cat,
                                  IdentityMorphism( cat, av ),
                                  CartesianBraiding( cat, a, av ) ),
                          
                          ExponentialOnMorphisms( cat,
                                  IdentityMorphism( cat, av ),
                                  CartesianLeftEvaluationMorphism( cat, a, TerminalObject( cat ) ) ) ],
                        avv );
    
    return morphism;
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( DirectProductExponentialCompatibilityMorphismWithGivenObjects,
                    "DirectProductExponentialCompatibilityMorphismWithGivenObjects using associator, braiding and the evaluation morphism",
                    [ [ ExponentialOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ DirectProduct, 3 ],
                      [ PreComposeList, 1 ],
                      [ CartesianAssociatorRightToLeft, 2 ],
                      [ DirectProductOnMorphisms, 7 ],
                      [ CartesianAssociatorLeftToRight, 2 ],
                      [ CartesianBraiding, 1 ],
                      [ CartesianLeftEvaluationMorphism, 2 ],
                      [ DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, b1, a2, b2, a1a2, exp_a1_b1, exp_a2_b2, id_a2, morphism;
    
    # (Exp(a1,b1) × Exp(a2,b2)) × (a1 × a2)
    #                  |
    #                  | α_( Exp(a1,b1) × Exp(a2,b2), (a1, a2) )
    #                  v
    # ((Exp(a1,b1) × Exp(a2,b2)) × a1) × a2
    #                  |
    #                  | α_( ( Exp(a1,b1), Exp(a2,b2) ), a1 ) × id_a2
    #                  v
    # (Exp(a1,b1) × (Exp(a2,b2) × a1)) × a2
    #                  |
    #                  | ( id_Exp(a1,b1) × B_( Exp(a2,b2), a1 ) ) × id_a2
    #                  v
    # (Exp(a1,b1) × (a1 × Exp(a2,b2))) × a2
    #                  |
    #                  | α_( Exp(a1,b1), ( a1, Exp(a2,b2) ) ) × id_a2
    #                  v
    # ((Exp(a1,b1) × a1) × Exp(a2,b2)) × a2
    #                  |
    #                  | ( ev_(a1,b1) × id_Exp(a2,b2) ) × id_a2
    #                  v
    #       (b1 × Exp(a2,b2)) × a2
    #                  |
    #                  | α_( ( b1, Exp(a2,b2) ), a2 )
    #                  v
    #       b1 × (Exp(a2,b2) × a2)
    #                  |
    #                  | id_b1 × ev_(a2,b2)
    #                  v
    #               b1 × b2
    #
    #
    # Adjoint[ (Exp(a1,b1) × Exp(a2,b2)) × (a1 × a2) → b1 × b2 ] = [ Exp(a1,b1) × Exp(a2,b2) → Exp(a1 × a2, b1 × b2) ]
    
    a1 := list[1];
    b1 := list[2];
    a2 := list[3];
    b2 := list[4];
    
    a1a2 := BinaryDirectProduct( cat, a1, a2 );
    
    exp_a1_b1 := ExponentialOnObjects( cat, a1, b1 );
    
    exp_a2_b2 := ExponentialOnObjects( cat, a2, b2 );
    
    id_a2 := IdentityMorphism( cat, a2 );
    
    morphism := PreComposeList( cat,
                        BinaryDirectProduct( cat,
                                source,
                                a1a2 ),
                        [ CartesianAssociatorRightToLeft( cat,
                                source,
                                a1, a2 ),
                          
                          DirectProductOnMorphisms( cat,
                                  CartesianAssociatorLeftToRight( cat, exp_a1_b1, exp_a2_b2, a1 ),
                                  id_a2 ),
                          
                          DirectProductOnMorphisms( cat,
                                  DirectProductOnMorphisms( cat,
                                          IdentityMorphism( cat, exp_a1_b1 ),
                                          CartesianBraiding( cat, exp_a2_b2, a1 ) ),
                                  id_a2 ),
                          
                          DirectProductOnMorphisms( cat,
                                  CartesianAssociatorRightToLeft( cat, exp_a1_b1, a1, exp_a2_b2 ),
                                  id_a2 ),
                          
                          DirectProductOnMorphisms( cat,
                                  DirectProductOnMorphisms( cat,
                                          CartesianLeftEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, exp_a2_b2 ) ),
                                  id_a2 ),
                          
                          CartesianAssociatorLeftToRight( cat, b1, exp_a2_b2, a2 ),
                          
                          DirectProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b1 ),
                                  CartesianLeftEvaluationMorphism( cat, a2, b2 ) ) ],
                        BinaryDirectProduct( cat, b1, b2 ) );
    
    return DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential( cat,
                   source,
                   a1a2,
                   morphism,
                   range );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianPreComposeMorphismWithGivenObjects,
                    "CartesianPreComposeMorphismWithGivenObjects using associator, braiding, evaluation, and direct product-exponential adjunction",
                    [ [ ExponentialOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CartesianAssociatorLeftToRight, 1 ],
                      [ DirectProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ CartesianBraiding, 2 ],
                      [ CartesianAssociatorRightToLeft, 1 ],
                      [ CartesianLeftEvaluationMorphism, 2 ],
                      [ DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential, 1 ],
                      [ DirectProduct, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local exp_a_b, exp_b_c, morphism;
    
    # (Exp(a,b) × Exp(b,c)) × a
    #           |
    #           | α_( ( Exp(a,b), Exp(b,c) ), a)
    #           v
    # Exp(a,b) × (Exp(b,c) × a)
    #           |
    #           | id_Exp(a,b) × B_( Exp(b,c), a )
    #           v
    # Exp(a,b) × (a × Exp(b,c))
    #           |
    #           | α_( Exp(a,b), ( a, Exp(b,c) ) )
    #           v
    # (Exp(a,b) × a) × Exp(b,c)
    #           |
    #           | ev_ab × id_Exp(b,c)
    #           v
    #      b × Exp(b,c)
    #           |
    #           | B_( b, Exp(b,c) )
    #           v
    #     Exp(b,c) × b
    #           |
    #           | ev_bc
    #           v
    #           c
    #
    #
    # Adjoint(  (Exp(a,b) × Exp(b,c)) × a → c ) = ( Exp(a,b) × Exp(b,c) → Exp(a,c) )

    exp_a_b := ExponentialOnObjects( cat, a, b );
    
    exp_b_c := ExponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        BinaryDirectProduct( cat,
                                source,
                                a ),
                        [ CartesianAssociatorLeftToRight( cat, exp_a_b, exp_b_c, a ),
                          
                          DirectProductOnMorphisms( cat,
                                  IdentityMorphism( cat, exp_a_b ),
                                  CartesianBraiding( cat, exp_b_c, a ) ),
                          
                          CartesianAssociatorRightToLeft( cat, exp_a_b, a, exp_b_c ),
                          
                          DirectProductOnMorphisms( cat,
                                  CartesianLeftEvaluationMorphism( cat, a, b ),
                                  IdentityMorphism( cat, exp_b_c ) ),
                          
                          CartesianBraiding( cat, b, exp_b_c ),
                          
                          CartesianLeftEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    "CartesianPostComposeMorphismWithGivenObjects using CartesianPreComposeMorphism and braiding",
                    [ [ CartesianBraiding, 1 ],
                      [ ExponentialOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ CartesianPreComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;

    # Exp(b,c) × Exp(a,b)
    #          |
    #          | B_( Exp(b,c), Exp(a,b) )
    #          v
    # Exp(a,b) × Exp(b,c)
    #          |
    #          | PreCompose
    #          v
    #       Exp(a,c)
    
    braiding := CartesianBraiding( cat, ExponentialOnObjects( cat, b, c ), ExponentialOnObjects( cat, a, b ) );
    
    return PreCompose( cat, braiding, CartesianPreComposeMorphism( cat, a, b, c ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianPreComposeMorphismWithGivenObjects,
                    "CartesianPreComposeMorphismWithGivenObjects using CartesianPostComposeMorphism and braiding",
                    [ [ CartesianBraiding, 1 ],
                      [ ExponentialOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ CartesianPostComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;

    # Exp(a,b) × Exp(b,c)
    #          |
    #          | B_( Exp(a,b), Exp(b,c) )
    #          v
    # Exp(b,c) × Exp(a,b)
    #          |
    #          | PostCompose
    #          v
    #       Exp(a,c)
    
    braiding := CartesianBraiding( cat, ExponentialOnObjects( cat, a, b ), ExponentialOnObjects( cat, b, c ) );
    
    return PreCompose( cat, braiding, CartesianPostComposeMorphism( cat, a, b, c ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( DirectProductExponentialCompatibilityMorphismWithGivenObjects,
                    "DirectProductExponentialCompatibilityMorphismWithGivenObjects using braiding and the evaluation morphism",
                    [ [ ExponentialOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ DirectProduct, 3 ],
                      [ PreComposeList, 1 ],
                      [ DirectProductOnMorphisms, 5 ],
                      [ CartesianBraiding, 1 ],
                      [ CartesianLeftEvaluationMorphism, 2 ],
                      [ DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, b1, a2, b2, a1a2, exp_a1_b1, exp_a2_b2, id_a2, morphism;
    
    # Exp(a1,b1) × Exp(a2,b2) × a1 × a2
    #                 |
    #                 | id_Exp(a1,b1) × B_( Exp(a2,b2), a1 ) × id_a2
    #                 v
    # Exp(a1,b1) × a1 × Exp(a2,b2) × a2
    #                 |
    #                 | ev_(a1,b1) × id_Exp(a2,b2) × id_a2
    #                 v
    #       b1 × Exp(a2,b2) × a2
    #                 |
    #                 | id_b1 × ev_(a2,b2)
    #                 v
    #              b1 × b2
    #
    #
    # Adjoint[ Exp(a1,b1) × Exp(a2,b2) × a1 × a2 → b1 × b2 ] = [ Exp(a1,b1) × Exp(a2,b2) → Exp(a1 × a2, b1 × b2) ]
    
    a1 := list[1];
    b1 := list[2];
    a2 := list[3];
    b2 := list[4];
    
    a1a2 := BinaryDirectProduct( cat, a1, a2 );
    
    exp_a1_b1 := ExponentialOnObjects( cat, a1, b1 );
    
    exp_a2_b2 := ExponentialOnObjects( cat, a2, b2 );
    
    id_a2 := IdentityMorphism( cat, a2 );
    
    morphism := PreComposeList( cat,
                        BinaryDirectProduct( cat,
                                source,
                                a1a2 ),
                        [ DirectProductOnMorphisms( cat,
                                DirectProductOnMorphisms( cat,
                                        IdentityMorphism( cat, exp_a1_b1 ),
                                        CartesianBraiding( cat, exp_a2_b2, a1 ) ),
                                id_a2 ),
                          
                          DirectProductOnMorphisms( cat,
                                  DirectProductOnMorphisms( cat,
                                          CartesianLeftEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, exp_a2_b2 ) ),
                                  id_a2 ),
                          
                          DirectProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b1 ),
                                  CartesianLeftEvaluationMorphism( cat, a2, b2 ) ) ],
                        BinaryDirectProduct( cat, b1, b2 ) );
    
    return DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential( cat,
                   source,
                   a1a2,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsCartesianClosedCategory( cat ) and IsCartesianClosedCategory( cat ) and HasIsStrictCartesianCategory( cat ) and IsStrictCartesianCategory( cat ) );

##
AddDerivationToCAP( CartesianPreComposeMorphismWithGivenObjects,
                    "CartesianPreComposeMorphismWithGivenObjects using, braiding, evaluation, and direct product-exponential adjunction",
                    [ [ ExponentialOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ DirectProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ CartesianBraiding, 2 ],
                      [ CartesianLeftEvaluationMorphism, 2 ],
                      [ DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential, 1 ],
                      [ DirectProduct, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local exp_a_b, exp_b_c, morphism;

    # Exp(a,b) × Exp(b,c) × a
    #          |
    #          | id_Exp(a,b) × B_( Exp(b,c), a )
    #          v
    # Exp(a,b) × a × Exp(b,c)
    #          |
    #          | ev_ab × id_Exp(b,c)
    #          v
    #     b × Exp(b,c)
    #          |
    #          | B_( b, Exp(b,c) )
    #          v
    #     Exp(b,c) × b
    #          |
    #          | ev_bc
    #          v
    #          c
    #
    #
    # Adjoint(  (Exp(a,b) × Exp(b,c)) × a → c ) = ( Exp(a,b) × Exp(b,c) → Exp(a,c) )
    
    exp_a_b := ExponentialOnObjects( cat, a, b );
    
    exp_b_c := ExponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        BinaryDirectProduct( cat,
                                source,
                                a ),
                        [ DirectProductOnMorphisms( cat,
                                IdentityMorphism( cat, exp_a_b ),
                                CartesianBraiding( cat, exp_b_c, a ) ),
                          
                          DirectProductOnMorphisms( cat,
                                  CartesianLeftEvaluationMorphism( cat, a, b ),
                                  IdentityMorphism( cat, exp_b_c ) ),
                          
                          CartesianBraiding( cat, b, exp_b_c ),
                          
                          CartesianLeftEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsCartesianClosedCategory( cat ) and IsCartesianClosedCategory( cat ) and HasIsStrictCartesianCategory( cat ) and IsStrictCartesianCategory( cat ) );
