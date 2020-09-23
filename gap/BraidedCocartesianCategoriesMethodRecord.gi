#
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( BRAIDED_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

CocartesianBraidingWithGivenCoproducts := rec(
  installation_name := "CocartesianBraidingWithGivenCoproducts",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "CocartesianBraidingWithGivenCoproducts",
  return_type := "morphism" ),

CocartesianBraidingInverseWithGivenCoproducts := rec(
  installation_name := "CocartesianBraidingInverseWithGivenCoproducts",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "CocartesianBraidingInverseWithGivenCoproducts",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( BRAIDED_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( BRAIDED_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
