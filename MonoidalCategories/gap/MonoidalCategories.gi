# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallTrueMethod( IsMonoidalCategory, IsStrictMonoidalCategory );

##
AddDerivationToCAP( AssociatorRightToLeft,

  function( cat, object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, object_1, TensorProductOnObjects( cat, object_2, object_3 ) );
    
    return AssociatorRightToLeftWithGivenTensorProducts( cat,
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( AssociatorLeftToRight,

  function( cat, object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, object_1, TensorProductOnObjects( cat, object_2, object_3 ) );
    
    return AssociatorLeftToRightWithGivenTensorProducts( cat,
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( LeftUnitor,

  function( cat, object )
    
    return LeftUnitorWithGivenTensorProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( LeftUnitorInverse,

  function( cat, object )
    
    return LeftUnitorInverseWithGivenTensorProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightUnitor,

  function( cat, object )
    
    return RightUnitorWithGivenTensorProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightUnitorInverse,

  function( cat, object )
    
    return RightUnitorInverseWithGivenTensorProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );
