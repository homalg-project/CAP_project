# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

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
