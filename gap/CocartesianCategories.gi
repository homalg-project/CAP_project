#
# Toposes: Elementary toposes
#
# Implementations
#

##
InstallValue( CAP_INTERNAL_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS.CoproductOnMorphisms := 
  [ [ "CoproductOnMorphismsWithGivenCoproducts", 1 ],
    [ "Coproduct", 2 ] ];
##
InstallMethod( CoproductOnMorphisms,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_1, morphism_2 )
    
    return CoproductOnMorphismsWithGivenCoproducts( 
             Coproduct( Source( morphism_1 ), Source( morphism_2 ) ),
             morphism_1, morphism_2,
             Coproduct( Range( morphism_1 ), Range( morphism_2 ) )
           );
    
end );

##
CAP_INTERNAL_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS.CocartesianAssociatorRightToLeft := 
  [ [ "CocartesianAssociatorRightToLeftWithGivenCoproducts", 1 ],
    [ "Coproduct", 4 ] ];
##
InstallMethod( CocartesianAssociatorRightToLeft,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return CocartesianAssociatorRightToLeftWithGivenCoproducts( 
             Coproduct( object_1, Coproduct( object_2, object_3 ) ),
             object_1, object_2, object_3,
             Coproduct( Coproduct( object_1, object_2 ), object_3 ) 
           );
    
end );

##
InstallMethod( CocartesianAssociatorRightToLeft,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range := Coproduct( object_1, Coproduct( object_2, object_3 ) );
    
    return CocartesianAssociatorRightToLeftWithGivenCoproducts( 
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS.CocartesianAssociatorLeftToRight := 
  [ [ "CocartesianAssociatorLeftToRightWithGivenCoproducts", 1 ],
    [ "Coproduct", 4 ] ];
##
InstallMethod( CocartesianAssociatorLeftToRight,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return CocartesianAssociatorLeftToRightWithGivenCoproducts( 
             Coproduct( Coproduct( object_1, object_2 ), object_3 ),
             object_1, object_2, object_3,
             Coproduct( object_1, Coproduct( object_2, object_3 ) ) 
           );
    
end );

##
InstallMethod( CocartesianAssociatorLeftToRight,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range := Coproduct( object_1, Coproduct( object_2, object_3 ) );
    
    return CocartesianAssociatorLeftToRightWithGivenCoproducts( 
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS.CocartesianLeftUnitor := 
  [ [ "CocartesianLeftUnitorWithGivenCoproduct", 1 ],
    [ "Coproduct", 1 ],
    [ "InitialObject", 1 ] ];
##
InstallMethod( CocartesianLeftUnitor,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return CocartesianLeftUnitorWithGivenCoproduct( object, Coproduct( InitialObject( category ), object ) );
    
end );

##
InstallMethod( CocartesianLeftUnitor,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return CocartesianLeftUnitorWithGivenCoproduct( object, object );
    
end );


##
CAP_INTERNAL_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS.CocartesianLeftUnitorInverse := 
  [ [ "CocartesianLeftUnitorInverseWithGivenCoproduct", 1 ],
    [ "Coproduct", 1 ],
    [ "InitialObject", 1 ] ];
##
InstallMethod( CocartesianLeftUnitorInverse,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return CocartesianLeftUnitorInverseWithGivenCoproduct( object, Coproduct( InitialObject( category ), object ) );
    
end );

##
InstallMethod( CocartesianLeftUnitorInverse,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return CocartesianLeftUnitorInverseWithGivenCoproduct( object, object );
    
end );

##
CAP_INTERNAL_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS.CocartesianRightUnitor := 
  [ [ "CocartesianRightUnitorWithGivenCoproduct", 1 ],
    [ "Coproduct", 1 ],
    [ "InitialObject", 1 ] ];
##
InstallMethod( CocartesianRightUnitor,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return CocartesianRightUnitorWithGivenCoproduct( object, Coproduct( object, InitialObject( category ) ) );
    
end );

##
InstallMethod( CocartesianRightUnitor,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return CocartesianRightUnitorWithGivenCoproduct( object, object );
    
end );

##
CAP_INTERNAL_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS.CocartesianRightUnitorInverse := 
  [ [ "CocartesianRightUnitorInverseWithGivenCoproduct", 1 ],
    [ "Coproduct", 1 ],
    [ "InitialObject", 1 ] ];
##
InstallMethod( CocartesianRightUnitorInverse,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return CocartesianRightUnitorInverseWithGivenCoproduct( object, Coproduct( object, InitialObject( category ) ) );
    
end );

##
InstallMethod( CocartesianRightUnitorInverse,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return CocartesianRightUnitorInverseWithGivenCoproduct( object, object );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS );
