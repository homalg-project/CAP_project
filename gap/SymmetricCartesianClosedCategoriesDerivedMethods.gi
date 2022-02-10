# THIS FILE WAS AUTOMATICALLY GENERATED

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( DirectProductToExponentialAdjunctionMap,
                    
  function( cat, a, b, f )

    # f: a x b -> c
    #
    #      a
    #      |
    #      | coev_ab
    #      v
    # Exp(b,a x b)
    #      |
    #      | Exp(id_b, f)
    #      v
    #   Exp(b,c)

    return PreCompose( cat,
             CartesianCoevaluationMorphism( cat, a, b ),
             ExponentialOnMorphisms( cat, IdentityMorphism( cat, b ), f ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "DirectProductToExponentialAdjunctionMap using CartesianCoevaluationMorphism and Exponential" );

##
AddDerivationToCAP( ExponentialToDirectProductAdjunctionMap,
                    
  function( cat, b, c, g )

    # g: a -> Exp(b,c)
    #
    #    a x b
    #      |
    #      | g x id_b
    #      v
    # Exp(b,c) x b
    #      |
    #      | ev_bc
    #      v
    #      c

    return PreCompose( cat,
             DirectProductOnMorphisms( cat, g, IdentityMorphism( cat, b ) ),
             CartesianEvaluationMorphism( cat, b, c ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "ExponentialToDirectProductAdjunctionMap using DirectProductOnMorphisms and CartesianEvaluationMorphism" );

##
AddDerivationToCAP( UniversalPropertyOfCartesianDual,
                    
  function( cat, t, a, alpha )

    # alpha: t x a -> 1
    #
    # Adjoint( alpha ) = ( t -> Exp(a,1) ) -> a^v
    
    return PreCompose( cat,
             DirectProductToExponentialAdjunctionMap( cat, t, a, alpha ),
             IsomorphismFromExponentialToCartesianDual( cat, a ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "UniversalPropertyOfCartesianDual using the direct product-exponential adjunction" );

##
AddDerivationToCAP( MorphismToCartesianBidualWithGivenCartesianBidual,
                  
  function( cat, a, avv )
    local alpha;

    #    a x a^v
    #      |
    #      | B_(a,a^v)
    #      v
    #  a^v x a
    #      |
    #      | ev_a
    #      v
    #      1
    #
    # UniversalProperty( a x a^v -> 1 ) = ( a -> a^v^v)

    alpha := PreCompose( cat, CartesianBraiding( cat, a, CartesianDualOnObjects( cat, a ) ),
                            CartesianEvaluationForCartesianDual( cat, a ) );
    
    return UniversalPropertyOfCartesianDual( cat, a, CartesianDualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "MorphismToCartesianBidualWithGivenCartesianBidual using the braiding and the universal property of the dual" );

##
AddDerivationToCAP( MorphismToCartesianBidualWithGivenCartesianBidual,
                    
  function( cat, a, avv )
    local morphism, av, tensor_unit;

    #        a
    #        |
    #        | coev_(a,a^v)
    #        v
    #  Exp(av, a x a^v)
    #        |
    #        | Exp(id_av, B_(a,a^v))
    #        v
    # Exp(av, a^v x a)
    #        |
    #        | Exp(id_(a^v), ev_(a,1))
    #        v
    #    Exp(a^v,1)
    
    av := CartesianDualOnObjects( cat, a );
    
    tensor_unit := TerminalObject( cat );

    morphism := PreComposeList( cat, [
                  CartesianCoevaluationMorphism( cat, a, av ),
                  
                  ExponentialOnMorphisms( cat,
                    IdentityMorphism( cat, av ),
                    CartesianBraiding( cat, a, av ) ),
                  
                  ExponentialOnMorphisms( cat,
                    IdentityMorphism( cat, av ),
                    CartesianEvaluationMorphism( cat, a, tensor_unit ) )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "MorphismToCartesianBidualWithGivenCartesianBidual using CartesianCoevaluation, Exponential, and CartesianEvaluation" );

##
AddDerivationToCAP( CartesianDualOnObjects,
                  
  function( cat, a )

    # Source( a^v -> Exp(a,1) )
    
    return Source( IsomorphismFromCartesianDualToExponential( cat, a ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianDualOnObjects as the source of IsomorphismFromCartesianDualToExponential" );

##
AddDerivationToCAP( CartesianDualOnObjects,
                  
  function( cat, a )

    # Range( Exp(a,1) -> a^v )
    
    return Range( IsomorphismFromExponentialToCartesianDual( cat, a ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianDualOnObjects as the range of IsomorphismFromExponentialToCartesianDual" );

##
AddDerivationToCAP( CartesianDualOnMorphismsWithGivenCartesianDuals,
                  
  function( cat, s, alpha, r )

    # alpha: a->b
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
    
    return PreComposeList( cat, [
             IsomorphismFromCartesianDualToExponential( cat, Range( alpha ) ),
             
             ExponentialOnMorphisms( cat,
               alpha,
               IdentityMorphism( cat, TerminalObject( cat ) ) ),
               
             IsomorphismFromExponentialToCartesianDual( cat, Source( alpha ) )
           ] );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianDualOnMorphismsWithGivenCartesianDuals using ExponentialOnMorphisms and IsomorphismFromCartesianDualToExponential" );

##
AddDerivationToCAP( CartesianEvaluationForCartesianDualWithGivenDirectProduct,
                  
  function( cat, s, a, r )

    # r := 1
    #
    # Adjoint( a^v -> Exp(a,1) ) = ( a^v x a -> 1 )
    
    return ExponentialToDirectProductAdjunctionMap( cat, a, r,
                                                    IsomorphismFromCartesianDualToExponential( cat, a ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianEvaluationForCartesianDualWithGivenDirectProduct using the direct product-exponential adjunction and IsomorphismFromCartesianDualToExponential" );

##
AddDerivationToCAP( CartesianLambdaIntroduction,
                  
  function( cat, alpha )
    local result_morphism, source;

    # 1 x a
    #   |
    #   | λ_a
    #   v
    #   a
    #   |
    #   | alpha
    #   v
    #   b
    #
    # Adjoint( 1 x a -> b) = ( 1 -> Exp(a,b) )
    
    source := Source( alpha );
    
    result_morphism := PreCompose( cat, CartesianLeftUnitor( cat, source ), alpha );
    
    return DirectProductToExponentialAdjunctionMap( cat, TerminalObject( cat ), source, result_morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianLambdaIntroduction using the direct product-exponential adjunction and left unitor" );

##
AddDerivationToCAP( CartesianLambdaElimination,
                  
  function( cat, a, b, alpha )
    local result_morphism;

    # alpha: 1 -> Exp(a,b)
    # Adjoint( alpha ) = ( 1 x a -> b)
    #
    #   a
    #   |
    #   | (λ_a)^-1
    #   v
    # 1 x a
    #   |
    #   | Adjoint( alpha)
    #   v
    #   b
    
    result_morphism := ExponentialToDirectProductAdjunctionMap( cat, a, b, alpha );
    
    return PreCompose( cat, CartesianLeftUnitorInverse( cat, a ), result_morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianLambdaElimination using the direct product-exponential adjunction and left unitor inverse" );

##
AddDerivationToCAP( DirectProductExponentialCompatibilityMorphismWithGivenObjects,
                    
  function( cat, source, list, range )
    local a1, b1, a2, b2, morphism, exp_a1_b1, exp_a2_b2, id_a2, direct_product_on_objects_exp_a1_b1_exp_a2_b2;
    
    # (Exp(a1,b1) x Exp(a2,b2)) x (a1 x a2)
    #                  |
    #                  | α_( Exp(a1,b1) x Exp(a2,b2), (a1, a2) )
    #                  v
    # ((Exp(a1,b1) x Exp(a2,b2)) x a1) x a2
    #                  |
    #                  | α_( ( Exp(a1,b1), Exp(a2,b2) ), a1 ) x id_a2
    #                  v
    # (Exp(a1,b1) x (Exp(a2,b2) x a1)) x a2
    #                  |
    #                  | ( id_Exp(a1,b1) x B_( Exp(a2,b2), a1 ) ) x id_a2
    #                  v
    # (Exp(a1,b1) x (a1 x Exp(a2,b2))) x a2
    #                  |
    #                  | α_( Exp(a1,b1), ( a1, Exp(a2,b2) ) ) x id_a2
    #                  v
    # ((Exp(a1,b1) x a1) x Exp(a2,b2)) x a2
    #                  |
    #                  | ( ev_(a1,b1) x id_Exp(a2,b2) ) x id_a2
    #                  v
    #       (b1 x Exp(a2,b2)) x a2
    #                  |
    #                  | α_( ( b1, Exp(a2,b2) ), a2 )
    #                  v
    #       b1 x (Exp(a2,b2) x a2)
    #                  |
    #                  | id_b1 x ev_(a2,b2)
    #                  v
    #               b1 x b2
    #
    #
    # Adjoint[ (Exp(a1,b1) x Exp(a2,b2)) x (a1 x a2) -> b1 x b2 ] = [ Exp(a1,b1) x Exp(a2,b2) -> Exp(a1 x a2, b1 x b2) ]

    a1 := list[1];
    b1 := list[2];
    a2 := list[3];
    b2 := list[4];
    
    exp_a1_b1 := ExponentialOnObjects( cat, a1, b1 );
    
    exp_a2_b2 := ExponentialOnObjects( cat, a2, b2 );
    
    id_a2 := IdentityMorphism( cat, a2 );
    
    direct_product_on_objects_exp_a1_b1_exp_a2_b2 := 
      BinaryDirectProduct( cat, exp_a1_b1, exp_a2_b2 );

    morphism := PreComposeList( cat, [
                  CartesianAssociatorRightToLeft( cat,
                    direct_product_on_objects_exp_a1_b1_exp_a2_b2,
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
                    CartesianEvaluationMorphism( cat, a2, b2 ) )
                ] );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             direct_product_on_objects_exp_a1_b1_exp_a2_b2,
             BinaryDirectProduct( cat, a1, a2 ),
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "DirectProductExponentialCompatibilityMorphismWithGivenObjects using associator, braiding and the evaluation morphism" );

##
AddDerivationToCAP( DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects,
                  
  function( cat, s, a, b, r )
    local morphism, unit, direct_product_on_a_and_b;

    #      a^v x b^v
    #          |
    #          v
    # Exp(a,1) x Exp(b,1)
    #          |
    #          | CompatMorphism(a,1,b,1)
    #          V
    #  Exp(a x b, 1 x 1)
    #          |
    #          | Exp(id_(a x b), λ_1)
    #          V
    #    Exp(a x b, 1)
    #          |
    #          V
    #       (a x b)^v

    
    unit := TerminalObject( cat );
    
    direct_product_on_a_and_b := BinaryDirectProduct( cat, a, b );
    
    morphism := PreComposeList( cat, [
                  DirectProductOnMorphisms( cat,
                    IsomorphismFromCartesianDualToExponential( cat, a ),
                    IsomorphismFromCartesianDualToExponential( cat, b ) ),
                  
                  DirectProductExponentialCompatibilityMorphism( cat, [ a, unit, b, unit ] ),
                  
                  ExponentialOnMorphisms( cat,
                    IdentityMorphism( cat, direct_product_on_a_and_b ),
                    CartesianLeftUnitor( cat, unit ) ),
                  
                  IsomorphismFromExponentialToCartesianDual( cat, direct_product_on_a_and_b )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of direct product and exponential" );

##
AddDerivationToCAP( IsomorphismFromObjectToExponentialWithGivenExponential,
                  
  function( cat, a, internal_hom )
    local unit;

    #       a
    #       |
    #       | coev_(a,1)
    #       v
    # Exp(1, a x 1)
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
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "IsomorphismFromObjectToExponentialWithGivenExponential using the coevaluation morphism" );

##
AddDerivationToCAP( IsomorphismFromObjectToExponentialWithGivenExponential,
                  
  function( cat, a, internal_hom )
    local unit;

    # ρ_a: a x 1 -> a
    #
    # Adjoint( ρ_a ) = ( a -> Exp(1,a) )
    
    unit := TerminalObject( cat );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             a,
             unit,
             CartesianRightUnitor( cat, a ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "IsomorphismFromObjectToExponentialWithGivenExponential as the adjoint of the right unitor" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromExponentialToObjectWithGivenExponential,
#                     
#   function( cat, a, internal_hom )
#
#     # Inverse( a -> Exp(1,a) )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToExponential( cat, a ) );
#     
# end : CategoryFilter := IsCartesianClosedCategory,
#       Description := "IsomorphismFromExponentialToObjectWithGivenExponential as the inverse of IsomorphismFromObjectToExponential" );

##
AddDerivationToCAP( IsomorphismFromExponentialToObjectWithGivenExponential,
                  
  function( cat, a, internal_hom )
    local unit;

    #  Exp(1,a)
    #      |
    #      | ( ρ_Exp(1,a) )^-1
    #      v
    # Exp(1,a) x 1
    #      |
    #      | ev_(1,a)
    #      v
    #      a
    
    unit := TerminalObject( cat );
    
    return PreCompose( cat, CartesianRightUnitorInverse( cat, internal_hom ),
                       CartesianEvaluationMorphism( cat, unit, a ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "IsomorphismFromExponentialToObjectWithGivenExponential using the evaluation morphism" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToExponentialWithGivenExponential,
#                     
#   function( cat, object, internal_hom )
#
#     # Inverse( a -> Exp(1,a))
#     
#     return InverseForMorphisms( cat, IsomorphismFromExponentialToObject( cat, object ) );
#     
# end : CategoryFilter := IsCartesianClosedCategory,
#       Description := "IsomorphismFromObjectToExponential as the inverse of IsomorphismFromExponentialToObject" );

##
AddDerivationToCAP( MorphismFromDirectProductToExponentialWithGivenObjects,
                    
  function( cat, direct_product_object, a, b, internal_hom )
    local unit;

    #      a^v x b
    #          |
    #          v
    # Exp(a,1) x Exp(1,b)
    #          |
    #          | CompatMorphism
    #          v
    # Exp(a x 1, 1 x b)
    #          |
    #          | Exp((ρ_a)^-1, λ_b)
    #          v
    #       Exp(a,b)

    unit := TerminalObject( cat );
    
    return PreComposeList( cat, [
             DirectProductOnMorphisms( cat,
               IsomorphismFromCartesianDualToExponential( cat, a ),
               IsomorphismFromObjectToExponential( cat, b ) ),
                
             DirectProductExponentialCompatibilityMorphism( cat,
               [ a, unit, unit, b ] ),
                
             ExponentialOnMorphisms( cat,
               CartesianRightUnitorInverse( cat, a ),
               CartesianLeftUnitor( cat, b ) ),
           ] );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "MorphismFromDirectProductToExponentialWithGivenObjects using DirectProductExponentialCompatibilityMorphism" );

##
AddDerivationToCAP( CartesianEvaluationMorphismWithGivenSource,
                  
  function( cat, a, b, direct_product_object )

    # Adjoint( id_Exp(a,b): Exp(a,b) -> Exp(a,b) ) = ( Exp(a,b) x a -> b )
    
    return ExponentialToDirectProductAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, ExponentialOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianEvaluationMorphismWithGivenSource using the direct product-exponential adjunction on the identity" );

##
AddDerivationToCAP( CartesianCoevaluationMorphismWithGivenRange,
                  
  function( cat, a, b, internal_hom )
    
    # Adjoint( id_(a x b): a x b -> a x b ) = ( a -> Exp(b, a x b) )

    return DirectProductToExponentialAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, BinaryDirectProduct( cat, a, b ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianCoevaluationMorphismWithGivenRange using the direct product-exponential adjunction on the identity" );

##
AddDerivationToCAP( CartesianPreComposeMorphismWithGivenObjects,
                  
  function( cat, source, a, b, c, range )
    local exp_a_b, exp_b_c, morphism;

    # (Exp(a,b) x Exp(b,c)) x a
    #           |
    #           | α_( ( Exp(a,b), Exp(b,c) ), a)
    #           v
    # Exp(a,b) x (Exp(b,c) x a)
    #           |
    #           | id_Exp(a,b) x B_( Exp(b,c), a )
    #           v
    # Exp(a,b) x (a x Exp(b,c))
    #           |
    #           | α_( Exp(a,b), ( a, Exp(b,c) ) )
    #           v
    # (Exp(a,b) x a) x Exp(b,c)
    #           |
    #           | ev_ab x id_Exp(b,c)
    #           v
    #      b x Exp(b,c)
    #           |
    #           | B_( b, Exp(b,c) )
    #           v
    #     Exp(b,c) x b
    #           |
    #           | ev_bc
    #           v
    #           c
    #
    #
    # Adjoint(  (Exp(a,b) x Exp(b,c)) x a -> c ) = ( Exp(a,b) x Exp(b,c) -> Exp(a,c) )

    exp_a_b := ExponentialOnObjects( cat, a, b );
    
    exp_b_c := ExponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat, [
                  CartesianAssociatorLeftToRight( cat, exp_a_b, exp_b_c, a ),
                  
                  DirectProductOnMorphisms( cat,
                    IdentityMorphism( cat, exp_a_b ),
                    CartesianBraiding( cat, exp_b_c, a ) ),
                  
                  CartesianAssociatorRightToLeft( cat, exp_a_b, a, exp_b_c ),
                  
                  DirectProductOnMorphisms( cat,
                    CartesianEvaluationMorphism( cat, a, b ),
                    IdentityMorphism( cat, exp_b_c ) ),
                  
                  CartesianBraiding( cat, b, exp_b_c ),
                  
                  CartesianEvaluationMorphism( cat, b, c )
                ] );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             BinaryDirectProduct( cat, exp_a_b, exp_b_c ),
             a,
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianPreComposeMorphismWithGivenObjects using associator, braiding, evaluation, and direct product-exponential adjunction" );

##
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    
  function( cat, source, a, b, c, range )
    local exp_a_b, exp_b_c, morphism;

    # (Exp(b,c) x Exp(a,b)) x a
    #            |
    #            | α_( ( Exp(b,c), Exp(a,b) ), c )
    #            v
    # Exp(b,c) x (Exp(a,b) x a)
    #            |
    #            | id_Exp(b,c) x ev_ab
    #            v
    #      Exp(b,c) x b
    #            |
    #            | ev_bc
    #            v
    #            c
    #
    #
    # Adjoint( (Exp(b,c) x Exp(a,b)) x a -> c ) = ( Exp(b,c) x Exp(a,b) -> Exp(a,c) )
    
    exp_a_b := ExponentialOnObjects( cat, a, b );
    
    exp_b_c := ExponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat, [
                  CartesianAssociatorLeftToRight( cat, exp_b_c, exp_a_b, a ),
                  
                  DirectProductOnMorphisms( cat,
                    IdentityMorphism( cat, exp_b_c ),
                    CartesianEvaluationMorphism( cat, a, b ) ),
                  
                  CartesianEvaluationMorphism( cat, b, c )
                ] );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             BinaryDirectProduct( cat, exp_b_c, exp_a_b ),
             a,
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianPostComposeMorphismWithGivenObjects using associator, evaluation, and direct product-exponential adjunction" );

##
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    
  function( cat, source, a, b, c, range )
    local braiding;

    # Exp(b,c) x Exp(a,b)
    #          |
    #          | B_( Exp(b,c), Exp(a,b) )
    #          v
    # Exp(a,b) x Exp(b,c)
    #          |
    #          | PreCompose
    #          v
    #       Exp(a,c)
    
    braiding := CartesianBraiding( cat, ExponentialOnObjects( cat, b, c ), ExponentialOnObjects( cat, a, b ) );
    
    return PreCompose( cat, braiding, CartesianPreComposeMorphism( cat, a, b, c ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianPostComposeMorphismWithGivenObjects using CartesianPreComposeMorphism and braiding" );

##
AddDerivationToCAP( CartesianPreComposeMorphismWithGivenObjects,
                    
  function( cat, source, a, b, c, range )
    local braiding;

    # Exp(a,b) x Exp(b,c)
    #          |
    #          | B_( Exp(a,b), Exp(b,c) )
    #          v
    # Exp(b,c) x Exp(a,b)
    #          |
    #          | PostCompose
    #          v
    #       Exp(a,c)
    
    braiding := CartesianBraiding( cat, ExponentialOnObjects( cat, a, b ), ExponentialOnObjects( cat, b, c ) );
    
    return PreCompose( cat, braiding, CartesianPostComposeMorphism( cat, a, b, c ) );
    
end : CategoryFilter := IsCartesianClosedCategory,
      Description := "CartesianPreComposeMorphismWithGivenObjects using CartesianPostComposeMorphism and braiding" );

##
AddDerivationToCAP( DirectProductExponentialCompatibilityMorphismWithGivenObjects,
                    
  function( cat, source, list, range )
    local a1, b1, a2, b2, morphism, exp_a1_b1, exp_a2_b2, id_a2, direct_product_on_objects_exp_a1_b1_exp_a2_b2;

    # Exp(a1,b1) x Exp(a2,b2) x a1 x a2
    #                 |
    #                 | id_Exp(a1,b1) x B_( Exp(a2,b2), a1 ) x id_a2
    #                 v
    # Exp(a1,b1) x a1 x Exp(a2,b2) x a2
    #                 |
    #                 | ev_(a1,b1) x id_Exp(a2,b2) x id_a2
    #                 v
    #       b1 x Exp(a2,b2) x a2
    #                 |
    #                 | id_b1 x ev_(a2,b2)
    #                 v
    #              b1 x b2
    #
    #
    # Adjoint[ Exp(a1,b1) x Exp(a2,b2) x a1 x a2 -> b1 x b2 ] = [ Exp(a1,b1) x Exp(a2,b2) -> Exp(a1 x a2, b1 x b2) ]
    
    a1 := list[1];
    b1 := list[2];
    a2 := list[3];
    b2 := list[4];
    
    exp_a1_b1 := ExponentialOnObjects( cat, a1, b1 );
    
    exp_a2_b2 := ExponentialOnObjects( cat, a2, b2 );
    
    id_a2 := IdentityMorphism( cat, a2 );
    
    direct_product_on_objects_exp_a1_b1_exp_a2_b2 := 
      BinaryDirectProduct( cat, exp_a1_b1, exp_a2_b2 );
    
    morphism := PreComposeList( cat, [
                  DirectProductOnMorphisms( cat,
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
                    CartesianEvaluationMorphism( cat, a2, b2 ) )
                ] );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             direct_product_on_objects_exp_a1_b1_exp_a2_b2,
             BinaryDirectProduct( cat, a1, a2 ),
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory and IsStrictCartesianCategory,
      Description := "DirectProductExponentialCompatibilityMorphismWithGivenObjects using braiding and the evaluation morphism" );

##
AddDerivationToCAP( DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects,
                  
  function( cat, source, a, b, range )
    local morphism, unit, direct_product_on_a_and_b;

    #      a^v x b^v
    #          |
    #          v
    # Exp(a,1) x Exp(b,1)
    #          |
    #          | CompatMorphism(a,1,b,1)
    #          V
    #  Exp(a x b, 1)
    #          |
    #          V
    #       (a x b)^v
    
    unit := TerminalObject( cat );
    
    direct_product_on_a_and_b := BinaryDirectProduct( cat, a, b );
    
    morphism := PreComposeList( cat, [
                  DirectProductOnMorphisms( cat,
                    IsomorphismFromCartesianDualToExponential( cat, a ),
                    IsomorphismFromCartesianDualToExponential( cat, b ) ),
                  
                  DirectProductExponentialCompatibilityMorphism( cat, [ a, unit, b, unit ] ),
                  
                  IsomorphismFromExponentialToCartesianDual( cat, direct_product_on_a_and_b )
                ] );
    
    return morphism;
    
end : CategoryFilter := IsCartesianClosedCategory and IsStrictCartesianCategory,
      Description := "DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects using compatibility of direct product and exponential" );

##
AddDerivationToCAP( CartesianPreComposeMorphismWithGivenObjects,
                  
  function( cat, source, a, b, c, range )
    local exp_a_b, exp_b_c, morphism;

    # Exp(a,b) x Exp(b,c) x a
    #          |
    #          | id_Exp(a,b) x B_( Exp(b,c), a )
    #          v
    # Exp(a,b) x a x Exp(b,c)
    #          |
    #          | ev_ab x id_Exp(b,c)
    #          v
    #     b x Exp(b,c)
    #          |
    #          | B_( b, Exp(b,c) )
    #          v
    #     Exp(b,c) x b
    #          |
    #          | ev_bc
    #          v
    #          c
    #
    #
    # Adjoint(  (Exp(a,b) x Exp(b,c)) x a -> c ) = ( Exp(a,b) x Exp(b,c) -> Exp(a,c) )
    
    exp_a_b := ExponentialOnObjects( cat, a, b );
    
    exp_b_c := ExponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat, [
                  DirectProductOnMorphisms( cat,
                    IdentityMorphism( cat, exp_a_b ),
                    CartesianBraiding( cat, exp_b_c, a ) ),
                  
                  DirectProductOnMorphisms( cat,
                    CartesianEvaluationMorphism( cat, a, b ),
                    IdentityMorphism( cat, exp_b_c ) ),
                  
                  CartesianBraiding( cat, b, exp_b_c ),
                  
                  CartesianEvaluationMorphism( cat, b, c )
                ] );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             BinaryDirectProduct( cat, exp_a_b, exp_b_c ),
             a,
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory and IsStrictCartesianCategory,
      Description := "CartesianPreComposeMorphismWithGivenObjects using, braiding, evaluation, and direct product-exponential adjunction" );

##
AddDerivationToCAP( CartesianPostComposeMorphismWithGivenObjects,
                    
  function( cat, source, a, b, c, range )
    local exp_a_b, exp_b_c, morphism;

    # Exp(b,c) x Exp(a,b) x a
    #            |
    #            | id_Exp(b,c) x ev_ab
    #            v
    #      Exp(b,c) x b
    #            |
    #            | ev_bc
    #            v
    #            c
    #
    #
    # Adjoint( Exp(b,c) x Exp(a,b) x a -> c ) = ( Exp(b,c) x Exp(a,b) -> Exp(a,c) )
    
    exp_a_b := ExponentialOnObjects( cat, a, b );
    
    exp_b_c := ExponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat, [
                  DirectProductOnMorphisms( cat,
                    IdentityMorphism( cat, exp_b_c ),
                    CartesianEvaluationMorphism( cat, a, b ) ),
                  
                  CartesianEvaluationMorphism( cat, b, c )
                ] );
    
    return DirectProductToExponentialAdjunctionMap( cat,
             BinaryDirectProduct( cat, exp_b_c, exp_a_b ),
             a,
             morphism );
    
end : CategoryFilter := IsCartesianClosedCategory and IsStrictCartesianCategory,
      Description := "CartesianPostComposeMorphismWithGivenObjects using evaluation, and direct product-exponential adjunction" );
