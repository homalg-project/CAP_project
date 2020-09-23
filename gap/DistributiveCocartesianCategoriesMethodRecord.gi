#
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( DISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

LeftCocartesianDistributivityExpandingWithGivenObjects := rec(
  installation_name := "LeftCocartesianDistributivityExpandingWithGivenObjects",
  filter_list := [ "object", "object", IsList, "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  cache_name := "LeftCocartesianDistributivityExpandingWithGivenObjects",
  return_type := "morphism" ),

LeftCocartesianDistributivityFactoringWithGivenObjects := rec(
  installation_name := "LeftCocartesianDistributivityFactoringWithGivenObjects",
  filter_list := [ "object", "object", IsList, "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  cache_name := "LeftCocartesianDistributivityFactoringWithGivenObjects",
  return_type := "morphism" ),

RightCocartesianDistributivityExpandingWithGivenObjects := rec(
  installation_name := "RightCocartesianDistributivityExpandingWithGivenObjects",
  filter_list := [ "object", IsList, "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  cache_name := "RightCocartesianDistributivityExpandingWithGivenObjects",
  return_type := "morphism" ),

RightCocartesianDistributivityFactoringWithGivenObjects := rec(
  installation_name := "RightCocartesianDistributivityFactoringWithGivenObjects",
  filter_list := [ "object", IsList, "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  cache_name := "RightCocartesianDistributivityFactoringWithGivenObjects",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( DISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( DISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
