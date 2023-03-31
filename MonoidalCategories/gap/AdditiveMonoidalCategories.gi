# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( LeftDistributivityExpanding,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ TensorProductOnObjects, 1 ],
                      [ DirectSum, 1 ],
                      [ LeftDistributivityExpandingWithGivenObjects, 1 ] ],
                    
  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, object, DirectSum( cat, summands_list ) );
    
    return LeftDistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( LeftDistributivityFactoring,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ TensorProductOnObjects, 1 ],
                      [ DirectSum, 1 ],
                      [ LeftDistributivityFactoringWithGivenObjects, 1 ] ],
                    
  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, object, DirectSum( cat, summands_list ) );
    
    return LeftDistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( RightDistributivityExpanding,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ TensorProductOnObjects, 1 ],
                      [ DirectSum, 1 ],
                      [ RightDistributivityExpandingWithGivenObjects, 1 ] ],
                    
  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, DirectSum( cat, summands_list ), object );
    
    return RightDistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( RightDistributivityFactoring,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ TensorProductOnObjects, 1 ],
                      [ DirectSum, 1 ],
                      [ RightDistributivityFactoringWithGivenObjects, 1 ] ],
                    
  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, DirectSum( cat, summands_list ), object );
    
    return RightDistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory );
