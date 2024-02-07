# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom,
                    "TensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom using TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom and the braiding",
                    [ [ TensorProductOnObjects, 1 ],
                      [ BraidingInverseWithGivenTensorProducts, 1 ],
                      [ PreCompose, 1 ],
                      [ TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom, 1 ] ],
                    
  function( cat, a, b, f, i )
    
    ## b → i = Hom( a, c )
    return TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom( cat,
                   b,
                   a,
                   ## b ⊗ a → c
                   PreCompose( cat,
                           ## b ⊗ a → a ⊗ b
                           BraidingInverseWithGivenTensorProducts( cat,
                                   TensorProductOnObjects( cat, b, a ),
                                   a,
                                   b,
                                   Source( f ) ),
                           ## f: a ⊗ b → c
                           f ),
                   ## Hom( a, c )
                   i );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom,
                    "TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom using TensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom and the braiding",
                    [ [ TensorProductOnObjects, 1 ],
                      [ BraidingInverseWithGivenTensorProducts, 1 ],
                      [ PreCompose, 1 ],
                      [ TensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom, 1 ] ],
                    
  function( cat, a, b, f, i )
    
    ## a → i = Hom( b, c )
    return TensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom( cat,
                   b,
                   a,
                   ## b ⊗ a → c
                   PreCompose( cat,
                           ## b ⊗ a → a ⊗ b
                           BraidingInverseWithGivenTensorProducts( cat,
                                   TensorProductOnObjects( cat, b, a ),
                                   a,
                                   b,
                                   Source( f ) ),
                           ## f: a ⊗ b → c
                           f ),
                   ## Hom( b, c )
                   i );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct,
                    "InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct using InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct and the braiding",
                    [ [ TensorProductOnObjects, 1 ],
                      [ BraidingWithGivenTensorProducts, 1 ],
                      [ InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, a, c, g, s )
    local b, b_tensor_a;
    
    ## g: b → Hom(a,c)
    b := Source( g );
    
    ## b ⊗ a
    b_tensor_a := TensorProductOnObjects( cat, b, a );
    
    ## a ⊗ b → c
    return PreCompose( cat,
                   ## a ⊗ b → b ⊗ a
                   BraidingWithGivenTensorProducts( cat,
                           s, # a ⊗ b
                           a,
                           b,
                           b_tensor_a ),
                   ## b ⊗ a → c
                   InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( cat,
                           a,
                           c,
                           g,
                           b_tensor_a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct,
                    "InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct using InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct and the braiding",
                    [ [ TensorProductOnObjects, 1 ],
                      [ BraidingWithGivenTensorProducts, 1 ],
                      [ InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, b, c, g, s )
    local a, b_tensor_a;

    ## g: a → Hom(b,c)
    a := Source( g );
    
    ## b ⊗ a
    b_tensor_a := TensorProductOnObjects( cat, b, a );
    
    ## a ⊗ b → c
    return PreCompose( cat,
                   ## a ⊗ b → b ⊗ a
                   BraidingWithGivenTensorProducts( cat,
                           s, # a ⊗ b
                           a,
                           b,
                           b_tensor_a ),
                   ## b ⊗ a → c
                   InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct( cat,
                           b,
                           c,
                           g,
                           b_tensor_a ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                    "MorphismToBidualWithGivenBidual using the braiding and the universal property of the dual",
                    [ [ PreCompose, 1 ],
                      [ Braiding, 1 ],
                      [ DualOnObjects, 2 ],
                      [ EvaluationForDual, 1 ],
                      [ UniversalPropertyOfDual, 1 ] ],
                    
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
                     Braiding( cat, a, DualOnObjects( cat, a ) ),
                     EvaluationForDual( cat, a ) );
    
    return UniversalPropertyOfDual( cat, a, DualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MorphismToBidualWithGivenBidual,
                    "MorphismToBidualWithGivenBidual using ClosedMonoidalCoevaluation, InternalHom, and ClosedMonoidalEvaluation",
                    [ [ DualOnObjects, 1 ],
                      [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ ClosedMonoidalLeftCoevaluationMorphism, 1 ],
                      [ InternalHomOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 1 ],
                      [ ClosedMonoidalLeftEvaluationMorphism, 1 ] ],
                    
  function( cat, a, avv )
    local av, morphism;
    
    #        a
    #        |
    #        | coev_(a^v,a)
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
    
    av := DualOnObjects( cat, a );
    
    morphism := PreComposeList( cat,
                        a,
                        [ ClosedMonoidalLeftCoevaluationMorphism( cat, av, a ),
                          
                          InternalHomOnMorphisms( cat,
                                  IdentityMorphism( cat, av ),
                                  Braiding( cat, a, av ) ),
                          
                          InternalHomOnMorphisms( cat,
                                  IdentityMorphism( cat, av ),
                                  ClosedMonoidalLeftEvaluationMorphism( cat, a, TensorUnit( cat ) ) ) ],
                        avv );
    
    return morphism;
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                    "TensorProductInternalHomCompatibilityMorphismWithGivenObjects using associator, braiding and the evaluation morphism",
                    [ [ InternalHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ AssociatorRightToLeft, 2 ],
                      [ TensorProductOnMorphisms, 7 ],
                      [ AssociatorLeftToRight, 2 ],
                      [ Braiding, 1 ],
                      [ ClosedMonoidalLeftEvaluationMorphism, 2 ],
                      [ TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom, 1 ] ],
                    
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
    
    int_hom_a1_b1 := InternalHomOnObjects( cat, a1, b1 );
    
    int_hom_a2_b2 := InternalHomOnObjects( cat, a2, b2 );
    
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
                                          ClosedMonoidalLeftEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, int_hom_a2_b2 ) ),
                                  id_a2 ),
                          
                          AssociatorLeftToRight( cat, b1, int_hom_a2_b2, a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b1 ),
                                  ClosedMonoidalLeftEvaluationMorphism( cat, a2, b2 ) ) ],
                        TensorProductOnObjects( cat, b1, b2 ) );
    
    return TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom( cat,
                   source,
                   a1a2,
                   morphism,
                   range );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                    "MonoidalPreComposeMorphismWithGivenObjects using associator, braiding, evaluation, and tensor hom adjunction",
                    [ [ InternalHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ AssociatorRightToLeft, 1 ],
                      [ ClosedMonoidalLeftEvaluationMorphism, 2 ],
                      [ TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom, 1 ],
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

    hom_a_b := InternalHomOnObjects( cat, a, b );
    
    hom_b_c := InternalHomOnObjects( cat, b, c );
    
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
                                  ClosedMonoidalLeftEvaluationMorphism( cat, a, b ),
                                  IdentityMorphism( cat, hom_b_c ) ),
                          
                          Braiding( cat, b, hom_b_c ),
                          
                          ClosedMonoidalLeftEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    "MonoidalPostComposeMorphismWithGivenObjects using MonoidalPreComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ InternalHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ MonoidalPreComposeMorphism, 1 ] ],
                    
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
    
    braiding := Braiding( cat, InternalHomOnObjects( cat, b, c ), InternalHomOnObjects( cat, a, b ) );
    
    return PreCompose( cat, braiding, MonoidalPreComposeMorphism( cat, a, b, c ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                    "MonoidalPreComposeMorphismWithGivenObjects using MonoidalPostComposeMorphism and braiding",
                    [ [ Braiding, 1 ],
                      [ InternalHomOnObjects, 2 ],
                      [ PreCompose, 1 ],
                      [ MonoidalPostComposeMorphism, 1 ] ],
                    
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
    
    braiding := Braiding( cat, InternalHomOnObjects( cat, a, b ), InternalHomOnObjects( cat, b, c ) );
    
    return PreCompose( cat, braiding, MonoidalPostComposeMorphism( cat, a, b, c ) );
    
end : CategoryFilter := IsSymmetricClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductInternalHomCompatibilityMorphismWithGivenObjects,
                    "TensorProductInternalHomCompatibilityMorphismWithGivenObjects using braiding and the evaluation morphism",
                    [ [ InternalHomOnObjects, 2 ],
                      [ IdentityMorphism, 4 ],
                      [ TensorProductOnObjects, 3 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 5 ],
                      [ Braiding, 1 ],
                      [ ClosedMonoidalLeftEvaluationMorphism, 2 ],
                      [ TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom, 1 ] ],
                    
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
    
    int_hom_a1_b1 := InternalHomOnObjects( cat, a1, b1 );
    
    int_hom_a2_b2 := InternalHomOnObjects( cat, a2, b2 );
    
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
                                          ClosedMonoidalLeftEvaluationMorphism( cat, a1, b1 ),
                                          IdentityMorphism( cat, int_hom_a2_b2 ) ),
                                  id_a2 ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, b1 ),
                                  ClosedMonoidalLeftEvaluationMorphism( cat, a2, b2 ) ) ],
                        TensorProductOnObjects( cat, b1, b2 ) );
    
    return TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom( cat,
                   source,
                   a1a2,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( MonoidalPreComposeMorphismWithGivenObjects,
                    "MonoidalPreComposeMorphismWithGivenObjects using, braiding, evaluation, and tensor hom adjunction",
                    [ [ InternalHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ Braiding, 2 ],
                      [ ClosedMonoidalLeftEvaluationMorphism, 2 ],
                      [ TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom, 1 ],
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
    
    hom_a_b := InternalHomOnObjects( cat, a, b );
    
    hom_b_c := InternalHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, hom_a_b ),
                                Braiding( cat, hom_b_c, a ) ),
                          
                          TensorProductOnMorphisms( cat,
                                  ClosedMonoidalLeftEvaluationMorphism( cat, a, b ),
                                  IdentityMorphism( cat, hom_b_c ) ),
                          
                          Braiding( cat, b, hom_b_c ),
                          
                          ClosedMonoidalLeftEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );
