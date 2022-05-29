# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallValue( CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD, rec(

ExponentialOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i" ] ],
  return_type := "object",
  dual_operation := "CoexponentialOnObjects",
  dual_arguments_reversed := true,
  # Test in CartesianClosedCategoriesTest
),

ExponentialOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "s", "r" ] ],
  output_source_getter_string := "ExponentialOnObjects( cat, Range( alpha ), Source( beta ) )",
  output_range_getter_string := "ExponentialOnObjects( cat, Source( alpha ), Range( beta ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CoexponentialOnMorphisms",
  dual_arguments_reversed := true,
  # Test in CartesianClosedCategoriesTest
),

ExponentialOnMorphismsWithGivenExponentials := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CoexponentialOnMorphismsWithGivenCoexponentials",
  dual_arguments_reversed := true,
  # Test in CartesianClosedCategoriesTest
),

CartesianEvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "b" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, ExponentialOnObjects( cat, a, b ), a )",
  output_range_getter_string := "b",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CocartesianEvaluationMorphism",
  dual_arguments_reversed := true,
  # Test in CartesianClosedCategoriesTest
),

CartesianEvaluationMorphismWithGivenSource := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "s" ], [ "s", "b" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianEvaluationMorphismWithGivenRange",
  dual_preprocessor_func := { cat, a, b, s } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( s ) ),
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

CartesianCoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "ExponentialOnObjects( cat, b, BinaryDirectProduct( cat, a, b ) )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "CocartesianCoevaluationMorphism",
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

CartesianCoevaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianCoevaluationMorphismWithGivenSource",
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

DirectProductToExponentialAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "f" ], [ "a", "i" ] ],
  return_type := "morphism",
  dual_operation := "CoproductToCoexponentialAdjunctionMap",
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

ExponentialToDirectProductAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "b", "c", "g" ], [ "t", "c" ] ],
  return_type := "morphism",
  dual_operation := "CoexponentialToCoproductAdjunctionMap",
  dual_preprocessor_func := { cat, a, b, g } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ) ),
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

CartesianPreComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, ExponentialOnObjects( cat, a, b ), ExponentialOnObjects( cat, b, c ) )",
  output_range_getter_string := "ExponentialOnObjects( cat, a, c )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianPreCoComposeMorphism",
  dual_arguments_reversed := true,
  # Test in CartesianClosedCategoriesTest
),

CartesianPreComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianPreCoComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
  # Test in CartesianClosedCategoriesTest
),

CartesianPostComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, ExponentialOnObjects( cat, b, c ), ExponentialOnObjects( cat, a, b ) )",
  output_range_getter_string := "ExponentialOnObjects( cat, a, c )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianPostCoComposeMorphism",
  dual_arguments_reversed := true,
  # Test in CartesianClosedCategoriesTest
),

CartesianPostComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianPostCoComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
  # Test in CartesianClosedCategoriesTest
),

CartesianDualOnObjects := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "ad" ] ],
  return_type := "object",
  dual_operation := "CocartesianDualOnObjects",
  # Test in CartesianClosedCategoriesTest
),

CartesianDualOnMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "s", "r" ] ],
  output_source_getter_string := "CartesianDualOnObjects( cat, Range( alpha ) )",
  output_range_getter_string := "CartesianDualOnObjects( cat, Source( alpha ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianDualOnMorphisms",
  # Test in CartesianClosedCategoriesTest
),

CartesianDualOnMorphismsWithGivenCartesianDuals := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianDualOnMorphismsWithGivenCocartesianDuals",
  dual_arguments_reversed := true,
  # Test in CartesianClosedCategoriesTest
),

CartesianEvaluationForCartesianDual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, CartesianDualOnObjects( cat, a ), a )",
  output_range_getter_string := "TerminalObject( cat )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianEvaluationForCocartesianDual",
  # Test in CartesianClosedCategoriesTest
),

CartesianEvaluationForCartesianDualWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianEvaluationForCocartesianDualWithGivenCoproduct",
  dual_arguments_reversed := true,
  # Test in CartesianClosedCategoriesTest
),

MorphismToCartesianBidual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "CartesianDualOnObjects( cat, CartesianDualOnObjects( cat, a ) )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "MorphismFromCocartesianBidual",
  # Test in CartesianClosedCategoriesTest
),

MorphismToCartesianBidualWithGivenCartesianBidual := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "MorphismFromCocartesianBidualWithGivenCocartesianBidual",
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

DirectProductExponentialCompatibilityMorphism := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "BinaryDirectProduct( cat, ExponentialOnObjects( cat, list[1], list[2] ), ExponentialOnObjects( cat, list[3], list[4] ) )",
  output_range_getter_string := "ExponentialOnObjects( cat, BinaryDirectProduct( cat, list[1], list[3] ), BinaryDirectProduct( cat, list[2], list[4] ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CoexponentialCoproductCompatibilityMorphism",
  dual_preprocessor_func := { cat, list } -> Pair( Opposite( cat ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ] ),
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

DirectProductExponentialCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  return_type := "morphism",
  dual_operation := "CoexponentialCoproductCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func :=
    { cat, s, list, r } -> NTuple( 4, Opposite( cat ), Opposite( r ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ], Opposite( s ) ),
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

DirectProductCartesianDualityCompatibilityMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, CartesianDualOnObjects( cat, a ), CartesianDualOnObjects( cat, b ) )",
  output_range_getter_string := "CartesianDualOnObjects( cat, BinaryDirectProduct( cat, a, b ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianDualityCoproductCompatibilityMorphism",
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func := { cat, s, a, b, r } -> NTuple( 5, Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( s ) ),
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

MorphismFromDirectProductToExponential := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, CartesianDualOnObjects( cat, a ), b )",
  output_range_getter_string := "ExponentialOnObjects( cat, a, b )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "MorphismFromCoexponentialToCoproduct",
  dual_arguments_reversed := true,
  # Test in CartesianClosedCategoriesTest
),

MorphismFromDirectProductToExponentialWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "MorphismFromCoexponentialToCoproductWithGivenObjects",
  dual_arguments_reversed := true,
  # Test in CartesianClosedCategoriesTest
),

IsomorphismFromExponentialToCartesianDual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "i", "d" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCocartesianDualToCoexponential",
  # Test in CartesianClosedCategoriesTest
),

IsomorphismFromCartesianDualToExponential := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "d", "i" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCoexponentialToCocartesianDual",
  # Test in CartesianClosedCategoriesTest
),

UniversalPropertyOfCartesianDual := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "t", "a", "alpha" ], [ "t", "d" ] ],
  return_type := "morphism",
  dual_operation := "UniversalPropertyOfCocartesianDual",
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

CartesianLambdaIntroduction := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "i" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianLambdaIntroduction",
  # Test in CartesianClosedCategoriesTest
),

CartesianLambdaElimination := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "alpha" ], [ "a", "b" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianLambdaElimination",
  dual_preprocessor_func := { cat, a, b, alpha } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( alpha ) ),
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

IsomorphismFromObjectToExponential := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "ExponentialOnObjects( cat, TerminalObject( cat ), a )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "IsomorphismFromCoexponentialToObject",
  # Test in CartesianClosedCategoriesTest
),

IsomorphismFromObjectToExponentialWithGivenExponential := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCoexponentialToObjectWithGivenCoexponential",
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

IsomorphismFromExponentialToObject := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "ExponentialOnObjects( cat, TerminalObject( cat ), a )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "IsomorphismFromObjectToCoexponential",
  # Test in CartesianClosedCategoriesTest
),

IsomorphismFromExponentialToObjectWithGivenExponential := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromObjectToCoexponentialWithGivenCoexponential",
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

) );
