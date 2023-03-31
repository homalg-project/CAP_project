# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CartesianAssociatorLeftToRightWithGivenDirectProducts,
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianAssociatorRightToLeftWithGivenDirectProducts, 1 ] ],
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return InverseForMorphisms( cat, CartesianAssociatorRightToLeftWithGivenDirectProducts( cat,
                      right_associated_object,
                      object_1, object_2, object_3,
                      left_associated_object )
                  );
    
end : Description := "CartesianAssociatorLeftToRightWithGivenDirectProducts as the inverse of CartesianAssociatorRightToLeftWithGivenDirectProducts" );

##
AddDerivationToCAP( CartesianAssociatorRightToLeftWithGivenDirectProducts,
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianAssociatorLeftToRightWithGivenDirectProducts, 1 ] ],
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return InverseForMorphisms( cat, CartesianAssociatorLeftToRightWithGivenDirectProducts( cat,
                      left_associated_object,
                      object_1, object_2, object_3,
                      right_associated_object )
                  );
    
end : Description := "CartesianAssociatorRightToLeftWithGivenDirectProducts as the inverse of CartesianAssociatorLeftToRightWithGivenDirectProducts" );

##
AddDerivationToCAP( CartesianLeftUnitorWithGivenDirectProduct,
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianLeftUnitorInverseWithGivenDirectProduct, 1 ] ],
                    
  function( cat, object, unit_x_object )
    
    return InverseForMorphisms( cat, CartesianLeftUnitorInverseWithGivenDirectProduct( cat, object, unit_x_object ) );
    
end : Description := "CartesianLeftUnitorWithGivenDirectProduct as the inverse of CartesianLeftUnitorInverseWithGivenDirectProduct" );

##
AddDerivationToCAP( CartesianLeftUnitorInverseWithGivenDirectProduct,
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianLeftUnitorWithGivenDirectProduct, 1 ] ],
                    
  function( cat, object, unit_x_object )
    
    return InverseForMorphisms( cat, CartesianLeftUnitorWithGivenDirectProduct( cat, object, unit_x_object ) );
    
end : Description := "CartesianLeftUnitorInverseWithGivenDirectProduct as the inverse of CartesianLeftUnitorWithGivenDirectProduct" );

##
AddDerivationToCAP( CartesianRightUnitorWithGivenDirectProduct,
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianRightUnitorInverseWithGivenDirectProduct, 1 ] ],
                    
  function( cat, object, object_x_unit )
    
    return InverseForMorphisms( cat, CartesianRightUnitorInverseWithGivenDirectProduct( cat, object, object_x_unit ) );
    
end : Description := "CartesianRightUnitorWithGivenDirectProduct as the inverse of CartesianRightUnitorInverseWithGivenDirectProduct" );

##
AddDerivationToCAP( CartesianRightUnitorInverseWithGivenDirectProduct,
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianRightUnitorWithGivenDirectProduct, 1 ] ],
                    
  function( cat, object, object_x_unit )
    
    return InverseForMorphisms( cat, CartesianRightUnitorWithGivenDirectProduct( cat, object, object_x_unit ) );
    
end : Description := "CartesianRightUnitorInverseWithGivenDirectProduct as the inverse of CartesianRightUnitorWithGivenDirectProduct" );

##
AddDerivationToCAP( CartesianAssociatorLeftToRightWithGivenDirectProducts,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return IdentityMorphism( cat, left_associated_object );
    
end : CategoryFilter := IsStrictCartesianCategory,
      Description := "CartesianAssociatorLeftToRightWithGivenDirectProducts as the identity morphism" );

##
AddDerivationToCAP( CartesianAssociatorRightToLeftWithGivenDirectProducts,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return IdentityMorphism( cat, right_associated_object );
    
end : CategoryFilter := IsStrictCartesianCategory,
      Description := "CartesianAssociatorRightToLeft as the identity morphism" );

##
AddDerivationToCAP( CartesianLeftUnitorWithGivenDirectProduct,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, unit_x_object )
    
    return IdentityMorphism( cat, object );
      
end : CategoryFilter := IsStrictCartesianCategory,
      Description := "CartesianLeftUnitorWithGivenDirectProduct as the identity morphism" );

##
AddDerivationToCAP( CartesianLeftUnitorInverseWithGivenDirectProduct,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, unit_x_object )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCartesianCategory,
      Description := "CartesianLeftUnitorInverseWithGivenDirectProduct as the identity morphism" );

##
AddDerivationToCAP( CartesianRightUnitorWithGivenDirectProduct,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, object_x_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCartesianCategory,
      Description := "CartesianRightUnitorWithGivenDirectProduct as the identity morphism" );

##
AddDerivationToCAP( CartesianRightUnitorInverseWithGivenDirectProduct,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, object_x_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCartesianCategory,
      Description := "CartesianRightUnitorInverseWithGivenDirectProduct as the identity morphism" );
