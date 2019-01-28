##
AddDerivationToCAP( BraidingInverseWithGivenTensorProducts,
                  
  function( object_2_tensored_object_1, object_1, object_2, object_1_tensored_object_2 )
    ##TODO: Use BraidingWithGiven
    return Inverse( Braiding( object_1, object_2 ) );
    
end : CategoryFilter := IsBraidedMonoidalCategory,
      Description := "BraidingInverseWithGivenTensorProducts as the inverse of the braiding" );

##
AddDerivationToCAP( BraidingWithGivenTensorProducts,
                  
  function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
    ##TODO: Use BraidingInverseWithGiven
    return Inverse( BraidingInverse( object_1, object_2 ) );
    
end : CategoryFilter := IsBraidedMonoidalCategory,
      Description := "BraidingWithGivenTensorProducts as the inverse of BraidingInverse" );
