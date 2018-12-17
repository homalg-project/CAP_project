InstallValue( CAP_INTERNAL_BRAIDED_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_BRAIDED_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS.CocartesianBraiding := 
  [ [ "CocartesianBraidingWithGivenCoproducts", 1 ],
    [ "Coproduct", 2 ] ];
##
InstallMethod( CocartesianBraiding,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return CocartesianBraidingWithGivenCoproducts( Coproduct( object_1, object_2 ), object_1, object_2, Coproduct( object_2, object_1 ) );
    
end );

##
InstallMethod( CocartesianBraiding,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    local source_and_range;
    
    source_and_range := Coproduct( object_1, object_2 );
    
    return CocartesianBraidingWithGivenCoproducts( source_and_range, object_1, object_2, source_and_range );
    
end );

##
CAP_INTERNAL_BRAIDED_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS.CocartesianBraidingInverse := 
  [ [ "CocartesianBraidingInverseWithGivenCoproducts", 1 ],
    [ "Coproduct", 2 ] ];
##
InstallMethod( CocartesianBraidingInverse,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return CocartesianBraidingInverseWithGivenCoproducts( Coproduct( object_2, object_1 ), object_1, object_2, Coproduct( object_1, object_2 ) );
    
end );

##
InstallMethod( CocartesianBraidingInverse,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    local source_and_range;
    
    source_and_range := Coproduct( object_1, object_2 );
    
    return CocartesianBraidingInverseWithGivenCoproducts( source_and_range, object_1, object_2, source_and_range );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_BRAIDED_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS );
