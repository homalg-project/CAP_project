# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CocartesianBraidingInverseWithGivenCoproducts,
                    "CocartesianBraidingInverseWithGivenCoproducts as the inverse of the braiding",
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianBraiding, 1 ] ],
                    
  function( cat, object_2_u_object_1, object_1, object_2, object_1_u_object_2 )
    ##TODO: Use CocartesianBraidingWithGiven
    return InverseForMorphisms( cat, CocartesianBraiding( cat, object_1, object_2 ) );
    
end : CategoryFilter := IsCocartesianCategory );

##
AddDerivationToCAP( CocartesianBraidingWithGivenCoproducts,
                    "CocartesianBraidingWithGivenCoproducts as the inverse of CocartesianBraidingInverse",
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianBraidingInverse, 1 ] ],
                    
  function( cat, object_1_u_object_2, object_1, object_2, object_2_u_object_1 )
    ##TODO: Use CocartesianBraidingInverseWithGiven
    return InverseForMorphisms( cat, CocartesianBraidingInverse( cat, object_1, object_2 ) );
    
end : CategoryFilter := IsCocartesianCategory );
