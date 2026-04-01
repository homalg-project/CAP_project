# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( TensorProductOnMorphismsWithGivenTensorProducts,
                    "TensorProductOnMorphismsWithGivenTensorProducts via TensorProductOfMorphismAndIdentityWithGivenTensorProducts and TensorProductOfIdentityAndMorphismWithGivenTensorProducts and the functoriality of the tensor product",
                    [ [ TensorProductOfMorphismAndIdentityWithGivenTensorProducts, 1 ],
                      [ TensorProductOfIdentityAndMorphismWithGivenTensorProducts, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ TensorProductOnObjects, 4 ],
                      [ PreCompose, 1 ],
                    ],
                    
  function( cat, source, alpha, beta, range )
    local alpha_source, alpha_range, beta_source, beta_range, alpha_times_id_source_beta, id_range_alpha_times_beta;
    
    alpha_source := Source( alpha );
    alpha_range := Range( alpha );
    
    beta_source := Source( beta );
    beta_range := Range( beta );
    
    # α ⊗ Id_Source(β)
    alpha_times_id_source_beta := TensorProductOfMorphismAndIdentityWithGivenTensorProducts( cat,
                                        TensorProductOnObjects( cat, alpha_source, beta_source ),
                                        alpha,
                                        IdentityMorphism( cat, beta_source ),
                                        TensorProductOnObjects( cat, alpha_range, beta_source ) );
    
    # Id_Range(α) ⊗ β
    id_range_alpha_times_beta := TensorProductOfIdentityAndMorphismWithGivenTensorProducts( cat,
                                        TensorProductOnObjects( cat, alpha_range, beta_source ),
                                        IdentityMorphism( cat, alpha_range ),
                                        beta,
                                        TensorProductOnObjects( cat, alpha_range, beta_range ) );
    
    # The functoriality of the bifunctor '⊗':
    #
    # α ⊗ β = (α · Id_Range(α)) ⊗ (Id_Source(β) · β)
    #       = (α ⊗ Id_Source(β)) · (Id_Range(α) ⊗ β)
    return PreCompose( cat, alpha_times_id_source_beta, id_range_alpha_times_beta );
    
end );

##
AddDerivationToCAP( TensorProductOfMorphismAndIdentityWithGivenTensorProducts,
                    "TensorProductOfMorphismAndIdentityWithGivenTensorProducts via TensorProductOnMorphismsWithGivenTensorProducts",
                    [ [ TensorProductOnMorphismsWithGivenTensorProducts, 1 ] ],
                    
  function( cat, source, alpha, id_b, range )
    
    return TensorProductOnMorphismsWithGivenTensorProducts( cat, source, alpha, id_b, range );
    
end );

##
AddDerivationToCAP( TensorProductOfIdentityAndMorphismWithGivenTensorProducts,
                    "TensorProductOfIdentityAndMorphismWithGivenTensorProducts via TensorProductOnMorphismsWithGivenTensorProducts",
                    [ [ TensorProductOnMorphismsWithGivenTensorProducts, 1 ] ],
                    
  function( cat, source, id_a, beta, range )
    
    return TensorProductOnMorphismsWithGivenTensorProducts( cat, source, id_a, beta, range );
    
end );

##
AddDerivationToCAP( AssociatorLeftToRightWithGivenTensorProducts,
                    "AssociatorLeftToRightWithGivenTensorProducts as the inverse of AssociatorRightToLeftWithGivenTensorProducts",
                    [ [ InverseForMorphisms, 1 ],
                      [ AssociatorRightToLeftWithGivenTensorProducts, 1 ] ],
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return InverseForMorphisms( cat, AssociatorRightToLeftWithGivenTensorProducts( cat,
                      right_associated_object,
                      object_1, object_2, object_3,
                      left_associated_object )
                  );
    
end );

##
AddDerivationToCAP( AssociatorRightToLeftWithGivenTensorProducts,
                    "AssociatorRightToLeftWithGivenTensorProducts as the inverse of AssociatorLeftToRightWithGivenTensorProducts",
                    [ [ InverseForMorphisms, 1 ],
                      [ AssociatorLeftToRightWithGivenTensorProducts, 1 ] ],
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return InverseForMorphisms( cat, AssociatorLeftToRightWithGivenTensorProducts( cat,
                      left_associated_object,
                      object_1, object_2, object_3,
                      right_associated_object )
                  );
    
end );

##
AddDerivationToCAP( LeftUnitorWithGivenTensorProduct,
                    "LeftUnitorWithGivenTensorProduct as the inverse of LeftUnitorInverseWithGivenTensorProduct",
                    [ [ InverseForMorphisms, 1 ],
                      [ LeftUnitorInverseWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object, unit_tensored_object )
    
    return InverseForMorphisms( cat, LeftUnitorInverseWithGivenTensorProduct( cat, object, unit_tensored_object ) );
    
end );

##
AddDerivationToCAP( LeftUnitorInverseWithGivenTensorProduct,
                    "LeftUnitorInverseWithGivenTensorProduct as the inverse of LeftUnitorWithGivenTensorProduct",
                    [ [ InverseForMorphisms, 1 ],
                      [ LeftUnitorWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object, unit_tensored_object )
    
    return InverseForMorphisms( cat, LeftUnitorWithGivenTensorProduct( cat, object, unit_tensored_object ) );
    
end );

##
AddDerivationToCAP( RightUnitorWithGivenTensorProduct,
                    "RightUnitorWithGivenTensorProduct as the inverse of RightUnitorInverseWithGivenTensorProduct",
                    [ [ InverseForMorphisms, 1 ],
                      [ RightUnitorInverseWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object, object_tensored_unit )
    
    return InverseForMorphisms( cat, RightUnitorInverseWithGivenTensorProduct( cat, object, object_tensored_unit ) );
    
end );

##
AddDerivationToCAP( RightUnitorInverseWithGivenTensorProduct,
                    "RightUnitorInverseWithGivenTensorProduct as the inverse of RightUnitorWithGivenTensorProduct",
                    [ [ InverseForMorphisms, 1 ],
                      [ RightUnitorWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object, object_tensored_unit )
    
    return InverseForMorphisms( cat, RightUnitorWithGivenTensorProduct( cat, object, object_tensored_unit ) );
    
end );

##
AddDerivationToCAP( AssociatorLeftToRightWithGivenTensorProducts,
                    "AssociatorLeftToRightWithGivenTensorProducts as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return IdentityMorphism( cat, left_associated_object );
    
end : CategoryFilter := IsStrictMonoidalCategory );

##
AddDerivationToCAP( AssociatorRightToLeftWithGivenTensorProducts,
                    "AssociatorRightToLeft as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return IdentityMorphism( cat, right_associated_object );
    
end : CategoryFilter := IsStrictMonoidalCategory );

##
AddDerivationToCAP( LeftUnitorWithGivenTensorProduct,
                    "LeftUnitorWithGivenTensorProduct as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, unit_tensored_object )
    
    return IdentityMorphism( cat, object );
      
end : CategoryFilter := IsStrictMonoidalCategory );

##
AddDerivationToCAP( LeftUnitorInverseWithGivenTensorProduct,
                    "LeftUnitorInverseWithGivenTensorProduct as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, unit_tensored_object )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictMonoidalCategory );

##
AddDerivationToCAP( RightUnitorWithGivenTensorProduct,
                    "RightUnitorWithGivenTensorProduct as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, object_tensored_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictMonoidalCategory );

##
AddDerivationToCAP( RightUnitorInverseWithGivenTensorProduct,
                    "RightUnitorInverseWithGivenTensorProduct as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, object_tensored_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictMonoidalCategory );
