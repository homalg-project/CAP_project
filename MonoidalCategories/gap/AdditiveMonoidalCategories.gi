# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( LeftDistributivityExpanding,

  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, object, DirectSum( cat, summands_list ) );
    
    return LeftDistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( LeftDistributivityFactoring,

  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, object, DirectSum( cat, summands_list ) );
    
    return LeftDistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightDistributivityExpanding,

  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, DirectSum( cat, summands_list ), object );
    
    return RightDistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightDistributivityFactoring,

  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, DirectSum( cat, summands_list ), object );
    
    return RightDistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );
