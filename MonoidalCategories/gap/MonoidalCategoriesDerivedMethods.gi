# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( AssociatorLeftToRightWithGivenTensorProducts,
                    [ [ InverseForMorphisms, 1 ],
                      [ AssociatorRightToLeftWithGivenTensorProducts, 1 ] ],
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return InverseForMorphisms( cat, AssociatorRightToLeftWithGivenTensorProducts( cat,
                      right_associated_object,
                      object_1, object_2, object_3,
                      left_associated_object )
                  );
    
end : Description := "AssociatorLeftToRightWithGivenTensorProducts as the inverse of AssociatorRightToLeftWithGivenTensorProducts" );

##
AddDerivationToCAP( AssociatorRightToLeftWithGivenTensorProducts,
                    [ [ InverseForMorphisms, 1 ],
                      [ AssociatorLeftToRightWithGivenTensorProducts, 1 ] ],
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return InverseForMorphisms( cat, AssociatorLeftToRightWithGivenTensorProducts( cat,
                      left_associated_object,
                      object_1, object_2, object_3,
                      right_associated_object )
                  );
    
end : Description := "AssociatorRightToLeftWithGivenTensorProducts as the inverse of AssociatorLeftToRightWithGivenTensorProducts" );

##
AddDerivationToCAP( LeftUnitorWithGivenTensorProduct,
                    [ [ InverseForMorphisms, 1 ],
                      [ LeftUnitorInverseWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object, unit_tensored_object )
    
    return InverseForMorphisms( cat, LeftUnitorInverseWithGivenTensorProduct( cat, object, unit_tensored_object ) );
    
end : Description := "LeftUnitorWithGivenTensorProduct as the inverse of LeftUnitorInverseWithGivenTensorProduct" );

##
AddDerivationToCAP( LeftUnitorInverseWithGivenTensorProduct,
                    [ [ InverseForMorphisms, 1 ],
                      [ LeftUnitorWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object, unit_tensored_object )
    
    return InverseForMorphisms( cat, LeftUnitorWithGivenTensorProduct( cat, object, unit_tensored_object ) );
    
end : Description := "LeftUnitorInverseWithGivenTensorProduct as the inverse of LeftUnitorWithGivenTensorProduct" );

##
AddDerivationToCAP( RightUnitorWithGivenTensorProduct,
                    [ [ InverseForMorphisms, 1 ],
                      [ RightUnitorInverseWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object, object_tensored_unit )
    
    return InverseForMorphisms( cat, RightUnitorInverseWithGivenTensorProduct( cat, object, object_tensored_unit ) );
    
end : Description := "RightUnitorWithGivenTensorProduct as the inverse of RightUnitorInverseWithGivenTensorProduct" );

##
AddDerivationToCAP( RightUnitorInverseWithGivenTensorProduct,
                    [ [ InverseForMorphisms, 1 ],
                      [ RightUnitorWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object, object_tensored_unit )
    
    return InverseForMorphisms( cat, RightUnitorWithGivenTensorProduct( cat, object, object_tensored_unit ) );
    
end : Description := "RightUnitorInverseWithGivenTensorProduct as the inverse of RightUnitorWithGivenTensorProduct" );

##
AddDerivationToCAP( AssociatorLeftToRightWithGivenTensorProducts,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return IdentityMorphism( cat, left_associated_object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "AssociatorLeftToRightWithGivenTensorProducts as the identity morphism" );

##
AddDerivationToCAP( AssociatorRightToLeftWithGivenTensorProducts,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return IdentityMorphism( cat, right_associated_object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "AssociatorRightToLeft as the identity morphism" );

##
AddDerivationToCAP( LeftUnitorWithGivenTensorProduct,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, unit_tensored_object )
    
    return IdentityMorphism( cat, object );
      
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "LeftUnitorWithGivenTensorProduct as the identity morphism" );

##
AddDerivationToCAP( LeftUnitorInverseWithGivenTensorProduct,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, unit_tensored_object )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "LeftUnitorInverseWithGivenTensorProduct as the identity morphism" );

##
AddDerivationToCAP( RightUnitorWithGivenTensorProduct,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, object_tensored_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "RightUnitorWithGivenTensorProduct as the identity morphism" );

##
AddDerivationToCAP( RightUnitorInverseWithGivenTensorProduct,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, object_tensored_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "RightUnitorInverseWithGivenTensorProduct as the identity morphism" );
