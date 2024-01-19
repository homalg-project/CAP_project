# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( RIGID_SYMMETRIC_LEFT_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

CoevaluationForLeftDual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "TensorUnit( cat )",
  output_source_getter_preconditions := [ [ "TensorUnit", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, a, LeftDualOnObjects( cat, a ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftDualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftCoclosedMonoidalCoevaluationForLeftCoDual",
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

CoevaluationForLeftDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCoclosedMonoidalCoevaluationForLeftCoDualWithGivenTensorProduct",
  dual_arguments_reversed := true,
),

MorphismFromLeftBidual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "LeftDualOnObjects( cat, LeftDualOnObjects( cat, a ) )",
  output_source_getter_preconditions := [ [ "LeftDualOnObjects", 2 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  dual_operation := "MorphismToLeftCoBidual",
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

MorphismFromLeftBidualWithGivenLeftBidual := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismToLeftCoBidualWithGivenLeftCoBidual",
  dual_arguments_reversed := false,
),

TensorProductLeftInternalHomCompatibilityMorphismInverse := rec(
  filter_list := [ "category", "list_of_objects" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "LeftInternalHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[3] ), TensorProductOnObjects( cat, list[2], list[4] ) )",
  output_source_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ], [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, LeftInternalHomOnObjects( cat, list[1], list[2] ), LeftInternalHomOnObjects( cat, list[3], list[4] ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftInternalHomOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftInternalCoHomTensorProductCompatibilityMorphismInverse",
  dual_preprocessor_func :=
    { cat, list } -> Pair( Opposite( cat ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ] ),
  dual_arguments_reversed := false,
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

TensorProductLeftInternalHomCompatibilityMorphismInverseWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "LeftInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
  dual_preprocessor_func :=
    { cat, s, list, r } -> NTuple( 4, Opposite( cat ), Opposite( r ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ], Opposite( s ) ),
  dual_arguments_reversed := false,
),

MorphismFromLeftInternalHomToTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "LeftInternalHomOnObjects( cat, a, b )",
  output_source_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, LeftDualOnObjects( cat, a ), b )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftDualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "MorphismFromTensorProductToLeftInternalCoHom",
  dual_arguments_reversed := false,
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

MorphismFromLeftInternalHomToTensorProductWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromTensorProductToLeftInternalCoHomWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

TraceMap := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha" ],
  dual_operation := "CoTraceMap",
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

RankMorphism := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  dual_operation := "CoRankMorphism",
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  dual_operation := "IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject",
  dual_arguments_reversed := true,
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  dual_operation := "IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom",
  dual_arguments_reversed := false,
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

) );
