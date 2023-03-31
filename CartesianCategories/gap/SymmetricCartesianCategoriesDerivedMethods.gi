# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CartesianBraidingWithGivenDirectProducts,
                    "CartesianBraidingWithGivenDirectProducts using CartesianBraidingInverseWithGivenDirectProducts",
                    [ [ CartesianBraidingInverseWithGivenDirectProducts, 1 ] ],
                    
  function( cat, object_1_x_object_2, object_1, object_2, object_2_x_object_1 )
    
    return CartesianBraidingInverseWithGivenDirectProducts( cat,
                            object_1_x_object_2,
                            object_2, object_1,
                            object_2_x_object_1 );
    
end : CategoryFilter := IsCartesianCategory );

##
AddDerivationToCAP( CartesianBraidingInverseWithGivenDirectProducts,
                    "CartesianBraidingInverseWithGivenDirectProducts using CartesianBraidingWithGivenDirectProducts",
                    [ [ CartesianBraidingWithGivenDirectProducts, 1 ] ],
                    
  function( cat, object_2_x_object_1, object_1, object_2, object_1_x_object_2 )
    
    return CartesianBraidingWithGivenDirectProducts( cat,
                     object_2_x_object_1,
                     object_2, object_1,
                     object_1_x_object_2 );
    
end : CategoryFilter := IsCartesianCategory );
