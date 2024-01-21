# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( RIGID_SYMMETRIC_LEFT_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

CoevaluationForDual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "TensorUnit( cat )",
  output_source_getter_preconditions := [ [ "TensorUnit", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, a, DualOnObjects( cat, a ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "CoclosedCoevaluationForCoDual",
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

CoevaluationForDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CoclosedCoevaluationForCoDualWithGivenTensorProduct",
  dual_arguments_reversed := true,
),

MorphismFromBidual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "DualOnObjects( cat, DualOnObjects( cat, a ) )",
  output_source_getter_preconditions := [ [ "DualOnObjects", 2 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  dual_operation := "MorphismToCoBidual",
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

MorphismFromBidualWithGivenBidual := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismToCoBidualWithGivenCoBidual",
  dual_arguments_reversed := false,
),

TensorProductInternalHomCompatibilityMorphismInverse := rec(
  filter_list := [ "category", "list_of_objects" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "InternalHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[3] ), TensorProductOnObjects( cat, list[2], list[4] ) )",
  output_source_getter_preconditions := [ [ "InternalHomOnObjects", 1 ], [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, list[1], list[2] ), InternalHomOnObjects( cat, list[3], list[4] ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "InternalHomOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "InternalCoHomTensorProductCompatibilityMorphismInverse",
  dual_preprocessor_func :=
    { cat, list } -> Pair( Opposite( cat ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ] ),
  dual_arguments_reversed := false,
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
  dual_preprocessor_func :=
    { cat, s, list, r } -> NTuple( 4, Opposite( cat ), Opposite( r ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ], Opposite( s ) ),
  dual_arguments_reversed := false,
),

MorphismFromInternalHomToTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "InternalHomOnObjects( cat, a, b )",
  output_source_getter_preconditions := [ [ "InternalHomOnObjects", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, DualOnObjects( cat, a ), b )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "MorphismFromTensorProductToInternalCoHom",
  dual_arguments_reversed := false,
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

MorphismFromInternalHomToTensorProductWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromTensorProductToInternalCoHomWithGivenObjects",
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

IsomorphismFromTensorProductWithDualObjectToInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  dual_operation := "IsomorphismFromInternalCoHomToTensorProductWithCoDualObject",
  dual_arguments_reversed := true,
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

IsomorphismFromInternalHomToTensorProductWithDualObject := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  dual_operation := "IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom",
  dual_arguments_reversed := false,
  # Test in RigidSymmetricClosedMonoidalCategoriesTest
),

) );
