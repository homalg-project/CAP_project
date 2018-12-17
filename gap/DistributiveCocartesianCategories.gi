InstallValue( CAP_INTERNAL_DISTRIBUTIVE_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_DISTRIBUTIVE_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS.LeftCocartesianDistributivityExpanding := 
  [ [ "Coproduct", 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ "DirectProduct", 2 ] ];
##
InstallMethod( LeftCocartesianDistributivityExpanding,
               [ IsCapCategoryObject, IsList ],
               
  function( object, summands_list )
    
    return LeftCocartesianDistributivityExpandingWithGivenObjects(
             Coproduct( object, DirectProduct( summands_list ) ),
             object, summands_list,
             DirectProduct( List( summands_list, summand -> Coproduct( object, summand ) ) )
           );
    
end );

##
InstallMethod( LeftCocartesianDistributivityExpanding,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsList ],
               
  function( object, summands_list )
    local source_and_range;
    
    source_and_range := Coproduct( object, DirectProduct( summands_list ) );
    
    return LeftCocartesianDistributivityExpandingWithGivenObjects(
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_DISTRIBUTIVE_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS.LeftCocartesianDistributivityFactoring := 
  [ [ "Coproduct", 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ "DirectProduct", 2 ] ];
##
InstallMethod( LeftCocartesianDistributivityFactoring,
               [ IsCapCategoryObject, IsList ],
               
  function( object, summands_list )
    
    return LeftCocartesianDistributivityFactoringWithGivenObjects(
             DirectProduct( List( summands_list, summand -> Coproduct( object, summand ) ) ),
             object, summands_list,
             Coproduct( object, DirectProduct( summands_list ) )
           );
    
end );

##
InstallMethod( LeftCocartesianDistributivityFactoring,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsList ],
               
  function( object, summands_list )
    local source_and_range;
    
    source_and_range := Coproduct( object, DirectProduct( summands_list ) );
    
    return LeftCocartesianDistributivityFactoringWithGivenObjects(
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_DISTRIBUTIVE_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS.RightCocartesianDistributivityExpanding := 
  [ [ "Coproduct", 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ "DirectProduct", 2 ] ];
##
InstallMethod( RightCocartesianDistributivityExpanding,
               [ IsList, IsCapCategoryObject ],
               
  function( summands_list, object )
    
    return RightCocartesianDistributivityExpandingWithGivenObjects(
             Coproduct( DirectProduct( summands_list ), object ),
             summands_list, object,
             DirectProduct( List( summands_list, summand -> Coproduct( summand, object ) ) )
           );
    
end );

##
InstallMethod( RightCocartesianDistributivityExpanding,
               [ IsList, IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( summands_list, object )
    local source_and_range;
    
    source_and_range := Coproduct( DirectProduct( summands_list ), object );
    
    return RightCocartesianDistributivityExpandingWithGivenObjects(
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_DISTRIBUTIVE_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS.RightCocartesianDistributivityFactoring := 
  [ [ "Coproduct", 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ "DirectProduct", 2 ] ];
##
InstallMethod( RightCocartesianDistributivityFactoring,
               [ IsList, IsCapCategoryObject ],
               
  function( summands_list, object )
    
    return RightCocartesianDistributivityFactoringWithGivenObjects(
             DirectProduct( List( summands_list, summand -> Coproduct( summand, object ) ) ),
             summands_list, object,
             Coproduct( DirectProduct( summands_list ), object )
           );
    
end );

##
InstallMethod( RightCocartesianDistributivityFactoring,
               [ IsList, IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( summands_list, object )
    local source_and_range;
    
    source_and_range := Coproduct( DirectProduct( summands_list ), object );
    
    return RightCocartesianDistributivityFactoringWithGivenObjects(
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_DISTRIBUTIVE_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS );
