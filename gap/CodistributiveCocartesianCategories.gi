# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( LeftCocartesianCodistributivityExpanding,

  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := BinaryCoproduct( cat, object, DirectProduct( cat, summands_list ) );
    
    return LeftCocartesianCodistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( LeftCocartesianCodistributivityFactoring,

  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := BinaryCoproduct( cat, object, DirectProduct( cat, summands_list ) );
    
    return LeftCocartesianCodistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightCocartesianCodistributivityExpanding,

  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := BinaryCoproduct( cat, DirectProduct( cat, summands_list ), object );
    
    return RightCocartesianCodistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightCocartesianCodistributivityFactoring,

  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := BinaryCoproduct( cat, DirectProduct( cat, summands_list ), object );
    
    return RightCocartesianCodistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );
