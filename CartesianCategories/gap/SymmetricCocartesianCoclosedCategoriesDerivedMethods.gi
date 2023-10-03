# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CoproductToCoexponentialAdjunctionMap,
                    "CoproductToCoexponentialAdjunctionMap using CocartesianCoevaluationMorphism and Coexponential",
                    [ [ PreCompose, 1 ],
                      [ CoexponentialOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CocartesianCoevaluationMorphism, 1 ] ],
                    
  function( cat, c, b, g )
    
    # g: a → c ⊔ b
    #
    #    Coexp(a,b)
    #        |
    #        | Coexp(g, id_b)
    #        v
    # Coexp(c ⊔ b, b)
    #        |
    #        | cocacoev_cb
    #        v
    #        c

    return PreCompose( cat,
             CoexponentialOnMorphisms( cat, g, IdentityMorphism( cat, b ) ),
             CocartesianCoevaluationMorphism( cat, c, b ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CoproductToCoexponentialAdjunctionMapWithGivenCoexponential,
                    "CoproductToCoexponentialAdjunctionMapWithGivenCoexponential using CocartesianCoevaluationMorphism and Coexponential",
                    [ [ CocartesianCoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ CoexponentialOnMorphismsWithGivenCoexponentials, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, c, b, g, i )
    local cocacoev_cb;
    
    # g: a → c ⊔ b
    #
    #    Coexp(a,b)
    #        |
    #        | Coexp(g, id_b)
    #        v
    # Coexp(c ⊔ b, b)
    #        |
    #        | cocacoev_cb
    #        v
    #        c
    
    cocacoev_cb := CocartesianCoevaluationMorphism( cat, c, b );
    
    return PreCompose( cat,
             CoexponentialOnMorphismsWithGivenCoexponentials( cat, i, g, IdentityMorphism( cat, b ), Source( cocacoev_cb ) ),
             cocacoev_cb );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CoexponentialToCoproductAdjunctionMap,
                    "CoexponentialToCoproductAdjunctionMap using CoproductOnMorphisms and CocartesianEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ CocartesianEvaluationMorphism, 1 ],
                      [ CoproductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f )
    
    # f: Coexp(a,b) → c
    #
    #        a
    #        |
    #        | cocaev_ab
    #        v
    # Coexp(a,b) ⊔ b
    #        |
    #        | f ⊔ id_b
    #        v
    #      c ⊔ b
    
    return PreCompose( cat,
             CocartesianEvaluationMorphism( cat, a, b ),
             CoproductOnMorphisms( cat, f, IdentityMorphism( cat, b ) ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CoexponentialToCoproductAdjunctionMapWithGivenCoproduct,
                    "CoexponentialToCoproductAdjunctionMapWithGivenCoproduct using CoproductOnMorphisms and CocartesianEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ CocartesianEvaluationMorphism, 1 ],
                      [ CoproductOnMorphismsWithGivenCoproducts, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f, t )
    local cocaev_bc;
    
    # f: Coexp(a,b) → c
    #
    #        a
    #        |
    #        | cocaev_ab
    #        v
    # Coexp(a,b) ⊔ b
    #        |
    #        | f ⊔ id_b
    #        v
    #      c ⊔ b
    
    cocaev_bc := CocartesianEvaluationMorphism( cat, a, b );
    
    return PreCompose( cat,
             cocaev_bc,
             CoproductOnMorphismsWithGivenCoproducts( cat, Range( cocaev_bc ), f, IdentityMorphism( cat, b ), t ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( UniversalPropertyOfCocartesianDual,
                    "UniversalPropertyOfCocartesianDual using the coexponential-coproduct adjunction",
                    [ [ PreCompose, 1 ],
                      [ IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject, 1 ],
                      [ CoproductToCoexponentialAdjunctionMap, 1 ] ],
                    
  function( cat, t, a, alpha )
    
    # alpha: 1 → t ⊔ a
    #
    # a_v → ( Coexp(1,a) → t ) = Adjoint( alpha )
    
    return PreCompose( cat,
             IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject( cat, a ),
             CoproductToCoexponentialAdjunctionMap( cat, t, a, alpha ) );
             
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
                      [ CocartesianEvaluationMorphism, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ CocartesianBraiding, 1 ],
                      [ CocartesianCoevaluationMorphism, 1 ] ],
                    
  function( cat, a, avv )
    local av, morphism;
    
    #     Coexp(1, a_v)
    #          |
    #          | Coexp( cocaev_(1,a), id_(a_v) )
    #          v
    # Coexp(a_v ⊔ a, a_v)
    #          |
    #          | Coexp( B_( a_v, a), id_(a_v) )
    #          v
    # Coexp(a ⊔ a_v, a_v)
    #          |
    #          | cocacoev_(a, a_v)
    #          v
    #          a
    
    av := CocartesianDualOnObjects( cat, a );
    
    morphism := PreComposeList( cat,
                        avv,
                        [ CoexponentialOnMorphisms( cat,
                                CocartesianEvaluationMorphism( cat, InitialObject( cat ), a ),
                                IdentityMorphism( cat, av ) ),
                          
                          CoexponentialOnMorphisms( cat,
                                  CocartesianBraiding( cat, av, a ),
                                  IdentityMorphism( cat, av ) ),
                          
                          CocartesianCoevaluationMorphism( cat, a, av ) ],
                        a );
    
    return morphism;
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianDualOnObjects,
                    "CocartesianDualOnObjects as the source of IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject",
                    [ [ IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject, 1 ] ],
                    
  function( cat, a )
    
    # Source( a_v → Coexp(1,a) )
    
    return Source( IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject( cat, a ) );

end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianDualOnObjects,
                    "CocartesianDualOnObjects as the range of IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject",
                    [ [ IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject, 1 ] ],
                    
  function( cat, a )
    
    # Range( Coexp(1,a) → a_v )
    
    return Range( IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject( cat, a ) );

end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianDualOnMorphismsWithGivenCocartesianDuals,
                    "CocartesianDualOnMorphismsWithGivenCocartesianDuals using CoexponentialOnMorphisms and IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject",
                    [ [ PreComposeList, 1 ],
                      [ IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject, 1 ],
                      [ CoexponentialOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ InitialObject, 1 ],
                      [ IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject, 1 ] ],
                    
  function( cat, s, alpha, r )
    local result_morphism;
    
    # alpha: a → b
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
    
    result_morphism := PreComposeList( cat,
                               s,
                               [ IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject( cat, Range( alpha ) ),
                                 
                                 CoexponentialOnMorphisms( cat,
                                         IdentityMorphism( cat, InitialObject( cat ) ),
                                         alpha ),
                                 
                                 IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject( cat, Source( alpha ) ) ],
                               r );
    
    return result_morphism;
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianEvaluationForCocartesianDualWithGivenCoproduct,
                    "CocartesianEvaluationForCocartesianDualWithGivenCoproduct using the coexponential-coproduct adjunction and IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject",
                    [ [ CoexponentialToCoproductAdjunctionMapWithGivenCoproduct, 1 ],
                      [ IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject, 1 ] ],
                    
  function( cat, s, a, r )
    
    # s := 1
    
    # Adjoint( Coexp(1,a) → a_v ) = ( 1 → a_v ⊔ a )

    return CoexponentialToCoproductAdjunctionMapWithGivenCoproduct( cat,
            s,
            a,
            IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject( cat, a ),
            r );

end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianLambdaIntroduction,
                    "CocartesianLambdaIntroduction using the coexponential-coproduct adjunction and the left unitor inverse",
                    [ [ PreCompose, 1 ],
                      [ CocartesianLeftUnitorInverse, 1 ],
                      [ CoproductToCoexponentialAdjunctionMap, 1 ],
                      [ InitialObject, 1 ] ],
                    
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
    # 1 ⊔ b
    #
    # Adjoint( a → 1 ⊔ b ) = ( Coexp(a,b) → 1 )

    range := Range( alpha );

    result_morphism := PreCompose( cat, alpha, CocartesianLeftUnitorInverse( cat, range ) );

    return CoproductToCoexponentialAdjunctionMap( cat,
             InitialObject( cat ),
             range,
             result_morphism );

end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianLambdaElimination,
                    "CocartesianLambdaElimination using the coexponential-coproduct adjunction and the left unitor",
                    [ [ CoexponentialToCoproductAdjunctionMap, 1 ],
                      [ PreCompose, 1 ],
                      [ CocartesianLeftUnitor, 1 ] ],
                    
  function( cat, a, b, alpha )
    local result_morphism;
    
    # alpha: Coexp(a,b) → 1
    # Adjoint( alpha ) = ( a → 1 ⊔ b )
    #
    #   a
    #   |
    #   | Adjoint( alpha )
    #   v
    # 1 ⊔ b
    #   |
    #   | λ_b
    #   v
    #   b
    
    result_morphism := CoexponentialToCoproductAdjunctionMap( cat, a, b, alpha );
    
    return PreCompose( cat, result_morphism, CocartesianLeftUnitor( cat, b ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CoexponentialCoproductCompatibilityMorphismWithGivenObjects,
                    "CoexponentialCoproductCompatibilityMorphismWithGivenObjects using associator, braiding and the cocartesian evaluation morphism",
                    [ [ CoexponentialOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ Coproduct, 3 ],
                      [ PreComposeList, 1 ],
                      [ CoproductOnMorphisms, 7 ],
                      [ CocartesianEvaluationMorphism, 2 ],
                      [ CocartesianAssociatorRightToLeft, 2 ],
                      [ CocartesianAssociatorLeftToRight, 2 ],
                      [ CocartesianBraiding, 1 ],
                      [ CoproductToCoexponentialAdjunctionMapWithGivenCoexponential, 1 ] ],
                    
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
                                CocartesianEvaluationMorphism( cat, a2, b2 ) ),
                          
                          CocartesianAssociatorRightToLeft( cat, a1, coexp_a2_b2, b2 ),
                          
                          CoproductOnMorphisms( cat,
                                  CoproductOnMorphisms( cat,
                                          CocartesianEvaluationMorphism( cat, a1, b1 ),
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
    
    return CoproductToCoexponentialAdjunctionMapWithGivenCoexponential( cat,
                   range,
                   b1b2,
                   morphism,
                   source );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects,
                    "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of coexponential and coproduct",
                    [ [ InitialObject, 1 ],
                      [ Coproduct, 1 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject, 1 ],
                      [ CoexponentialOnMorphisms, 1 ],
                      [ CocartesianLeftUnitorInverse, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CoexponentialCoproductCompatibilityMorphism, 1 ],
                      [ CoproductOnMorphisms, 1 ],
                      [ IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject, 2 ] ],
                    
  function( cat, s, a, b, r )
    local unit, coproduct_on_a_and_b, morphism;
    
    #         (a ⊔ b)_v
    #            |
    #            V
    #      Coexp(1, a ⊔ b)
    #            |
    #            | Coexp((λ_1)^-1, id_(a ⊔ b))
    #            V
    #  Coexp(1 ⊔ 1, a ⊔ b)
    #            |
    #            | CompatMorphism(1,1,a,b)
    #            V
    # Coexp(1,a) ⊔ Coexp(1,b)
    #            |
    #            v
    #        a_v ⊔ b_v
    
    unit := InitialObject( cat );
    
    coproduct_on_a_and_b := BinaryCoproduct( cat, a, b );
    
    morphism := PreComposeList( cat,
                        s,
                        [ IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject( cat, coproduct_on_a_and_b ),
                          
                          CoexponentialOnMorphisms( cat,
                                  CocartesianLeftUnitorInverse( cat, unit ),
                                  IdentityMorphism( cat, coproduct_on_a_and_b ) ),
                          
                          CoexponentialCoproductCompatibilityMorphism( cat, [ unit, unit, a, b ] ),
                          
                          CoproductOnMorphisms( cat,
                                  IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject( cat, a ),
                                  IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject( cat, b ) ) ],
                        r );
    
    return morphism;
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( IsomorphismFromCoexponentialToObjectWithGivenCoexponential,
                    "IsomorphismFromCoexponentialToObjectWithGivenCoexponential using the cocartesian coevaluation morphism",
                    [ [ InitialObject, 1 ],
                      [ PreCompose, 1 ],
                      [ CoexponentialOnMorphisms, 1 ],
                      [ CocartesianRightUnitorInverse, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CocartesianCoevaluationMorphism, 1 ] ],
                    
  function( cat, a, internal_cohom )
    local unit;
    
    #     Coexp(a, 1)
    #         |
    #         | Coexp((ρ_a)^-1, id_1)
    #         v
    # Coexp(a ⊔ 1, 1)
    #         |
    #         | cocacoev_(a,1)
    #         v
    #         a
    
    unit := InitialObject( cat );
    
    return PreCompose( cat,
                   CoexponentialOnMorphisms( cat,
                           CocartesianRightUnitorInverse( cat, a ),
                           IdentityMorphism( cat, unit ) ),
                   
                   CocartesianCoevaluationMorphism( cat, a, unit ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( IsomorphismFromCoexponentialToObjectWithGivenCoexponential,
                    "IsomorphismFromCoexponentialToObjectWithGivenCoexponential as the adjoint of the right inverse unitor",
                    [ [ InitialObject, 1 ],
                      [ CoproductToCoexponentialAdjunctionMap, 1 ],
                      [ CocartesianRightUnitorInverse, 1 ] ],
                    
  function( cat, a, internal_cohom )
    
    # (ρ_a)^-1: a → a ⊔ 1
    #
    # Adjoint( (ρ_a)^-1 ) = ( Coexp(a,1) → a )
    
    return CoproductToCoexponentialAdjunctionMap( cat,
                   a,
                   InitialObject( cat ),
                   CocartesianRightUnitorInverse( cat, a ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromCoexponentialToObjectWithGivenCoexponential,
#                     
#   function( cat, a, internal_cohom )
#
#     # Inverse( a → Coexp(a,1) )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToCoexponential( cat, a ) );
#     
# end : CategoryFilter := IsCocartesianCoclosedCategory,
#       Description := "IsomorphismFromCoexponentialToObjectWithGivenCoexponential as the inverse of IsomorphismFromObjectToCoexponential" );

##
AddDerivationToCAP( IsomorphismFromObjectToCoexponentialWithGivenCoexponential,
                    "IsomorphismFromObjectToCoexponentialWithGivenCoexponential using the cocartesian evaluation morphism",
                    [ [ InitialObject, 1 ],
                      [ PreCompose, 1 ],
                      [ CocartesianEvaluationMorphism, 1 ],
                      [ CocartesianRightUnitor, 1 ] ],
                    
  function( cat, a, internal_cohom )
    
    #       a
    #       |
    #       | cocaev_(a,1)
    #       v
    # Coexp(a,1) ⊔ 1
    #       |
    #       | ρ_Coexp(a,1)
    #       v
    #   Coexp(a,1)
    
    return PreCompose( cat,
                   CocartesianEvaluationMorphism( cat, a, InitialObject( cat ) ),
                   CocartesianRightUnitor( cat, internal_cohom ) );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToCoexponentialWithGivenCoexponential,
#                     
#   function( cat, a, internal_cohom )
#
#     # Inverse( Coexp(a,1) → a)
#     
#     return InverseForMorphisms( cat, IsomorphismFromCoexponentialToObject( cat, a ) );
#     
# end : CategoryFilter := IsSymmetricClosedCocartesianCategory,
#       Description := "IsomorphismFromObjectToCoexponential as the inverse of IsomorphismFromCoexponentialToObject" );

##
AddDerivationToCAP( MorphismFromCoexponentialToCoproductWithGivenObjects,
                    "MorphismFromCoexponentialToCoproductWithGivenObjects using CoexponentialCoproductCompatibilityMorphism",
                    [ [ InitialObject, 1 ],
                      [ PreComposeList, 1 ],
                      [ CoexponentialOnMorphisms, 1 ],
                      [ CocartesianLeftUnitorInverse, 1 ],
                      [ CocartesianRightUnitor, 1 ],
                      [ CoexponentialCoproductCompatibilityMorphism, 1 ],
                      [ CoproductOnMorphisms, 1 ],
                      [ IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject, 1 ],
                      [ IsomorphismFromCoexponentialToObject, 1 ] ],
                    
  function( cat, internal_cohom, a, b, coproduct_object )
    local unit;
    
    #       Coexp(a,b)
    #            |
    #            | Coexp((λ_a)^-1, ρ_b)
    #            v
    # Coexp(1 ⊔ a, b ⊔ 1)
    #            |
    #            | CompatMorphism
    #            v
    # Coexp(1,b) ⊔ Coexp(a,1)
    #            |
    #            v
    #        b_v ⊔ a
    
    unit := InitialObject( cat );
    
    return PreComposeList( cat,
                   internal_cohom,
                   [ CoexponentialOnMorphisms( cat,
                           CocartesianLeftUnitorInverse( cat, a ),
                           CocartesianRightUnitor( cat, b ) ),
                     
                     CoexponentialCoproductCompatibilityMorphism( cat,
                             [ unit, a, b, unit ] ),
                     
                     CoproductOnMorphisms( cat,
                             IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject( cat, b ),
                             IsomorphismFromCoexponentialToObject( cat, a ) ) ],
                   coproduct_object );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianEvaluationMorphismWithGivenRange,
                    "CocartesianEvaluationMorphismWithGivenRange using the coexponential-coproduct adjunction on the identity",
                    [ [ CoexponentialToCoproductAdjunctionMapWithGivenCoproduct, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CoexponentialOnObjects, 1 ] ],
                    
  function( cat, a, b, coproduct_object )
    
    # Adjoint( id_Coexp(a,b): Coexp(a,b) → Coexp(a,b) ) = ( a → Coexp(a,b) ⊔ b )
    
    return CoexponentialToCoproductAdjunctionMapWithGivenCoproduct( cat,
             a,
             b,
             IdentityMorphism( cat, CoexponentialOnObjects( cat, a, b ) ),
             coproduct_object );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

AddDerivationToCAP( CocartesianCoevaluationMorphismWithGivenSource,
                    "CocartesianCoevaluationMorphismWithGivenSource using the coexponential-coproduct adjunction on the identity",
                    [ [ CoproductToCoexponentialAdjunctionMapWithGivenCoexponential, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ Coproduct, 1 ] ],
                    
  function( cat, a, b, internal_cohom )
    
    # Adjoint( id_(a ⊔ b): a ⊔ b → a ⊔ b ) = ( Coexp(a ⊔ b, b) → a )
    
    return CoproductToCoexponentialAdjunctionMapWithGivenCoexponential( cat,
             a,
             b,
             IdentityMorphism( cat, BinaryCoproduct( cat, a, b ) ),
             internal_cohom );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                    "CocartesianPreCoComposeMorphismWithGivenObjects using associator, braiding, cocartesian evaluation, and coexponential-coproduct adjunction",
                    [ [ CoexponentialOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CocartesianEvaluationMorphism, 2 ],
                      [ CocartesianBraiding, 2 ],
                      [ CoproductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ CocartesianAssociatorLeftToRight, 1 ],
                      [ CocartesianAssociatorRightToLeft, 1 ],
                      [ CoproductToCoexponentialAdjunctionMapWithGivenCoexponential, 1 ],
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
                        [ CocartesianEvaluationMorphism( cat, a, b ),
                          
                          CocartesianBraiding( cat, coexp_a_b, b ),
                          
                          CoproductOnMorphisms( cat,
                                  CocartesianEvaluationMorphism( cat, b, c ),
                                  IdentityMorphism( cat, coexp_a_b ) ),
                          
                          CocartesianAssociatorLeftToRight( cat, coexp_b_c, c, coexp_a_b ),
                          
                          CoproductOnMorphisms( cat,
                                  IdentityMorphism( cat, coexp_b_c ),
                                  CocartesianBraiding( cat, c, coexp_a_b ) ),
                          
                          CocartesianAssociatorRightToLeft( cat, coexp_b_c, coexp_a_b, c ) ],
                        BinaryCoproduct( cat,
                                range,
                                c ) );
    
    return CoproductToCoexponentialAdjunctionMapWithGivenCoexponential( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianPostCoComposeMorphismWithGivenObjects,
                    "CocartesianPostCoComposeMorphismWithGivenObjects using associator, cocartesian evaluation, and coexponential-coproduct adjunction",
                    [ [ CoexponentialOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CocartesianEvaluationMorphism, 2 ],
                      [ CoproductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CocartesianAssociatorRightToLeft, 1 ],
                      [ CoproductToCoexponentialAdjunctionMapWithGivenCoexponential, 1 ],
                      [ Coproduct, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local coexp_a_b, coexp_b_c, morphism;
    
    #             a
    #             |
    #             | cocaev_ab
    #             v
    #      Coexp(a,b) ⊔ b
    #             |
    #             | id_Coexp(a,b) ⊔ cocaev_bc
    #             v
    #  Coexp(a,b) ⊔ (Coexp(b,c) ⊔ c)
    #             |
    #             | α_( Coexp(a,b), ( Coexp(b,c), c ) )
    #             v
    # (Coexp(a,b) ⊔ Coexp(b,c)) ⊔ c
    #
    #
    # Adjoint( a → (Coexp(a,b) ⊔ Coexp(b,c)) ⊔ c ) = ( Coexp(a,c) → Coexp(a,b) ⊔ Coexp(b,c) )
    
    coexp_a_b := CoexponentialOnObjects( cat, a, b );
    
    coexp_b_c := CoexponentialOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        a,
                        [ CocartesianEvaluationMorphism( cat, a, b ),
                          
                          CoproductOnMorphisms( cat,
                                  IdentityMorphism( cat, coexp_a_b ),
                                  CocartesianEvaluationMorphism( cat, b, c ) ),
                          
                          CocartesianAssociatorRightToLeft( cat, coexp_a_b, coexp_b_c, c ) ],
                        BinaryCoproduct( cat,
                                range,
                                c ) );
    
    return CoproductToCoexponentialAdjunctionMapWithGivenCoexponential( cat,
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
                      [ CocartesianEvaluationMorphism, 2 ],
                      [ CocartesianBraiding, 1 ],
                      [ CoproductToCoexponentialAdjunctionMapWithGivenCoexponential, 1 ] ],
                    
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
                                CocartesianEvaluationMorphism( cat, a2, b2 ) ),
                          
                          CoproductOnMorphisms( cat,
                                  CoproductOnMorphisms( cat,
                                          CocartesianEvaluationMorphism( cat, a1, b1 ),
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
    
    return CoproductToCoexponentialAdjunctionMapWithGivenCoexponential( cat,
                   range,
                   b1b2,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsCocartesianCoclosedCategory( cat ) and IsCocartesianCoclosedCategory( cat ) and HasIsStrictCocartesianCategory( cat ) and IsStrictCocartesianCategory( cat ) );

##
AddDerivationToCAP( CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects,
                    "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects using compatibility of coexponential and coproduct",
                    [ [ InitialObject, 1 ],
                      [ Coproduct, 1 ],
                      [ PreComposeList, 1 ],
                      [ IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject, 1 ],
                      [ CoexponentialCoproductCompatibilityMorphism, 1 ],
                      [ CoproductOnMorphisms, 1 ],
                      [ IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject, 2 ] ],
                    
  function( cat, source, a, b, range )
    local unit, morphism;
    
    #         (a ⊔ b)_v
    #            |
    #            V
    #      Coexp(1, a ⊔ b)
    #            |
    #            | CompatMorphism(1,1,a,b)
    #            V
    # Coexp(1,a) ⊔ Coexp(1,b)
    #            |
    #            v
    #        a_v ⊔ b_v
    
    unit := InitialObject( cat );
    
    morphism := PreComposeList( cat,
                        source,
                        [ IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject( cat, BinaryCoproduct( cat, a, b ) ),
                          
                          CoexponentialCoproductCompatibilityMorphism( cat, [ unit, unit, a, b ] ),
                          
                          CoproductOnMorphisms( cat,
                                  IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject( cat, a ),
                                  IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject( cat, b ) ) ],
                        range );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsCocartesianCoclosedCategory( cat ) and IsCocartesianCoclosedCategory( cat ) and HasIsStrictCocartesianCategory( cat ) and IsStrictCocartesianCategory( cat ) );

##
AddDerivationToCAP( CocartesianPreCoComposeMorphismWithGivenObjects,
                    "CocartesianPreCoComposeMorphismWithGivenObjects using braiding, cocartesian evaluation, and coexponential-coproduct adjunction",
                    [ [ CoexponentialOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ CocartesianEvaluationMorphism, 2 ],
                      [ CocartesianBraiding, 2 ],
                      [ CoproductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Coproduct, 1 ],
                      [ CoproductToCoexponentialAdjunctionMapWithGivenCoexponential, 1 ] ],
                    
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
                        [ CocartesianEvaluationMorphism( cat, a, b ),
                          
                          CocartesianBraiding( cat, coexp_a_b, b ),
                          
                          CoproductOnMorphisms( cat,
                                  CocartesianEvaluationMorphism( cat, b, c ),
                                  IdentityMorphism( cat, coexp_a_b ) ),
                          
                          CoproductOnMorphisms( cat,
                                  IdentityMorphism( cat, coexp_b_c ),
                                  CocartesianBraiding( cat, c, coexp_a_b ) ) ],
                        BinaryCoproduct( cat,
                                range,
                                c ) );
    
    return CoproductToCoexponentialAdjunctionMapWithGivenCoexponential( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsCocartesianCoclosedCategory( cat ) and IsCocartesianCoclosedCategory( cat ) and HasIsStrictCocartesianCategory( cat ) and IsStrictCocartesianCategory( cat ) );

##
AddDerivationToCAP( CocartesianPostCoComposeMorphismWithGivenObjects,
                    "CocartesianPostCoComposeMorphismWithGivenObjects using cocartesian evaluation, and coexponential-coproduct adjunction",
                    [ [ CoexponentialOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ CocartesianEvaluationMorphism, 2 ],
                      [ CoproductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CoproductToCoexponentialAdjunctionMapWithGivenCoexponential, 1 ],
                      [ Coproduct, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local morphism;
    
    #             a
    #             |
    #             | cocaev_ab
    #             v
    #      Coexp(a,b) ⊔ b
    #             |
    #             | id_Coexp(a,b) ⊔ cocaev_bc
    #             v
    #  Coexp(a,b) ⊔ (Coexp(b,c) ⊔ c)
    #
    #
    # Adjoint( a → (Coexp(a,b) ⊔ Coexp(b,c)) ⊔ c ) = ( Coexp(a,c) → Coexp(a,b) ⊔ Coexp(b,c) )
    
    morphism := PreComposeList( cat,
                        a,
                        [ CocartesianEvaluationMorphism( cat, a, b ),
                          
                          CoproductOnMorphisms( cat,
                                  IdentityMorphism( cat, CoexponentialOnObjects( cat, a, b ) ),
                                  CocartesianEvaluationMorphism( cat, b, c ) ) ],
                        BinaryCoproduct( cat,
                                range,
                                c ) );
    
    return CoproductToCoexponentialAdjunctionMapWithGivenCoexponential( cat,
                   range,
                   c,
                   morphism,
                   source );
    
end : CategoryFilter := cat -> HasIsCocartesianCoclosedCategory( cat ) and IsCocartesianCoclosedCategory( cat ) and HasIsStrictCocartesianCategory( cat ) and IsStrictCocartesianCategory( cat ) );
