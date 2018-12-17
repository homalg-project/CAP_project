##
AddDerivationToCAP( CartesianBraidingWithGivenDirectProducts,
                  
  function( object_1_x_object_2, object_1, object_2, object_2_x_object_1 )
    
    return CartesianBraidingInverseWithGivenDirectProducts(
                            object_1_x_object_2,
                            object_2, object_1,
                            object_2_x_object_1 );
    
end : CategoryFilter := IsCartesianCategory,
      Description := "CartesianBraidingWithGivenDirectProducts using CartesianBraidingInverseWithGivenDirectProducts" );

##
AddDerivationToCAP( CartesianBraidingInverseWithGivenDirectProducts,
                  
  function( object_2_x_object_1, object_1, object_2, object_1_x_object_2 )
    
    return CartesianBraidingWithGivenDirectProducts(
                     object_2_x_object_1,
                     object_2, object_1,
                     object_1_x_object_2 );
    
end : CategoryFilter := IsCartesianCategory,
      Description := "CartesianBraidingInverseWithGivenDirectProducts using CartesianBraidingWithGivenDirectProducts" );
