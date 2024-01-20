# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductToLeftInternalCoHomAdjunctionMap,
                    "TensorProductToLeftInternalCoHomAdjunctionMap using LeftCoclosedMonoidalCoevaluationMorphism and LeftInternalCoHom",
                    [ [ PreCompose, 1 ],
                      [ LeftInternalCoHomOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftCoclosedMonoidalCoevaluationMorphism, 1 ] ],
                    
  function( cat, c, b, g )
    
    # g: a → c ⊗ b
    #
    #    coHom(a,b)
    #        |
    #        | coHom(g, id_b)
    #        v
    # coHom(c ⊗ b, b)
    #        |
    #        | coclcoev_cb
    #        v
    #        c

    return PreCompose( cat,
             LeftInternalCoHomOnMorphisms( cat, g, IdentityMorphism( cat, b ) ),
             LeftCoclosedMonoidalCoevaluationMorphism( cat, c, b ) );
             
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom,
                    "TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom using LeftCoclosedMonoidalCoevaluationMorphism and LeftInternalCoHom",
                    [ [ LeftCoclosedMonoidalCoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, c, b, g, i )
    local coclcoev_cb;
    
    # g: a → c ⊗ b
    #
    #    coHom(a,b)
    #        |
    #        | coHom(g, id_b)
    #        v
    # coHom(c ⊗ b, b)
    #        |
    #        | coclcoev_cb
    #        v
    #        c
    
    coclcoev_cb := LeftCoclosedMonoidalCoevaluationMorphism( cat, c, b );
    
    return PreCompose( cat,
             LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms( cat, i, g, IdentityMorphism( cat, b ), Source( coclcoev_cb ) ),
             coclcoev_cb );
    
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalCoHomToTensorProductAdjunctionMap,
                    "LeftInternalCoHomToTensorProductAdjunctionMap using TensorProductOnMorphisms and LeftCoclosedMonoidalEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 1 ],
                      [ TensorProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f )
    
    # f: coHom(a,b) → c
    #
    #        a
    #        |
    #        | coclev_ab
    #        v
    # coHom(a,b) ⊗ b
    #        |
    #        | f ⊗ id_b
    #        v
    #      c ⊗ b
    
    return PreCompose( cat,
             LeftCoclosedMonoidalEvaluationMorphism( cat, a, b ),
             TensorProductOnMorphisms( cat, f, IdentityMorphism( cat, b ) ) );
             
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftInternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct,
                    "LeftInternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct using TensorProductOnMorphisms and LeftCoclosedMonoidalEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ LeftCoclosedMonoidalEvaluationMorphism, 1 ],
                      [ TensorProductOnMorphismsWithGivenTensorProducts, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f, t )
    local coclev_bc;
    
    # f: coHom(a,b) → c
    #
    #        a
    #        |
    #        | coclev_ab
    #        v
    # coHom(a,b) ⊗ b
    #        |
    #        | f ⊗ id_b
    #        v
    #      c ⊗ b
    
    coclev_bc := LeftCoclosedMonoidalEvaluationMorphism( cat, a, b );
    
    return PreCompose( cat,
             coclev_bc,
             TensorProductOnMorphismsWithGivenTensorProducts( cat, Range( coclev_bc ), f, IdentityMorphism( cat, b ), t ) );
             
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

##
AddDerivationToCAP( LeftCoclosedMonoidalEvaluationMorphismWithGivenRange,
                    "LeftCoclosedMonoidalEvaluationMorphismWithGivenRange using the cohom tensor adjunction on the identity",
                    [ [ LeftInternalCoHomToTensorProductAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ LeftInternalCoHomOnObjects, 1 ] ],
                    
  function( cat, a, b, tensor_object )
    
    # Adjoint( id_coHom(a,b): coHom(a,b) → coHom(a,b) ) = ( a → coHom(a,b) ⊗ b )
    
    return LeftInternalCoHomToTensorProductAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, LeftInternalCoHomOnObjects( cat, a, b ) )
           );
    
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );

AddDerivationToCAP( LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource,
                    "LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource using the cohom tensor adjunction on the identity",
                    [ [ TensorProductToLeftInternalCoHomAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ TensorProductOnObjects, 1 ] ],
                    
  function( cat, a, b, internal_cohom )
    
    # Adjoint( id_(a ⊗ b): a ⊗ b → a ⊗ b ) = ( coHom(a ⊗ b, b) → a )
    
    return TensorProductToLeftInternalCoHomAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, TensorProductOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsLeftCoclosedMonoidalCategory );
