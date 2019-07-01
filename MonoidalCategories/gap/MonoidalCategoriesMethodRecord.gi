InstallValue( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

## Basic Operations for Monoidal Categories

TensorProductOnMorphismsWithGivenTensorProducts := rec(
  installation_name := "TensorProductOnMorphismsWithGivenTensorProducts",
  filter_list := [ "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  cache_name := "TensorProductOnMorphismsWithGivenTensorProducts",
  return_type := "morphism" ),

AssociatorRightToLeftWithGivenTensorProducts := rec(
  installation_name := "AssociatorRightToLeftWithGivenTensorProducts",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "AssociatorRightToLeftWithGivenTensorProducts",
  return_type := "morphism" ),

AssociatorLeftToRightWithGivenTensorProducts := rec(
  installation_name := "AssociatorLeftToRightWithGivenTensorProducts",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "AssociatorLeftToRightWithGivenTensorProducts",
  return_type := "morphism" ),

LeftUnitorWithGivenTensorProduct := rec(
  installation_name := "LeftUnitorWithGivenTensorProduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "LeftUnitorWithGivenTensorProduct",
  return_type := "morphism" ),

LeftUnitorInverseWithGivenTensorProduct := rec(
  installation_name := "LeftUnitorInverseWithGivenTensorProduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "LeftUnitorInverseWithGivenTensorProduct",
  return_type := "morphism" ),

RightUnitorWithGivenTensorProduct := rec(
  installation_name := "RightUnitorWithGivenTensorProduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "RightUnitorWithGivenTensorProduct",
  return_type := "morphism" ),

RightUnitorInverseWithGivenTensorProduct := rec(
  installation_name := "RightUnitorInverseWithGivenTensorProduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "RightUnitorInverseWithGivenTensorProduct",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
