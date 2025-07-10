# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( Braiding,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ TensorProductOnObjects, 1 ],
                      [ BraidingWithGivenTensorProducts, 1 ] ],
                    
  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, object_1, object_2 );
    
    return BraidingWithGivenTensorProducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( BraidingInverse,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ TensorProductOnObjects, 1 ],
                      [ BraidingInverseWithGivenTensorProducts, 1 ] ],
                    
  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, object_1, object_2 );
    
    return BraidingInverseWithGivenTensorProducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end : CategoryFilter := IsSkeletalCategory );
