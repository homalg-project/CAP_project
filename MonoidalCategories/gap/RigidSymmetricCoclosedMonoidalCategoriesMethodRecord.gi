# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( RIGID_SYMMETRIC_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

CoclosedCoevaluationForCoDual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "TensorProductOnObjects( cat, a, CoDualOnObjects( cat, a ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "CoDualOnObjects", 1 ] ],
  output_range_getter_string := "TensorUnit( cat )",
  output_range_getter_preconditions := [ [ "TensorUnit", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "CoevaluationForDual",
  # Test in RigidSymmetricCoclosedMonoidalCategoriesTest
),

CoclosedCoevaluationForCoDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CoevaluationForDualWithGivenTensorProduct",
  dual_arguments_reversed := true,
),

MorphismToCoBidual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "CoDualOnObjects( cat, CoDualOnObjects( cat, a ) )",
  output_range_getter_preconditions := [ [ "CoDualOnObjects", 2 ] ],
  with_given_object_position := "Range",
  dual_operation := "MorphismFromBidual",
  # Test in RigidSymmetricCoclosedMonoidalCategoriesTest
),

MorphismToCoBidualWithGivenCoBidual := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromBidualWithGivenBidual",
  dual_arguments_reversed := false,
),

InternalCoHomTensorProductCompatibilityMorphismInverse := rec(
  filter_list := [ "category", "list_of_objects" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, list[1], list[3] ), InternalCoHomOnObjects( cat, list[2], list[4] ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "InternalCoHomOnObjects", 2 ] ],
  output_range_getter_string := "InternalCoHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[2] ), TensorProductOnObjects( cat, list[3], list[4] ) )",
  output_range_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ], [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "TensorProductInternalHomCompatibilityMorphismInverse",
  dual_preprocessor_func :=
    { cat, list } -> Pair( Opposite( cat ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ] ),
  dual_arguments_reversed := false,
  # Test in RigidSymmetricCoclosedMonoidalCategoriesTest
),

InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
  dual_preprocessor_func :=
    { cat, s, list, r } -> NTuple( 4, Opposite( cat ), Opposite( r ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ], Opposite( s ) ),
  dual_arguments_reversed := false,
),

MorphismFromTensorProductToInternalCoHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "TensorProductOnObjects( cat, CoDualOnObjects( cat, a ), b  )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "CoDualOnObjects", 1 ] ],
  output_range_getter_string := "InternalCoHomOnObjects( cat, b, a )",
  output_range_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "MorphismFromInternalHomToTensorProduct",
  dual_arguments_reversed := false,
  # Test in RigidSymmetricCoclosedMonoidalCategoriesTest
),

MorphismFromTensorProductToInternalCoHomWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromInternalHomToTensorProductWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

CoTraceMap := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha" ],
  dual_operation := "TraceMap",
  # Test in RigidSymmetricCoclosedMonoidalCategoriesTest
),

CoRankMorphism := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  dual_operation := "RankMorphism",
  # Test in RigidSymmetricCoclosedMonoidalCategoriesTest
),

IsomorphismFromInternalCoHomToTensorProductWithCoDualObject := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  dual_operation := "IsomorphismFromTensorProductWithDualObjectToInternalHom",
  dual_arguments_reversed := true,
  # Test in RigidSymmetricCoclosedMonoidalCategoriesTest
),

IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  dual_operation := "IsomorphismFromInternalHomToTensorProductWithDualObject",
  dual_arguments_reversed := false,
  # Test in RigidSymmetricCoclosedMonoidalCategoriesTest
),

) );

# collect closed and coclosed operations
BindGlobal( "RIGID_SYMMETRIC_LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD", rec( ) );

Perform( RecNames( RIGID_SYMMETRIC_LEFT_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD ), function ( name )

    RIGID_SYMMETRIC_LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD.(name) := RIGID_SYMMETRIC_LEFT_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD.(name);

end );

Perform( RecNames( RIGID_SYMMETRIC_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD ), function ( name )

    RIGID_SYMMETRIC_LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD.(name) := RIGID_SYMMETRIC_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD.(name);

end );

CAP_INTERNAL_ENHANCE_NAME_RECORD( RIGID_SYMMETRIC_LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    RIGID_SYMMETRIC_LEFT_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "RigidSymmetricClosedMonoidalCategoriesMethodRecord", "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    RIGID_SYMMETRIC_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "RigidSymmetricCoclosedMonoidalCategoriesMethodRecord", "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( RIGID_SYMMETRIC_LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( RIGID_SYMMETRIC_LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
