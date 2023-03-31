# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( BraidingInverseWithGivenTensorProducts,
                    "BraidingInverseWithGivenTensorProducts as the inverse of the braiding",
                    [ [ InverseForMorphisms, 1 ],
                      [ Braiding, 1 ] ],
                    
  function( cat, object_2_tensored_object_1, object_1, object_2, object_1_tensored_object_2 )
    ##TODO: Use BraidingWithGiven
    return InverseForMorphisms( cat, Braiding( cat, object_1, object_2 ) );
    
end : CategoryFilter := IsBraidedMonoidalCategory );

##
AddDerivationToCAP( BraidingWithGivenTensorProducts,
                    "BraidingWithGivenTensorProducts as the inverse of BraidingInverse",
                    [ [ InverseForMorphisms, 1 ],
                      [ BraidingInverse, 1 ] ],
                    
  function( cat, object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
    ##TODO: Use BraidingInverseWithGiven
    return InverseForMorphisms( cat, BraidingInverse( cat, object_1, object_2 ) );
    
end : CategoryFilter := IsBraidedMonoidalCategory );
