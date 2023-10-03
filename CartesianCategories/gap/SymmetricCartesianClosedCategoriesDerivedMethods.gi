# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( DirectProductToExponentialAdjunctionMap,
                    "DirectProductToExponentialAdjunctionMap using CartesianCoevaluationMorphism and Exponential",
                    [ [ PreCompose, 1 ],
                      [ CartesianCoevaluationMorphism, 1 ],
                      [ ExponentialOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f )

    # f: a × b → c
    #
    #      a
    #      |
    #      | coev_ab
    #      v
    # Exp(b,a × b)
    #      |
    #      | Exp(id_b, f)
    #      v
    #   Exp(b,c)

    return PreCompose( cat,
             CartesianCoevaluationMorphism( cat, a, b ),
             ExponentialOnMorphisms( cat, IdentityMorphism( cat, b ), f ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( DirectProductToExponentialAdjunctionMapWithGivenExponential,
                    "DirectProductToExponentialAdjunctionMapWithGivenExponential using CartesianCoevaluationMorphism and Exponential",
                    [ [ CartesianCoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ ExponentialOnMorphismsWithGivenExponentials, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f, i )
    local coev_ab;
    
    # f: a × b → c
    #
    #      a
    #      |
    #      | coev_ab
    #      v
    # Exp(b,a × b)
    #      |
    #      | Exp(id_b, f)
    #      v
    #   Exp(b,c)
    
    coev_ab := CartesianCoevaluationMorphism( cat, a, b );
    
    return PreCompose( cat,
             coev_ab,
             ExponentialOnMorphismsWithGivenExponentials( cat, Range( coev_ab ), IdentityMorphism( cat, b ), f, i ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( ExponentialToDirectProductAdjunctionMap,
                    "ExponentialToDirectProductAdjunctionMap using DirectProductOnMorphisms and CartesianEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ DirectProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CartesianEvaluationMorphism, 1 ] ],
                    
  function( cat, b, c, g )

    # g: a → Exp(b,c)
    #
    #    a × b
    #      |
    #      | g × id_b
    #      v
    # Exp(b,c) × b
    #      |
    #      | ev_bc
    #      v
    #      c

    return PreCompose( cat,
             DirectProductOnMorphisms( cat, g, IdentityMorphism( cat, b ) ),
             CartesianEvaluationMorphism( cat, b, c ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct,
                    "ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct using DirectProductOnMorphisms and CartesianEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ DirectProductOnMorphismsWithGivenDirectProducts, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CartesianEvaluationMorphism, 1 ] ],
                    
  function( cat, b, c, g, t )
    local ev_bc;
    
    # g: a → Exp(b,c)
    #
    #    a × b
    #      |
    #      | g × id_b
    #      v
    # Exp(b,c) × b
    #      |
    #      | ev_bc
    #      v
    #      c
     
    ev_bc := CartesianEvaluationMorphism( cat, b, c );
     
    return PreCompose( cat,
             DirectProductOnMorphismsWithGivenDirectProducts( cat, t, g, IdentityMorphism( cat, b ), Source( ev_bc ) ),
             ev_bc );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( UniversalPropertyOfCartesianDual,
                    "UniversalPropertyOfCartesianDual using the direct product-exponential adjunction",
                    [ [ PreCompose, 1 ],
                      [ DirectProductToExponentialAdjunctionMap, 1 ],
                      [ IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject, 1 ] ],
                    
  function( cat, t, a, alpha )

    # alpha: t × a → 1
    #
    # Adjoint( alpha ) = ( t → Exp(a,1) ) → a^v
    
    return PreCompose( cat,
             DirectProductToExponentialAdjunctionMap( cat, t, a, alpha ),
             IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject( cat, a ) );
    
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

    alpha := PreCompose( cat, CartesianBraiding( cat, a, CartesianDualOnObjects( cat, a ) ),
                            CartesianEvaluationForCartesianDual( cat, a ) );
    
    return UniversalPropertyOfCartesianDual( cat, a, CartesianDualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( MorphismToCartesianBidualWithGivenCartesianBidual,
                    "MorphismToCartesianBidualWithGivenCartesianBidual using CartesianCoevaluation, Exponential, and CartesianEvaluation",
                    [ [ CartesianDualOnObjects, 1 ],
                      [ TerminalObject, 1 ],
                      [ PreComposeList, 1 ],
                      [ CartesianCoevaluationMorphism, 1 ],
                      [ ExponentialOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ CartesianBraiding, 1 ],
                      [ CartesianEvaluationMorphism, 1 ] ],
                    
  function( cat, a, avv )
    local av, morphism;
    
    #        a
    #        |
    #        | coev_(a,a^v)
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
                        [ CartesianCoevaluationMorphism( cat, a, av ),
                          
                          ExponentialOnMorphisms( cat,
                                  IdentityMorphism( cat, av ),
                                  CartesianBraiding( cat, a, av ) ),
                          
                          ExponentialOnMorphisms( cat,
                                  IdentityMorphism( cat, av ),
                                  CartesianEvaluationMorphism( cat, a, TerminalObject( cat ) ) ) ],
                        avv );
    
    return morphism;
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianDualOnObjects,
                    "CartesianDualOnObjects as the source of IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject",
                    [ [ IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject, 1 ] ],
                    
  function( cat, a )

    # Source( a^v → Exp(a,1) )
    
    return Source( IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject( cat, a ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianDualOnObjects,
                    "CartesianDualOnObjects as the range of IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject",
                    [ [ IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject, 1 ] ],
                    
  function( cat, a )

    # Range( Exp(a,1) → a^v )
    
    return Range( IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject( cat, a ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianDualOnMorphismsWithGivenCartesianDuals,
                    "CartesianDualOnMorphismsWithGivenCartesianDuals using ExponentialOnMorphisms and IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject",
                    [ [ PreComposeList, 1 ],
                      [ IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject, 1 ],
                      [ ExponentialOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TerminalObject, 1 ],
                      [ IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject, 1 ] ],
                    
  function( cat, s, alpha, r )
    
    # alpha: a → b
    #
    #   b^v
    #    |
    #    v
    # Exp(b,1)
    #    |
    #    | Exp(alpha, id_1)
    #    v
    # Exp(a,1)
    #    |
    #    v
    #   a^v
    
    return PreComposeList( cat,
                   s,
                   [ IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject( cat, Range( alpha ) ),
                     
                     ExponentialOnMorphisms( cat,
                             alpha,
                             IdentityMorphism( cat, TerminalObject( cat ) ) ),
                     
                     IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject( cat, Source( alpha ) ) ],
                   r );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianEvaluationForCartesianDualWithGivenDirectProduct,
                    "CartesianEvaluationForCartesianDualWithGivenDirectProduct using the direct product-exponential adjunction and IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject",
                    [ [ ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct, 1 ],
                      [ IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject, 1 ] ],
                    
  function( cat, s, a, r )

    # r := 1
    #
    # Adjoint( a^v → Exp(a,1) ) = ( a^v × a → 1 )
    
    return ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct( cat,
                a,
                r,
                IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject( cat, a ),
                s );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianLambdaIntroduction,
                    "CartesianLambdaIntroduction using the direct product-exponential adjunction and left unitor",
                    [ [ PreCompose, 1 ],
                      [ CartesianLeftUnitor, 1 ],
                      [ DirectProductToExponentialAdjunctionMap, 1 ],
                      [ TerminalObject, 1 ] ],
                    
  function( cat, alpha )
    local result_morphism, source;

    # 1 × a
    #   |
    #   | λ_a
    #   v
    #   a
    #   |
    #   | alpha
    #   v
    #   b
    #
    # Adjoint( 1 × a → b) = ( 1 → Exp(a,b) )
    
    source := Source( alpha );
    
    result_morphism := PreCompose( cat, CartesianLeftUnitor( cat, source ), alpha );
    
    return DirectProductToExponentialAdjunctionMap( cat, TerminalObject( cat ), source, result_morphism );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianLambdaElimination,
                    "CartesianLambdaElimination using the direct product-exponential adjunction and left unitor inverse",
                    [ [ ExponentialToDirectProductAdjunctionMap, 1 ],
                      [ PreCompose, 1 ],
                      [ CartesianLeftUnitorInverse, 1 ] ],
                    
  function( cat, a, b, alpha )
    local result_morphism;

    # alpha: 1 → Exp(a,b)
    # Adjoint( alpha ) = ( 1 × a → b)
    #
    #   a
    #   |
    #   | (λ_a)^-1
    #   v
    # 1 × a
    #   |
    #   | Adjoint( alpha)
    #   v
    #   b
    
    result_morphism := ExponentialToDirectProductAdjunctionMap( cat, a, b, alpha );
    
    return PreCompose( cat, CartesianLeftUnitorInverse( cat, a ), result_morphism );
    
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
                      [ CartesianEvaluationMorphism, 2 ],
                      [ DirectProductToExponentialAdjunctionMapWithGivenExponential, 1 ] ],
                    
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
                                          CartesianEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, exp_a2_b2 ) ),
                                  id_a2 ),
                          
                          CartesianAssociatorLeftToRight( cat, b1, exp_a2_b2, a2 ),
                          
                          DirectProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b1 ),
                                  CartesianEvaluationMorphism( cat, a2, b2 ) ) ],
                        BinaryDirectProduct( cat, b1, b2 ) );
    
    return DirectProductToExponentialAdjunctionMapWithGivenExponential( cat,
                   source,
                   a1a2,
                   morphism,
                   range );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects,
                    "DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of direct product and exponential",
                    [ [ TerminalObject, 1 ],
                      [ DirectProduct, 1 ],
                      [ PreComposeList, 1 ],
                      [ DirectProductOnMorphisms, 1 ],
                      [ IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject, 2 ],
                      [ DirectProductExponentialCompatibilityMorphism, 1 ],
                      [ ExponentialOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CartesianLeftUnitor, 1 ],
                      [ IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject, 1 ] ],
                    
  function( cat, s, a, b, r )
    local unit, direct_product_on_a_and_b, morphism;
    
    #      a^v × b^v
    #          |
    #          v
    # Exp(a,1) × Exp(b,1)
    #          |
    #          | CompatMorphism(a,1,b,1)
    #          V
    #  Exp(a × b, 1 × 1)
    #          |
    #          | Exp(id_(a × b), λ_1)
    #          V
    #    Exp(a × b, 1)
    #          |
    #          V
    #       (a × b)^v
    
    unit := TerminalObject( cat );
    
    direct_product_on_a_and_b := BinaryDirectProduct( cat, a, b );
    
    morphism := PreComposeList( cat,
                        s,
                        [ DirectProductOnMorphisms( cat,
                                IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject( cat, a ),
                                IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject( cat, b ) ),
                          
                          DirectProductExponentialCompatibilityMorphism( cat, [ a, unit, b, unit ] ),
                          
                          ExponentialOnMorphisms( cat,
                                  IdentityMorphism( cat, direct_product_on_a_and_b ),
                                  CartesianLeftUnitor( cat, unit ) ),
                          
                          IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject( cat, direct_product_on_a_and_b ) ],
                        r );
    
    return morphism;
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToExponentialWithGivenExponential,
                    "IsomorphismFromObjectToExponentialWithGivenExponential using the coevaluation morphism",
                    [ [ TerminalObject, 1 ],
                      [ PreCompose, 1 ],
                      [ CartesianCoevaluationMorphism, 1 ],
                      [ ExponentialOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CartesianRightUnitor, 1 ] ],
                    
  function( cat, a, internal_hom )
    local unit;
    
    #       a
    #       |
    #       | coev_(a,1)
    #       v
    # Exp(1, a × 1)
    #       |
    #       | Exp(id_1, ρ_a)
    #       v
    #   Exp(1, a)
    
    unit := TerminalObject( cat );
    
    return PreCompose( cat,
             CartesianCoevaluationMorphism( cat, a, unit ),
             ExponentialOnMorphisms( cat,
               IdentityMorphism( cat, unit ),
               CartesianRightUnitor( cat, a ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToExponentialWithGivenExponential,
                    "IsomorphismFromObjectToExponentialWithGivenExponential as the adjoint of the right unitor",
                    [ [ TerminalObject, 1 ],
                      [ DirectProductToExponentialAdjunctionMap, 1 ],
                      [ CartesianRightUnitor, 1 ] ],
                    
  function( cat, a, internal_hom )
    
    # ρ_a: a × 1 → a
    #
    # Adjoint( ρ_a ) = ( a → Exp(1,a) )
    
    return DirectProductToExponentialAdjunctionMap( cat,
                   a,
                   TerminalObject( cat ),
                   CartesianRightUnitor( cat, a ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromExponentialToObjectWithGivenExponential,
#                     
#   function( cat, a, internal_hom )
#
#     # Inverse( a → Exp(1,a) )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToExponential( cat, a ) );
#     
# end : CategoryFilter := IsCartesianClosedCategory,
#       Description := "IsomorphismFromExponentialToObjectWithGivenExponential as the inverse of IsomorphismFromObjectToExponential" );

##
AddDerivationToCAP( IsomorphismFromExponentialToObjectWithGivenExponential,
                    "IsomorphismFromExponentialToObjectWithGivenExponential using the evaluation morphism",
                    [ [ TerminalObject, 1 ],
                      [ PreCompose, 1 ],
                      [ CartesianRightUnitorInverse, 1 ],
                      [ CartesianEvaluationMorphism, 1 ] ],
                    
  function( cat, a, internal_hom )
    
    #  Exp(1,a)
    #      |
    #      | ( ρ_Exp(1,a) )^-1
    #      v
    # Exp(1,a) × 1
    #      |
    #      | ev_(1,a)
    #      v
    #      a
    
    return PreCompose( cat,
                   CartesianRightUnitorInverse( cat, internal_hom ),
                   CartesianEvaluationMorphism( cat, TerminalObject( cat ), a ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToExponentialWithGivenExponential,
#                     
#   function( cat, object, internal_hom )
#
#     # Inverse( a → Exp(1,a))
#     
#     return InverseForMorphisms( cat, IsomorphismFromExponentialToObject( cat, object ) );
#     
# end : CategoryFilter := IsCartesianClosedCategory,
#       Description := "IsomorphismFromObjectToExponential as the inverse of IsomorphismFromExponentialToObject" );

##
AddDerivationToCAP( MorphismFromDirectProductToExponentialWithGivenObjects,
                    "MorphismFromDirectProductToExponentialWithGivenObjects using DirectProductExponentialCompatibilityMorphism",
                    [ [ TerminalObject, 1 ],
                      [ PreComposeList, 1 ],
                      [ DirectProductOnMorphisms, 1 ],
                      [ IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject, 1 ],
                      [ IsomorphismFromObjectToExponential, 1 ],
                      [ DirectProductExponentialCompatibilityMorphism, 1 ],
                      [ ExponentialOnMorphisms, 1 ],
                      [ CartesianRightUnitorInverse, 1 ],
                      [ CartesianLeftUnitor, 1 ] ],
                    
  function( cat, direct_product_object, a, b, internal_hom )
    local unit;
    
    #      a^v × b
    #          |
    #          v
    # Exp(a,1) × Exp(1,b)
    #          |
    #          | CompatMorphism
    #          v
    # Exp(a × 1, 1 × b)
    #          |
    #          | Exp((ρ_a)^-1, λ_b)
    #          v
    #       Exp(a,b)
    
    unit := TerminalObject( cat );
    
    return PreComposeList( cat,
                   direct_product_object,
                   [ DirectProductOnMorphisms( cat,
                           IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject( cat, a ),
                           IsomorphismFromObjectToExponential( cat, b ) ),
                     
                     DirectProductExponentialCompatibilityMorphism( cat,
                             [ a, unit, unit, b ] ),
                     
                     ExponentialOnMorphisms( cat,
                             CartesianRightUnitorInverse( cat, a ),
                             CartesianLeftUnitor( cat, b ) ) ],
                   internal_hom );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianEvaluationMorphismWithGivenSource,
                    "CartesianEvaluationMorphismWithGivenSource using the direct product-exponential adjunction on the identity",
                    [ [ ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ ExponentialOnObjects, 1 ] ],
                    
  function( cat, a, b, direct_product_object )

    # Adjoint( id_Exp(a,b): Exp(a,b) → Exp(a,b) ) = ( Exp(a,b) × a → b )
    
    return ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct( cat,
             a,
             b,
             IdentityMorphism( cat, ExponentialOnObjects( cat, a, b ) ),
             direct_product_object );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianCoevaluationMorphismWithGivenRange,
                    "CartesianCoevaluationMorphismWithGivenRange using the direct product-exponential adjunction on the identity",
                    [ [ DirectProductToExponentialAdjunctionMapWithGivenExponential, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ DirectProduct, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    
    # Adjoint( id_(a × b): a × b → a × b ) = ( a → Exp(b, a × b) )

    return DirectProductToExponentialAdjunctionMapWithGivenExponential( cat,
             a,
             b,
             IdentityMorphism( cat, BinaryDirectProduct( cat, a, b ) ),
             internal_hom );
    
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
                      [ CartesianEvaluationMorphism, 2 ],
                      [ DirectProductToExponentialAdjunctionMapWithGivenExponential, 1 ],
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
                                  CartesianEvaluationMorphism( cat, a, b ),
                                  IdentityMorphism( cat, exp_b_c ) ),
                          
                          CartesianBraiding( cat, b, exp_b_c ),
                          
                          CartesianEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return DirectProductToExponentialAdjunctionMapWithGivenExponential( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    "CartesianPostComposeMorphismWithGivenObjects using associator, evaluation, and direct product-exponential adjunction",
                    [ [ ExponentialOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CartesianAssociatorLeftToRight, 1 ],
                      [ DirectProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CartesianEvaluationMorphism, 2 ],
                      [ DirectProductToExponentialAdjunctionMapWithGivenExponential, 1 ],
                      [ DirectProduct, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local exp_a_b, exp_b_c, morphism;
    
    # (Exp(b,c) × Exp(a,b)) × a
    #            |
    #            | α_( ( Exp(b,c), Exp(a,b) ), c )
    #            v
    # Exp(b,c) × (Exp(a,b) × a)
    #            |
    #            | id_Exp(b,c) × ev_ab
    #            v
    #      Exp(b,c) × b
    #            |
    #            | ev_bc
    #            v
    #            c
    #
    #
    # Adjoint( (Exp(b,c) × Exp(a,b)) × a → c ) = ( Exp(b,c) × Exp(a,b) → Exp(a,c) )
    
    exp_a_b := ExponentialOnObjects( cat, a, b );
    
    exp_b_c := ExponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        BinaryDirectProduct( cat,
                                source,
                                a ),
                        [ CartesianAssociatorLeftToRight( cat, exp_b_c, exp_a_b, a ),
                          
                          DirectProductOnMorphisms( cat,
                                  IdentityMorphism( cat, exp_b_c ),
                                  CartesianEvaluationMorphism( cat, a, b ) ),
                          
                          CartesianEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return DirectProductToExponentialAdjunctionMapWithGivenExponential( cat,
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
                      [ CartesianEvaluationMorphism, 2 ],
                      [ DirectProductToExponentialAdjunctionMapWithGivenExponential, 1 ] ],
                    
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
                                          CartesianEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, exp_a2_b2 ) ),
                                  id_a2 ),
                          
                          DirectProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b1 ),
                                  CartesianEvaluationMorphism( cat, a2, b2 ) ) ],
                        BinaryDirectProduct( cat, b1, b2 ) );
    
    return DirectProductToExponentialAdjunctionMapWithGivenExponential( cat,
                   source,
                   a1a2,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsCartesianClosedCategory( cat ) and IsCartesianClosedCategory( cat ) and HasIsStrictCartesianCategory( cat ) and IsStrictCartesianCategory( cat ) );

##
AddDerivationToCAP( DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects,
                    "DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects using compatibility of direct product and exponential",
                    [ [ TerminalObject, 1 ],
                      [ DirectProduct, 1 ],
                      [ PreComposeList, 1 ],
                      [ DirectProductOnMorphisms, 1 ],
                      [ IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject, 2 ],
                      [ DirectProductExponentialCompatibilityMorphism, 1 ],
                      [ IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject, 1 ] ],
                    
  function( cat, source, a, b, range )
    local unit, morphism;
    
    #      a^v × b^v
    #          |
    #          v
    # Exp(a,1) × Exp(b,1)
    #          |
    #          | CompatMorphism(a,1,b,1)
    #          V
    #  Exp(a × b, 1)
    #          |
    #          V
    #       (a × b)^v
    
    unit := TerminalObject( cat );
    
    morphism := PreComposeList( cat,
                        source,
                        [ DirectProductOnMorphisms( cat,
                                IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject( cat, a ),
                                IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject( cat, b ) ),
                          
                          DirectProductExponentialCompatibilityMorphism( cat, [ a, unit, b, unit ] ),
                          
                          IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject( cat,
                                  BinaryDirectProduct( cat, a, b ) ) ],
                        range );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsCartesianClosedCategory( cat ) and IsCartesianClosedCategory( cat ) and HasIsStrictCartesianCategory( cat ) and IsStrictCartesianCategory( cat ) );

##
AddDerivationToCAP( CartesianPreComposeMorphismWithGivenObjects,
                    "CartesianPreComposeMorphismWithGivenObjects using, braiding, evaluation, and direct product-exponential adjunction",
                    [ [ ExponentialOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ DirectProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ CartesianBraiding, 2 ],
                      [ CartesianEvaluationMorphism, 2 ],
                      [ DirectProductToExponentialAdjunctionMapWithGivenExponential, 1 ],
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
                                  CartesianEvaluationMorphism( cat, a, b ),
                                  IdentityMorphism( cat, exp_b_c ) ),
                          
                          CartesianBraiding( cat, b, exp_b_c ),
                          
                          CartesianEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return DirectProductToExponentialAdjunctionMapWithGivenExponential( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsCartesianClosedCategory( cat ) and IsCartesianClosedCategory( cat ) and HasIsStrictCartesianCategory( cat ) and IsStrictCartesianCategory( cat ) );

##
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    "CartesianPostComposeMorphismWithGivenObjects using evaluation, and direct product-exponential adjunction",
                    [ [ ExponentialOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ DirectProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CartesianEvaluationMorphism, 2 ],
                      [ DirectProductToExponentialAdjunctionMapWithGivenExponential, 1 ],
                      [ DirectProduct, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local morphism;
    
    # Exp(b,c) × Exp(a,b) × a
    #            |
    #            | id_Exp(b,c) × ev_ab
    #            v
    #      Exp(b,c) × b
    #            |
    #            | ev_bc
    #            v
    #            c
    #
    #
    # Adjoint( Exp(b,c) × Exp(a,b) × a → c ) = ( Exp(b,c) × Exp(a,b) → Exp(a,c) )
    
    morphism := PreComposeList( cat,
                        BinaryDirectProduct( cat,
                                source,
                                a ),
                        [ DirectProductOnMorphisms( cat,
                                IdentityMorphism( cat, ExponentialOnObjects( cat, b, c ) ),
                                CartesianEvaluationMorphism( cat, a, b ) ),
                          
                          CartesianEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return DirectProductToExponentialAdjunctionMapWithGivenExponential( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsCartesianClosedCategory( cat ) and IsCartesianClosedCategory( cat ) and HasIsStrictCartesianCategory( cat ) and IsStrictCartesianCategory( cat ) );
