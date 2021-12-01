# THIS FILE WAS AUTOMATICALLY GENERATED
# FROM MonoidalCategories v2021.12-01
# USING CategoryConstructor v2021.12-01

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( LeftCartesianDistributivityExpanding,

  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := DirectProduct( object, Coproduct( cat, summands_list ) );
    
    return LeftCartesianDistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( LeftCartesianDistributivityFactoring,

  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := DirectProduct( object, Coproduct( cat, summands_list ) );
    
    return LeftCartesianDistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightCartesianDistributivityExpanding,

  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := DirectProduct( Coproduct( cat, summands_list ), object );
    
    return RightCartesianDistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightCartesianDistributivityFactoring,

  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := DirectProduct( Coproduct( cat, summands_list ), object );
    
    return RightCartesianDistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );
