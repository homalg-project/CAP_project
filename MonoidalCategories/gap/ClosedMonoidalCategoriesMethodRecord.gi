# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

InternalHomOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i" ] ],
  return_type := "object" ),

InternalHomOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "s", "r" ] ],
  output_source_getter_string := "InternalHomOnObjects( cat, Range( alpha ), Source( beta ) )",
  output_range_getter_string := "InternalHomOnObjects( cat, Source( alpha ), Range( beta ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

InternalHomOnMorphismsWithGivenInternalHoms := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

EvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "b" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, a, b ), a )",
  output_range_getter_string := "b",
  with_given_object_position := "Source",
  return_type := "morphism" ),

EvaluationMorphismWithGivenSource := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "s" ], [ "s", "b" ] ],
  return_type := "morphism" ),

CoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "InternalHomOnObjects( cat, b, TensorProductOnObjects( cat, a, b ) )",
  with_given_object_position := "Range",
  return_type := "morphism" ),

CoevaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "r" ], [ "a", "r" ] ],
  return_type := "morphism" ),

TensorProductToInternalHomAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "f" ], [ "a", "i" ] ],
  return_type := "morphism",
),

InternalHomToTensorProductAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "b", "c", "g" ], [ "t", "c" ] ],
  return_type := "morphism",
),

MonoidalPreComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, a, b ), InternalHomOnObjects( cat, b, c ) )",
  output_range_getter_string := "InternalHomOnObjects( cat, a, c )",
  with_given_object_position := "both",
  return_type := "morphism" ),

MonoidalPreComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

MonoidalPostComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, b, c ), InternalHomOnObjects( cat, a, b ) )",
  output_range_getter_string := "InternalHomOnObjects( cat, a, c )",
  with_given_object_position := "both",
  return_type := "morphism" ),

MonoidalPostComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

DualOnObjects := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "ad" ] ],
  return_type := "object" ),

DualOnMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "s", "r" ] ],
  output_source_getter_string := "DualOnObjects( cat, Range( alpha ) )",
  output_range_getter_string := "DualOnObjects( cat, Source( alpha ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

DualOnMorphismsWithGivenDuals := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

EvaluationForDual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, DualOnObjects( cat, a ), a )",
  output_range_getter_string := "TensorUnit( cat )",
  with_given_object_position := "both",
  return_type := "morphism" ),

EvaluationForDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

MorphismToBidual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "DualOnObjects( cat, DualOnObjects( cat, a ) )",
  with_given_object_position := "Range",
  return_type := "morphism" ),

MorphismToBidualWithGivenBidual := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism" ),

TensorProductInternalHomCompatibilityMorphism := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, list[1], list[2] ), InternalHomOnObjects( cat, list[3], list[4] ) )",
  output_range_getter_string := "InternalHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[3] ), TensorProductOnObjects( cat, list[2], list[4] ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

TensorProductInternalHomCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  return_type := "morphism" ),

TensorProductDualityCompatibilityMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, DualOnObjects( cat, a ), DualOnObjects( cat, b ) )",
  output_range_getter_string := "DualOnObjects( cat, TensorProductOnObjects( cat, a, b ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

TensorProductDualityCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

MorphismFromTensorProductToInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, DualOnObjects( cat, a ), b )",
  output_range_getter_string := "InternalHomOnObjects( cat, a, b )",
  with_given_object_position := "both",
  return_type := "morphism" ),

MorphismFromTensorProductToInternalHomWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

IsomorphismFromInternalHomToDual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "i", "d" ] ],
  return_type := "morphism",
),

IsomorphismFromDualToInternalHom := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "d", "i" ] ],
  return_type := "morphism",
),

UniversalPropertyOfDual := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "t", "a", "alpha" ], [ "t", "d" ] ],
  return_type := "morphism",
),

LambdaIntroduction := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "i" ] ],
  return_type := "morphism",
),

LambdaElimination := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "alpha" ], [ "a", "b" ] ],
  return_type := "morphism",
),

IsomorphismFromObjectToInternalHom := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "InternalHomOnObjects( cat, TensorUnit( cat ), a )",
  with_given_object_position := "Range",
  return_type := "morphism" ),

IsomorphismFromObjectToInternalHomWithGivenInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism" ),

IsomorphismFromInternalHomToObject := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "InternalHomOnObjects( cat, TensorUnit( cat ), a )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism" ),

IsomorphismFromInternalHomToObjectWithGivenInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "ClosedMonoidalCategories.autogen.gd",
    "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
