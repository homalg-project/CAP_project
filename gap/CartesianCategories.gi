# THIS FILE WAS AUTOMATICALLY GENERATED
# FROM MonoidalCategories v2021.12-05
# USING CategoryConstructor v2021.12-04

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( CartesianAssociatorRightToLeft,

  function( cat, object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range := DirectProduct( object_1, DirectProduct( object_2, object_3 ) );
    
    return CartesianAssociatorRightToLeftWithGivenDirectProducts( cat,
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CartesianAssociatorLeftToRight,

  function( cat, object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range := DirectProduct( object_1, DirectProduct( object_2, object_3 ) );
    
    return CartesianAssociatorLeftToRightWithGivenDirectProducts( cat,
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CartesianLeftUnitor,

  function( cat, object )
    
    return CartesianLeftUnitorWithGivenDirectProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CartesianLeftUnitorInverse,

  function( cat, object )
    
    return CartesianLeftUnitorInverseWithGivenDirectProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CartesianRightUnitor,

  function( cat, object )
    
    return CartesianRightUnitorWithGivenDirectProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CartesianRightUnitorInverse,

  function( cat, object )
    
    return CartesianRightUnitorInverseWithGivenDirectProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );
