# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( BraidingWithGivenTensorProducts,
                    "BraidingWithGivenTensorProducts using BraidingInverseWithGivenTensorProducts",
                    [ [ BraidingInverseWithGivenTensorProducts, 1 ] ],
                    
  function( cat, object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
    
    return BraidingInverseWithGivenTensorProducts( cat,
                            object_1_tensored_object_2,
                            object_2, object_1,
                            object_2_tensored_object_1 );
    
end : CategoryFilter := IsSymmetricMonoidalCategory );

##
AddDerivationToCAP( BraidingInverseWithGivenTensorProducts,
                    "BraidingInverseWithGivenTensorProducts using BraidingWithGivenTensorProducts",
                    [ [ BraidingWithGivenTensorProducts, 1 ] ],
                    
  function( cat, object_2_tensored_object_1, object_1, object_2, object_1_tensored_object_2 )
    
    return BraidingWithGivenTensorProducts( cat,
                     object_2_tensored_object_1,
                     object_2, object_1,
                     object_1_tensored_object_2 );
    
end : CategoryFilter := IsSymmetricMonoidalCategory );
