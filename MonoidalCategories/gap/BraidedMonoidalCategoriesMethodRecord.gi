InstallValue( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

BraidingWithGivenTensorProducts := rec(
  installation_name := "BraidingWithGivenTensorProducts",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "BraidingWithGivenTensorProducts",
  return_type := "morphism" ),

BraidingInverseWithGivenTensorProducts := rec(
  installation_name := "BraidingInverseWithGivenTensorProducts",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "BraidingInverseWithGivenTensorProducts",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
