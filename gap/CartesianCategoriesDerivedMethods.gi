#
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( CartesianAssociatorLeftToRightWithGivenDirectProducts,
                    
  function( left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return Inverse( CartesianAssociatorRightToLeftWithGivenDirectProducts(
                      right_associated_object,
                      object_1, object_2, object_3,
                      left_associated_object )
                  );
    
end : Description := "CartesianAssociatorLeftToRightWithGivenDirectProducts as the inverse of CartesianAssociatorRightToLeftWithGivenDirectProducts" );

##
AddDerivationToCAP( CartesianAssociatorRightToLeftWithGivenDirectProducts,
                    
  function( right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return Inverse( CartesianAssociatorLeftToRightWithGivenDirectProducts(
                      left_associated_object,
                      object_1, object_2, object_3,
                      right_associated_object )
                  );
    
end : Description := "CartesianAssociatorRightToLeftWithGivenDirectProducts as the inverse of CartesianAssociatorLeftToRightWithGivenDirectProducts" );

##
AddDerivationToCAP( CartesianLeftUnitorWithGivenDirectProduct,
                  
  function( object, unit_x_object )
    
    return Inverse( CartesianLeftUnitorInverseWithGivenDirectProduct( object, unit_x_object ) );
    
end : Description := "CartesianLeftUnitorWithGivenDirectProduct as the inverse of CartesianLeftUnitorInverseWithGivenDirectProduct" );

##
AddDerivationToCAP( CartesianLeftUnitorInverseWithGivenDirectProduct,
                  
  function( object, unit_x_object )
    
    return Inverse( CartesianLeftUnitorWithGivenDirectProduct( object, unit_x_object ) );
    
end : Description := "CartesianLeftUnitorInverseWithGivenDirectProduct as the inverse of CartesianLeftUnitorWithGivenDirectProduct" );

##
AddDerivationToCAP( CartesianRightUnitorWithGivenDirectProduct,
                  
  function( object, object_x_unit )
    
    return Inverse( CartesianRightUnitorInverseWithGivenDirectProduct( object, object_x_unit ) );
    
end : Description := "CartesianRightUnitorWithGivenDirectProduct as the inverse of CartesianRightUnitorInverseWithGivenDirectProduct" );

##
AddDerivationToCAP( CartesianRightUnitorInverseWithGivenDirectProduct,
                  
  function( object, object_x_unit )
    
    return Inverse( CartesianRightUnitorWithGivenDirectProduct( object, object_x_unit ) );
    
end : Description := "CartesianRightUnitorInverseWithGivenDirectProduct as the inverse of CartesianRightUnitorWithGivenDirectProduct" );

##
AddDerivationToCAP( CartesianAssociatorLeftToRightWithGivenDirectProducts,
                    
  function( left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return IdentityMorphism( left_associated_object );
    
end : CategoryFilter := IsStrictCartesianCategory,
      Description := "CartesianAssociatorLeftToRightWithGivenDirectProducts as the identity morphism" );

##
AddDerivationToCAP( CartesianAssociatorRightToLeftWithGivenDirectProducts,
                    
  function( right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return IdentityMorphism( right_associated_object );
    
end : CategoryFilter := IsStrictCartesianCategory,
      Description := "CartesianAssociatorRightToLeft as the identity morphism" );

##
AddDerivationToCAP( CartesianLeftUnitorWithGivenDirectProduct,
                    
  function( object, unit_x_object )
    
    return IdentityMorphism( object );
      
end : CategoryFilter := IsStrictCartesianCategory,
      Description := "CartesianLeftUnitorWithGivenDirectProduct as the identity morphism" );

##
AddDerivationToCAP( CartesianLeftUnitorInverseWithGivenDirectProduct,
                  
  function( object, unit_x_object )
    
    return IdentityMorphism( object );
    
end : CategoryFilter := IsStrictCartesianCategory,
      Description := "CartesianLeftUnitorInverseWithGivenDirectProduct as the identity morphism" );

##
AddDerivationToCAP( CartesianRightUnitorWithGivenDirectProduct,
                    
  function( object, object_x_unit )
    
    return IdentityMorphism( object );
    
end : CategoryFilter := IsStrictCartesianCategory,
      Description := "CartesianRightUnitorWithGivenDirectProduct as the identity morphism" );

##
AddDerivationToCAP( CartesianRightUnitorInverseWithGivenDirectProduct,
                    
  function( object, object_x_unit )
    
    return IdentityMorphism( object );
    
end : CategoryFilter := IsStrictCartesianCategory,
      Description := "CartesianRightUnitorInverseWithGivenDirectProduct as the identity morphism" );
