# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
InstallValue( TOPOS_METHOD_NAME_RECORD, rec(

SubobjectClassifier := rec(
  filter_list := [ "category" ],
  return_type := "object" ),

CartesianSquareOfSubobjectClassifier := rec(
  filter_list := [ "category" ],
  return_type := "object" ),

TruthMorphismOfTrue := rec(
  filter_list := [ "category" ],
  output_source_getter_string := "TerminalObject( cat )",
  output_range_getter_string := "SubobjectClassifier( cat )",
  with_given_object_position := "both",
  io_type := [ [ ] , [ "T" , "Omega" ] ],
  return_type := "morphism" ),

TruthMorphismOfTrueWithGivenObjects := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "T", "Omega" ] , [ "T" , "Omega" ] ],
  return_type := "morphism" ),

TruthMorphismOfFalse := rec(
  filter_list := [ "category" ],
  output_source_getter_string := "TerminalObject( cat )",
  output_range_getter_string := "SubobjectClassifier( cat )",
  with_given_object_position := "both",
  io_type := [ [ ] , [ "T" , "Omega" ] ],
  return_type := "morphism" ),

TruthMorphismOfFalseWithGivenObjects := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "T", "Omega" ] , [ "T" , "Omega" ] ],
  return_type := "morphism" ),

TruthMorphismOfNot := rec(
  filter_list := [ "category" ],
  output_source_getter_string := "SubobjectClassifier( cat )",
  output_range_getter_string := "SubobjectClassifier( cat )",
  with_given_object_position := "both",
  io_type := [ [ ] , [ "Omega" , "Omega1" ] ],
  return_type := "morphism" ),

TruthMorphismOfNotWithGivenObjects := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "Omega", "Omega1" ] , [ "Omega" , "Omega1" ] ],
  return_type := "morphism" ),

TruthMorphismOfAnd := rec(
  filter_list := [ "category" ],
  output_source_getter_string := "CartesianSquareOfSubobjectClassifier( cat )",
  output_range_getter_string := "SubobjectClassifier( cat )",
  with_given_object_position := "both",
  io_type := [ [ ] , [ "Omega2" , "Omega" ] ],
  return_type := "morphism" ),

TruthMorphismOfAndWithGivenObjects := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "Omega2", "Omega" ] , [ "Omega2" , "Omega" ] ],
  return_type := "morphism" ),

TruthMorphismOfOr := rec(
  filter_list := [ "category" ],
  output_source_getter_string := "CartesianSquareOfSubobjectClassifier( cat )",
  output_range_getter_string := "SubobjectClassifier( cat )",
  with_given_object_position := "both",
  io_type := [ [ ] , [ "Omega2" , "Omega" ] ],
  return_type := "morphism" ),

TruthMorphismOfOrWithGivenObjects := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "Omega2", "Omega" ] , [ "Omega2" , "Omega" ] ],
  return_type := "morphism" ),

TruthMorphismOfImplies := rec(
  filter_list := [ "category" ],
  output_source_getter_string := "CartesianSquareOfSubobjectClassifier( cat )",
  output_range_getter_string := "SubobjectClassifier( cat )",
  with_given_object_position := "both",
  io_type := [ [ ] , [ "Omega2" , "Omega" ] ],
  return_type := "morphism" ),

TruthMorphismOfImpliesWithGivenObjects := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "Omega2", "Omega" ] , [ "Omega2" , "Omega" ] ],
  return_type := "morphism" ),

ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier := rec(
  filter_list := [ "category", "morphism" , "object" ],
  io_type := [ [ "alpha", "Omega" ] , [ "alpha_range" , "Omega" ] ],
  return_type := "morphism" ),

ClassifyingMorphismOfSubobject := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ] , [ "alpha_range" , "Omega" ] ],
  with_given_object_position := "Range",
  return_type := "morphism" ),

SubobjectOfClassifyingMorphism := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ] , [ "subobject" , "alpha_source" ] ],
  return_type := "morphism" ),

 ) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( TOPOS_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    TOPOS_METHOD_NAME_RECORD,
    "Toposes",
    "Topos.autogen.gd",
    "Toposes",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( TOPOS_METHOD_NAME_RECORD, "Toposes" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( TOPOS_METHOD_NAME_RECORD );

##
AppendToAhomalgTable( TOPOS_METHOD_NAME_RECORD, CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

##
AppendToAhomalgTable( TOPOS_METHOD_NAME_RECORD, CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD );

##
AppendToAhomalgTable( TOPOS_METHOD_NAME_RECORD, COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

##
AppendToAhomalgTable( TOPOS_METHOD_NAME_RECORD, COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD );
