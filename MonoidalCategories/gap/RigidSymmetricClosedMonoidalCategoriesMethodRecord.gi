# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

# Pre processor functions for dual operations
BindGlobal( "PreProcessorFuncTensorProductInternalHomCompatibilityMorphismInverse",
              { cat, list } -> [ Opposite( cat ), [ Opposite( list[3] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[2] ) ] ]
);

BindGlobal( "PreProcessorFuncTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
              { cat, s, list, r } -> [ Opposite( cat ), Opposite( r ), [ Opposite( list[3] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[2] ) ], Opposite( s ) ]
);

BindGlobal( "PreProcessorFuncMorphismFromInternalHomToTensorProductWithGivenObjects",
              { cat, s, a, b, r } -> [ Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( s ) ]
);

InstallValue( RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

CoevaluationForDual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorUnit( cat )",
  output_range_getter_string := "TensorProductOnObjects( cat, a, DualOnObjects( cat, a ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CoclosedCoevaluationForCoDual",
),

CoevaluationForDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CoclosedCoevaluationForCoDualWithGivenTensorProduct",
  dual_arguments_reversed := true,
),

MorphismFromBidual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "DualOnObjects( cat, DualOnObjects( cat, a ) )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "MorphismToCoBidual",
),

MorphismFromBidualWithGivenBidual := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism",
  dual_operation := "MorphismToCoBidualWithGivenCoBidual",
  dual_arguments_reversed := false,
),

TensorProductInternalHomCompatibilityMorphismInverse := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "InternalHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[3] ), TensorProductOnObjects( cat, list[2], list[4] ) )",
  output_range_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, list[1], list[2] ), InternalHomOnObjects( cat, list[3], list[4] ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "InternalCoHomTensorProductCompatibilityMorphismInverse",
  dual_preprocessor_func := PreProcessorFuncTensorProductInternalHomCompatibilityMorphismInverse,
  dual_arguments_reversed := false,
),

TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  return_type := "morphism",
  dual_operation := "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
  dual_preprocessor_func := PreProcessorFuncTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects,
  dual_arguments_reversed := false,
),

MorphismFromInternalHomToTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "InternalHomOnObjects( cat, a, b )",
  output_range_getter_string := "TensorProductOnObjects( cat, DualOnObjects( cat, a ), b )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "MorphismFromTensorProductToInternalCoHom",
  dual_arguments_reversed := false,
),

MorphismFromInternalHomToTensorProductWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "MorphismFromTensorProductToInternalCoHomWithGivenObjects",
  dual_preprocessor_func := PreProcessorFuncMorphismFromInternalHomToTensorProductWithGivenObjects,
  dual_arguments_reversed := false,
),

TraceMap := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "u" ] ],
  return_type := "morphism",
  dual_operation := "CoTraceMap",
),

RankMorphism := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "u", "u" ] ],
  return_type := "morphism",
  dual_operation := "CoRankMorphism",
),

IsomorphismFromTensorProductToInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "t", "i" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromInternalCoHomToTensorProduct",
  dual_arguments_reversed := true,
),

IsomorphismFromInternalHomToTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i", "t" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromTensorProductToInternalCoHom",
  dual_arguments_reversed := false,
),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "RigidSymmetricClosedMonoidalCategories.autogen.gd",
    "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
