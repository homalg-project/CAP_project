# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallTrueMethod( IsMonoidalCategory, IsStrictMonoidalCategory );

##
AddDerivationToCAP( AssociatorRightToLeft,
                    "calling the WithGiven operation in a skeletal setting",
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
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( AssociatorLeftToRight,
                    "calling the WithGiven operation in a skeletal setting",
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
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( LeftUnitor,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ LeftUnitorWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object )
    
    return LeftUnitorWithGivenTensorProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( LeftUnitorInverse,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ LeftUnitorInverseWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object )
    
    return LeftUnitorInverseWithGivenTensorProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( RightUnitor,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ RightUnitorWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object )
    
    return RightUnitorWithGivenTensorProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( RightUnitorInverse,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ RightUnitorInverseWithGivenTensorProduct, 1 ] ],
                    
  function( cat, object )
    
    return RightUnitorInverseWithGivenTensorProduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory );
