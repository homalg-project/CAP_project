# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( CAP_INTERNAL_DISTRIBUTIVE_CARTESIAN_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_DISTRIBUTIVE_CARTESIAN_CATEGORIES_BASIC_OPERATIONS.LeftCartesianDistributivityExpanding := 
  [ [ "DirectProduct", 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ "Coproduct", 2 ] ];
##
InstallMethod( LeftCartesianDistributivityExpanding,
               [ IsCapCategoryObject, IsList ],
               
  function( object, summands_list )
    
    return LeftCartesianDistributivityExpandingWithGivenObjects(
             DirectProduct( object, Coproduct( summands_list ) ),
             object, summands_list,
             Coproduct( List( summands_list, summand -> DirectProduct( object, summand ) ) )
           );
    
end );

##
InstallMethod( LeftCartesianDistributivityExpanding,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsList ],
               
  function( object, summands_list )
    local source_and_range;
    
    source_and_range := DirectProduct( object, Coproduct( summands_list ) );
    
    return LeftCartesianDistributivityExpandingWithGivenObjects(
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_DISTRIBUTIVE_CARTESIAN_CATEGORIES_BASIC_OPERATIONS.LeftCartesianDistributivityFactoring := 
  [ [ "DirectProduct", 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ "Coproduct", 2 ] ];
##
InstallMethod( LeftCartesianDistributivityFactoring,
               [ IsCapCategoryObject, IsList ],
               
  function( object, summands_list )
    
    return LeftCartesianDistributivityFactoringWithGivenObjects(
             Coproduct( List( summands_list, summand -> DirectProduct( object, summand ) ) ),
             object, summands_list,
             DirectProduct( object, Coproduct( summands_list ) )
           );
    
end );

##
InstallMethod( LeftCartesianDistributivityFactoring,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsList ],
               
  function( object, summands_list )
    local source_and_range;
    
    source_and_range := DirectProduct( object, Coproduct( summands_list ) );
    
    return LeftCartesianDistributivityFactoringWithGivenObjects(
             source_and_range,
             object, summands_list,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_DISTRIBUTIVE_CARTESIAN_CATEGORIES_BASIC_OPERATIONS.RightCartesianDistributivityExpanding := 
  [ [ "DirectProduct", 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ "Coproduct", 2 ] ];
##
InstallMethod( RightCartesianDistributivityExpanding,
               [ IsList, IsCapCategoryObject ],
               
  function( summands_list, object )
    
    return RightCartesianDistributivityExpandingWithGivenObjects(
             DirectProduct( Coproduct( summands_list ), object ),
             summands_list, object,
             Coproduct( List( summands_list, summand -> DirectProduct( summand, object ) ) )
           );
    
end );

##
InstallMethod( RightCartesianDistributivityExpanding,
               [ IsList, IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( summands_list, object )
    local source_and_range;
    
    source_and_range := DirectProduct( Coproduct( summands_list ), object );
    
    return RightCartesianDistributivityExpandingWithGivenObjects(
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_DISTRIBUTIVE_CARTESIAN_CATEGORIES_BASIC_OPERATIONS.RightCartesianDistributivityFactoring := 
  [ [ "DirectProduct", 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ "Coproduct", 2 ] ];
##
InstallMethod( RightCartesianDistributivityFactoring,
               [ IsList, IsCapCategoryObject ],
               
  function( summands_list, object )
    
    return RightCartesianDistributivityFactoringWithGivenObjects(
             Coproduct( List( summands_list, summand -> DirectProduct( summand, object ) ) ),
             summands_list, object,
             DirectProduct( Coproduct( summands_list ), object )
           );
    
end );

##
InstallMethod( RightCartesianDistributivityFactoring,
               [ IsList, IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( summands_list, object )
    local source_and_range;
    
    source_and_range := DirectProduct( Coproduct( summands_list ), object );
    
    return RightCartesianDistributivityFactoringWithGivenObjects(
             source_and_range,
             summands_list, object,
             source_and_range
           );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_DISTRIBUTIVE_CARTESIAN_CATEGORIES_BASIC_OPERATIONS );
