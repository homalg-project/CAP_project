# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CartesianBraidingInverseWithGivenDirectProducts,
                    "CartesianBraidingInverseWithGivenDirectProducts as the inverse of the braiding",
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianBraidingWithGivenDirectProducts, 1 ] ],
                    
  function( cat, object_2_x_object_1, object_1, object_2, object_1_x_object_2 )
    
    return InverseForMorphisms( cat, CartesianBraidingWithGivenDirectProducts( cat, object_1_x_object_2, object_1, object_2, object_2_x_object_1 ) );
    
end : CategoryFilter := IsCartesianCategory );

##
AddDerivationToCAP( CartesianBraidingWithGivenDirectProducts,
                    "CartesianBraidingWithGivenDirectProducts as the inverse of CartesianBraidingInverse",
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianBraidingInverseWithGivenDirectProducts, 1 ] ],
                    
  function( cat, object_1_x_object_2, object_1, object_2, object_2_x_object_1 )
    
    return InverseForMorphisms( cat, CartesianBraidingInverseWithGivenDirectProducts( cat, object_2_x_object_1, object_1, object_2, object_1_x_object_2 ) );
    
end : CategoryFilter := IsCartesianCategory );

