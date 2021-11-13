# THIS FILE WAS AUTOMATICALLY GENERATED FROM MonoidalCategories v2021.11-02

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD, rec(

ExponentialOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i" ] ],
  return_type := "object" ),

ExponentialOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "s", "r" ] ],
  output_source_getter_string := "ExponentialOnObjects( cat, Range( alpha ), Source( beta ) )",
  output_range_getter_string := "ExponentialOnObjects( cat, Source( alpha ), Range( beta ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

ExponentialOnMorphismsWithGivenExponentials := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CartesianEvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "b" ] ],
  output_source_getter_string := "DirectProduct( cat, ExponentialOnObjects( cat, a, b ), a )",
  output_range_getter_string := "b",
  with_given_object_position := "Source",
  return_type := "morphism" ),

CartesianEvaluationMorphismWithGivenSource := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "s" ], [ "s", "b" ] ],
  return_type := "morphism" ),

CartesianCoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "ExponentialOnObjects( cat, b, DirectProduct( cat, a, b ) )",
  with_given_object_position := "Range",
  return_type := "morphism" ),

CartesianCoevaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "r" ], [ "a", "r" ] ],
  return_type := "morphism" ),

DirectProductToExponentialAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "f" ], [ "a", "i" ] ],
  return_type := "morphism",
),

ExponentialToDirectProductAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "b", "c", "g" ], [ "t", "c" ] ],
  return_type := "morphism",
),

CartesianPreComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( cat, ExponentialOnObjects( cat, a, b ), ExponentialOnObjects( cat, b, c ) )",
  output_range_getter_string := "ExponentialOnObjects( cat, a, c )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CartesianPreComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CartesianPostComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( cat, ExponentialOnObjects( cat, b, c ), ExponentialOnObjects( cat, a, b ) )",
  output_range_getter_string := "ExponentialOnObjects( cat, a, c )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CartesianPostComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CartesianDualOnObjects := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "ad" ] ],
  return_type := "object" ),

CartesianDualOnMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "s", "r" ] ],
  output_source_getter_string := "CartesianDualOnObjects( cat, Range( alpha ) )",
  output_range_getter_string := "CartesianDualOnObjects( cat, Source( alpha ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CartesianDualOnMorphismsWithGivenCartesianDuals := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CartesianEvaluationForCartesianDual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( cat, CartesianDualOnObjects( cat, a ), a )",
  output_range_getter_string := "TerminalObject( cat )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CartesianEvaluationForCartesianDualWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

MorphismToCartesianBidual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "CartesianDualOnObjects( cat, CartesianDualOnObjects( cat, a ) )",
  with_given_object_position := "Range",
  return_type := "morphism" ),

MorphismToCartesianBidualWithGivenCartesianBidual := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism" ),

DirectProductExponentialCompatibilityMorphism := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "DirectProduct( cat, ExponentialOnObjects( cat, list[1], list[2] ), ExponentialOnObjects( cat, list[3], list[4] ) )",
  output_range_getter_string := "ExponentialOnObjects( cat, DirectProduct( cat, list[1], list[3] ), DirectProduct( cat, list[2], list[4] ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

DirectProductExponentialCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  return_type := "morphism" ),

DirectProductCartesianDualityCompatibilityMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( cat, CartesianDualOnObjects( cat, a ), CartesianDualOnObjects( cat, b ) )",
  output_range_getter_string := "CartesianDualOnObjects( cat, DirectProduct( cat, a, b ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

MorphismFromDirectProductToExponential := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( cat, CartesianDualOnObjects( cat, a ), b )",
  output_range_getter_string := "ExponentialOnObjects( cat, a, b )",
  with_given_object_position := "both",
  return_type := "morphism" ),

MorphismFromDirectProductToExponentialWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

IsomorphismFromExponentialToCartesianDual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "i", "d" ] ],
  return_type := "morphism",
),

IsomorphismFromCartesianDualToExponential := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "d", "i" ] ],
  return_type := "morphism",
),

UniversalPropertyOfCartesianDual := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "t", "a", "alpha" ], [ "t", "d" ] ],
  return_type := "morphism",
),

CartesianLambdaIntroduction := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "i" ] ],
  return_type := "morphism",
),

CartesianLambdaElimination := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "alpha" ], [ "a", "b" ] ],
  return_type := "morphism",
),

IsomorphismFromObjectToExponential := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "ExponentialOnObjects( cat, TerminalObject( cat ), a )",
  with_given_object_position := "Range",
  return_type := "morphism" ),

IsomorphismFromObjectToExponentialWithGivenExponential := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism" ),

IsomorphismFromExponentialToObject := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "ExponentialOnObjects( cat, TerminalObject( cat ), a )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism" ),

IsomorphismFromExponentialToObjectWithGivenExponential := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD,
    "Toposes",
    "CartesianClosedCategories.autogen.gd",
    "Cartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD, "CartesianCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD );
