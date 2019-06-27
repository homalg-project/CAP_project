InstallValue( CAP_INTERNAL_DISTRIBUTIVE_MONOIDAL_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_DISTRIBUTIVE_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.LeftDistributivityExpanding := 
  [ [ "TensorProductOnObjects", 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ "DirectSum", 2 ] ];
##
InstallMethod( LeftDistributivityExpanding,
               [ IsCapCategoryObject, IsList ],
               
  function( object, summands_list )
    
    return LeftDistributivityExpandingWithGivenObjects(
             TensorProductOnObjects( object, DirectSum( summands_list ) ),
             object, summands_list,
             DirectSum( List( summands_list, summand -> TensorProductOnObjects( object, summand ) ) )
           );
    
end );

##
InstallMethod( LeftDistributivityExpanding,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsList ],
               
  function( object, summands_list )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( object, DirectSum( summands_list ) );
    
    return LeftDistributivityExpandingWithGivenObjects(
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_DISTRIBUTIVE_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.LeftDistributivityFactoring := 
  [ [ "TensorProductOnObjects", 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ "DirectSum", 2 ] ];
##
InstallMethod( LeftDistributivityFactoring,
               [ IsCapCategoryObject, IsList ],
               
  function( object, summands_list )
    
    return LeftDistributivityFactoringWithGivenObjects(
             DirectSum( List( summands_list, summand -> TensorProductOnObjects( object, summand ) ) ),
             object, summands_list,
             TensorProductOnObjects( object, DirectSum( summands_list ) )
           );
    
end );

##
InstallMethod( LeftDistributivityFactoring,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsList ],
               
  function( object, summands_list )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( object, DirectSum( summands_list ) );
    
    return LeftDistributivityFactoringWithGivenObjects(
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_DISTRIBUTIVE_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.RightDistributivityExpanding := 
  [ [ "TensorProductOnObjects", 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ "DirectSum", 2 ] ];
##
InstallMethod( RightDistributivityExpanding,
               [ IsList, IsCapCategoryObject ],
               
  function( summands_list, object )
    
    return RightDistributivityExpandingWithGivenObjects(
             TensorProductOnObjects( DirectSum( summands_list ), object ),
             summands_list, object,
             DirectSum( List( summands_list, summand -> TensorProductOnObjects( summand, object ) ) )
           );
    
end );

##
InstallMethod( RightDistributivityExpanding,
               [ IsList, IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( summands_list, object )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( DirectSum( summands_list ), object );
    
    return RightDistributivityExpandingWithGivenObjects(
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_DISTRIBUTIVE_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.RightDistributivityFactoring := 
  [ [ "TensorProductOnObjects", 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ "DirectSum", 2 ] ];
##
InstallMethod( RightDistributivityFactoring,
               [ IsList, IsCapCategoryObject ],
               
  function( summands_list, object )
    
    return RightDistributivityFactoringWithGivenObjects(
             DirectSum( List( summands_list, summand -> TensorProductOnObjects( summand, object ) ) ),
             summands_list, object,
             TensorProductOnObjects( DirectSum( summands_list ), object )
           );
    
end );

##
InstallMethod( RightDistributivityFactoring,
               [ IsList, IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( summands_list, object )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( DirectSum( summands_list ), object );
    
    return RightDistributivityFactoringWithGivenObjects(
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_DISTRIBUTIVE_MONOIDAL_CATEGORIES_BASIC_OPERATIONS );
