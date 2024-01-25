# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( DirectProductToExponentialLeftAdjunctionMap,
                    "DirectProductToExponentialLeftAdjunctionMap using CartesianLeftCoevaluationMorphism and Exponential",
                    [ [ PreCompose, 1 ],
                      [ CartesianLeftCoevaluationMorphism, 1 ],
                      [ ExponentialOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f )
    
    # f: a × b → c
    #
    #      a
    #      |
    #      | coev_ba
    #      v
    # Exp(b,a × b)
    #      |
    #      | Exp(id_b, f)
    #      v
    #   Exp(b,c)
    
    return PreCompose( cat,
             CartesianLeftCoevaluationMorphism( cat, b, a ),
             ExponentialOnMorphisms( cat, IdentityMorphism( cat, b ), f ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( DirectProductToExponentialLeftAdjunctionMapWithGivenExponential,
                    "DirectProductToExponentialLeftAdjunctionMapWithGivenExponential using CartesianLeftCoevaluationMorphism and Exponential",
                    [ [ CartesianLeftCoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ ExponentialOnMorphismsWithGivenExponentials, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f, i )
    local coev_ba;
    
    # f: a × b → c
    #
    #      a
    #      |
    #      | coev_ba
    #      v
    # Exp(b,a × b)
    #      |
    #      | Exp(id_b, f)
    #      v
    #   Exp(b,c)
    
    coev_ba := CartesianLeftCoevaluationMorphism( cat, b, a );
    
    return PreCompose( cat,
             coev_ba,
             ExponentialOnMorphismsWithGivenExponentials( cat, Range( coev_ba ), IdentityMorphism( cat, b ), f, i ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( ExponentialToDirectProductLeftAdjunctionMap,
                    "ExponentialToDirectProductLeftAdjunctionMap using DirectProductOnMorphisms and CartesianLeftEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ DirectProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CartesianLeftEvaluationMorphism, 1 ] ],
                    
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
             CartesianLeftEvaluationMorphism( cat, b, c ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( ExponentialToDirectProductLeftAdjunctionMapWithGivenDirectProduct,
                    "ExponentialToDirectProductLeftAdjunctionMapWithGivenDirectProduct using DirectProductOnMorphisms and CartesianLeftEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ DirectProductOnMorphismsWithGivenDirectProducts, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CartesianLeftEvaluationMorphism, 1 ] ],
                    
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
    
    ev_bc := CartesianLeftEvaluationMorphism( cat, b, c );
     
    return PreCompose( cat,
             DirectProductOnMorphismsWithGivenDirectProducts( cat, t, g, IdentityMorphism( cat, b ), Source( ev_bc ) ),
             ev_bc );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianLeftEvaluationMorphismWithGivenSource,
                    "CartesianLeftEvaluationMorphismWithGivenSource using the direct product-exponential adjunction on the identity",
                    [ [ ExponentialToDirectProductLeftAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ ExponentialOnObjects, 1 ] ],
                    
  function( cat, a, b, direct_product_object )
    
    # Adjoint( id_Exp(a,b): Exp(a,b) → Exp(a,b) ) = ( Exp(a,b) × a → b )
    
    return ExponentialToDirectProductLeftAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, ExponentialOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianLeftCoevaluationMorphismWithGivenRange,
                    "CartesianLeftCoevaluationMorphismWithGivenRange using the direct product-exponential adjunction on the identity",
                    [ [ DirectProductToExponentialLeftAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ DirectProduct, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    
    # Adjoint( id_(b × a): b × a → b × a ) = ( b → Exp(a, b × a) )
    
    return DirectProductToExponentialLeftAdjunctionMap( cat,
             b, a,
             IdentityMorphism( cat, BinaryDirectProduct( cat, b, a ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( UniversalPropertyOfCartesianDual,
                    "UniversalPropertyOfCartesianDual using the direct product-exponential adjunction",
                    [ [ PreCompose, 1 ],
                      [ DirectProductToExponentialLeftAdjunctionMap, 1 ],
                      [ IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject, 1 ] ],
                    
  function( cat, t, a, alpha )

    # alpha: t × a → 1
    #
    # Adjoint( alpha ) = ( t → Exp(a,1) ) → a^v
    
    return PreCompose( cat,
             DirectProductToExponentialLeftAdjunctionMap( cat, t, a, alpha ),
             IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject( cat, a ) );
    
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
                    [ [ ExponentialToDirectProductLeftAdjunctionMap, 1 ],
                      [ IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject, 1 ] ],
                    
  function( cat, s, a, r )

    # r := 1
    #
    # Adjoint( a^v → Exp(a,1) ) = ( a^v × a → 1 )
    
    return ExponentialToDirectProductLeftAdjunctionMap( cat,
                   a,
                   r,
                   IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject( cat, a ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianLambdaIntroduction,
                    "CartesianLambdaIntroduction using the direct product-exponential adjunction and left unitor",
                    [ [ PreCompose, 1 ],
                      [ CartesianLeftUnitor, 1 ],
                      [ DirectProductToExponentialLeftAdjunctionMap, 1 ],
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
    
    return DirectProductToExponentialLeftAdjunctionMap( cat,
                   TerminalObject( cat ),
                   source,
                   result_morphism );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianLambdaElimination,
                    "CartesianLambdaElimination using the direct product-exponential adjunction and left unitor inverse",
                    [ [ ExponentialToDirectProductLeftAdjunctionMap, 1 ],
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
    
    result_morphism := ExponentialToDirectProductLeftAdjunctionMap( cat, a, b, alpha );
    
    return PreCompose( cat, CartesianLeftUnitorInverse( cat, a ), result_morphism );
    
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
                      [ CartesianLeftCoevaluationMorphism, 1 ],
                      [ ExponentialOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CartesianRightUnitor, 1 ] ],
                    
  function( cat, a, internal_hom )
    local unit;
    
    #       a
    #       |
    #       | coev_(1,a)
    #       v
    # Exp(1, a × 1)
    #       |
    #       | Exp(id_1, ρ_a)
    #       v
    #   Exp(1, a)
    
    unit := TerminalObject( cat );
    
    return PreCompose( cat,
                   CartesianLeftCoevaluationMorphism( cat, unit, a ),
                   
                   ExponentialOnMorphisms( cat,
                           IdentityMorphism( cat, unit ),
                           CartesianRightUnitor( cat, a ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToExponentialWithGivenExponential,
                    "IsomorphismFromObjectToExponentialWithGivenExponential as the adjoint of the right unitor",
                    [ [ TerminalObject, 1 ],
                      [ DirectProductToExponentialLeftAdjunctionMap, 1 ],
                      [ CartesianRightUnitor, 1 ] ],
                    
  function( cat, a, internal_hom )
    
    # ρ_a: a × 1 → a
    #
    # Adjoint( ρ_a ) = ( a → Exp(1,a) )
    
    return DirectProductToExponentialLeftAdjunctionMap( cat,
                   a,
                   TerminalObject( cat ),
                   CartesianRightUnitor( cat, a ) );
    
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
AddDerivationToCAP( IsomorphismFromExponentialToObjectWithGivenExponential,
                    "IsomorphismFromExponentialToObjectWithGivenExponential using the evaluation morphism",
                    [ [ TerminalObject, 1 ],
                      [ PreCompose, 1 ],
                      [ CartesianRightUnitorInverse, 1 ],
                      [ CartesianLeftEvaluationMorphism, 1 ] ],
                    
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
                   CartesianLeftEvaluationMorphism( cat, TerminalObject( cat ), a ) );
    
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
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    "CartesianPostComposeMorphismWithGivenObjects using associator, evaluation, and direct product-exponential adjunction",
                    [ [ ExponentialOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CartesianAssociatorLeftToRight, 1 ],
                      [ DirectProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CartesianLeftEvaluationMorphism, 2 ],
                      [ DirectProductToExponentialLeftAdjunctionMapWithGivenExponential, 1 ],
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
                                  CartesianLeftEvaluationMorphism( cat, a, b ) ),
                          
                          CartesianLeftEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return DirectProductToExponentialLeftAdjunctionMapWithGivenExponential( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := IsCartesianClosedCategory );

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
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    "CartesianPostComposeMorphismWithGivenObjects using evaluation, and direct product-exponential adjunction",
                    [ [ ExponentialOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ DirectProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CartesianLeftEvaluationMorphism, 2 ],
                      [ DirectProductToExponentialLeftAdjunctionMapWithGivenExponential, 1 ],
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
                                CartesianLeftEvaluationMorphism( cat, a, b ) ),
                          
                          CartesianLeftEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return DirectProductToExponentialLeftAdjunctionMapWithGivenExponential( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsCartesianClosedCategory( cat ) and IsCartesianClosedCategory( cat ) and HasIsStrictCartesianCategory( cat ) and IsStrictCartesianCategory( cat ) );

####################################
## Final derived methods
####################################

## Final methods for CartesianDual
AddFinalDerivationBundle( "IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject and its inverse as the identity of Exp(a,1)",
                    [ [ IdentityMorphism, 1 ],
                      [ ExponentialOnObjects, 1 ],
                      [ TerminalObject, 1 ] ],
                    [ CartesianDualOnObjects,
                      CartesianDualOnMorphismsWithGivenCartesianDuals,
                      MorphismToCartesianBidualWithGivenCartesianBidual,
                      IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject,
                      IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject,
                      UniversalPropertyOfCartesianDual,
                      DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects,
                      CartesianEvaluationForCartesianDualWithGivenDirectProduct,
                      MorphismFromDirectProductToExponentialWithGivenObjects ],
[
  IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject,
  [ [ IdentityMorphism, 1 ],
    [ ExponentialOnObjects, 1 ],
    [ TerminalObject, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, ExponentialOnObjects( cat, object, TerminalObject( cat ) ) );
    
  end
],
[
  IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject,
  [ [ IdentityMorphism, 1 ],
    [ ExponentialOnObjects, 1 ],
    [ TerminalObject, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, ExponentialOnObjects( cat, object, TerminalObject( cat ) ) );
    
  end
] : CategoryFilter := IsCartesianClosedCategory );
