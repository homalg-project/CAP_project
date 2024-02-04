# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToInternalHomRightAdjunctionMap,
                    "TensorProductToInternalHomRightAdjunctionMap using ClosedMonoidalRightCoevaluationMorphism and InternalHom",
                    [ [ PreCompose, 1 ],
                      [ ClosedMonoidalRightCoevaluationMorphism, 1 ],
                      [ InternalHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f )
    
    # f: a ⊗ b → c
    #
    #      b
    #      |
    #      | coev_ab
    #      v
    # Hom(a,a ⊗ b)
    #      |
    #      | Hom(id_a, f)
    #      v
    #   Hom(a,c)
    
    return PreCompose( cat,
             ClosedMonoidalRightCoevaluationMorphism( cat, a, b ),
             InternalHomOnMorphisms( cat, IdentityMorphism( cat, a ), f ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductToInternalHomRightAdjunctionMapWithGivenInternalHom,
                    "TensorProductToInternalHomRightAdjunctionMapWithGivenInternalHom using ClosedMonoidalRightCoevaluationMorphism and InternalHom",
                    [ [ ClosedMonoidalRightCoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ InternalHomOnMorphismsWithGivenInternalHoms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f, i )
    local coev_ab;
    
    # f: a ⊗ b → c
    #
    #      b
    #      |
    #      | coev_ab
    #      v
    # Hom(a,a ⊗ b)
    #      |
    #      | Hom(id_a, f)
    #      v
    #   Hom(a,c)
    
    coev_ab := ClosedMonoidalRightCoevaluationMorphism( cat, a, b );
    
    return PreCompose( cat,
             coev_ab,
             InternalHomOnMorphismsWithGivenInternalHoms( cat, Range( coev_ab ), IdentityMorphism( cat, a ), f, i ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( InternalHomToTensorProductRightAdjunctionMap,
                    "InternalHomToTensorProductRightAdjunctionMap using TensorProductOnMorphisms and ClosedMonoidalRightEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ ClosedMonoidalRightEvaluationMorphism, 1 ] ],
                    
  function( cat, a, c, g )
    
    # g: b → Hom(a,c)
    #
    #    a ⊗ b
    #      |
    #      | id_a ⊗ g
    #      v
    # a ⊗ Hom(a,c)
    #      |
    #      | ev_ac
    #      v
    #      c
    
    return PreCompose( cat,
             TensorProductOnMorphisms( cat, IdentityMorphism( cat, a ), g ),
             ClosedMonoidalRightEvaluationMorphism( cat, a, c ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( InternalHomToTensorProductRightAdjunctionMapWithGivenTensorProduct,
                    "InternalHomToTensorProductRightAdjunctionMapWithGivenTensorProduct using TensorProductOnMorphisms and ClosedMonoidalRightEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ TensorProductOnMorphismsWithGivenTensorProducts, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ ClosedMonoidalRightEvaluationMorphism, 1 ] ],
                    
  function( cat, a, c, g, s )
    local ev_ac;
    
    # g: b → Hom(a,c)
    #
    #    a ⊗ b
    #      |
    #      | id_a ⊗ g
    #      v
    # a ⊗ Hom(a,c)
    #      |
    #      | ev_ac
    #      v
    #      c
    
    ev_ac := ClosedMonoidalRightEvaluationMorphism( cat, a, c );
     
    return PreCompose( cat,
             TensorProductOnMorphismsWithGivenTensorProducts( cat, s, IdentityMorphism( cat, a ), g, Source( ev_ac ) ),
             ev_ac );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( ClosedMonoidalRightEvaluationMorphismWithGivenSource,
                    "ClosedMonoidalRightEvaluationMorphismWithGivenSource using the tensor hom adjunction on the identity",
                    [ [ InternalHomToTensorProductRightAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ InternalHomOnObjects, 1 ] ],
                    
  function( cat, a, b, tensor_object )
    
    # Adjoint( id_Hom(a,b): Hom(a,b) → Hom(a,b) ) = ( a ⊗ Hom(a,b) → b )
    
    return InternalHomToTensorProductRightAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, InternalHomOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( ClosedMonoidalRightCoevaluationMorphismWithGivenRange,
                    "ClosedMonoidalRightCoevaluationMorphismWithGivenRange using the tensor hom adjunction on the identity",
                    [ [ TensorProductToInternalHomRightAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    
    # Adjoint( id_(a ⊗ b): a ⊗ b → a ⊗ b ) = ( b → Hom(a, a ⊗ b) )
    
    return TensorProductToInternalHomRightAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, TensorProductOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductToInternalHomLeftAdjunctionMap,
                    "TensorProductToInternalHomLeftAdjunctionMap using ClosedMonoidalLeftCoevaluationMorphism and InternalHom",
                    [ [ PreCompose, 1 ],
                      [ ClosedMonoidalLeftCoevaluationMorphism, 1 ],
                      [ InternalHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f )
    
    # f: a ⊗ b → c
    #
    #      a
    #      |
    #      | coev_ba
    #      v
    # Hom(b,a ⊗ b)
    #      |
    #      | Hom(id_b, f)
    #      v
    #   Hom(b,c)
    
    return PreCompose( cat,
             ClosedMonoidalLeftCoevaluationMorphism( cat, b, a ),
             InternalHomOnMorphisms( cat, IdentityMorphism( cat, b ), f ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductToInternalHomLeftAdjunctionMapWithGivenInternalHom,
                    "TensorProductToInternalHomLeftAdjunctionMapWithGivenInternalHom using ClosedMonoidalLeftCoevaluationMorphism and InternalHom",
                    [ [ ClosedMonoidalLeftCoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ InternalHomOnMorphismsWithGivenInternalHoms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f, i )
    local coev_ba;
    
    # f: a ⊗ b → c
    #
    #      a
    #      |
    #      | coev_ba
    #      v
    # Hom(b,a ⊗ b)
    #      |
    #      | Hom(id_b, f)
    #      v
    #   Hom(b,c)
    
    coev_ba := ClosedMonoidalLeftCoevaluationMorphism( cat, b, a );
    
    return PreCompose( cat,
             coev_ba,
             InternalHomOnMorphismsWithGivenInternalHoms( cat, Range( coev_ba ), IdentityMorphism( cat, b ), f, i ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( InternalHomToTensorProductLeftAdjunctionMap,
                    "InternalHomToTensorProductLeftAdjunctionMap using TensorProductOnMorphisms and ClosedMonoidalLeftEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ ClosedMonoidalLeftEvaluationMorphism, 1 ] ],
                    
  function( cat, b, c, g )
    
    # g: a → Hom(b,c)
    #
    #    a ⊗ b
    #      |
    #      | g ⊗ id_b
    #      v
    # Hom(b,c) ⊗ b
    #      |
    #      | ev_bc
    #      v
    #      c
    
    return PreCompose( cat,
             TensorProductOnMorphisms( cat, g, IdentityMorphism( cat, b ) ),
             ClosedMonoidalLeftEvaluationMorphism( cat, b, c ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( InternalHomToTensorProductLeftAdjunctionMapWithGivenTensorProduct,
                    "InternalHomToTensorProductLeftAdjunctionMapWithGivenTensorProduct using TensorProductOnMorphisms and ClosedMonoidalLeftEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ TensorProductOnMorphismsWithGivenTensorProducts, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ ClosedMonoidalLeftEvaluationMorphism, 1 ] ],
                    
  function( cat, b, c, g, s )
    local ev_bc;
    
    # g: a → Hom(b,c)
    #
    #    a ⊗ b
    #      |
    #      | g ⊗ id_b
    #      v
    # Hom(b,c) ⊗ b
    #      |
    #      | ev_bc
    #      v
    #      c
    
    ev_bc := ClosedMonoidalLeftEvaluationMorphism( cat, b, c );
     
    return PreCompose( cat,
             TensorProductOnMorphismsWithGivenTensorProducts( cat, s, g, IdentityMorphism( cat, b ), Source( ev_bc ) ),
             ev_bc );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( ClosedMonoidalLeftEvaluationMorphismWithGivenSource,
                    "ClosedMonoidalLeftEvaluationMorphismWithGivenSource using the tensor hom adjunction on the identity",
                    [ [ InternalHomToTensorProductLeftAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ InternalHomOnObjects, 1 ] ],
                    
  function( cat, a, b, tensor_object )
    
    # Adjoint( id_Hom(a,b): Hom(a,b) → Hom(a,b) ) = ( Hom(a,b) ⊗ a → b )
    
    return InternalHomToTensorProductLeftAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, InternalHomOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( ClosedMonoidalLeftCoevaluationMorphismWithGivenRange,
                    "ClosedMonoidalLeftCoevaluationMorphismWithGivenRange using the tensor hom adjunction on the identity",
                    [ [ TensorProductToInternalHomLeftAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    
    # Adjoint( id_(b ⊗ a): b ⊗ a → b ⊗ a ) = ( b → Hom(a, b ⊗ a) )
    
    return TensorProductToInternalHomLeftAdjunctionMap( cat,
             b, a,
             IdentityMorphism( cat, TensorProductOnObjects( cat, b, a ) ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( UniversalPropertyOfDual,
                    "UniversalPropertyOfDual using the tensor hom adjunction",
                    [ [ PreCompose, 1 ],
                      [ TensorProductToInternalHomLeftAdjunctionMap, 1 ],
                      [ IsomorphismFromInternalHomIntoTensorUnitToDualObject, 1 ] ],
                    
  function( cat, t, a, alpha )

    # alpha: t ⊗ a → 1
    #
    # Adjoint( alpha ) = ( t → Hom(a,1) ) → a^v
    
    return PreCompose( cat,
             TensorProductToInternalHomLeftAdjunctionMap( cat, t, a, alpha ),
             IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, a ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( DualOnObjects,
                    "DualOnObjects as the source of IsomorphismFromDualObjectToInternalHomIntoTensorUnit",
                    [ [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit, 1 ] ],
                    
  function( cat, a )

    # Source( a^v → Hom(a,1) )
    
    return Source( IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( DualOnObjects,
                    "DualOnObjects as the range of IsomorphismFromInternalHomIntoTensorUnitToDualObject",
                    [ [ IsomorphismFromInternalHomIntoTensorUnitToDualObject, 1 ] ],
                    
  function( cat, a )

    # Range( Hom(a,1) → a^v )
    
    return Range( IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, a ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( DualOnMorphismsWithGivenDuals,
                    "DualOnMorphismsWithGivenDuals using InternalHomOnMorphisms and IsomorphismFromDualObjectToInternalHomIntoTensorUnit",
                    [ [ PreComposeList, 1 ],
                      [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit, 1 ],
                      [ InternalHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorUnit, 1 ],
                      [ IsomorphismFromInternalHomIntoTensorUnitToDualObject, 1 ] ],
                    
  function( cat, s, alpha, r )
    
    # alpha: a → b
    #
    #   b^v
    #    |
    #    v
    # Hom(b,1)
    #    |
    #    | Hom(alpha, id_1)
    #    v
    # Hom(a,1)
    #    |
    #    v
    #   a^v
    
    return PreComposeList( cat,
                   s,
                   [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, Range( alpha ) ),
                     
                     InternalHomOnMorphisms( cat,
                             alpha,
                             IdentityMorphism( cat, TensorUnit( cat ) ) ),
                     
                     IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, Source( alpha ) ) ],
                   r );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( EvaluationForDualWithGivenTensorProduct,
                    "EvaluationForDualWithGivenTensorProduct using the tensor hom adjunction and IsomorphismFromDualObjectToInternalHomIntoTensorUnit",
                    [ [ InternalHomToTensorProductLeftAdjunctionMap, 1 ],
                      [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit, 1 ] ],
                    
  function( cat, s, a, r )

    # r := 1
    #
    # Adjoint( a^v → Hom(a,1) ) = ( a^v ⊗ a → 1 )
    
    return InternalHomToTensorProductLeftAdjunctionMap( cat,
                   a,
                   r,
                   IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( LambdaIntroduction,
                    "LambdaIntroduction using the tensor hom adjunction and right unitor",
                    [ [ PreCompose, 1 ],
                      [ RightUnitor, 1 ],
                      [ TensorProductToInternalHomRightAdjunctionMap, 1 ],
                      [ TensorUnit, 1 ] ],
                    
  function( cat, alpha )
    local result_morphism, source;
    
    # a ⊗ 1
    #   |
    #   | ρ_a
    #   v
    #   a
    #   |
    #   | alpha
    #   v
    #   b
    #
    # Adjoint( a ⊗ 1 → b ) = ( 1 → Hom(a,b) )
    
    source := Source( alpha );
    
    result_morphism := PreCompose( cat, RightUnitor( cat, source ), alpha );
    
    return TensorProductToInternalHomRightAdjunctionMap( cat,
                   source,
                   TensorUnit( cat ),
                   result_morphism );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( LambdaIntroduction,
                    "LambdaIntroduction using the tensor hom adjunction and left unitor",
                    [ [ PreCompose, 1 ],
                      [ LeftUnitor, 1 ],
                      [ TensorProductToInternalHomLeftAdjunctionMap, 1 ],
                      [ TensorUnit, 1 ] ],
                    
  function( cat, alpha )
    local result_morphism, source;
    
    # 1 ⊗ a
    #   |
    #   | λ_a
    #   v
    #   a
    #   |
    #   | alpha
    #   v
    #   b
    #
    # Adjoint( 1 ⊗ a → b ) = ( 1 → Hom(a,b) )
    
    source := Source( alpha );
    
    result_morphism := PreCompose( cat, LeftUnitor( cat, source ), alpha );
    
    return TensorProductToInternalHomLeftAdjunctionMap( cat,
                   TensorUnit( cat ),
                   source,
                   result_morphism );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( LambdaElimination,
                    "LambdaElimination using the tensor hom adjunction and right unitor inverse",
                    [ [ InternalHomToTensorProductRightAdjunctionMap, 1 ],
                      [ PreCompose, 1 ],
                      [ RightUnitorInverse, 1 ] ],
                    
  function( cat, a, b, alpha )
    local result_morphism;
    
    # alpha: 1 → Hom(a,b)
    # Adjoint( alpha ) = ( a ⊗ 1 → b )
    #
    #   a
    #   |
    #   | (ρ_a)^-1
    #   v
    # a ⊗ 1
    #   |
    #   | Adjoint( alpha )
    #   v
    #   b
    
    result_morphism := InternalHomToTensorProductRightAdjunctionMap( cat, a, b, alpha );
    
    return PreCompose( cat, RightUnitorInverse( cat, a ), result_morphism );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( LambdaElimination,
                    "LambdaElimination using the tensor hom adjunction and left unitor inverse",
                    [ [ InternalHomToTensorProductLeftAdjunctionMap, 1 ],
                      [ PreCompose, 1 ],
                      [ LeftUnitorInverse, 1 ] ],
                    
  function( cat, a, b, alpha )
    local result_morphism;
    
    # alpha: 1 → Hom(a,b)
    # Adjoint( alpha ) = ( 1 ⊗ a → b )
    #
    #   a
    #   |
    #   | (λ_a)^-1
    #   v
    # 1 ⊗ a
    #   |
    #   | Adjoint( alpha )
    #   v
    #   b
    
    result_morphism := InternalHomToTensorProductLeftAdjunctionMap( cat, a, b, alpha );
    
    return PreCompose( cat, LeftUnitorInverse( cat, a ), result_morphism );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductDualityCompatibilityMorphismWithGivenObjects,
                    "TensorProductDualityCompatibilityMorphismWithGivenObjects using left unitor, and compatibility of tensor product and internal hom",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit, 2 ],
                      [ TensorProductInternalHomCompatibilityMorphism, 1 ],
                      [ InternalHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftUnitor, 1 ],
                      [ IsomorphismFromInternalHomIntoTensorUnitToDualObject, 1 ] ],
                    
  function( cat, s, a, b, r )
    local unit, tensor_product_on_a_and_b, morphism;
    
    #      a^v ⊗ b^v
    #          |
    #          v
    # Hom(a,1) ⊗ Hom(b,1)
    #          |
    #          | CompatMorphism(a,1,b,1)
    #          V
    #  Hom(a ⊗ b, 1 ⊗ 1)
    #          |
    #          | Hom(id_(a ⊗ b), λ_1)
    #          V
    #    Hom(a ⊗ b, 1)
    #          |
    #          V
    #       (a ⊗ b)^v
    
    unit := TensorUnit( cat );
    
    tensor_product_on_a_and_b := TensorProductOnObjects( cat, a, b );
    
    morphism := PreComposeList( cat,
                        s,
                        [ TensorProductOnMorphisms( cat,
                                IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ),
                                IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, b ) ),
                          
                          TensorProductInternalHomCompatibilityMorphism( cat, [ a, unit, b, unit ] ),
                          
                          InternalHomOnMorphisms( cat,
                                  IdentityMorphism( cat, tensor_product_on_a_and_b ),
                                  LeftUnitor( cat, unit ) ),
                          
                          IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat, tensor_product_on_a_and_b ) ],
                        r );
    
    return morphism;
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
                    "IsomorphismFromObjectToInternalHomWithGivenInternalHom using the coevaluation morphism",
                    [ [ TensorUnit, 1 ],
                      [ PreCompose, 1 ],
                      [ ClosedMonoidalLeftCoevaluationMorphism, 1 ],
                      [ InternalHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ RightUnitor, 1 ] ],
                    
  function( cat, a, internal_hom )
    local unit;
    
    #       a
    #       |
    #       | coev_(1,a)
    #       v
    # Hom(1, a ⊗ 1)
    #       |
    #       | Hom(id_1, ρ_a)
    #       v
    #   Hom(1, a)
    
    unit := TensorUnit( cat );
    
    return PreCompose( cat,
                   ClosedMonoidalLeftCoevaluationMorphism( cat, unit, a ),
                   
                   InternalHomOnMorphisms( cat,
                           IdentityMorphism( cat, unit ),
                           RightUnitor( cat, a ) ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
                    "IsomorphismFromObjectToInternalHomWithGivenInternalHom as the adjoint of the right unitor",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductToInternalHomLeftAdjunctionMap, 1 ],
                      [ RightUnitor, 1 ] ],
                    
  function( cat, a, internal_hom )
    
    # ρ_a: a ⊗ 1 → a
    #
    # Adjoint( ρ_a ) = ( a → Hom(1,a) )
    
    return TensorProductToInternalHomLeftAdjunctionMap( cat,
                   a,
                   TensorUnit( cat ),
                   RightUnitor( cat, a ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromObjectToInternalHomWithGivenInternalHom,
#                     
#   function( cat, object, internal_hom )
#
#     # Inverse( a → Hom(1,a))
#     
#     return InverseForMorphisms( cat, IsomorphismFromInternalHomToObject( cat, object ) );
#     
# end : CategoryFilter := IsClosedMonoidalCategory,
#       Description := "IsomorphismFromObjectToInternalHom as the inverse of IsomorphismFromInternalHomToObject" );

##
AddDerivationToCAP( IsomorphismFromInternalHomToObjectWithGivenInternalHom,
                    "IsomorphismFromInternalHomToObjectWithGivenInternalHom using the evaluation morphism",
                    [ [ TensorUnit, 1 ],
                      [ PreCompose, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ ClosedMonoidalLeftEvaluationMorphism, 1 ] ],
                    
  function( cat, a, internal_hom )
    
    #  Hom(1,a)
    #      |
    #      | ( ρ_Hom(1,a) )^-1
    #      v
    # Hom(1,a) ⊗ 1
    #      |
    #      | ev_(1,a)
    #      v
    #      a
    
    return PreCompose( cat,
                   RightUnitorInverse( cat, internal_hom ),
                   ClosedMonoidalLeftEvaluationMorphism( cat, TensorUnit( cat ), a ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

## TODO: enable
# ##
# AddDerivationToCAP( IsomorphismFromInternalHomToObjectWithGivenInternalHom,
#                     
#   function( cat, a, internal_hom )
#
#     # Inverse( a → Hom(1,a) )
#     
#     return InverseForMorphisms( cat, IsomorphismFromObjectToInternalHom( cat, a ) );
#     
# end : CategoryFilter := IsClosedMonoidalCategory,
#       Description := "IsomorphismFromInternalHomToObjectWithGivenInternalHom as the inverse of IsomorphismFromObjectToInternalHom" );

##
AddDerivationToCAP( MorphismFromTensorProductToInternalHomWithGivenObjects,
                    "MorphismFromTensorProductToInternalHomWithGivenObjects using TensorProductInternalHomCompatibilityMorphism",
                    [ [ TensorUnit, 1 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit, 1 ],
                      [ IsomorphismFromObjectToInternalHom, 1 ],
                      [ TensorProductInternalHomCompatibilityMorphism, 1 ],
                      [ InternalHomOnMorphisms, 1 ],
                      [ RightUnitorInverse, 1 ],
                      [ LeftUnitor, 1 ] ],
                    
  function( cat, tensor_object, a, b, internal_hom )
    local unit;
    
    #      a^v ⊗ b
    #          |
    #          v
    # Hom(a,1) ⊗ Hom(1,b)
    #          |
    #          | CompatMorphism
    #          v
    # Hom(a ⊗ 1, 1 ⊗ b)
    #          |
    #          | Hom((ρ_a)^-1, λ_b)
    #          v
    #       Hom(a,b)
    
    unit := TensorUnit( cat );
    
    return PreComposeList( cat,
                   tensor_object,
                   [ TensorProductOnMorphisms( cat,
                           IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ),
                           IsomorphismFromObjectToInternalHom( cat, b ) ),
                     
                     TensorProductInternalHomCompatibilityMorphism( cat,
                             [ a, unit, unit, b ] ),
                     
                     InternalHomOnMorphisms( cat,
                             RightUnitorInverse( cat, a ),
                             LeftUnitor( cat, b ) ) ],
                   internal_hom );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    "MonoidalPostComposeMorphismWithGivenObjects using associator, evaluation, and tensor hom adjunction",
                    [ [ InternalHomOnObjects, 2 ],
                      [ PreComposeList, 1 ],
                      [ AssociatorLeftToRight, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ ClosedMonoidalLeftEvaluationMorphism, 2 ],
                      [ TensorProductToInternalHomLeftAdjunctionMapWithGivenInternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local hom_a_b, hom_b_c, morphism;
    
    # (Hom(b,c) ⊗ Hom(a,b)) ⊗ a
    #            |
    #            | α_( ( Hom(b,c), Hom(a,b) ), c )
    #            v
    # Hom(b,c) ⊗ (Hom(a,b) ⊗ a)
    #            |
    #            | id_Hom(b,c) ⊗ ev_ab
    #            v
    #      Hom(b,c) ⊗ b
    #            |
    #            | ev_bc
    #            v
    #            c
    #
    #
    # Adjoint( (Hom(b,c) ⊗ Hom(a,b)) ⊗ a → c ) = ( Hom(b,c) ⊗ Hom(a,b) → Hom(a,c) )
    
    hom_a_b := InternalHomOnObjects( cat, a, b );
    
    hom_b_c := InternalHomOnObjects( cat, b, c );
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a ),
                        [ AssociatorLeftToRight( cat, hom_b_c, hom_a_b, a ),
                          
                          TensorProductOnMorphisms( cat,
                                  IdentityMorphism( cat, hom_b_c ),
                                  ClosedMonoidalLeftEvaluationMorphism( cat, a, b ) ),
                          
                          ClosedMonoidalLeftEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToInternalHomLeftAdjunctionMapWithGivenInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductDualityCompatibilityMorphismWithGivenObjects,
                    "TensorProductDualityCompatibilityMorphismWithGivenObjects using compatibility of tensor product and internal hom",
                    [ [ TensorUnit, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit, 2 ],
                      [ TensorProductInternalHomCompatibilityMorphism, 1 ],
                      [ IsomorphismFromInternalHomIntoTensorUnitToDualObject, 1 ] ],
                    
  function( cat, source, a, b, range )
    local unit, morphism;
    
    #      a^v ⊗ b^v
    #          |
    #          v
    # Hom(a,1) ⊗ Hom(b,1)
    #          |
    #          | CompatMorphism(a,1,b,1)
    #          V
    #  Hom(a ⊗ b, 1)
    #          |
    #          V
    #       (a ⊗ b)^v
    
    unit := TensorUnit( cat );
    
    morphism := PreComposeList( cat,
                        source,
                        [ TensorProductOnMorphisms( cat,
                                IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ),
                                IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, b ) ),
                          
                          TensorProductInternalHomCompatibilityMorphism( cat, [ a, unit, b, unit ] ),
                          
                          IsomorphismFromInternalHomIntoTensorUnitToDualObject( cat,
                                  TensorProductOnObjects( cat, a, b ) ) ],
                        range );
    
    return morphism;
    
end : CategoryFilter := cat -> HasIsClosedMonoidalCategory( cat ) and IsClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( MonoidalPostComposeMorphismWithGivenObjects,
                    "MonoidalPostComposeMorphismWithGivenObjects using evaluation, and tensor hom adjunction",
                    [ [ InternalHomOnObjects, 1 ],
                      [ PreComposeList, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ ClosedMonoidalLeftEvaluationMorphism, 2 ],
                      [ TensorProductToInternalHomLeftAdjunctionMapWithGivenInternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, source, a, b, c, range )
    local morphism;
    
    # Hom(b,c) ⊗ Hom(a,b) ⊗ a
    #            |
    #            | id_Hom(b,c) ⊗ ev_ab
    #            v
    #      Hom(b,c) ⊗ b
    #            |
    #            | ev_bc
    #            v
    #            c
    #
    #
    # Adjoint( Hom(b,c) ⊗ Hom(a,b) ⊗ a → c ) = ( Hom(b,c) ⊗ Hom(a,b) → Hom(a,c) )
    
    morphism := PreComposeList( cat,
                        TensorProductOnObjects( cat,
                                source,
                                a ),
                        [ TensorProductOnMorphisms( cat,
                                IdentityMorphism( cat, InternalHomOnObjects( cat, b, c ) ),
                                ClosedMonoidalLeftEvaluationMorphism( cat, a, b ) ),
                          
                          ClosedMonoidalLeftEvaluationMorphism( cat, b, c ) ],
                        c );
    
    return TensorProductToInternalHomLeftAdjunctionMapWithGivenInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsClosedMonoidalCategory( cat ) and IsClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

####################################
## Final derived methods
####################################

## Final methods for Dual
AddFinalDerivationBundle( "IsomorphismFromDualObjectToInternalHomIntoTensorUnit and its inverse as the identity of Hom(a,1)",
                    [ [ IdentityMorphism, 1 ],
                      [ InternalHomOnObjects, 1 ],
                      [ TensorUnit, 1 ] ],
                    [ DualOnObjects,
                      DualOnMorphismsWithGivenDuals,
                      MorphismToBidualWithGivenBidual,
                      IsomorphismFromDualObjectToInternalHomIntoTensorUnit,
                      IsomorphismFromInternalHomIntoTensorUnitToDualObject,
                      UniversalPropertyOfDual,
                      TensorProductDualityCompatibilityMorphismWithGivenObjects,
                      EvaluationForDualWithGivenTensorProduct,
                      MorphismFromTensorProductToInternalHomWithGivenObjects ],
[
  IsomorphismFromDualObjectToInternalHomIntoTensorUnit,
  [ [ IdentityMorphism, 1 ],
    [ InternalHomOnObjects, 1 ],
    [ TensorUnit, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, InternalHomOnObjects( cat, object, TensorUnit( cat ) ) );
    
  end
],
[
  IsomorphismFromInternalHomIntoTensorUnitToDualObject,
  [ [ IdentityMorphism, 1 ],
    [ InternalHomOnObjects, 1 ],
    [ TensorUnit, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, InternalHomOnObjects( cat, object, TensorUnit( cat ) ) );
    
  end
] : CategoryFilter := IsClosedMonoidalCategory );
