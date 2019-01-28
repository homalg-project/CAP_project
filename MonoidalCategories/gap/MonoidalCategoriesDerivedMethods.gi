##
AddDerivationToCAP( AssociatorLeftToRightWithGivenTensorProducts,
                    
  function( left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return Inverse( AssociatorRightToLeftWithGivenTensorProducts(
                      right_associated_object,
                      object_1, object_2, object_3,
                      left_associated_object )
                  );
    
end : Description := "AssociatorLeftToRightWithGivenTensorProducts as the inverse of AssociatorRightToLeftWithGivenTensorProducts" );

##
AddDerivationToCAP( AssociatorRightToLeftWithGivenTensorProducts,
                    
  function( right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return Inverse( AssociatorLeftToRightWithGivenTensorProducts(
                      left_associated_object,
                      object_1, object_2, object_3,
                      right_associated_object )
                  );
    
end : Description := "AssociatorRightToLeftWithGivenTensorProducts as the inverse of AssociatorLeftToRightWithGivenTensorProducts" );

##
AddDerivationToCAP( LeftUnitorWithGivenTensorProduct,
                  
  function( object, unit_tensored_object )
    
    return Inverse( LeftUnitorInverseWithGivenTensorProduct( object, unit_tensored_object ) );
    
end : Description := "LeftUnitorWithGivenTensorProduct as the inverse of LeftUnitorInverseWithGivenTensorProduct" );

##
AddDerivationToCAP( LeftUnitorInverseWithGivenTensorProduct,
                  
  function( object, unit_tensored_object )
    
    return Inverse( LeftUnitorWithGivenTensorProduct( object, unit_tensored_object ) );
    
end : Description := "LeftUnitorInverseWithGivenTensorProduct as the inverse of LeftUnitorWithGivenTensorProduct" );

##
AddDerivationToCAP( RightUnitorWithGivenTensorProduct,
                  
  function( object, object_tensored_unit )
    
    return Inverse( RightUnitorInverseWithGivenTensorProduct( object, object_tensored_unit ) );
    
end : Description := "RightUnitorWithGivenTensorProduct as the inverse of RightUnitorInverseWithGivenTensorProduct" );

##
AddDerivationToCAP( RightUnitorInverseWithGivenTensorProduct,
                  
  function( object, object_tensored_unit )
    
    return Inverse( RightUnitorWithGivenTensorProduct( object, object_tensored_unit ) );
    
end : Description := "RightUnitorInverseWithGivenTensorProduct as the inverse of RightUnitorWithGivenTensorProduct" );

##
AddDerivationToCAP( AssociatorLeftToRightWithGivenTensorProducts,
                    
  function( left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return IdentityMorphism( left_associated_object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "AssociatorLeftToRightWithGivenTensorProducts as the identity morphism" );

##
AddDerivationToCAP( AssociatorRightToLeftWithGivenTensorProducts,
                    
  function( right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return IdentityMorphism( right_associated_object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "AssociatorRightToLeft as the identity morphism" );

##
AddDerivationToCAP( LeftUnitorWithGivenTensorProduct,
                    
  function( object, unit_tensored_object )
    
    return IdentityMorphism( object );
      
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "LeftUnitorWithGivenTensorProduct as the identity morphism" );

##
AddDerivationToCAP( LeftUnitorInverseWithGivenTensorProduct,
                  
  function( object, unit_tensored_object )
    
    return IdentityMorphism( object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "LeftUnitorInverseWithGivenTensorProduct as the identity morphism" );

##
AddDerivationToCAP( RightUnitorWithGivenTensorProduct,
                    
  function( object, object_tensored_unit )
    
    return IdentityMorphism( object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "RightUnitorWithGivenTensorProduct as the identity morphism" );

##
AddDerivationToCAP( RightUnitorInverseWithGivenTensorProduct,
                    
  function( object, object_tensored_unit )
    
    return IdentityMorphism( object );
    
end : CategoryFilter := IsStrictMonoidalCategory,
      Description := "RightUnitorInverseWithGivenTensorProduct as the identity morphism" );
