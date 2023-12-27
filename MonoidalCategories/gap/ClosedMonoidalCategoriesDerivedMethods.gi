# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToInternalHomRightAdjunctMorphism,
                    "TensorProductToInternalHomRightAdjunctMorphism using ClosedMonoidalRightCoevaluationMorphism and InternalHom",
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
AddDerivationToCAP( TensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom,
                    "TensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom using ClosedMonoidalRightCoevaluationMorphism and InternalHom",
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
AddDerivationToCAP( InternalHomToTensorProductRightAdjunctMorphism,
                    "InternalHomToTensorProductRightAdjunctMorphism using TensorProductOnMorphisms and ClosedMonoidalRightEvaluationMorphism",
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
AddDerivationToCAP( InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct,
                    "InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct using TensorProductOnMorphisms and ClosedMonoidalRightEvaluationMorphism",
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
                    [ [ InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ InternalHomOnObjects, 1 ] ],
                    
  function( cat, a, b, tensor_object )
    
    # Adjoint( id_Hom(a,b): Hom(a,b) → Hom(a,b) ) = ( a ⊗ Hom(a,b) → b )
    
    return InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct( cat,
                   a,
                   b,
                   IdentityMorphism( cat, InternalHomOnObjects( cat, a, b ) ),
                   tensor_object # = a ⊗ Hom(a,b)
                   );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( ClosedMonoidalRightCoevaluationMorphismWithGivenRange,
                    "ClosedMonoidalRightCoevaluationMorphismWithGivenRange using the tensor hom adjunction on the identity",
                    [ [ TensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    
    # Adjoint( id_(a ⊗ b): a ⊗ b → a ⊗ b ) = ( b → Hom(a, a ⊗ b) )
    
    return TensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom( cat,
                   a,
                   b,
                   IdentityMorphism( cat, TensorProductOnObjects( cat, a, b ) ),
                   internal_hom # = Hom(a, a ⊗ b)
                   );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductToInternalHomLeftAdjunctMorphism,
                    "TensorProductToInternalHomLeftAdjunctMorphism using ClosedMonoidalLeftCoevaluationMorphism and InternalHom",
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
AddDerivationToCAP( TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom,
                    "TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom using ClosedMonoidalLeftCoevaluationMorphism and InternalHom",
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
AddDerivationToCAP( InternalHomToTensorProductLeftAdjunctMorphism,
                    "InternalHomToTensorProductLeftAdjunctMorphism using TensorProductOnMorphisms and ClosedMonoidalLeftEvaluationMorphism",
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
AddDerivationToCAP( InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct,
                    "InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct using TensorProductOnMorphisms and ClosedMonoidalLeftEvaluationMorphism",
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
                    [ [ InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ InternalHomOnObjects, 1 ] ],
                    
  function( cat, a, b, tensor_object )
    
    # Adjoint( id_Hom(a,b): Hom(a,b) → Hom(a,b) ) = ( Hom(a,b) ⊗ a → b )
    
    return InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( cat,
                   a,
                   b,
                   IdentityMorphism( cat, InternalHomOnObjects( cat, a, b ) ),
                   tensor_object # = Hom(a,b) ⊗ a
                   );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( ClosedMonoidalLeftCoevaluationMorphismWithGivenRange,
                    "ClosedMonoidalLeftCoevaluationMorphismWithGivenRange using the tensor hom adjunction on the identity",
                    [ [ TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    
    # Adjoint( id_(b ⊗ a): b ⊗ a → b ⊗ a ) = ( b → Hom(a, b ⊗ a) )
    
    return TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom( cat,
                   b,
                   a,
                   IdentityMorphism( cat, TensorProductOnObjects( cat, b, a ) ),
                   internal_hom # = Hom(a, b ⊗ a)
                   );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( UniversalPropertyOfDual,
                    "UniversalPropertyOfDual using the tensor hom adjunction",
                    [ [ PreCompose, 1 ],
                      [ TensorProductToInternalHomLeftAdjunctMorphism, 1 ],
                      [ IsomorphismFromInternalHomIntoTensorUnitToDualObject, 1 ] ],
                    
  function( cat, t, a, alpha )

    # alpha: t ⊗ a → 1
    #
    # Adjoint( alpha ) = ( t → Hom(a,1) ) → a^v
    
    return PreCompose( cat,
             TensorProductToInternalHomLeftAdjunctMorphism( cat, t, a, alpha ),
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
                    [ [ InternalHomToTensorProductLeftAdjunctMorphism, 1 ],
                      [ IsomorphismFromDualObjectToInternalHomIntoTensorUnit, 1 ] ],
                    
  function( cat, s, a, r )

    # r := 1
    #
    # Adjoint( a^v → Hom(a,1) ) = ( a^v ⊗ a → 1 )
    
    return InternalHomToTensorProductLeftAdjunctMorphism( cat,
                   a,
                   r,
                   IsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat, a ) );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( LambdaIntroduction,
                    "LambdaIntroduction using the tensor hom adjunction and right unitor",
                    [ [ PreCompose, 1 ],
                      [ RightUnitor, 1 ],
                      [ TensorProductToInternalHomRightAdjunctMorphism, 1 ],
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
    
    return TensorProductToInternalHomRightAdjunctMorphism( cat,
                   source,
                   TensorUnit( cat ),
                   result_morphism );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( LambdaIntroduction,
                    "LambdaIntroduction using the tensor hom adjunction and left unitor",
                    [ [ PreCompose, 1 ],
                      [ LeftUnitor, 1 ],
                      [ TensorProductToInternalHomLeftAdjunctMorphism, 1 ],
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
    
    return TensorProductToInternalHomLeftAdjunctMorphism( cat,
                   TensorUnit( cat ),
                   source,
                   result_morphism );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( LambdaElimination,
                    "LambdaElimination using the tensor hom adjunction and right unitor inverse",
                    [ [ InternalHomToTensorProductRightAdjunctMorphism, 1 ],
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
    
    result_morphism := InternalHomToTensorProductRightAdjunctMorphism( cat, a, b, alpha );
    
    return PreCompose( cat, RightUnitorInverse( cat, a ), result_morphism );
    
end : CategoryFilter := IsClosedMonoidalCategory );

##
AddDerivationToCAP( LambdaElimination,
                    "LambdaElimination using the tensor hom adjunction and left unitor inverse",
                    [ [ InternalHomToTensorProductLeftAdjunctMorphism, 1 ],
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
    
    result_morphism := InternalHomToTensorProductLeftAdjunctMorphism( cat, a, b, alpha );
    
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
                      [ TensorProductToInternalHomLeftAdjunctMorphism, 1 ],
                      [ RightUnitor, 1 ] ],
                    
  function( cat, a, internal_hom )
    
    # ρ_a: a ⊗ 1 → a
    #
    # Adjoint( ρ_a ) = ( a → Hom(1,a) )
    
    return TensorProductToInternalHomLeftAdjunctMorphism( cat,
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
                      [ TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom, 1 ],
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
    
    return TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom( cat,
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
                      [ TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom, 1 ],
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
    
    return TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom( cat,
                   source,
                   a,
                   morphism,
                   range );
    
end : CategoryFilter := cat -> HasIsClosedMonoidalCategory( cat ) and IsClosedMonoidalCategory( cat ) and HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) );

##
AddDerivationToCAP( TensorProductToInternalHomRightAdjunctionIsomorphismWithGivenObjects,
                    "TensorProductToInternalHomRightAdjunctionIsomorphismWithGivenObjects as inverse of InternalHomToTensorProductRightAdjunctionIsomorphismWithGivenObjects",
                    [ [ InternalHomToTensorProductRightAdjunctionIsomorphismWithGivenObjects, 1 ],
                      [ InverseForMorphisms, 1, RangeCategoryOfHomomorphismStructure ] ],
        
  function( cat, H_a_tensor_b_c, a, b, c, H_b_hom_ac )
    local H;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    return InverseForMorphisms( H,
                   InternalHomToTensorProductRightAdjunctionIsomorphismWithGivenObjects( cat,
                           H_b_hom_ac,
                           a,
                           b,
                           c,
                           H_a_tensor_b_c ) );
    
end : CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ),
      CategoryFilter := HasRangeCategoryOfHomomorphismStructure );

##
AddDerivationToCAP( InternalHomToTensorProductRightAdjunctionIsomorphismWithGivenObjects,
                    "InternalHomToTensorProductRightAdjunctionIsomorphismWithGivenObjects as inverse of TensorProductToInternalHomRightAdjunctionIsomorphismWithGivenObjects",
                    [ [ TensorProductToInternalHomRightAdjunctionIsomorphismWithGivenObjects, 1 ],
                      [ InverseForMorphisms, 1, RangeCategoryOfHomomorphismStructure ] ],
        
  function( cat, H_b_hom_ac, a, b, c, H_a_tensor_b_c )
    local H;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    return InverseForMorphisms( H,
                   TensorProductToInternalHomRightAdjunctionIsomorphismWithGivenObjects( cat,
                           H_a_tensor_b_c,
                           a,
                           b,
                           c,
                           H_b_hom_ac ) );
    
end : CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ),
      CategoryFilter := HasRangeCategoryOfHomomorphismStructure );

##
AddDerivationToCAP( TensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom,
                    "TensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom using TensorProductToInternalHomRightAdjunctionIsomorphismWithGivenObjects",
                    [ [ HomomorphismStructureOnObjects, 2 ],
                      [ TensorProductOnObjects, 1 ],
                      [ TensorProductToInternalHomRightAdjunctionIsomorphismWithGivenObjects, 1 ],
                      [ DistinguishedObjectOfHomomorphismStructure, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects, 1 ],
                      [ PreCompose, 1, RangeCategoryOfHomomorphismStructure ],
                      [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ] ],
        
  function( cat, a, b, f, hom_ac )
    local H, c, H_a_tensor_b_c, H_b_hom_ac, iso, distinguished_object, f_name, g_name;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    c := Range( f );
    
    H_a_tensor_b_c := HomomorphismStructureOnObjects( cat,
                              TensorProductOnObjects( cat, a, b ),
                              c );
    
    H_b_hom_ac := HomomorphismStructureOnObjects( cat,
                          b,
                          hom_ac );
    
    iso := TensorProductToInternalHomRightAdjunctionIsomorphismWithGivenObjects( cat,
                   H_a_tensor_b_c,
                   a,
                   b,
                   c,
                   H_b_hom_ac );
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
    
    f_name := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
                      distinguished_object,
                      f,
                      H_a_tensor_b_c );
    
    ## the name of the adjunct of f:
    g_name := PreCompose( H,
                      f_name,
                      iso );
    
    return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
                   b,
                   hom_ac,
                   g_name );
    
end : CategoryFilter := IsClosedMonoidalCategory,
      CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ) );

##
AddDerivationToCAP( InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct,
                    "InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct using InternalHomToTensorProductRightAdjunctionIsomorphismWithGivenObjects",
                    [ [ InternalHomOnObjects, 1 ],
                      [ HomomorphismStructureOnObjects, 2 ],
                      [ InternalHomToTensorProductRightAdjunctionIsomorphismWithGivenObjects, 1 ],
                      [ DistinguishedObjectOfHomomorphismStructure, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects, 1 ],
                      [ PreCompose, 1, RangeCategoryOfHomomorphismStructure ],
                      [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ] ],
        
  function( cat, a, c, g, a_tensor_b )
    local H, b, H_b_hom_ac, H_a_tensor_b_c, iso, distinguished_object, g_name, f_name;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    b := Source( g );
    
    H_b_hom_ac := HomomorphismStructureOnObjects( cat,
                          b,
                          InternalHomOnObjects( cat,
                                  a,
                                  c ) );
    
    H_a_tensor_b_c := HomomorphismStructureOnObjects( cat,
                              a_tensor_b,
                              c );
    
    iso := InternalHomToTensorProductRightAdjunctionIsomorphismWithGivenObjects( cat,
                   H_b_hom_ac,
                   a,
                   b,
                   c,
                   H_a_tensor_b_c );
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
    
    g_name := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
                      distinguished_object,
                      g,
                      H_b_hom_ac );
    
    ## the name of the adjunct of g:
    f_name := PreCompose( H,
                      g_name,
                      iso );
    
    return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
                   a_tensor_b,
                   c,
                   f_name );
    
end : CategoryFilter := IsClosedMonoidalCategory,
      CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ) );

##
AddDerivationToCAP( TensorProductToInternalHomLeftAdjunctionIsomorphismWithGivenObjects,
                    "TensorProductToInternalHomLeftAdjunctionIsomorphismWithGivenObjects as inverse of InternalHomToTensorProductLeftAdjunctionIsomorphismWithGivenObjects",
                    [ [ InternalHomToTensorProductLeftAdjunctionIsomorphismWithGivenObjects, 1 ],
                      [ InverseForMorphisms, 1, RangeCategoryOfHomomorphismStructure ] ],
        
  function( cat, H_a_tensor_b_c, a, b, c, H_a_hom_bc )
    local H;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    return InverseForMorphisms( H,
                   InternalHomToTensorProductLeftAdjunctionIsomorphismWithGivenObjects( cat,
                           H_a_hom_bc,
                           a,
                           b,
                           c,
                           H_a_tensor_b_c ) );
    
end : CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ),
      CategoryFilter := HasRangeCategoryOfHomomorphismStructure );

##
AddDerivationToCAP( InternalHomToTensorProductLeftAdjunctionIsomorphismWithGivenObjects,
                    "InternalHomToTensorProductLeftAdjunctionIsomorphismWithGivenObjects as inverse of TensorProductToInternalHomLeftAdjunctionIsomorphismWithGivenObjects",
                    [ [ TensorProductToInternalHomLeftAdjunctionIsomorphismWithGivenObjects, 1 ],
                      [ InverseForMorphisms, 1, RangeCategoryOfHomomorphismStructure ] ],
        
  function( cat, H_a_hom_bc, a, b, c, H_a_tensor_b_c )
    local H;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    return InverseForMorphisms( H,
                   TensorProductToInternalHomLeftAdjunctionIsomorphismWithGivenObjects( cat,
                           H_a_tensor_b_c,
                           a,
                           b,
                           c,
                           H_a_hom_bc ) );
    
end : CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ),
      CategoryFilter := HasRangeCategoryOfHomomorphismStructure );

##
AddDerivationToCAP( TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom,
                    "TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom using TensorProductToInternalHomLeftAdjunctionIsomorphismWithGivenObjects",
                    [ [ HomomorphismStructureOnObjects, 2 ],
                      [ TensorProductOnObjects, 1 ],
                      [ TensorProductToInternalHomLeftAdjunctionIsomorphismWithGivenObjects, 1 ],
                      [ DistinguishedObjectOfHomomorphismStructure, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects, 1 ],
                      [ PreCompose, 1, RangeCategoryOfHomomorphismStructure ],
                      [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ] ],
        
  function( cat, a, b, f, hom_bc )
    local H, c, H_a_tensor_b_c, H_a_hom_bc, iso, distinguished_object, f_name, g_name;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    c := Range( f );
    
    H_a_tensor_b_c := HomomorphismStructureOnObjects( cat,
                              TensorProductOnObjects( cat, a, b ),
                              c );
    
    H_a_hom_bc := HomomorphismStructureOnObjects( cat,
                          a,
                          hom_bc );
    
    iso := TensorProductToInternalHomLeftAdjunctionIsomorphismWithGivenObjects( cat,
                   H_a_tensor_b_c,
                   a,
                   b,
                   c,
                   H_a_hom_bc );
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
    
    f_name := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
                      distinguished_object,
                      f,
                      H_a_tensor_b_c );
    
    ## the name of the adjunct of f:
    g_name := PreCompose( H,
                      f_name,
                      iso );
    
    return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
                   a,
                   hom_bc,
                   g_name );
    
end : CategoryFilter := IsClosedMonoidalCategory,
      CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ) );

##
AddDerivationToCAP( InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct,
                    "InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct using InternalHomToTensorProductLeftAdjunctionIsomorphismWithGivenObjects",
                    [ [ InternalHomOnObjects, 1 ],
                      [ HomomorphismStructureOnObjects, 2 ],
                      [ InternalHomToTensorProductLeftAdjunctionIsomorphismWithGivenObjects, 1 ],
                      [ DistinguishedObjectOfHomomorphismStructure, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects, 1 ],
                      [ PreCompose, 1, RangeCategoryOfHomomorphismStructure ],
                      [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ] ],
        
  function( cat, b, c, g, a_tensor_b )
    local H, a, H_a_hom_bc, H_a_tensor_b_c, iso, distinguished_object, g_name, f_name;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    a := Source( g );
    
    H_a_hom_bc := HomomorphismStructureOnObjects( cat,
                          a,
                          InternalHomOnObjects( cat,
                                  b,
                                  c ) );
    
    H_a_tensor_b_c := HomomorphismStructureOnObjects( cat,
                              a_tensor_b,
                              c );
    
    iso := InternalHomToTensorProductLeftAdjunctionIsomorphismWithGivenObjects( cat,
                   H_a_hom_bc,
                   a,
                   b,
                   c,
                   H_a_tensor_b_c );
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
    
    g_name := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
                      distinguished_object,
                      g,
                      H_a_hom_bc );
    
    ## the name of the adjunct of g:
    f_name := PreCompose( H,
                      g_name,
                      iso );
    
    return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
                   a_tensor_b,
                   c,
                   f_name );
    
end : CategoryFilter := IsClosedMonoidalCategory,
      CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ) );

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
