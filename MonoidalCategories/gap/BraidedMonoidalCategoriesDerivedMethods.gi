# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( BraidingInverseWithGivenTensorProducts,
                    "BraidingInverseWithGivenTensorProducts as the inverse of the braiding",
                    [ [ InverseForMorphisms, 1 ],
                      [ BraidingWithGivenTensorProducts, 1 ] ],
                    
  function( cat, object_2_tensored_object_1, object_1, object_2, object_1_tensored_object_2 )
    
    return InverseForMorphisms( cat, BraidingWithGivenTensorProducts( cat, object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 ) );
    
end : CategoryFilter := IsBraidedMonoidalCategory );

##
AddDerivationToCAP( BraidingWithGivenTensorProducts,
                    "BraidingWithGivenTensorProducts as the inverse of BraidingInverse",
                    [ [ InverseForMorphisms, 1 ],
                      [ BraidingInverseWithGivenTensorProducts, 1 ] ],
                    
  function( cat, object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
    
    return InverseForMorphisms( cat, BraidingInverseWithGivenTensorProducts( cat, object_2_tensored_object_1, object_1, object_2, object_1_tensored_object_2 ) );
    
end : CategoryFilter := IsBraidedMonoidalCategory );

