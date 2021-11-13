# THIS FILE WAS AUTOMATICALLY GENERATED FROM MonoidalCategories v2021.11-02

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( LeftCocartesianDistributivityExpanding,

  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := Coproduct( cat, object, DirectProduct( cat, summands_list ) );
    
    return LeftCocartesianDistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( LeftCocartesianDistributivityFactoring,

  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := Coproduct( cat, object, DirectProduct( cat, summands_list ) );
    
    return LeftCocartesianDistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightCocartesianDistributivityExpanding,

  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := Coproduct( cat, DirectProduct( cat, summands_list ), object );
    
    return RightCocartesianDistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightCocartesianDistributivityFactoring,

  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := Coproduct( cat, DirectProduct( cat, summands_list ), object );
    
    return RightCocartesianDistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );
