#
# Toposes: Elementary toposes
#
# Implementations
#

##
InstallValue( CAP_INTERNAL_CARTESIAN_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_CARTESIAN_CATEGORIES_BASIC_OPERATIONS.DirectProductOnMorphisms := 
  [ [ "DirectProductOnMorphismsWithGivenDirectProducts", 1 ],
    [ "DirectProduct", 2 ] ];
##
InstallMethod( DirectProductOnMorphisms,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_1, morphism_2 )
    
    return DirectProductOnMorphismsWithGivenDirectProducts( 
             DirectProduct( Source( morphism_1 ), Source( morphism_2 ) ),
             morphism_1, morphism_2,
             DirectProduct( Range( morphism_1 ), Range( morphism_2 ) )
           );
    
end );

##
CAP_INTERNAL_CARTESIAN_CATEGORIES_BASIC_OPERATIONS.CartesianAssociatorRightToLeft := 
  [ [ "CartesianAssociatorRightToLeftWithGivenDirectProducts", 1 ],
    [ "DirectProduct", 4 ] ];
##
InstallMethod( CartesianAssociatorRightToLeft,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return CartesianAssociatorRightToLeftWithGivenDirectProducts( 
             DirectProduct( object_1, DirectProduct( object_2, object_3 ) ),
             object_1, object_2, object_3,
             DirectProduct( DirectProduct( object_1, object_2 ), object_3 ) 
           );
    
end );

##
InstallMethod( CartesianAssociatorRightToLeft,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range := DirectProduct( object_1, DirectProduct( object_2, object_3 ) );
    
    return CartesianAssociatorRightToLeftWithGivenDirectProducts( 
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_CARTESIAN_CATEGORIES_BASIC_OPERATIONS.CartesianAssociatorLeftToRight := 
  [ [ "CartesianAssociatorLeftToRightWithGivenDirectProducts", 1 ],
    [ "DirectProduct", 4 ] ];
##
InstallMethod( CartesianAssociatorLeftToRight,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return CartesianAssociatorLeftToRightWithGivenDirectProducts( 
             DirectProduct( DirectProduct( object_1, object_2 ), object_3 ),
             object_1, object_2, object_3,
             DirectProduct( object_1, DirectProduct( object_2, object_3 ) ) 
           );
    
end );

##
InstallMethod( CartesianAssociatorLeftToRight,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range := DirectProduct( object_1, DirectProduct( object_2, object_3 ) );
    
    return CartesianAssociatorLeftToRightWithGivenDirectProducts( 
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_CARTESIAN_CATEGORIES_BASIC_OPERATIONS.CartesianLeftUnitor := 
  [ [ "CartesianLeftUnitorWithGivenDirectProduct", 1 ],
    [ "DirectProduct", 1 ],
    [ "TerminalObject", 1 ] ];
##
InstallMethod( CartesianLeftUnitor,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return CartesianLeftUnitorWithGivenDirectProduct( object, DirectProduct( TerminalObject( category ), object ) );
    
end );

##
InstallMethod( CartesianLeftUnitor,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return CartesianLeftUnitorWithGivenDirectProduct( object, object );
    
end );


##
CAP_INTERNAL_CARTESIAN_CATEGORIES_BASIC_OPERATIONS.CartesianLeftUnitorInverse := 
  [ [ "CartesianLeftUnitorInverseWithGivenDirectProduct", 1 ],
    [ "DirectProduct", 1 ],
    [ "TerminalObject", 1 ] ];
##
InstallMethod( CartesianLeftUnitorInverse,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return CartesianLeftUnitorInverseWithGivenDirectProduct( object, DirectProduct( TerminalObject( category ), object ) );
    
end );

##
InstallMethod( CartesianLeftUnitorInverse,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return CartesianLeftUnitorInverseWithGivenDirectProduct( object, object );
    
end );

##
CAP_INTERNAL_CARTESIAN_CATEGORIES_BASIC_OPERATIONS.CartesianRightUnitor := 
  [ [ "CartesianRightUnitorWithGivenDirectProduct", 1 ],
    [ "DirectProduct", 1 ],
    [ "TerminalObject", 1 ] ];
##
InstallMethod( CartesianRightUnitor,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return CartesianRightUnitorWithGivenDirectProduct( object, DirectProduct( object, TerminalObject( category ) ) );
    
end );

##
InstallMethod( CartesianRightUnitor,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return CartesianRightUnitorWithGivenDirectProduct( object, object );
    
end );

##
CAP_INTERNAL_CARTESIAN_CATEGORIES_BASIC_OPERATIONS.CartesianRightUnitorInverse := 
  [ [ "CartesianRightUnitorInverseWithGivenDirectProduct", 1 ],
    [ "DirectProduct", 1 ],
    [ "TerminalObject", 1 ] ];
##
InstallMethod( CartesianRightUnitorInverse,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return CartesianRightUnitorInverseWithGivenDirectProduct( object, DirectProduct( object, TerminalObject( category ) ) );
    
end );

##
InstallMethod( CartesianRightUnitorInverse,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return CartesianRightUnitorInverseWithGivenDirectProduct( object, object );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_CARTESIAN_CATEGORIES_BASIC_OPERATIONS );
