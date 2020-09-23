#
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( CartesianBraidingInverseWithGivenDirectProducts,
                  
  function( object_2_x_object_1, object_1, object_2, object_1_x_object_2 )
    ##TODO: Use CartesianBraidingWithGiven
    return Inverse( CartesianBraiding( object_1, object_2 ) );
    
end : CategoryFilter := IsCartesianCategory,
      Description := "CartesianBraidingInverseWithGivenDirectProducts as the inverse of the braiding" );

##
AddDerivationToCAP( CartesianBraidingWithGivenDirectProducts,
                  
  function( object_1_x_object_2, object_1, object_2, object_2_x_object_1 )
    ##TODO: Use CartesianBraidingInverseWithGiven
    return Inverse( CartesianBraidingInverse( object_1, object_2 ) );
    
end : CategoryFilter := IsCartesianCategory,
      Description := "CartesianBraidingWithGivenDirectProducts as the inverse of CartesianBraidingInverse" );
