# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

CoclosedCoevaluationForCoDual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, CoDualOnObjects( cat, a ), a )",
  output_range_getter_string := "TensorUnit( cat )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CoclosedCoevaluationForCoDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

MorphismToCoBidual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "CoDualOnObjects( cat, CoDualOnObjects( cat, a ) )",
  with_given_object_position := "Range",
  return_type := "morphism" ),

MorphismToCoBidualWithGivenCoBidual := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism" ),

InternalCoHomTensorProductCompatibilityMorphismInverse := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, list[1], list[3] ), InternalCoHomOnObjects( cat, list[2], list[4] ) )",
  output_range_getter_string := "InternalCoHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[2] ), TensorProductOnObjects( cat, list[3], list[4] ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  return_type := "morphism" ),

MorphismFromTensorProductToInternalCoHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, a, DualOnObjects( cat, b ) )",
  output_range_getter_string := "InternalCoHomOnObjects( cat, a, b )",
  with_given_object_position := "both",
  return_type := "morphism" ),

MorphismFromTensorProductToInternalCoHomWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CoTraceMap := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "u" ] ],
  return_type := "morphism",
),

CoRankMorphism := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "u", "u" ] ],
  return_type := "morphism",
),

IsomorphismFromInternalCoHomToTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i", "t" ] ],
  return_type := "morphism",
),

IsomorphismFromTensorProductToInternalCoHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "t", "i" ] ],
  return_type := "morphism",
),
  
) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "RigidSymmetricCoclosedMonoidalCategories.autogen.gd",
    "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
