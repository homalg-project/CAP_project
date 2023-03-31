# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CartesianAssociatorLeftToRightWithGivenDirectProducts,
                    "CartesianAssociatorLeftToRightWithGivenDirectProducts as the inverse of CartesianAssociatorRightToLeftWithGivenDirectProducts",
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianAssociatorRightToLeftWithGivenDirectProducts, 1 ] ],
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return InverseForMorphisms( cat, CartesianAssociatorRightToLeftWithGivenDirectProducts( cat,
                      right_associated_object,
                      object_1, object_2, object_3,
                      left_associated_object )
                  );
    
end );

##
AddDerivationToCAP( CartesianAssociatorRightToLeftWithGivenDirectProducts,
                    "CartesianAssociatorRightToLeftWithGivenDirectProducts as the inverse of CartesianAssociatorLeftToRightWithGivenDirectProducts",
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianAssociatorLeftToRightWithGivenDirectProducts, 1 ] ],
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return InverseForMorphisms( cat, CartesianAssociatorLeftToRightWithGivenDirectProducts( cat,
                      left_associated_object,
                      object_1, object_2, object_3,
                      right_associated_object )
                  );
    
end );

##
AddDerivationToCAP( CartesianLeftUnitorWithGivenDirectProduct,
                    "CartesianLeftUnitorWithGivenDirectProduct as the inverse of CartesianLeftUnitorInverseWithGivenDirectProduct",
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianLeftUnitorInverseWithGivenDirectProduct, 1 ] ],
                    
  function( cat, object, unit_x_object )
    
    return InverseForMorphisms( cat, CartesianLeftUnitorInverseWithGivenDirectProduct( cat, object, unit_x_object ) );
    
end );

##
AddDerivationToCAP( CartesianLeftUnitorInverseWithGivenDirectProduct,
                    "CartesianLeftUnitorInverseWithGivenDirectProduct as the inverse of CartesianLeftUnitorWithGivenDirectProduct",
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianLeftUnitorWithGivenDirectProduct, 1 ] ],
                    
  function( cat, object, unit_x_object )
    
    return InverseForMorphisms( cat, CartesianLeftUnitorWithGivenDirectProduct( cat, object, unit_x_object ) );
    
end );

##
AddDerivationToCAP( CartesianRightUnitorWithGivenDirectProduct,
                    "CartesianRightUnitorWithGivenDirectProduct as the inverse of CartesianRightUnitorInverseWithGivenDirectProduct",
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianRightUnitorInverseWithGivenDirectProduct, 1 ] ],
                    
  function( cat, object, object_x_unit )
    
    return InverseForMorphisms( cat, CartesianRightUnitorInverseWithGivenDirectProduct( cat, object, object_x_unit ) );
    
end );

##
AddDerivationToCAP( CartesianRightUnitorInverseWithGivenDirectProduct,
                    "CartesianRightUnitorInverseWithGivenDirectProduct as the inverse of CartesianRightUnitorWithGivenDirectProduct",
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianRightUnitorWithGivenDirectProduct, 1 ] ],
                    
  function( cat, object, object_x_unit )
    
    return InverseForMorphisms( cat, CartesianRightUnitorWithGivenDirectProduct( cat, object, object_x_unit ) );
    
end );

##
AddDerivationToCAP( CartesianAssociatorLeftToRightWithGivenDirectProducts,
                    "CartesianAssociatorLeftToRightWithGivenDirectProducts as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return IdentityMorphism( cat, left_associated_object );
    
end : CategoryFilter := IsStrictCartesianCategory );

##
AddDerivationToCAP( CartesianAssociatorRightToLeftWithGivenDirectProducts,
                    "CartesianAssociatorRightToLeft as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return IdentityMorphism( cat, right_associated_object );
    
end : CategoryFilter := IsStrictCartesianCategory );

##
AddDerivationToCAP( CartesianLeftUnitorWithGivenDirectProduct,
                    "CartesianLeftUnitorWithGivenDirectProduct as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, unit_x_object )
    
    return IdentityMorphism( cat, object );
      
end : CategoryFilter := IsStrictCartesianCategory );

##
AddDerivationToCAP( CartesianLeftUnitorInverseWithGivenDirectProduct,
                    "CartesianLeftUnitorInverseWithGivenDirectProduct as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, unit_x_object )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCartesianCategory );

##
AddDerivationToCAP( CartesianRightUnitorWithGivenDirectProduct,
                    "CartesianRightUnitorWithGivenDirectProduct as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, object_x_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCartesianCategory );

##
AddDerivationToCAP( CartesianRightUnitorInverseWithGivenDirectProduct,
                    "CartesianRightUnitorInverseWithGivenDirectProduct as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, object_x_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCartesianCategory );
