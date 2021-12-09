# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

InternalHomOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i" ] ],
  return_type := "object",
  dual_operation := "InternalCoHomOnObjects",
  dual_arguments_reversed := true,
),

InternalHomOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "s", "r" ] ],
  output_source_getter_string := "InternalHomOnObjects( cat, Range( alpha ), Source( beta ) )",
  output_range_getter_string := "InternalHomOnObjects( cat, Source( alpha ), Range( beta ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "InternalCoHomOnMorphisms",
  dual_arguments_reversed := true,
),

InternalHomOnMorphismsWithGivenInternalHoms := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "InternalCoHomOnMorphismsWithGivenInternalCoHoms",
  dual_arguments_reversed := true,
),

EvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "b" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, a, b ), a )",
  output_range_getter_string := "b",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CoclosedEvaluationMorphism",
  dual_arguments_reversed := true,
),

EvaluationMorphismWithGivenSource := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "s" ], [ "s", "b" ] ],
  return_type := "morphism",
  dual_operation := "CoclosedEvaluationMorphismWithGivenRange",
  dual_preprocessor_func := { cat, a, b, s } -> [ Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( s ) ],
  dual_arguments_reversed := false,
),

CoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "InternalHomOnObjects( cat, b, TensorProductOnObjects( cat, a, b ) )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "CoclosedCoevaluationMorphism",
  dual_arguments_reversed := false,
),

CoevaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "CoclosedCoevaluationMorphismWithGivenSource",
  dual_arguments_reversed := false,
),

TensorProductToInternalHomAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "f" ], [ "a", "i" ] ],
  return_type := "morphism",
  dual_operation := "TensorProductToInternalCoHomAdjunctionMap",
  dual_arguments_reversed := false,
),

InternalHomToTensorProductAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "b", "c", "g" ], [ "t", "c" ] ],
  return_type := "morphism",
  dual_operation := "InternalCoHomToTensorProductAdjunctionMap",
  dual_preprocessor_func := { cat, a, b, g } -> [ Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ) ],
  dual_arguments_reversed := false,
),

MonoidalPreComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, a, b ), InternalHomOnObjects( cat, b, c ) )",
  output_range_getter_string := "InternalHomOnObjects( cat, a, c )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "MonoidalPreCoComposeMorphism",
  dual_arguments_reversed := true,
),

MonoidalPreComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "MonoidalPreCoComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
),

MonoidalPostComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, b, c ), InternalHomOnObjects( cat, a, b ) )",
  output_range_getter_string := "InternalHomOnObjects( cat, a, c )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "MonoidalPostCoComposeMorphism",
  dual_arguments_reversed := true,
),

MonoidalPostComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "MonoidalPostCoComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
),

DualOnObjects := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "ad" ] ],
  return_type := "object",
  dual_operation := "CoDualOnObjects",
),

DualOnMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "s", "r" ] ],
  output_source_getter_string := "DualOnObjects( cat, Range( alpha ) )",
  output_range_getter_string := "DualOnObjects( cat, Source( alpha ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CoDualOnMorphisms",
),

DualOnMorphismsWithGivenDuals := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CoDualOnMorphismsWithGivenCoDuals",
  dual_arguments_reversed := true,
),

EvaluationForDual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, DualOnObjects( cat, a ), a )",
  output_range_getter_string := "TensorUnit( cat )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CoclosedEvaluationForCoDual",
),

EvaluationForDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CoclosedEvaluationForCoDualWithGivenTensorProduct",
  dual_arguments_reversed := true,
),

MorphismToBidual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "DualOnObjects( cat, DualOnObjects( cat, a ) )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "MorphismFromCoBidual",
),

MorphismToBidualWithGivenBidual := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "MorphismFromCoBidualWithGivenCoBidual",
  dual_arguments_reversed := false,
),

TensorProductInternalHomCompatibilityMorphism := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, list[1], list[2] ), InternalHomOnObjects( cat, list[3], list[4] ) )",
  output_range_getter_string := "InternalHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[3] ), TensorProductOnObjects( cat, list[2], list[4] ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "InternalCoHomTensorProductCompatibilityMorphism",
  dual_preprocessor_func := { cat, list } -> [ Opposite( cat ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ] ],
  dual_arguments_reversed := false,
),

TensorProductInternalHomCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  return_type := "morphism",
  dual_operation := "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func :=
    { cat, s, list, r } -> [ Opposite( cat ), Opposite( r ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ], Opposite( s ) ],
  dual_arguments_reversed := false,
),

TensorProductDualityCompatibilityMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, DualOnObjects( cat, a ), DualOnObjects( cat, b ) )",
  output_range_getter_string := "DualOnObjects( cat, TensorProductOnObjects( cat, a, b ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CoDualityTensorProductCompatibilityMorphism",
  dual_arguments_reversed := false,
),

TensorProductDualityCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CoDualityTensorProductCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func := { cat, s, a, b, r} -> [ Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( s ) ],
  dual_arguments_reversed := false,
),

MorphismFromTensorProductToInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, DualOnObjects( cat, a ), b )",
  output_range_getter_string := "InternalHomOnObjects( cat, a, b )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "MorphismFromInternalCoHomToTensorProduct",
  dual_arguments_reversed := true,
),

MorphismFromTensorProductToInternalHomWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "MorphismFromInternalCoHomToTensorProductWithGivenObjects",
  dual_arguments_reversed := true,
),

IsomorphismFromInternalHomToDual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "i", "d" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCoDualToInternalCoHom",
),

IsomorphismFromDualToInternalHom := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "d", "i" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromInternalCoHomToCoDual",
),

UniversalPropertyOfDual := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "t", "a", "alpha" ], [ "t", "d" ] ],
  return_type := "morphism",
  dual_operation := "UniversalPropertyOfCoDual",
  dual_arguments_reversed := false,
),

LambdaIntroduction := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "i" ] ],
  return_type := "morphism",
  dual_operation := "CoLambdaIntroduction",
),

LambdaElimination := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "alpha" ], [ "a", "b" ] ],
  return_type := "morphism",
  dual_operation := "CoLambdaElimination",
  dual_preprocessor_func := { cat, a, b, alpha } -> [ Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( alpha ) ],
  dual_arguments_reversed := false,
),

IsomorphismFromObjectToInternalHom := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "InternalHomOnObjects( cat, TensorUnit( cat ), a )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "IsomorphismFromInternalCoHomToObject",
),

IsomorphismFromObjectToInternalHomWithGivenInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom",
  dual_arguments_reversed := false,
),

IsomorphismFromInternalHomToObject := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "InternalHomOnObjects( cat, TensorUnit( cat ), a )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "IsomorphismFromObjectToInternalCoHom",
),

IsomorphismFromInternalHomToObjectWithGivenInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom",
  dual_arguments_reversed := false,
),

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
