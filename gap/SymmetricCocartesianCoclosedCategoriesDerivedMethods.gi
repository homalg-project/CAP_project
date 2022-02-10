# THIS FILE WAS AUTOMATICALLY GENERATED

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( CoproductToCoexponentialAdjunctionMap,

  function( cat, c, b, g )
    
    # g: a -> c x b
    #
    #    Coexp(a,b)
    #        |
    #        | Coexp(g, id_b)
    #        v
    # Coexp(c x b, b)
    #        |
    #        | cocacoev_cb
    #        v
    #        c

    return PreCompose( cat,
             CoexponentialOnMorphisms( cat, g, IdentityMorphism( cat, b ) ),
             CocartesianCoevaluationMorphism( cat, c, b ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CoproductToCoexponentialAdjunctionMap using CocartesianCoevaluationMorphism and Coexponential" );

##
AddDerivationToCAP( CoexponentialToCoproductAdjunctionMap,

  function( cat, a, b, f )

    # f: Coexp(a,b) -> c
    #
    #        a
    #        |
    #        | cocaev_ab
    #        v
    # Coexp(a,b) x b
    #        |
    #        | f x id_b
    #        v
    #      c x b
    
    return PreCompose( cat,
             CocartesianEvaluationMorphism( cat, a, b ),
             CoproductOnMorphisms( cat, f, IdentityMorphism( cat, b ) ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CoexponentialToCoproductAdjunctionMap using CoproductOnMorphisms and CocartesianEvaluationMorphism" );

##
AddDerivationToCAP( UniversalPropertyOfCocartesianDual,

  function( cat, t, a, alpha )

    # alpha: 1 -> t x a
    #
    # a_v -> ( Coexp(1,a) -> t ) = Adjoint( alpha )
    
    return PreCompose( cat,
             IsomorphismFromCocartesianDualToCoexponential( cat, a ),
             CoproductToCoexponentialAdjunctionMap( cat, t, a, alpha ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "UniversalPropertyOfCocartesianDual using the coexponential-coproduct adjunction" );

##
AddDerivationToCAP( MorphismFromCocartesianBidualWithGivenCocartesianBidual,

  function( cat, a, avv )
    local alpha;

    #    1
    #    |
    #    | cocaev_a
    #    v
    # a_v x a
    #    |
    #    | B_(a_v,a)
    #    v
    #  a x a_v
    #
    #
    # UniversalPropertyOfCocartesianDual( 1 -> a x a_v) = ( a_v_v -> a )

    alpha := PreCompose( cat,
                  CocartesianEvaluationForCocartesianDual( cat, a ),
                  CocartesianBraiding( cat, CocartesianDualOnObjects( cat, a ), a ) );
                  
    return UniversalPropertyOfCocartesianDual( cat, a, CocartesianDualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "MorphismFromCocartesianBidualWithGivenCocartesianBidual using the braiding and the universal property of the codual" );

##
AddDerivationToCAP( MorphismFromCocartesianBidualWithGivenCocartesianBidual,

  function( cat, a, avv )
    local morphism, av, tensor_unit;

    #     Coexp(1, a_v)
    #          |
    #          | Coexp( cocaev_(1,a), id_(a_v) )
    #          v
    # Coexp(a_v x a, a_v)
    #          |
    #          | Coexp( B_( a_v, a), id_(a_v) )
    #          v
    # Coexp(a x a_v, a_v)
    #          |
    #          | cocacoev_(a, a_v)
    #          v
    #          a
    
    av := CocartesianDualOnObjects( cat, a );
    
    tensor_unit := InitialObject( cat );
    
    morphism := PreComposeList( cat, [
                  CoexponentialOnMorphisms( cat,
                    CocartesianEvaluationMorphism( cat, tensor_unit, a ),
                    IdentityMorphism( cat, av ) ),
                  
                  CoexponentialOnMorphisms( cat,
                    CocartesianBraiding( cat, av, a ),
                    IdentityMorphism( cat, av ) ),
                  
                  CocartesianCoevaluationMorphism( cat, a, av )
                ] );
    
    return morphism;

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "MorphismFromCocartesianBidualWithGivenCocartesianBidual using CocartesianEvaluation, Coexponential, and CocartesianCoevaluation" );

##
AddDerivationToCAP( CocartesianDualOnObjects,

  function( cat, a )

    # Source( a_v -> Coexp(1,a) )
    
    return Source( IsomorphismFromCocartesianDualToCoexponential( cat, a ) );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianDualOnObjects as the source of IsomorphismFromCocartesianDualToCoexponential" );

##
AddDerivationToCAP( CocartesianDualOnObjects,

  function( cat, a )

    # Range( Coexp(1,a) -> a_v )
    
    return Range( IsomorphismFromCoexponentialToCocartesianDual( cat, a ) );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianDualOnObjects as the range of IsomorphismFromCoexponentialToCocartesianDual" );

##
AddDerivationToCAP( CocartesianDualOnMorphismsWithGivenCocartesianDuals,

  function( cat, s, alpha, r )
    local result_morphism;

    # alpha: a->b
    #
    #    b_v
    #     |
    #     v
    # Coexp(1,b)
    #     |
    #     | Coexp(id_1, alpha)
    #     v
    # Coexp(1,a)
    #     |
    #     v
    #    a_v
    
    result_morphism := PreComposeList( cat, [
                         IsomorphismFromCocartesianDualToCoexponential( cat, Range( alpha ) ),
                         
                         CoexponentialOnMorphisms( cat,
                           IdentityMorphism( cat, InitialObject( cat ) ),
                           alpha ),
                           
                         IsomorphismFromCoexponentialToCocartesianDual( cat, Source( alpha ) )
                       ] );
                       
    return result_morphism;
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianDualOnMorphismsWithGivenCocartesianDuals using CoexponentialOnMorphisms and IsomorphismFromCocartesianDualToCoexponential" );

##
AddDerivationToCAP( CocartesianEvaluationForCocartesianDualWithGivenCoproduct,

  function( cat, s, a, r )

    # s := 1

    # Adjoint( Coexp(1,a) -> a_v ) = ( 1 -> a_v x a )

    return CoexponentialToCoproductAdjunctionMap( cat,
            s,
            a,
            IsomorphismFromCoexponentialToCocartesianDual( cat, a ) );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianEvaluationForCocartesianDualWithGivenCoproduct using the coexponential-coproduct adjunction and IsomorphismFromCoexponentialToCocartesianDual" );

##
AddDerivationToCAP( CocartesianLambdaIntroduction,

  function( cat, alpha )
    local result_morphism, range;

    #   a
    #   |
    #   | alpha
    #   v
    #   b
    #   |
    #   | (λ_b)^-1
    #   v
    # 1 x b
    #
    # Adjoint( a -> 1 x b ) = ( Coexp(a,b) -> 1 )

    range := Range( alpha );

    result_morphism := PreCompose( cat, alpha, CocartesianLeftUnitorInverse( cat, range ) );

    return CoproductToCoexponentialAdjunctionMap( cat,
             InitialObject( cat ),
             range,
             result_morphism );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianLambdaIntroduction using the coexponential-coproduct adjunction and the left unitor inverse" );

##
AddDerivationToCAP( CocartesianLambdaElimination,

  function( cat, a, b, alpha )
    local result_morphism;

    # alpha: Coexp(a,b) -> 1
    # Adjoint( alpha ) = ( a -> 1 x b )
    #
    #   a
    #   |
    #   | Adjoint( alpha )
    #   v
    # 1 x b
    #   |
    #   | λ_b
    #   v
    #   b
    
    result_morphism := CoexponentialToCoproductAdjunctionMap( cat, a, b, alpha );
    
    return PreCompose( cat, result_morphism, CocartesianLeftUnitor( cat, b ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianLambdaElimination using the coexponential-coproduct adjunction and the left unitor" );

##
AddDerivationToCAP( CoexponentialCoproductCompatibilityMorphismWithGivenObjects,

  function( cat, source, list, range )
    local a1, a2, b1, b2, morphism, coexp_a1_b1, coexp_a2_b2, id_b2, coproduct_on_objects_coexp_a1_b1_coexp_a2_b2;

    #                   a1 x a2
    #                      |
    #                      | id_a1 x cocaev_(a2,b2)
    #                      v
    #          a1 x (Coexp(a2,b2) x b2)
    #                      |
    #                      | α_( a1, (Coexp(a2,b2), b2) )
    #                      v
    #          (a1 x Coexp(a2,b2)) x b2
    #                      |
    #                      | ( cocaev_(a1,b1) x id_Coexp(a2,b2) ) x id_b2
    #                      v
    # ((Coexp(a1,b1) x b1) x Coexp(a2,b2)) x b2
    #                      |
    #                      | α_( (Coexp(a1,b1), a1), Coexp(a2,b2) ) ) x id_b2
    #                      v
    #  (Coexp(a1,b1) x (b1 x Coexp(a2,b2))) x b2
    #                      |
    #                      | ( id_Coexp(a1,b1) x B_( b1, Coexp(a2,b2) ) ) x id_b2
    #                      v
    #  (Coexp(a1,b1) x (Coexp(a2,b2) x b1)) x b2
    #                      |
    #                      | α_( Coexp(a1,b1), (Coexp(a2,b2), b1) ) x id_b2
    #                      v
    #  ((Coexp(a1,b1) x Coexp(a2,b2)) x b1) x b2
    #                      |
    #                      | α_( (Coexp(a1,b1) x Coexp(a2,b2), b1), b2 )
    #                      v
    #  (Coexp(a1,b1) x Coexp(a2,b2)) x (b1 x b2)
    #
    #
    # Adjoint[ a1 x a2 -> (Coexp(a1,b1) x Coexp(a2,b2)) x (b1 x b2) ] = [ Coexp(a1 x a2, b1 x b2) -> Coexp(a1,b1) x Coexp(a2,b2) ]
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    coexp_a1_b1 := CoexponentialOnObjects( cat, a1, b1 );
    
    coexp_a2_b2 := CoexponentialOnObjects( cat, a2, b2 );

    id_b2 := IdentityMorphism( cat, b2 );
    
    coproduct_on_objects_coexp_a1_b1_coexp_a2_b2 :=
      BinaryCoproduct( cat, coexp_a1_b1, coexp_a2_b2 );
    
    morphism := PreComposeList( cat, [
                  CoproductOnMorphisms( cat,
                    IdentityMorphism( cat, a1 ),
                    CocartesianEvaluationMorphism( cat, a2, b2 ) ),
                  
                  CocartesianAssociatorRightToLeft( cat, a1, coexp_a2_b2, b2),
                  
                  CoproductOnMorphisms( cat,
                    CoproductOnMorphisms( cat,
                      CocartesianEvaluationMorphism( cat, a1, b1 ),
                      IdentityMorphism( cat, coexp_a2_b2)),
                    id_b2 ),
                  
                  CoproductOnMorphisms( cat,
                    CocartesianAssociatorLeftToRight( cat, coexp_a1_b1, a1, coexp_a2_b2 ),
                    id_b2 ),
                  
                  CoproductOnMorphisms( cat,
                    CoproductOnMorphisms( cat,
                      IdentityMorphism( cat, coexp_a1_b1),
                      CocartesianBraiding( cat, b1, coexp_a2_b2 ) ),
                    id_b2 ),
                  
                  CoproductOnMorphisms( cat,
                    CocartesianAssociatorRightToLeft( cat, coexp_a1_b1, coexp_a2_b2, b1 ),
                    id_b2 ),
                  
                  CocartesianAssociatorLeftToRight( cat,
                    coproduct_on_objects_coexp_a1_b1_coexp_a2_b2,
                    b1, b2 )
                ] );

    return CoproductToCoexponentialAdjunctionMap( cat,
             coproduct_on_objects_coexp_a1_b1_coexp_a2_b2,
             BinaryCoproduct( cat, b1, b2 ),
             morphism );

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CoexponentialCoproductCompatibilityMorphismWithGivenObjects using associator, braiding and the cocartesian evaluation morphism" );

##
AddDerivationToCAP( CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects,

  function( cat, s, a, b, r )
    local morphism, unit, coproduct_on_a_and_b;

    #         (a x b)_v
    #            |
    #            V
    #      Coexp(1, a x b)
    #            |
    #            | Coexp((λ_1)^-1, id_(a x b))
    #            V
    #  Coexp(1 x 1, a x b)
    #            |
    #            | CompatMorphism(1,1,a,b)
    #            V
    # Coexp(1,a) x Coexp(1,b)
    #            |
    #            v
    #        a_v x b_v
    
    unit := InitialObject( cat );
    
    coproduct_on_a_and_b := BinaryCoproduct( cat, a, b );
    
    morphism := PreComposeList( cat, [
                  IsomorphismFromCocartesianDualToCoexponential( cat, coproduct_on_a_and_b ),
                  
                  CoexponentialOnMorphisms( cat,
                    CocartesianLeftUnitorInverse( cat, unit ),
                    IdentityMorphism( cat, coproduct_on_a_and_b ) ),
                  
                  CoexponentialCoproductCompatibilityMorphism( cat, [ unit, unit, a, b ] ),
                  
                  CoproductOnMorphisms( cat,
                    IsomorphismFromCoexponentialToCocartesianDual( cat, a ),
                    IsomorphismFromCoexponentialToCocartesianDual( cat, b ) )
                ] );

    return morphism;

end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of coexponential and coproduct" );

##
AddDerivationToCAP( IsomorphismFromCoexponentialToObjectWithGivenCoexponential,
                  
  function( cat, a, internal_cohom )
    local unit;

    #     Coexp(a, 1)
    #         |
    #         | Coexp((ρ_a)^-1, id_1)
    #         v
    # Coexp(a x 1, 1)
    #         |
    #         | cocacoev_(a,1)
    #         v
    #         a
    
    unit := InitialObject( cat );
    
    return PreCompose( cat,
             CoexponentialOnMorphisms( cat,
               CocartesianRightUnitorInverse( cat, a ),
               IdentityMorphism( cat, unit ) ),
               
             CocartesianCoevaluationMorphism( cat, a, unit ));
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "IsomorphismFromCoexponentialToObjectWithGivenCoexponential using the cocartesian coevaluation morphism" );

##
AddDerivationToCAP( IsomorphismFromCoexponentialToObjectWithGivenCoexponential,
                  
  function( cat, a, internal_cohom )
    local unit;

    # (ρ_a)^-1: a -> a x 1
    #
    # Adjoint( (ρ_a)^-1 ) = ( Coexp(a,1) -> a )
    
    unit := InitialObject( cat );
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             a,
             unit,
             CocartesianRightUnitorInverse( cat, a ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "IsomorphismFromCoexponentialToObjectWithGivenCoexponential as the adjoint of the right inverse unitor" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromCoexponentialToObjectWithGivenCoexponential,
#                     
#   function( cat, a, internal_cohom )
#
#     # Inverse( a -> Coexp(a,1) )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToCoexponential( cat, a ) );
#     
# end : CategoryFilter := IsCocartesianCoclosedCategory,
#       Description := "IsomorphismFromCoexponentialToObjectWithGivenCoexponential as the inverse of IsomorphismFromObjectToCoexponential" );

##
AddDerivationToCAP( IsomorphismFromObjectToCoexponentialWithGivenCoexponential,
                  
  function( cat, a, internal_cohom )
    local unit;

    #       a
    #       |
    #       | cocaev_(a,1)
    #       v
    # Coexp(a,1) x 1
    #       |
    #       | ρ_Coexp(a,1)
    #       v
    #   Coexp(a,1)
    
    unit := InitialObject( cat );
    
    return PreCompose( cat, CocartesianEvaluationMorphism( cat, a, unit ),
                       CocartesianRightUnitor( cat, internal_cohom ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "IsomorphismFromObjectToCoexponentialWithGivenCoexponential using the cocartesian evaluation morphism" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToCoexponentialWithGivenCoexponential,
#                     
#   function( cat, a, internal_cohom )
#
#     # Inverse( Coexp(a,1) -> a)
#     
#     return InverseForMorphisms( cat, IsomorphismFromCoexponentialToObject( cat, a ) );
#     
# end : CategoryFilter := IsSymmetricClosedCocartesianCategory,
#       Description := "IsomorphismFromObjectToCoexponential as the inverse of IsomorphismFromCoexponentialToObject" );

##
AddDerivationToCAP( MorphismFromCoexponentialToCoproductWithGivenObjects,
                    
  function( cat, internal_cohom, a, b, coproduct_object )
    local unit;

    #       Coexp(a,b)
    #            |
    #            | Coexp(λ_a, (ρ_b)^-1)
    #            v
    # Coexp(1 x a, b x 1)
    #            |
    #            | CompatMorphism
    #            v
    # Coexp(1,b) x Coexp(a,1)
    #            |
    #            v
    #        b_v x a
    
    unit := InitialObject( cat );
    
    return PreComposeList( cat, [
             CoexponentialOnMorphisms( cat,
               CocartesianLeftUnitor( cat, a ),
               CocartesianRightUnitorInverse( cat, b ) ),
              
             CoexponentialCoproductCompatibilityMorphism( cat,
               [ unit, a, b, unit ] ),
              
             CoproductOnMorphisms( cat,
               IsomorphismFromCoexponentialToCocartesianDual( cat, b ),
               IsomorphismFromCoexponentialToObject( cat, a ) )
           ] );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "MorphismFromCoexponentialToCoproductWithGivenObjects using CoexponentialCoproductCompatibilityMorphism" );

##
AddDerivationToCAP( CocartesianEvaluationMorphismWithGivenRange,
                  
  function( cat, a, b, coproduct_object )

    # Adjoint( id_Coexp(a,b): Coexp(a,b) -> Coexp(a,b) ) = ( a -> Coexp(a,b) x b )
    
    return CoexponentialToCoproductAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, CoexponentialOnObjects( cat, a, b ) )
           );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianEvaluationMorphismWithGivenRange using the coexponential-coproduct adjunction on the identity" );

AddDerivationToCAP( CocartesianCoevaluationMorphismWithGivenSource,

  # Adjoint( id_(a x b): a x b -> a x b ) = ( Coexp(a x b, b) -> a )
                  
  function( cat, a, b, internal_cohom )
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, BinaryCoproduct( cat, a, b ) )
           );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianCoevaluationMorphismWithGivenSource using the coexponential-coproduct adjunction on the identity" );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                  
  function( cat, source, a, b, c, range )
    local coexp_a_b, coexp_b_c, morphism;

    #           a
    #           |
    #           | cocaev_ab
    #           v
    #    Coexp(a,b) x b
    #           |
    #           | B_( Coexp(a,b), b )
    #           v
    #      b x Coexp(a,b)
    #           |
    #           | cocaev_bc x id_Coexp(a,b)
    #           v
    # (Coexp(b,c) x c) x Coexp(a,b)
    #           |
    #           | α_( ( Coexp(b,c), c ), Coexp(a,b) )
    #           v
    # Coexp(b,c) x (c x Coexp(a,b))
    #           |
    #           | id_Coexp(b,c) x B_( c, Coexp(a,b) )
    #           v
    # Coexp(b,c) x (Coexp(a,b) x c)
    #           |
    #           | α_( Coexp(b,c), ( Coexp(a,b), c ) )
    #           v
    # (Coexp(b,c) x Coexp(a,b)) x c
    #
    #
    # Adjoint( a -> (Coexp(b,c) x Coexp(a,b)) x c ) = ( Coexp(a,c) -> Coexp(b,c) x Coexp(a,b) )
    
    coexp_a_b := CoexponentialOnObjects( cat, a, b );
    
    coexp_b_c := CoexponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat, [
                  CocartesianEvaluationMorphism( cat, a, b ),
                  
                  CocartesianBraiding( cat, coexp_a_b, b ),
                  
                  CoproductOnMorphisms( cat,
                    CocartesianEvaluationMorphism( cat, b, c ),
                    IdentityMorphism( cat, coexp_a_b ) ),
                  
                  CocartesianAssociatorLeftToRight( cat, coexp_b_c, c, coexp_a_b ),
                  
                  CoproductOnMorphisms( cat,
                    IdentityMorphism( cat, coexp_b_c ),
                    CocartesianBraiding( cat, c, coexp_a_b ) ),
                  
                  CocartesianAssociatorRightToLeft( cat, coexp_b_c, coexp_a_b, c ),
                ] );
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             BinaryCoproduct( cat, coexp_b_c, coexp_a_b ),
             c,
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianPreCoComposeMorphismWithGivenObjects using associator, braiding, cocartesian evaluation, and coexponential-coproduct adjunction" );

##
AddDerivationToCAP( CocartesianPostCoComposeMorphismWithGivenObjects,
                    
  function( cat, source, a, b, c, range )
    local coexp_a_b, coexp_b_c, morphism;

    #             a
    #             |
    #             | cocaev_ab
    #             v
    #      Coexp(a,b) x b
    #             |
    #             | id_Coexp(a,b) x cocaev_bc
    #             v
    #  Coexp(a,b) x (Coexp(b,c) x c)
    #             |
    #             | α_( Coexp(a,b), ( Coexp(b,c), c ) )
    #             v
    # (Coexp(a,b) x Coexp(b,c)) x c
    #
    #
    # Adjoint( a -> (Coexp(a,b) x Coexp(b,c)) x c ) = ( Coexp(a,c) -> Coexp(a,b) x Coexp(b,c) )
    
    coexp_a_b := CoexponentialOnObjects( cat, a, b );
    
    coexp_b_c := CoexponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat, [
                  CocartesianEvaluationMorphism( cat, a, b ),
                  
                  CoproductOnMorphisms( cat,
                    CocartesianEvaluationMorphism( cat, b, c ),
                    IdentityMorphism( cat, coexp_a_b )
                  ),
                  
                  CocartesianAssociatorRightToLeft( cat, coexp_a_b, coexp_b_c, c )
                ] );
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             BinaryCoproduct( cat, coexp_a_b, coexp_b_c ),
             c,
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianPostCoComposeMorphismWithGivenObjects using associator, cocartesian evaluation, and coexponential-coproduct adjunction" );

##
AddDerivationToCAP( CocartesianPostCoComposeMorphismWithGivenObjects,
                    
  function( cat, source, a, b, c, range )
    local braiding;

    #       Coexp(a,c)
    #            |
    #            | PreCoCompose
    #            v
    # Coexp(b,c) x Coexp(a,b)
    #            |
    #            | B_( Coexp(b,c), Coexp(a,b) )
    #            v
    # Coexp(a,b) x Coexp(b,c)
    
    braiding := CocartesianBraiding( cat, CoexponentialOnObjects( cat, b, c ), CoexponentialOnObjects( cat, a, b ) );
    
    return PreCompose( cat, CocartesianPreCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianPostCoComposeMorphismWithGivenObjects using CocartesianPreCoComposeMorphism and braiding" );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                    
  function( cat, source, a, b, c, range )
    local braiding;
    
    #       Coexp(a,c)
    #            |
    #            | PostCoCompose
    #            v
    # Coexp(a,b) x Coexp(b,c)
    #            |
    #            | B_( Coexp(a,b), Coexp(b,c) )
    #            v
    # Coexp(b,c) x Coexp(a,b)

    braiding := CocartesianBraiding( cat, CoexponentialOnObjects( cat, a, b ), CoexponentialOnObjects( cat, b, c ) );
    
    return PreCompose( cat, CocartesianPostCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsCocartesianCoclosedCategory,
      Description := "CocartesianPreCoComposeMorphismWithGivenObjects using CocartesianPostCoComposeMorphism and braiding" );

##
AddDerivationToCAP( CoexponentialCoproductCompatibilityMorphismWithGivenObjects,
                    
  function( cat, source, list, range )
    local a1, a2, b1, b2, morphism, coexp_a1_b1, coexp_a2_b2, id_b2, coproduct_on_objects_coexp_a1_b1_coexp_a2_b2;

    #           a1 x a2
    #              |
    #              | id_a1 x cocaev_(a2,b2)
    #              v
    #    a1 x Coexp(a2,b2) x b2
    #              |
    #              | cocaev_(a1,b1) x id_Coexp(a2,b2) x id_b2
    #              v
    # Coexp(a1,b1) x b1 x Coexp(a2,b2) x b2
    #              |
    #              | id_Coexp(a1,b1) x B_( b1, Coexp(a2,b2) )  x id_b2
    #              v
    # Coexp(a1,b1) x Coexp(a2,b2) x b1 x b2
    #
    #
    # Adjoint[ a1 x a2 -> Coexp(a1,b1) x Coexp(a2,b2) x b1 x b2 ] = [ Coexp(a1 x a2, b1 x b2) -> Coexp(a1,b1) x Coexp(a2,b2) ]
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    coexp_a1_b1 := CoexponentialOnObjects( cat, a1, b1 );
    
    coexp_a2_b2 := CoexponentialOnObjects( cat, a2, b2 );

    id_b2 := IdentityMorphism( cat, b2 );
    
    coproduct_on_objects_coexp_a1_b1_coexp_a2_b2 :=
      BinaryCoproduct( cat, coexp_a1_b1, coexp_a2_b2 );
    
    morphism := PreComposeList( cat, [
                  CoproductOnMorphisms( cat,
                    IdentityMorphism( cat, a1 ),
                    CocartesianEvaluationMorphism( cat, a2, b2 ) ),
                  
                  CoproductOnMorphisms( cat,
                    CoproductOnMorphisms( cat,
                      CocartesianEvaluationMorphism( cat, a1, b1 ),
                      IdentityMorphism( cat, coexp_a2_b2)),
                    id_b2 ),
                  
                  CoproductOnMorphisms( cat,
                    CoproductOnMorphisms( cat,
                      IdentityMorphism( cat, coexp_a1_b1),
                      CocartesianBraiding( cat, b1, coexp_a2_b2 ) ),
                    id_b2 ),
                ] );

    return CoproductToCoexponentialAdjunctionMap( cat,
             coproduct_on_objects_coexp_a1_b1_coexp_a2_b2,
             BinaryCoproduct( cat, b1, b2 ),
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory and IsStrictCocartesianCategory,
      Description := "CoexponentialCoproductCompatibilityMorphismWithGivenObjects using braiding and the cocartesian evaluation morphism" );

##
AddDerivationToCAP( CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects,
                  
  function( cat, source, a, b, range )
    local morphism, unit, coproduct_on_a_and_b;

    #         (a x b)_v
    #            |
    #            V
    #      Coexp(1, a x b)
    #            |
    #            | CompatMorphism(1,1,a,b)
    #            V
    # Coexp(1,a) x Coexp(1,b)
    #            |
    #            v
    #        a_v x b_v
    
    unit := InitialObject( cat );
    
    coproduct_on_a_and_b := BinaryCoproduct( cat, a, b );
    
    morphism := PreComposeList( cat, [
                  IsomorphismFromCocartesianDualToCoexponential( cat, coproduct_on_a_and_b ),
                  
                  CoexponentialCoproductCompatibilityMorphism( cat, [ unit, unit, a, b ] ),
                  
                  CoproductOnMorphisms( cat,
                    IsomorphismFromCoexponentialToCocartesianDual( cat, a ),
                    IsomorphismFromCoexponentialToCocartesianDual( cat, b ) )
                ] );
              
    return morphism;
    
end : CategoryFilter := IsCocartesianCoclosedCategory and IsStrictCocartesianCategory,
      Description := "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects using compatibility of coexponential and coproduct" );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                  
  function( cat, source, a, b, c, range )
    local coexp_a_b, coexp_b_c, morphism;

    #            a
    #            |
    #            | cocaev_ab
    #            v
    #      Coexp(a,b) x b
    #            |
    #            | B_( Coexp(a,b), b )
    #            v
    #      b x Coexp(a,b)
    #            |
    #            | cocaev_bc x id_Coexp(a,b)
    #            v
    # Coexp(b,c) x c x Coexp(a,b)
    #            |
    #            | id_Coexp(b,c) x B_( c, Coexp(a,b) )
    #            v
    # Coexp(b,c) x Coexp(a,b) x c
    #
    #
    # Adjoint( a -> (Coexp(b,c) x Coexp(a,b)) x c ) = ( Coexp(a,c) -> Coexp(b,c) x Coexp(a,b) )
    
    coexp_a_b := CoexponentialOnObjects( cat, a, b );
    
    coexp_b_c := CoexponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat, [
                  CocartesianEvaluationMorphism( cat, a, b ),
                  
                  CocartesianBraiding( cat, coexp_a_b, b),
                  
                  CoproductOnMorphisms( cat,
                    CocartesianEvaluationMorphism( cat, b, c ),
                    IdentityMorphism( cat, coexp_a_b ) ),
                  
                  CoproductOnMorphisms( cat,
                    IdentityMorphism( cat, coexp_b_c ),
                    CocartesianBraiding( cat, c, coexp_a_b ) )
                ] );
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             BinaryCoproduct( cat, coexp_b_c, coexp_a_b ),
             c,
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory and IsStrictCocartesianCategory,
      Description := "CocartesianPreCoComposeMorphismWithGivenObjects using braiding, cocartesian evaluation, and coexponential-coproduct adjunction" );

##
AddDerivationToCAP( CocartesianPostCoComposeMorphismWithGivenObjects,
                    
  function( cat, source, a, b, c, range )
    local coexp_a_b, coexp_b_c, morphism;

    #             a
    #             |
    #             | cocaev_ab
    #             v
    #      Coexp(a,b) x b
    #             |
    #             | id_Coexp(a,b) x cocaev_bc
    #             v
    #  Coexp(a,b) x (Coexp(b,c) x c)
    #
    #
    # Adjoint( a -> (Coexp(a,b) x Coexp(b,c)) x c ) = ( Coexp(a,c) -> Coexp(a,b) x Coexp(b,c) )
    
    coexp_a_b := CoexponentialOnObjects( cat, a, b );
    
    coexp_b_c := CoexponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat, [
                  CocartesianEvaluationMorphism( cat, a, b ),
                  
                  CoproductOnMorphisms( cat,
                    IdentityMorphism( cat, coexp_a_b ),
                    CocartesianEvaluationMorphism( cat, b, c ) )
                ] );
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             BinaryCoproduct( cat, coexp_a_b, coexp_b_c ),
             c,
             morphism );
    
end : CategoryFilter := IsCocartesianCoclosedCategory and IsStrictCocartesianCategory,
      Description := "CocartesianPostCoComposeMorphismWithGivenObjects using cocartesian evaluation, and coexponential-coproduct adjunction" );
