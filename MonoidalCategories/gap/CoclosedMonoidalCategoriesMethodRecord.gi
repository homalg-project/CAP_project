# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

InternalCoHomOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i" ] ],
  return_type := "object" ),

InternalCoHomOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "s", "r" ] ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, Source( alpha ), Range( beta ) )",
  output_range_getter_string := "InternalCoHomOnObjects( cat, Range( alpha ), Source( beta ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

InternalCoHomOnMorphismsWithGivenInternalCoHoms := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CoclosedEvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "TensorProductOnObjects( cat, b, InternalCoHomOnObjects( cat, a, b ) )",
  with_given_object_position := "Range",
  return_type := "morphism" ),

CoclosedEvaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "r" ], [ "a", "r" ] ],
  return_type := "morphism" ),

CoclosedCoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "b" ] ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, TensorProductOnObjects( cat, a, b ), a )",
  output_range_getter_string := "b",
  with_given_object_position := "Source",
  return_type := "morphism" ),

CoclosedCoevaluationMorphismWithGivenSource := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "s" ], [ "s", "b" ] ],
  return_type := "morphism" ),

InternalCoHomToTensorProductAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "f" ], [ "a", "t" ] ],
  return_type := "morphism",
),

TensorProductToInternalCoHomAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "b", "c", "g" ], [ "i", "c" ] ],
  return_type := "morphism",
),

MonoidalPreCoComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, a, c )",
  output_range_getter_string := "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, a, b ), InternalCoHomOnObjects( cat, b, c ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

MonoidalPreCoComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

MonoidalPostCoComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, a, c )",
  output_range_getter_string := "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, b, c ), InternalCoHomOnObjects( cat, a, b ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

MonoidalPostCoComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CoDualOnObjects := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "acd" ] ],
  return_type := "object" ),

CoDualOnMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "s", "r" ] ],
  output_source_getter_string := "CoDualOnObjects( cat, Range( alpha ) )",
  output_range_getter_string := "CoDualOnObjects( cat, Source( alpha ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CoDualOnMorphismsWithGivenCoDuals := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CoclosedEvaluationForCoDual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorUnit( cat )",
  output_range_getter_string := "TensorProductOnObjects( cat, a, CoDualOnObjects( cat, a ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CoclosedEvaluationForCoDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

MorphismFromCoBidual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "CoDualOnObjects( cat, CoDualOnObjects( cat, a ) )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism" ),

MorphismFromCoBidualWithGivenCoBidual := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism" ),

InternalCoHomTensorProductCompatibilityMorphism := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[2] ), TensorProductOnObjects( cat, list[3], list[4] ) )",
  output_range_getter_string := "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, list[1], list[3] ), InternalCoHomOnObjects( cat, list[2], list[4] ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  return_type := "morphism" ),

CoDualityTensorProductCompatibilityMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "CoDualOnObjects( cat, TensorProductOnObjects( cat, a, b ) )",
  output_range_getter_string := "TensorProductOnObjects( cat, CoDualOnObjects( cat, a ), CoDualOnObjects( cat, b ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CoDualityTensorProductCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

MorphismFromInternalCoHomToTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, a, b )",
  output_range_getter_string := "TensorProductOnObjects( cat, a, CoDualOnObjects( cat, b ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

MorphismFromInternalCoHomToTensorProductWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

IsomorphismFromCoDualToInternalCoHom := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "i", "d" ] ],
  return_type := "morphism",
),

IsomorphismFromInternalCoHomToCoDual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "d", "i" ] ],
  return_type := "morphism",
),

UniversalPropertyOfCoDual := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "t", "alpha" ], [ "d", "t" ] ],
  return_type := "morphism",
),

CoLambdaIntroduction := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "i" ] ],
  return_type := "morphism",
),

CoLambdaElimination := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "alpha" ], [ "a", "b" ] ],
  return_type := "morphism",
),

IsomorphismFromObjectToInternalCoHom := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "InternalCoHomOnObjects( cat, a, TensorUnit( cat ) )",
  with_given_object_position := "Range",
  return_type := "morphism" ),

IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism" ),

IsomorphismFromInternalCoHomToObject := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, a, TensorUnit( cat ) )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism" ),

IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "CoclosedMonoidalCategories.autogen.gd",
    "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
