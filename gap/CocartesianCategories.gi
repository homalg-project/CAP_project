# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CocartesianAssociatorRightToLeft,

  function( cat, object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range := BinaryCoproduct( cat, object_1, BinaryCoproduct( cat, object_2, object_3 ) );
    
    return CocartesianAssociatorRightToLeftWithGivenCoproducts( cat,
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CocartesianAssociatorLeftToRight,

  function( cat, object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range := BinaryCoproduct( cat, object_1, BinaryCoproduct( cat, object_2, object_3 ) );
    
    return CocartesianAssociatorLeftToRightWithGivenCoproducts( cat,
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CocartesianLeftUnitor,

  function( cat, object )
    
    return CocartesianLeftUnitorWithGivenCoproduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CocartesianLeftUnitorInverse,

  function( cat, object )
    
    return CocartesianLeftUnitorInverseWithGivenCoproduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CocartesianRightUnitor,

  function( cat, object )
    
    return CocartesianRightUnitorWithGivenCoproduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CocartesianRightUnitorInverse,

  function( cat, object )
    
    return CocartesianRightUnitorInverseWithGivenCoproduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );
