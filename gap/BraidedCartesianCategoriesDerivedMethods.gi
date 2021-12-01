# THIS FILE WAS AUTOMATICALLY GENERATED
# FROM MonoidalCategories v2021.12-01
# USING CategoryConstructor v2021.12-01

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( CartesianBraidingInverseWithGivenDirectProducts,
                  
  function( cat, object_2_x_object_1, object_1, object_2, object_1_x_object_2 )
    ##TODO: Use CartesianBraidingWithGiven
    return InverseForMorphisms( cat, CartesianBraiding( cat, object_1, object_2 ) );
    
end : CategoryFilter := IsCartesianCategory,
      Description := "CartesianBraidingInverseWithGivenDirectProducts as the inverse of the braiding" );

##
AddDerivationToCAP( CartesianBraidingWithGivenDirectProducts,
                  
  function( cat, object_1_x_object_2, object_1, object_2, object_2_x_object_1 )
    ##TODO: Use CartesianBraidingInverseWithGiven
    return InverseForMorphisms( cat, CartesianBraidingInverse( cat, object_1, object_2 ) );
    
end : CategoryFilter := IsCartesianCategory,
      Description := "CartesianBraidingWithGivenDirectProducts as the inverse of CartesianBraidingInverse" );
