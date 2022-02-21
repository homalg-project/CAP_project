# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToInternalCoHomAdjunctionMap,

  function( cat, c, b, g )
    
    # g: a -> c x b
    #
    #    Cohom(a,b)
    #        |
    #        | Cohom(g, id_b)
    #        v
    # Cohom(c x b, b)
    #        |
    #        | coclcoev_cb
    #        v
    #        c

    return PreCompose( cat,
             InternalCoHomOnMorphisms( cat, g, IdentityMorphism( cat, b ) ),
             CoclosedCoevaluationMorphism( cat, c, b ) );
             
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "TensorProductToInternalCoHomAdjunctionMap using CoclosedCoevaluationMorphism and InternalCoHom" );

##
AddDerivationToCAP( InternalCoHomToTensorProductAdjunctionMap,

  function( cat, a, b, f )

    # f: Cohom(a,b) -> c
    #
    #        a
    #        |
    #        | coclev_ab
    #        v
    # Cohom(a,b) x b
    #        |
    #        | f x id_b
    #        v
    #      c x b
    
    return PreCompose( cat,
             CoclosedEvaluationMorphism( cat, a, b ),
             TensorProductOnMorphisms( cat, f, IdentityMorphism( cat, b ) ) );
             
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomToTensorProductAdjunctionMap using TensorProductOnMorphisms and CoclosedEvaluationMorphism" );

##
AddDerivationToCAP( UniversalPropertyOfCoDual,

  function( cat, t, a, alpha )

    # alpha: 1 -> t x a
    #
    # a_v -> ( Cohom(1,a) -> t ) = Adjoint( alpha )
    
    return PreCompose( cat,
             IsomorphismFromCoDualToInternalCoHom( cat, a ),
             TensorProductToInternalCoHomAdjunctionMap( cat, t, a, alpha ) );
             
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "UniversalPropertyOfCoDual using the cohom tensor adjunction" );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,

  function( cat, a, avv )
    local alpha;

    #    1
    #    |
    #    | coclev_a
    #    v
    # a_v x a
    #    |
    #    | B_(a_v,a)
    #    v
    #  a x a_v
    #
    #
    # UniversalPropertyOfCoDual( 1 -> a x a_v) = ( a_v_v -> a )

    alpha := PreCompose( cat,
                  CoclosedEvaluationForCoDual( cat, a ),
                  Braiding( cat, CoDualOnObjects( cat, a ), a ) );
                  
    return UniversalPropertyOfCoDual( cat, a, CoDualOnObjects( cat, a ), alpha );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MorphismFromCoBidualWithGivenCoBidual using the braiding and the universal property of the codual" );

##
AddDerivationToCAP( MorphismFromCoBidualWithGivenCoBidual,

  function( cat, a, avv )
    local morphism, av, tensor_unit;

    #     Cohom(1, a_v)
    #          |
    #          | Cohom( coclev_(1,a), id_(a_v) )
    #          v
    # Cohom(a_v x a, a_v)
    #          |
    #          | Cohom( B_( a_v, a), id_(a_v) )
    #          v
    # Cohom(a x a_v, a_v)
    #          |
    #          | coclcoev_(a, a_v)
    #          v
    #          a
    
    av := CoDualOnObjects( cat, a );
    
    tensor_unit := TensorUnit( cat );
    
    morphism := PreComposeList( cat, [
                  InternalCoHomOnMorphisms( cat,
                    CoclosedEvaluationMorphism( cat, tensor_unit, a ),
                    IdentityMorphism( cat, av ) ),
                  
                  InternalCoHomOnMorphisms( cat,
                    Braiding( cat, av, a ),
                    IdentityMorphism( cat, av ) ),
                  
                  CoclosedCoevaluationMorphism( cat, a, av )
                ] );
    
    return morphism;

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MorphismFromCoBidualWithGivenCoBidual using CoclosedEvaluation, InternalCoHom, and CoclosedCoevaluation" );

##
AddDerivationToCAP( CoDualOnObjects,

  function( cat, a )

    # Source( a_v -> Cohom(1,a) )
    
    return Source( IsomorphismFromCoDualToInternalCoHom( cat, a ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoDualOnObjects as the source of IsomorphismFromCoDualToInternalCoHom" );

##
AddDerivationToCAP( CoDualOnObjects,

  function( cat, a )

    # Range( Cohom(1,a) -> a_v )
    
    return Range( IsomorphismFromInternalCoHomToCoDual( cat, a ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoDualOnObjects as the range of IsomorphismFromInternalCoHomToCoDual" );

##
AddDerivationToCAP( CoDualOnMorphismsWithGivenCoDuals,

  function( cat, s, alpha, r )
    local result_morphism;

    # alpha: a->b
    #
    #    b_v
    #     |
    #     v
    # Cohom(1,b)
    #     |
    #     | Cohom(id_1, alpha)
    #     v
    # Cohom(1,a)
    #     |
    #     v
    #    a_v
    
    result_morphism := PreComposeList( cat, [
                         IsomorphismFromCoDualToInternalCoHom( cat, Range( alpha ) ),
                         
                         InternalCoHomOnMorphisms( cat,
                           IdentityMorphism( cat, TensorUnit( cat ) ),
                           alpha ),
                           
                         IsomorphismFromInternalCoHomToCoDual( cat, Source( alpha ) )
                       ] );
                       
    return result_morphism;
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoDualOnMorphismsWithGivenCoDuals using InternalCoHomOnMorphisms and IsomorphismFromCoDualToInternalCoHom" );

##
AddDerivationToCAP( CoclosedEvaluationForCoDualWithGivenTensorProduct,

  function( cat, s, a, r )

    # s := 1

    # Adjoint( Cohom(1,a) -> a_v ) = ( 1 -> a_v x a )

    return InternalCoHomToTensorProductAdjunctionMap( cat,
            s,
            a,
            IsomorphismFromInternalCoHomToCoDual( cat, a ) );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoclosedEvaluationForCoDualWithGivenTensorProduct using the cohom tensor adjunction and IsomorphismFromInternalCoHomToCoDual" );

##
AddDerivationToCAP( CoLambdaIntroduction,

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
    # Adjoint( a -> 1 x b ) = ( Cohom(a,b) -> 1 )

    range := Range( alpha );

    result_morphism := PreCompose( cat, alpha, LeftUnitorInverse( cat, range ) );

    return TensorProductToInternalCoHomAdjunctionMap( cat,
             TensorUnit( cat ),
             range,
             result_morphism );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoLambdaIntroduction using the cohom tensor adjunction and the left unitor inverse" );

##
AddDerivationToCAP( CoLambdaElimination,

  function( cat, a, b, alpha )
    local result_morphism;

    # alpha: Cohom(a,b) -> 1
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
    
    result_morphism := InternalCoHomToTensorProductAdjunctionMap( cat, a, b, alpha );
    
    return PreCompose( cat, result_morphism, LeftUnitor( cat, b ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoLambdaElimination using the cohom tensor adjunction and the left unitor" );

##
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,

  function( cat, source, list, range )
    local a1, a2, b1, b2, morphism, int_cohom_a1_b1, int_cohom_a2_b2, id_b2, tensor_product_on_objects_int_cohom_a1_b1_int_cohom_a2_b2;

    #                   a1 x a2
    #                      |
    #                      | id_a1 x coclev_(a2,b2)
    #                      v
    #          a1 x (Cohom(a2,b2) x b2)
    #                      |
    #                      | α_( a1, (Cohom(a2,b2), b2) )
    #                      v
    #          (a1 x Cohom(a2,b2)) x b2
    #                      |
    #                      | ( coclev_(a1,b1) x id_Cohom(a2,b2) ) x id_b2
    #                      v
    # ((Cohom(a1,b1) x b1) x Cohom(a2,b2)) x b2
    #                      |
    #                      | α_( (Cohom(a1,b1), b1), Cohom(a2,b2) ) ) x id_b2
    #                      v
    #  (Cohom(a1,b1) x (b1 x Cohom(a2,b2))) x b2
    #                      |
    #                      | ( id_Cohom(a1,b1) x B_( b1, Cohom(a2,b2) ) ) x id_b2
    #                      v
    #  (Cohom(a1,b1) x (Cohom(a2,b2) x b1)) x b2
    #                      |
    #                      | α_( Cohom(a1,b1), (Cohom(a2,b2), b1) ) x id_b2
    #                      v
    #  ((Cohom(a1,b1) x Cohom(a2,b2)) x b1) x b2
    #                      |
    #                      | α_( (Cohom(a1,b1) x Cohom(a2,b2), b1), b2 )
    #                      v
    #  (Cohom(a1,b1) x Cohom(a2,b2)) x (b1 x b2)
    #
    #
    # Adjoint[ a1 x a2 -> (Cohom(a1,b1) x Cohom(a2,b2)) x (b1 x b2) ] = [ Cohom(a1 x a2, b1 x b2) -> Cohom(a1,b1) x Cohom(a2,b2) ]
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    int_cohom_a1_b1 := InternalCoHomOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := InternalCoHomOnObjects( cat, a2, b2 );

    id_b2 := IdentityMorphism( cat, b2 );
    
    tensor_product_on_objects_int_cohom_a1_b1_int_cohom_a2_b2 :=
      TensorProductOnObjects( cat, int_cohom_a1_b1, int_cohom_a2_b2 );
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, a1 ),
                    CoclosedEvaluationMorphism( cat, a2, b2 ) ),
                  
                  AssociatorRightToLeft( cat, a1, int_cohom_a2_b2, b2),
                  
                  TensorProductOnMorphisms( cat,
                    TensorProductOnMorphisms( cat,
                      CoclosedEvaluationMorphism( cat, a1, b1 ),
                      IdentityMorphism( cat, int_cohom_a2_b2)),
                    id_b2 ),
                  
                  TensorProductOnMorphisms( cat,
                    AssociatorLeftToRight( cat, int_cohom_a1_b1, b1, int_cohom_a2_b2 ),
                    id_b2 ),
                  
                  TensorProductOnMorphisms( cat,
                    TensorProductOnMorphisms( cat,
                      IdentityMorphism( cat, int_cohom_a1_b1),
                      Braiding( cat, b1, int_cohom_a2_b2 ) ),
                    id_b2 ),
                  
                  TensorProductOnMorphisms( cat,
                    AssociatorRightToLeft( cat, int_cohom_a1_b1, int_cohom_a2_b2, b1 ),
                    id_b2 ),
                  
                  AssociatorLeftToRight( cat,
                    tensor_product_on_objects_int_cohom_a1_b1_int_cohom_a2_b2,
                    b1, b2 )
                ] );

    return TensorProductToInternalCoHomAdjunctionMap( cat,
             tensor_product_on_objects_int_cohom_a1_b1_int_cohom_a2_b2,
             TensorProductOnObjects( cat, b1, b2 ),
             morphism );

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using associator, braiding and the coclosed evaluation morphism" );

##
AddDerivationToCAP( CoDualityTensorProductCompatibilityMorphismWithGivenObjects,

  function( cat, s, a, b, r )
    local morphism, unit, tensor_product_on_a_and_b;

    #         (a x b)_v
    #            |
    #            V
    #      Cohom(1, a x b)
    #            |
    #            | Cohom((λ_1)^-1, id_(a x b))
    #            V
    #  Cohom(1 x 1, a x b)
    #            |
    #            | CompatMorphism(1,1,a,b)
    #            V
    # Cohom(1,a) x Cohom(1,b)
    #            |
    #            v
    #        a_v x b_v
    
    unit := TensorUnit( cat );
    
    tensor_product_on_a_and_b := TensorProductOnObjects( cat, a, b );
    
    morphism := PreComposeList( cat, [
                  IsomorphismFromCoDualToInternalCoHom( cat, tensor_product_on_a_and_b ),
                  
                  InternalCoHomOnMorphisms( cat,
                    LeftUnitorInverse( cat, unit ),
                    IdentityMorphism( cat, tensor_product_on_a_and_b ) ),
                  
                  InternalCoHomTensorProductCompatibilityMorphism( cat, [ unit, unit, a, b ] ),
                  
                  TensorProductOnMorphisms( cat,
                    IsomorphismFromInternalCoHomToCoDual( cat, a ),
                    IsomorphismFromInternalCoHomToCoDual( cat, b ) )
                ] );

    return morphism;

end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoDualityTensorProductCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of internal cohom and tensor product" );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom,
                  
  function( cat, a, internal_cohom )
    local unit;

    #     Cohom(a, 1)
    #         |
    #         | Cohom((ρ_a)^-1, id_1)
    #         v
    # Cohom(a x 1, 1)
    #         |
    #         | coclcoev_(a,1)
    #         v
    #         a
    
    unit := TensorUnit( cat );
    
    return PreCompose( cat,
             InternalCoHomOnMorphisms( cat,
               RightUnitorInverse( cat, a ),
               IdentityMorphism( cat, unit ) ),
               
             CoclosedCoevaluationMorphism( cat, a, unit ));
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom using the coclosed coevaluation morphism" );

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom,
                  
  function( cat, a, internal_cohom )
    local unit;

    # (ρ_a)^-1: a -> a x 1
    #
    # Adjoint( (ρ_a)^-1 ) = ( Cohom(a,1) -> a )
    
    unit := TensorUnit( cat );
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             a,
             unit,
             RightUnitorInverse( cat, a ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom as the adjoint of the right inverse unitor" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom,
#                     
#   function( cat, a, internal_cohom )
#
#     # Inverse( a -> Cohom(a,1) )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToInternalCoHom( cat, a ) );
#     
# end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
#       Description := "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom as the inverse of IsomorphismFromObjectToInternalCoHom" );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom,
                  
  function( cat, a, internal_cohom )
    local unit;

    #       a
    #       |
    #       | coclev_(a,1)
    #       v
    # Cohom(a,1) x 1
    #       |
    #       | ρ_Cohom(a,1)
    #       v
    #   Cohom(a,1)
    
    unit := TensorUnit( cat );
    
    return PreCompose( cat, CoclosedEvaluationMorphism( cat, a, unit ),
                       RightUnitor( cat, internal_cohom ) );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom using the coclosed evaluation morphism" );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom,
#                     
#   function( cat, a, internal_cohom )
#
#     # Inverse( Cohom(a,1) -> a)
#     
#     return InverseForMorphisms( cat, IsomorphismFromInternalCoHomToObject( cat, a ) );
#     
# end : CategoryFilter := IsSymmetricClosedMonoidalCategory,
#       Description := "IsomorphismFromObjectToInternalCoHom as the inverse of IsomorphismFromInternalCoHomToObject" );

##
AddDerivationToCAP( MorphismFromInternalCoHomToTensorProductWithGivenObjects,
                    
  function( cat, internal_cohom, a, b, tensor_object )
    local unit;

    #       Cohom(a,b)
    #            |
    #            | Cohom((λ_a)^-1, ρ_b)
    #            v
    # Cohom(1 x a, b x 1)
    #            |
    #            | CompatMorphism
    #            v
    # Cohom(1,b) x Cohom(a,1)
    #            |
    #            v
    #        b_v x a
    
    unit := TensorUnit( cat );
    
    return PreComposeList( cat, [
             InternalCoHomOnMorphisms( cat,
               LeftUnitorInverse( cat, a ),
               RightUnitor( cat, b ) ),
              
             InternalCoHomTensorProductCompatibilityMorphism( cat,
               [ unit, a, b, unit ] ),
              
             TensorProductOnMorphisms( cat,
               IsomorphismFromInternalCoHomToCoDual( cat, b ),
               IsomorphismFromInternalCoHomToObject( cat, a ) )
           ] );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MorphismFromInternalCoHomToTensorProductWithGivenObjects using InternalCoHomTensorProductCompatibilityMorphism" );

##
AddDerivationToCAP( CoclosedEvaluationMorphismWithGivenRange,
                  
  function( cat, a, b, tensor_object )

    # Adjoint( id_Cohom(a,b): Cohom(a,b) -> Cohom(a,b) ) = ( a -> Cohom(a,b) x b )
    
    return InternalCoHomToTensorProductAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, InternalCoHomOnObjects( cat, a, b ) )
           );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoclosedEvaluationMorphismWithGivenRange using the cohom tensor adjunction on the identity" );

AddDerivationToCAP( CoclosedCoevaluationMorphismWithGivenSource,

  # Adjoint( id_(a x b): a x b -> a x b ) = ( Cohom(a x b, b) -> a )
                  
  function( cat, a, b, internal_cohom )
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, TensorProductOnObjects( cat, a, b ) )
           );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "CoclosedCoevaluationMorphismWithGivenSource using the cohom tensor adjunction on the identity" );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                  
  function( cat, source, a, b, c, range )
    local cohom_a_b, cohom_b_c, morphism;

    #           a
    #           |
    #           | coclev_ab
    #           v
    #    Cohom(a,b) x b
    #           |
    #           | B_( Cohom(a,b), b )
    #           v
    #      b x Cohom(a,b)
    #           |
    #           | coclev_bc x id_Cohom(a,b)
    #           v
    # (Cohom(b,c) x c) x Cohom(a,b)
    #           |
    #           | α_( ( Cohom(b,c), c ), Cohom(a,b) )
    #           v
    # Cohom(b,c) x (c x Cohom(a,b))
    #           |
    #           | id_Cohom(b,c) x B_( c, Cohom(a,b) )
    #           v
    # Cohom(b,c) x (Cohom(a,b) x c)
    #           |
    #           | α_( Cohom(b,c), ( Cohom(a,b), c ) )
    #           v
    # (Cohom(b,c) x Cohom(a,b)) x c
    #
    #
    # Adjoint( a -> (Cohom(b,c) x Cohom(a,b)) x c ) = ( Cohom(a,c) -> Cohom(b,c) x Cohom(a,b) )
    
    cohom_a_b := InternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := InternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat, [
                  CoclosedEvaluationMorphism( cat, a, b ),
                  
                  Braiding( cat, cohom_a_b, b ),
                  
                  TensorProductOnMorphisms( cat,
                    CoclosedEvaluationMorphism( cat, b, c ),
                    IdentityMorphism( cat, cohom_a_b ) ),
                  
                  AssociatorLeftToRight( cat, cohom_b_c, c, cohom_a_b ),
                  
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, cohom_b_c ),
                    Braiding( cat, c, cohom_a_b ) ),
                  
                  AssociatorRightToLeft( cat, cohom_b_c, cohom_a_b, c ),
                ] );
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             TensorProductOnObjects( cat, cohom_b_c, cohom_a_b ),
             c,
             morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MonoidalPreCoComposeMorphismWithGivenObjects using associator, braiding, coclosed evaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    
  function( cat, source, a, b, c, range )
    local cohom_a_b, cohom_b_c, morphism;

    #             a
    #             |
    #             | coclev_ab
    #             v
    #      Cohom(a,b) x b
    #             |
    #             | id_Cohom(a,b) x coclev_bc
    #             v
    #  Cohom(a,b) x (Cohom(b,c) x c)
    #             |
    #             | α_( Cohom(a,b), ( Cohom(b,c), c ) )
    #             v
    # (Cohom(a,b) x Cohom(b,c)) x c
    #
    #
    # Adjoint( a -> (Cohom(a,b) x Cohom(b,c)) x c ) = ( Cohom(a,c) -> Cohom(a,b) x Cohom(b,c) )
    
    cohom_a_b := InternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := InternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat, [
                  CoclosedEvaluationMorphism( cat, a, b ),
                  
                  TensorProductOnMorphisms( cat,
                    CoclosedEvaluationMorphism( cat, b, c ),
                    IdentityMorphism( cat, cohom_a_b )
                  ),
                  
                  AssociatorRightToLeft( cat, cohom_a_b, cohom_b_c, c )
                ] );
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             TensorProductOnObjects( cat, cohom_a_b, cohom_b_c ),
             c,
             morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MonoidalPostCoComposeMorphismWithGivenObjects using associator, coclosed evaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    
  function( cat, source, a, b, c, range )
    local braiding;

    #       Cohom(a,c)
    #            |
    #            | PreCoCompose
    #            v
    # Cohom(b,c) x Cohom(a,b)
    #            |
    #            | B_( Cohom(b,c), Cohom(a,b) )
    #            v
    # Cohom(a,b) x Cohom(b,c)
    
    braiding := Braiding( cat, InternalCoHomOnObjects( cat, b, c ), InternalCoHomOnObjects( cat, a, b ) );
    
    return PreCompose( cat, MonoidalPreCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MonoidalPostCoComposeMorphismWithGivenObjects using MonoidalPreCoComposeMorphism and braiding" );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                    
  function( cat, source, a, b, c, range )
    local braiding;
    
    #       Cohom(a,c)
    #            |
    #            | PostCoCompose
    #            v
    # Cohom(a,b) x Cohom(b,c)
    #            |
    #            | B_( Cohom(a,b), Cohom(b,c) )
    #            v
    # Cohom(b,c) x Cohom(a,b)

    braiding := Braiding( cat, InternalCoHomOnObjects( cat, a, b ), InternalCoHomOnObjects( cat, b, c ) );
    
    return PreCompose( cat, MonoidalPostCoComposeMorphism( cat, a, b, c ), braiding );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory,
      Description := "MonoidalPreCoComposeMorphismWithGivenObjects using MonoidalPostCoComposeMorphism and braiding" );

##
AddDerivationToCAP( InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects,
                    
  function( cat, source, list, range )
    local a1, a2, b1, b2, morphism, int_cohom_a1_b1, int_cohom_a2_b2, id_b2, tensor_product_on_objects_int_cohom_a1_b1_int_cohom_a2_b2;

    #           a1 x a2
    #              |
    #              | id_a1 x coclev_(a2,b2)
    #              v
    #    a1 x Cohom(a2,b2) x b2
    #              |
    #              | coclev_(a1,b1) x id_Cohom(a2,b2) x id_b2
    #              v
    # Cohom(a1,b1) x b1 x Cohom(a2,b2) x b2
    #              |
    #              | id_Cohom(a1,b1) x B_( b1, Cohom(a2,b2) )  x id_b2
    #              v
    # Cohom(a1,b1) x Cohom(a2,b2) x b1 x b2
    #
    #
    # Adjoint[ a1 x a2 -> Cohom(a1,b1) x Cohom(a2,b2) x b1 x b2 ] = [ Cohom(a1 x a2, b1 x b2) -> Cohom(a1,b1) x Cohom(a2,b2) ]
    
    a1 := list[1];
    a2 := list[2];
    b1 := list[3];
    b2 := list[4];
    
    int_cohom_a1_b1 := InternalCoHomOnObjects( cat, a1, b1 );
    
    int_cohom_a2_b2 := InternalCoHomOnObjects( cat, a2, b2 );

    id_b2 := IdentityMorphism( cat, b2 );
    
    tensor_product_on_objects_int_cohom_a1_b1_int_cohom_a2_b2 :=
      TensorProductOnObjects( cat, int_cohom_a1_b1, int_cohom_a2_b2 );
    
    morphism := PreComposeList( cat, [
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, a1 ),
                    CoclosedEvaluationMorphism( cat, a2, b2 ) ),
                  
                  TensorProductOnMorphisms( cat,
                    TensorProductOnMorphisms( cat,
                      CoclosedEvaluationMorphism( cat, a1, b1 ),
                      IdentityMorphism( cat, int_cohom_a2_b2)),
                    id_b2 ),
                  
                  TensorProductOnMorphisms( cat,
                    TensorProductOnMorphisms( cat,
                      IdentityMorphism( cat, int_cohom_a1_b1),
                      Braiding( cat, b1, int_cohom_a2_b2 ) ),
                    id_b2 ),
                ] );

    return TensorProductToInternalCoHomAdjunctionMap( cat,
             tensor_product_on_objects_int_cohom_a1_b1_int_cohom_a2_b2,
             TensorProductOnObjects( cat, b1, b2 ),
             morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects using braiding and the coclosed evaluation morphism" );

##
AddDerivationToCAP( CoDualityTensorProductCompatibilityMorphismWithGivenObjects,
                  
  function( cat, source, a, b, range )
    local morphism, unit, tensor_product_on_a_and_b;

    #         (a x b)_v
    #            |
    #            V
    #      Cohom(1, a x b)
    #            |
    #            | CompatMorphism(1,1,a,b)
    #            V
    # Cohom(1,a) x Cohom(1,b)
    #            |
    #            v
    #        a_v x b_v
    
    unit := TensorUnit( cat );
    
    tensor_product_on_a_and_b := TensorProductOnObjects( cat, a, b );
    
    morphism := PreComposeList( cat, [
                  IsomorphismFromCoDualToInternalCoHom( cat, tensor_product_on_a_and_b ),
                  
                  InternalCoHomTensorProductCompatibilityMorphism( cat, [ unit, unit, a, b ] ),
                  
                  TensorProductOnMorphisms( cat,
                    IsomorphismFromInternalCoHomToCoDual( cat, a ),
                    IsomorphismFromInternalCoHomToCoDual( cat, b ) )
                ] );
              
    return morphism;
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "CoDualityTensorProductCompatibilityMorphismWithGivenObjects using compatibility of internal cohom and tensor product" );

##
AddDerivationToCAP( MonoidalPreCoComposeMorphismWithGivenObjects,
                  
  function( cat, source, a, b, c, range )
    local cohom_a_b, cohom_b_c, morphism;

    #            a
    #            |
    #            | coclev_ab
    #            v
    #      Cohom(a,b) x b
    #            |
    #            | B_( Cohom(a,b), b )
    #            v
    #      b x Cohom(a,b)
    #            |
    #            | coclev_bc x id_Cohom(a,b)
    #            v
    # Cohom(b,c) x c x Cohom(a,b)
    #            |
    #            | id_Cohom(b,c) x B_( c, Cohom(a,b) )
    #            v
    # Cohom(b,c) x Cohom(a,b) x c
    #
    #
    # Adjoint( a -> (Cohom(b,c) x Cohom(a,b)) x c ) = ( Cohom(a,c) -> Cohom(b,c) x Cohom(a,b) )
    
    cohom_a_b := InternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := InternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat, [
                  CoclosedEvaluationMorphism( cat, a, b ),
                  
                  Braiding( cat, cohom_a_b, b),
                  
                  TensorProductOnMorphisms( cat,
                    CoclosedEvaluationMorphism( cat, b, c ),
                    IdentityMorphism( cat, cohom_a_b ) ),
                  
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, cohom_b_c ),
                    Braiding( cat, c, cohom_a_b ) )
                ] );
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             TensorProductOnObjects( cat, cohom_b_c, cohom_a_b ),
             c,
             morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "MonoidalPreCoComposeMorphismWithGivenObjects using braiding, coclosed evaluation, and cohom tensor adjunction" );

##
AddDerivationToCAP( MonoidalPostCoComposeMorphismWithGivenObjects,
                    
  function( cat, source, a, b, c, range )
    local cohom_a_b, cohom_b_c, morphism;

    #             a
    #             |
    #             | coclev_ab
    #             v
    #      Cohom(a,b) x b
    #             |
    #             | id_Cohom(a,b) x coclev_bc
    #             v
    #  Cohom(a,b) x (Cohom(b,c) x c)
    #
    #
    # Adjoint( a -> (Cohom(a,b) x Cohom(b,c)) x c ) = ( Cohom(a,c) -> Cohom(a,b) x Cohom(b,c) )
    
    cohom_a_b := InternalCoHomOnObjects( cat, a, b );
    
    cohom_b_c := InternalCoHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat, [
                  CoclosedEvaluationMorphism( cat, a, b ),
                  
                  TensorProductOnMorphisms( cat,
                    IdentityMorphism( cat, cohom_a_b ),
                    CoclosedEvaluationMorphism( cat, b, c ) )
                ] );
    
    return TensorProductToInternalCoHomAdjunctionMap( cat,
             TensorProductOnObjects( cat, cohom_a_b, cohom_b_c ),
             c,
             morphism );
    
end : CategoryFilter := IsSymmetricCoclosedMonoidalCategory and IsStrictMonoidalCategory,
      Description := "MonoidalPostCoComposeMorphismWithGivenObjects using coclosed evaluation, and cohom tensor adjunction" );
