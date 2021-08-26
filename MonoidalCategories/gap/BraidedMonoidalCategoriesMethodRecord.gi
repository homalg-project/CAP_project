InstallValue( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

Braiding := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( a, b )",
  output_range_getter_string := "TensorProductOnObjects( b, a )",
  with_given_object_position := "both",
  return_type := "morphism" ),

BraidingWithGivenTensorProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

BraidingInverse := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( b, a )",
  output_range_getter_string := "TensorProductOnObjects( a, b )",
  with_given_object_position := "both",
  return_type := "morphism" ),

BraidingInverseWithGivenTensorProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
