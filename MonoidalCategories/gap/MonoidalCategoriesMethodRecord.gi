InstallValue( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

## Basic Operations for Monoidal Categories

TensorProductOnMorphismsWithGivenTensorProducts := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  cache_name := "TensorProductOnMorphismsWithGivenTensorProducts",
  return_type := "morphism" ),

AssociatorRightToLeftWithGivenTensorProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "AssociatorRightToLeftWithGivenTensorProducts",
  return_type := "morphism" ),

AssociatorLeftToRightWithGivenTensorProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "AssociatorLeftToRightWithGivenTensorProducts",
  return_type := "morphism" ),

LeftUnitorWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "LeftUnitorWithGivenTensorProduct",
  return_type := "morphism" ),

LeftUnitorInverseWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "LeftUnitorInverseWithGivenTensorProduct",
  return_type := "morphism" ),

RightUnitorWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "RightUnitorWithGivenTensorProduct",
  return_type := "morphism" ),

RightUnitorInverseWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "RightUnitorInverseWithGivenTensorProduct",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
