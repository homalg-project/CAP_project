# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( LeftCartesianDistributivityExpanding,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ DirectProduct, 1 ],
                      [ Coproduct, 1 ],
                      [ LeftCartesianDistributivityExpandingWithGivenObjects, 1 ] ],
                    
  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := BinaryDirectProduct( cat, object, Coproduct( cat, summands_list ) );
    
    return LeftCartesianDistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( LeftCartesianDistributivityFactoring,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ DirectProduct, 1 ],
                      [ Coproduct, 1 ],
                      [ LeftCartesianDistributivityFactoringWithGivenObjects, 1 ] ],
                    
  function( cat, object, summands_list )
    local source_and_range;
    
    source_and_range := BinaryDirectProduct( cat, object, Coproduct( cat, summands_list ) );
    
    return LeftCartesianDistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( RightCartesianDistributivityExpanding,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ DirectProduct, 1 ],
                      [ Coproduct, 1 ],
                      [ RightCartesianDistributivityExpandingWithGivenObjects, 1 ] ],
                    
  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := BinaryDirectProduct( cat, Coproduct( cat, summands_list ), object );
    
    return RightCartesianDistributivityExpandingWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( RightCartesianDistributivityFactoring,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ DirectProduct, 1 ],
                      [ Coproduct, 1 ],
                      [ RightCartesianDistributivityFactoringWithGivenObjects, 1 ] ],
                    
  function( cat, summands_list, object )
    local source_and_range;
    
    source_and_range := BinaryDirectProduct( cat, Coproduct( cat, summands_list ), object );
    
    return RightCartesianDistributivityFactoringWithGivenObjects( cat,
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory );
