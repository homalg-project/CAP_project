# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( LeftCocartesianCodistributivityExpanding,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ Coproduct, 1 ],
                      [ DirectProduct, 1 ],
                      [ LeftCocartesianCodistributivityExpandingWithGivenObjects, 1 ] ],
                    
  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := BinaryCoproduct( cat, object, DirectProduct( cat, summands_list ) );
    
    return LeftCocartesianCodistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( LeftCocartesianCodistributivityFactoring,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ Coproduct, 1 ],
                      [ DirectProduct, 1 ],
                      [ LeftCocartesianCodistributivityFactoringWithGivenObjects, 1 ] ],
                    
  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := BinaryCoproduct( cat, object, DirectProduct( cat, summands_list ) );
    
    return LeftCocartesianCodistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( RightCocartesianCodistributivityExpanding,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ Coproduct, 1 ],
                      [ DirectProduct, 1 ],
                      [ RightCocartesianCodistributivityExpandingWithGivenObjects, 1 ] ],
                    
  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := BinaryCoproduct( cat, DirectProduct( cat, summands_list ), object );
    
    return RightCocartesianCodistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( RightCocartesianCodistributivityFactoring,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ Coproduct, 1 ],
                      [ DirectProduct, 1 ],
                      [ RightCocartesianCodistributivityFactoringWithGivenObjects, 1 ] ],
                    
  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := BinaryCoproduct( cat, DirectProduct( cat, summands_list ), object );
    
    return RightCocartesianCodistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory );
