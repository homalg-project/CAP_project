##
AddDerivationToCAP( LeftDistributivityExpanding,

  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( object, DirectSum( summands_list ) );
    
    return LeftDistributivityExpandingWithGivenObjects(
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
    
    source_and_range := TensorProductOnObjects( object, DirectSum( summands_list ) );
    
    return LeftDistributivityFactoringWithGivenObjects(
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
    
    source_and_range := TensorProductOnObjects( DirectSum( summands_list ), object );
    
    return RightDistributivityExpandingWithGivenObjects(
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
    
    source_and_range := TensorProductOnObjects( DirectSum( summands_list ), object );
    
    return RightDistributivityFactoringWithGivenObjects(
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );
