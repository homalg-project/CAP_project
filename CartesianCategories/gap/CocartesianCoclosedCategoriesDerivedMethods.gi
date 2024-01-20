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
AddDerivationToCAP( CocartesianEvaluationMorphismWithGivenRange,
                    "CocartesianEvaluationMorphismWithGivenRange using the coexponential-coproduct adjunction on the identity",
                    [ [ CoexponentialToCoproductAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CoexponentialOnObjects, 1 ] ],
                    
  function( cat, a, b, coproduct_object )
    
    # Adjoint( id_Coexp(a,b): Coexp(a,b) → Coexp(a,b) ) = ( a → Coexp(a,b) ⊔ b )
    
    return CoexponentialToCoproductAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, CoexponentialOnObjects( cat, a, b ) )
           );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

AddDerivationToCAP( CocartesianCoevaluationMorphismWithGivenSource,
                    "CocartesianCoevaluationMorphismWithGivenSource using the coexponential-coproduct adjunction on the identity",
                    [ [ CoproductToCoexponentialAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ Coproduct, 1 ] ],
                    
  function( cat, a, b, internal_cohom )
    
    # Adjoint( id_(a ⊔ b): a ⊔ b → a ⊔ b ) = ( Coexp(a ⊔ b, b) → a )
    
    return CoproductToCoexponentialAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, BinaryCoproduct( cat, a, b ) ) );
    
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
    
    return PreComposeList( cat,
                   s,
                   [ IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject( cat, Range( alpha ) ),
                     
                     CoexponentialOnMorphisms( cat,
                             IdentityMorphism( cat, InitialObject( cat ) ),
                             alpha ),
                     
                     IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject( cat, Source( alpha ) ) ],
                   r );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CocartesianEvaluationForCocartesianDualWithGivenCoproduct,
                    "CocartesianEvaluationForCocartesianDualWithGivenCoproduct using the coexponential-coproduct adjunction and IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject",
                    [ [ CoexponentialToCoproductAdjunctionMap, 1 ],
                      [ IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject, 1 ] ],
                    
  function( cat, s, a, r )
    
    # s := 1
    #
    # Adjoint( Coexp(1,a) → a_v ) = ( 1 → a_v ⊔ a )

    return CoexponentialToCoproductAdjunctionMap( cat,
            s,
            a,
            IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject( cat, a ) );

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
# end : CategoryFilter := IsLeftClosedCocartesianCategory,
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
                        [ IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject( cat,
                                BinaryCoproduct( cat, a, b ) ),
                          
                          CoexponentialCoproductCompatibilityMorphism( cat, [ unit, unit, a, b ] ),
                          
                          CoproductOnMorphisms( cat,
                                  IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject( cat, a ),
                                  IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject( cat, b ) ) ],
                        range );
    
    return morphism;
    
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

####################################
## Final derived methods
####################################

## Final methods for CocartesianDual
AddFinalDerivationBundle( "IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject as the identity of Coexp(1,a)",
                    [ [ IdentityMorphism, 1 ],
                      [ CoexponentialOnObjects, 1 ],
                      [ InitialObject, 1 ] ],
                    [ CocartesianDualOnObjects,
                      CocartesianDualOnMorphismsWithGivenCocartesianDuals,
                      MorphismFromCocartesianBidualWithGivenCocartesianBidual,
                      IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject,
                      IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject,
                      UniversalPropertyOfCocartesianDual,
                      CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects,
                      CocartesianEvaluationForCocartesianDualWithGivenCoproduct,
                      MorphismFromCoexponentialToCoproductWithGivenObjects ],
[
  IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject,
  [ [ IdentityMorphism, 1 ],
    [ CoexponentialOnObjects, 1 ],
    [ InitialObject, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, CoexponentialOnObjects( cat, InitialObject( cat ), object ) );
    
  end
],
[
  IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject,
  [ [ IdentityMorphism, 1 ],
    [ CoexponentialOnObjects, 1 ],
    [ InitialObject, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, CoexponentialOnObjects( cat, InitialObject( cat ), object ) );
    
  end
] : CategoryFilter := IsCocartesianCoclosedCategory );
