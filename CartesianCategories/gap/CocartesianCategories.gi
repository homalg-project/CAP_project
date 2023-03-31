# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallTrueMethod( IsCocartesianCategory, IsStrictCocartesianCategory );

##
AddDerivationToCAP( CocartesianAssociatorRightToLeft,
                    [ [ Coproduct, 2 ],
                      [ CocartesianAssociatorRightToLeftWithGivenCoproducts, 1 ] ],
                    
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
                    [ [ Coproduct, 2 ],
                      [ CocartesianAssociatorLeftToRightWithGivenCoproducts, 1 ] ],
                    
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
                    [ [ CocartesianLeftUnitorWithGivenCoproduct, 1 ] ],
                    
  function( cat, object )
    
    return CocartesianLeftUnitorWithGivenCoproduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CocartesianLeftUnitorInverse,
                    [ [ CocartesianLeftUnitorInverseWithGivenCoproduct, 1 ] ],
                    
  function( cat, object )
    
    return CocartesianLeftUnitorInverseWithGivenCoproduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CocartesianRightUnitor,
                    [ [ CocartesianRightUnitorWithGivenCoproduct, 1 ] ],
                    
  function( cat, object )
    
    return CocartesianRightUnitorWithGivenCoproduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CocartesianRightUnitorInverse,
                    [ [ CocartesianRightUnitorInverseWithGivenCoproduct, 1 ] ],
                    
  function( cat, object )
    
    return CocartesianRightUnitorInverseWithGivenCoproduct( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );
