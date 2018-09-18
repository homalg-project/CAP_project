#
# Toposes: method-record
#
# Implementations
#

InstallValue( TOPOS_METHOD_NAME_RECORD, rec(

AssociatorRightToLeftOfDirectProductsWithGivenDirectProducts := rec(
  installation_name := "AssociatorRightToLeftOfDirectProductsWithGivenDirectProducts",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "AssociatorRightToLeftOfDirectProductsWithGivenDirectProducts",
  return_type := "morphism" ),

AssociatorLeftToRightOfDirectProductsWithGivenDirectProducts := rec(
  installation_name := "AssociatorLeftToRightOfDirectProductsWithGivenDirectProducts",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "AssociatorLeftToRightOfDirectProductsWithGivenDirectProducts",
  return_type := "morphism" ),

AssociatorRightToLeftOfCoproductsWithGivenCoproducts := rec(
  installation_name := "AssociatorRightToLeftOfCoproductsWithGivenCoproducts",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "AssociatorRightToLeftOfCoproductsWithGivenCoproducts",
  return_type := "morphism" ),

AssociatorLeftToRightOfCoproductsWithGivenCoproducts := rec(
  installation_name := "AssociatorLeftToRightOfCoproductsWithGivenCoproducts",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "AssociatorLeftToRightOfCoproductsWithGivenCoproducts",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( TOPOS_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( TOPOS_METHOD_NAME_RECORD );
