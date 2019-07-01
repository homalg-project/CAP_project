InstallValue( MONOIDAL_CATEGORIES_BASIC_METHOD_NAME_RECORD, rec(

TensorProductOnObjects := rec(
  installation_name := "TensorProductOnObjects",
  filter_list := [ "object", "object" ],
  cache_name := "TensorProductOnObjects",
  return_type := "object" ),

TensorUnit := rec(
  installation_name := "TensorUnit",
  filter_list := [ "category" ],
  cache_name := "TensorUnit",
  return_type := "object" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( MONOIDAL_CATEGORIES_BASIC_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( MONOIDAL_CATEGORIES_BASIC_METHOD_NAME_RECORD );
