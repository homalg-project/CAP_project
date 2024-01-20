# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( MorphismToLeftBidualWithGivenLeftBidual,
                    "MorphismToLeftBidualWithGivenLeftBidual using the braiding and the universal property of the dual",
                    [ [ PreCompose, 1 ],
                      [ Braiding, 1 ],
                      [ LeftDualOnObjects, 2 ],
                      [ LeftClosedMonoidalEvaluationForLeftDual, 1 ],
                      [ UniversalPropertyOfLeftDual, 1 ] ],
                    
  function( cat, a, avv )
    local alpha;

    #    a ⊗ a^v
    #      |
    #      | B_(a,a^v)
    #      v
    #  a^v ⊗ a
    #      |
    #      | ev_a
    #      v
    #      1
    #
    # UniversalProperty( a ⊗ a^v → 1 ) = ( a → a^v^v)

    alpha := PreCompose( cat,
                     Braiding( cat, a, LeftDualOnObjects( cat, a ) ),
                     LeftClosedMonoidalEvaluationForLeftDual( cat, a ) );
    
    return UniversalPropertyOfLeftDual( cat, a, LeftDualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismToLeftBidualWithGivenLeftBidual,
                    "MorphismToLeftBidualWithGivenLeftBidual using LeftClosedMonoidalCoevaluation, LeftInternalHom, and LeftClosedMonoidalEvaluation",
                    [ [ LeftDualOnObjects, 1 ],
                      [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ LeftClosedMonoidalCoevaluationMorphism, 1 ],
                      [ LeftInternalHomOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 1 ] ],
                    
  function( cat, a, avv )
    local av, morphism;
    
    #        a
    #        |
    #        | coev_(a,a^v)
    #        v
    #  Hom(av, a ⊗ a^v)
    #        |
    #        | Hom(id_av, B_(a,a^v))
    #        v
    # Hom(av, a^v ⊗ a)
    #        |
    #        | Hom(id_(a^v), ev_(a,1))
    #        v
    #    Hom(a^v,1)
    
    av := LeftDualOnObjects( cat, a );
    
    morphism := PreComposeList( cat,
                        a,
                        [ LeftClosedMonoidalCoevaluationMorphism( cat, a, av ),
                          
                          LeftInternalHomOnMorphisms( cat,
                                  IdentityMorphism( cat, av ),
                                  Braiding( cat, a, av ) ),
                          
                          LeftInternalHomOnMorphisms( cat,
                                  IdentityMorphism( cat, av ),
                                  LeftClosedMonoidalEvaluationMorphism( cat, a, TensorUnit( cat ) ) ) ],
                        avv );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects,
                    "TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects using associator, braiding and the evaluation morphism",
                    [ [ LeftInternalHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ AssociatorRightToLeft, 2 ],
                      [ TensorProductOnMorphisms, 7 ],
                      [ AssociatorLeftToRight, 2 ],
                      [ Braiding, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, b1, a2, b2, a1a2, int_hom_a1_b1, int_hom_a2_b2, id_a2, morphism;
    
    # (Hom(a1,b1) ⊗ Hom(a2,b2)) ⊗ (a1 ⊗ a2)
    #                  |
    #                  | α_( Hom(a1,b1) ⊗ Hom(a2,b2), (a1, a2) )
    #                  v
    # ((Hom(a1,b1) ⊗ Hom(a2,b2)) ⊗ a1) ⊗ a2
    #                  |
    #                  | α_( ( Hom(a1,b1), Hom(a2,b2) ), a1 ) ⊗ id_a2
    #                  v
    # (Hom(a1,b1) ⊗ (Hom(a2,b2) ⊗ a1)) ⊗ a2
    #                  |
    #                  | ( id_Hom(a1,b1) ⊗ B_( Hom(a2,b2), a1 ) ) ⊗ id_a2
    #                  v
    # (Hom(a1,b1) ⊗ (a1 ⊗ Hom(a2,b2))) ⊗ a2
    #                  |
    #                  | α_( Hom(a1,b1), ( a1, Hom(a2,b2) ) ) ⊗ id_a2
    #                  v
    # ((Hom(a1,b1) ⊗ a1) ⊗ Hom(a2,b2)) ⊗ a2
    #                  |
    #                  | ( ev_(a1,b1) ⊗ id_Hom(a2,b2) ) ⊗ id_a2
    #                  v
    #       (b1 ⊗ Hom(a2,b2)) ⊗ a2
    #                  |
    #                  | α_( ( b1, Hom(a2,b2) ), a2 )
    #                  v
    #       b1 ⊗ (Hom(a2,b2) ⊗ a2)
    #                  |
    #                  | id_b1 ⊗ ev_(a2,b2)
    #                  v
    #               b1 ⊗ b2
    #
    #
    # Adjoint[ (Hom(a1,b1) ⊗ Hom(a2,b2)) ⊗ (a1 ⊗ a2) → b1 ⊗ b2 ] = [ Hom(a1,b1) ⊗ Hom(a2,b2) → Hom(a1 ⊗ a2, b1 ⊗ b2) ]
    
    a1 := list[1];
    b1 := list[2];
    a2 := list[3];
    b2 := list[4];
    
    a1a2 := TensorProductOnObjects( cat, a1, a2 );
    
    int_hom_a1_b1 := LeftInternalHomOnObjects( cat, a1, b1 );
    
    int_hom_a2_b2 := LeftInternalHomOnObjects( cat, a2, b2 );
    
    id_a2 := IdentityMorphism( cat, a2 );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a1a2 ),
                        [ AssociatorRightToLeft( cat,
                                source,
                                a1, a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  AssociatorLeftToRight( cat, int_hom_a1_b1, int_hom_a2_b2, a1 ),
                                  id_a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          IdentityMorphism( cat, int_hom_a1_b1 ),
                                          Braiding( cat, int_hom_a2_b2, a1 ) ),
                                  id_a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  AssociatorRightToLeft( cat, int_hom_a1_b1, a1, int_hom_a2_b2 ),
                                  id_a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          LeftClosedMonoidalEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, int_hom_a2_b2 ) ),
                                  id_a2 ),
                          
                          AssociatorLeftToRight( cat, b1, int_hom_a2_b2, a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b1 ),
                                  LeftClosedMonoidalEvaluationMorphism( cat, a2, b2 ) ) ],
                        TensorProductOnObjects( cat, b1, b2 ) );
    
    return TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom( cat,
                   source,
                   a1a2,
                   morphism,
                   range );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalPreComposeMorphismWithGivenObjects,
                    "LeftClosedMonoidalPreComposeMorphismWithGivenObjects using associator, braiding, evaluation, and tensor hom adjunction",
                    [ [ LeftInternalHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local hom_a_b, hom_b_c, morphism;
    
    # (Hom(a,b) ⊗ Hom(b,c)) ⊗ a
    #           |
    #           | α_( ( Hom(a,b), Hom(b,c) ), a)
    #           v
    # Hom(a,b) ⊗ (Hom(b,c) ⊗ a)
    #           |
    #           | id_Hom(a,b) ⊗ B_( Hom(b,c), a )
    #           v
    # Hom(a,b) ⊗ (a ⊗ Hom(b,c))
    #           |
    #           | α_( Hom(a,b), ( a, Hom(b,c) ) )
    #           v
    # (Hom(a,b) ⊗ a) ⊗ Hom(b,c)
    #           |
    #           | ev_ab ⊗ id_Hom(b,c)
    #           v
    #      b ⊗ Hom(b,c)
    #           |
    #           | B_( b, Hom(b,c) )
    #           v
    #     Hom(b,c) ⊗ b
    #           |
    #           | ev_bc
    #           v
    #           c
    #
    #
    # Adjoint(  (Hom(a,b) ⊗ Hom(b,c)) ⊗ a → c ) = ( Hom(a,b) ⊗ Hom(b,c) → Hom(a,c) )

    hom_a_b := LeftInternalHomOnObjects( cat, a, b );
    
    hom_b_c := LeftInternalHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a ),
                        [ AssociatorLeftToRight( cat, hom_a_b, hom_b_c, a ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, hom_a_b ),
                                  Braiding( cat, hom_b_c, a ) ),
                          
                          AssociatorRightToLeft( cat, hom_a_b, a, hom_b_c ),
                          
                          TensorProductOnMorphisms( cat,
                                  LeftClosedMonoidalEvaluationMorphism( cat, a, b ),
                                  IdentityMorphism( cat, hom_b_c ) ),
                          
                          Braiding( cat, b, hom_b_c ),
                          
                          LeftClosedMonoidalEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalPostComposeMorphismWithGivenObjects,
                    "LeftClosedMonoidalPostComposeMorphismWithGivenObjects using LeftClosedMonoidalPreComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ LeftInternalHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ LeftClosedMonoidalPreComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;

    # Hom(b,c) ⊗ Hom(a,b)
    #          |
    #          | B_( Hom(b,c), Hom(a,b) )
    #          v
    # Hom(a,b) ⊗ Hom(b,c)
    #          |
    #          | PreCompose
    #          v
    #       Hom(a,c)
    
    braiding := Braiding( cat, LeftInternalHomOnObjects( cat, b, c ), LeftInternalHomOnObjects( cat, a, b ) );
    
    return PreCompose( cat, braiding, LeftClosedMonoidalPreComposeMorphism( cat, a, b, c ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( LeftClosedMonoidalPreComposeMorphismWithGivenObjects,
                    "LeftClosedMonoidalPreComposeMorphismWithGivenObjects using LeftClosedMonoidalPostComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ LeftInternalHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ LeftClosedMonoidalPostComposeMorphism, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local braiding;

    # Hom(a,b) ⊗ Hom(b,c)
    #          |
    #          | B_( Hom(a,b), Hom(b,c) )
    #          v
    # Hom(b,c) ⊗ Hom(a,b)
    #          |
    #          | PostCompose
    #          v
    #       Hom(a,c)
    
    braiding := Braiding( cat, LeftInternalHomOnObjects( cat, a, b ), LeftInternalHomOnObjects( cat, b, c ) );
    
    return PreCompose( cat, braiding, LeftClosedMonoidalPostComposeMorphism( cat, a, b, c ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects,
                    "TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects using braiding and the evaluation morphism",
                    [ [ LeftInternalHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 5 ],
                      [ Braiding, 1 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom, 1 ] ],
                    
  function( cat, source, list, range )
    local a1, b1, a2, b2, a1a2, int_hom_a1_b1, int_hom_a2_b2, id_a2, morphism;
    
    # Hom(a1,b1) ⊗ Hom(a2,b2) ⊗ a1 ⊗ a2
    #                 |
    #                 | id_Hom(a1,b1) ⊗ B_( Hom(a2,b2), a1 ) ⊗ id_a2
    #                 v
    # Hom(a1,b1) ⊗ a1 ⊗ Hom(a2,b2) ⊗ a2
    #                 |
    #                 | ev_(a1,b1) ⊗ id_Hom(a2,b2) ⊗ id_a2
    #                 v
    #       b1 ⊗ Hom(a2,b2) ⊗ a2
    #                 |
    #                 | id_b1 ⊗ ev_(a2,b2)
    #                 v
    #              b1 ⊗ b2
    #
    #
    # Adjoint[ Hom(a1,b1) ⊗ Hom(a2,b2) ⊗ a1 ⊗ a2 → b1 ⊗ b2 ] = [ Hom(a1,b1) ⊗ Hom(a2,b2) → Hom(a1 ⊗ a2, b1 ⊗ b2) ]
    
    a1 := list[1];
    b1 := list[2];
    a2 := list[3];
    b2 := list[4];
    
    a1a2 := TensorProductOnObjects( cat, a1, a2 );
    
    int_hom_a1_b1 := LeftInternalHomOnObjects( cat, a1, b1 );
    
    int_hom_a2_b2 := LeftInternalHomOnObjects( cat, a2, b2 );
    
    id_a2 := IdentityMorphism( cat, a2 );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a1a2 ),
                        [ TensorProductOnMorphisms( cat,
                                TensorProductOnMorphisms( cat,
                                        IdentityMorphism( cat, int_hom_a1_b1 ),
                                        Braiding( cat, int_hom_a2_b2, a1 ) ),
                                id_a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  TensorProductOnMorphisms( cat,
                                          LeftClosedMonoidalEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, int_hom_a2_b2 ) ),
                                  id_a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b1 ),
                                  LeftClosedMonoidalEvaluationMorphism( cat, a2, b2 ) ) ],
                        TensorProductOnObjects( cat, b1, b2 ) );
    
    return TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom( cat,
                   source,
                   a1a2,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( LeftClosedMonoidalPreComposeMorphismWithGivenObjects,
                    "LeftClosedMonoidalPreComposeMorphismWithGivenObjects using, braiding, evaluation, and tensor hom adjunction",
                    [ [ LeftInternalHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ LeftClosedMonoidalEvaluationMorphism, 2 ],
                      [ TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local hom_a_b, hom_b_c, morphism;

    # Hom(a,b) ⊗ Hom(b,c) ⊗ a
    #          |
    #          | id_Hom(a,b) ⊗ B_( Hom(b,c), a )
    #          v
    # Hom(a,b) ⊗ a ⊗ Hom(b,c)
    #          |
    #          | ev_ab ⊗ id_Hom(b,c)
    #          v
    #     b ⊗ Hom(b,c)
    #          |
    #          | B_( b, Hom(b,c) )
    #          v
    #     Hom(b,c) ⊗ b
    #          |
    #          | ev_bc
    #          v
    #          c
    #
    #
    # Adjoint(  (Hom(a,b) ⊗ Hom(b,c)) ⊗ a → c ) = ( Hom(a,b) ⊗ Hom(b,c) → Hom(a,c) )
    
    hom_a_b := LeftInternalHomOnObjects( cat, a, b );
    
    hom_b_c := LeftInternalHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, hom_a_b ),
                                Braiding( cat, hom_b_c, a ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  LeftClosedMonoidalEvaluationMorphism( cat, a, b ),
                                  IdentityMorphism( cat, hom_b_c ) ),
                          
                          Braiding( cat, b, hom_b_c ),
                          
                          LeftClosedMonoidalEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );
