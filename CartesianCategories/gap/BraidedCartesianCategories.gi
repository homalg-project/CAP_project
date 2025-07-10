# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CartesianBraiding,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ DirectProduct, 1 ],
                      [ CartesianBraidingWithGivenDirectProducts, 1 ] ],
                    
  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range := BinaryDirectProduct( cat, object_1, object_2 );
    
    return CartesianBraidingWithGivenDirectProducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( CartesianBraidingInverse,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ DirectProduct, 1 ],
                      [ CartesianBraidingInverseWithGivenDirectProducts, 1 ] ],
                    
  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range := BinaryDirectProduct( cat, object_1, object_2 );
    
    return CartesianBraidingInverseWithGivenDirectProducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end : CategoryFilter := IsSkeletalCategory );
