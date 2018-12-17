InstallValue( BRAIDED_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

CartesianBraidingWithGivenDirectProducts := rec(
  installation_name := "CartesianBraidingWithGivenDirectProducts",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "CartesianBraidingWithGivenDirectProducts",
  return_type := "morphism" ),

CartesianBraidingInverseWithGivenDirectProducts := rec(
  installation_name := "CartesianBraidingInverseWithGivenDirectProducts",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "CartesianBraidingInverseWithGivenDirectProducts",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( BRAIDED_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( BRAIDED_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
