# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CocartesianBraiding,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ Coproduct, 1 ],
                      [ CocartesianBraidingWithGivenCoproducts, 1 ] ],
                    
  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range := BinaryCoproduct( cat, object_1, object_2 );
    
    return CocartesianBraidingWithGivenCoproducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( CocartesianBraidingInverse,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ Coproduct, 1 ],
                      [ CocartesianBraidingInverseWithGivenCoproducts, 1 ] ],
                    
  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range := BinaryCoproduct( cat, object_1, object_2 );
    
    return CocartesianBraidingInverseWithGivenCoproducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end : CategoryFilter := IsSkeletalCategory );
