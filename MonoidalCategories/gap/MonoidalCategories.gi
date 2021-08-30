#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##  Monoidal Categories
##
##
#############################################################################

##
AddDerivationToCAP( AssociatorRightToLeft,

  function( cat, object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( object_1, TensorProductOnObjects( object_2, object_3 ) );
    
    return AssociatorRightToLeftWithGivenTensorProducts( 
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
    
    source_and_range := TensorProductOnObjects( object_1, TensorProductOnObjects( object_2, object_3 ) );
    
    return AssociatorLeftToRightWithGivenTensorProducts( 
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( LeftUnitor,

  function( cat, object )
    
    return LeftUnitorWithGivenTensorProduct( object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( LeftUnitorInverse,

  function( cat, object )
    
    return LeftUnitorInverseWithGivenTensorProduct( object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightUnitor,

  function( cat, object )
    
    return RightUnitorWithGivenTensorProduct( object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( RightUnitorInverse,

  function( cat, object )
    
    return RightUnitorInverseWithGivenTensorProduct( object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );
