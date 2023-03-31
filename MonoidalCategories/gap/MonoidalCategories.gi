# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallTrueMethod( IsMonoidalCategory, IsStrictMonoidalCategory );

##
AddDerivationToCAP( AssociatorRightToLeft,
                    [ [ TensorProductOnObjects, 2 ],
                      [ AssociatorRightToLeftWithGivenTensorProducts, 1 ] ],
                    
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
                    [ [ TensorProductOnObjects, 2 ],
                      [ AssociatorLeftToRightWithGivenTensorProducts, 1 ] ],
                    
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
                    [ [ LeftUnitorWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object )
    
    return LeftUnitorWithGivenTensorProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( LeftUnitorInverse,
                    [ [ LeftUnitorInverseWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object )
    
    return LeftUnitorInverseWithGivenTensorProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightUnitor,
                    [ [ RightUnitorWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object )
    
    return RightUnitorWithGivenTensorProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightUnitorInverse,
                    [ [ RightUnitorInverseWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object )
    
    return RightUnitorInverseWithGivenTensorProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );
