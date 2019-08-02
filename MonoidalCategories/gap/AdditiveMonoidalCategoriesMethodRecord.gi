InstallValue( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

LeftDistributivityExpandingWithGivenObjects := rec(
  installation_name := "LeftDistributivityExpandingWithGivenObjects",
  filter_list := [ "object", "object", "list_of_objects", "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  cache_name := "LeftDistributivityExpandingWithGivenObjects",
  return_type := "morphism" ),

LeftDistributivityFactoringWithGivenObjects := rec(
  installation_name := "LeftDistributivityFactoringWithGivenObjects",
  filter_list := [ "object", "object", "list_of_objects", "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  cache_name := "LeftDistributivityFactoringWithGivenObjects",
  return_type := "morphism" ),

RightDistributivityExpandingWithGivenObjects := rec(
  installation_name := "RightDistributivityExpandingWithGivenObjects",
  filter_list := [ "object", "list_of_objects", "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  cache_name := "RightDistributivityExpandingWithGivenObjects",
  return_type := "morphism" ),

RightDistributivityFactoringWithGivenObjects := rec(
  installation_name := "RightDistributivityFactoringWithGivenObjects",
  filter_list := [ "object", "list_of_objects", "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  cache_name := "RightDistributivityFactoringWithGivenObjects",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
