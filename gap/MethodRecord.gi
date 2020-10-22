# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
InstallValue( TOPOS_METHOD_NAME_RECORD, rec(

SubobjectClassifier := rec(
  installation_name := "SubobjectClassifier",
  filter_list := [ "category" ],
  cache_name := "SubobjectClassifier",
  return_type := "object" ),

TruthMorphismIntoSubobjectClassifierWithGivenObjects := rec(
  installation_name := "TruthMorphismIntoSubobjectClassifierWithGivenObjects",
  filter_list := [ "object", "object" ],
  io_type := [ [ "I", "S" ] , [ "I" , "S" ] ],
  universal_object_position := "Range",
  return_type := "morphism" ),

ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier := rec(
  installation_name := "ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
  filter_list := [ "morphism" , "object" ],
  io_type := [ [ "alpha", "S" ] , [ "alpha_range" , "S" ] ],
  number_of_diagram_arguments := 1,
  return_type := "morphism" ),

ClassifyingMorphismOfSubobject := rec(
  installation_name := "ClassifyingMorphismOfSubobject",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ] , [ "alpha_range" , "S" ] ],
  number_of_diagram_arguments := 1,
  return_type := "morphism" ),

SubobjectOfClassifyingMorphism := rec(
  installation_name := "SubobjectOfClassifyingMorphism",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ] , [ "subobject" , "alpha_source" ] ],
  return_type := "morphism" ),

 ) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( TOPOS_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( TOPOS_METHOD_NAME_RECORD );

##
AppendToAhomalgTable( TOPOS_METHOD_NAME_RECORD, CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

##
AppendToAhomalgTable( TOPOS_METHOD_NAME_RECORD, CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD );

##
AppendToAhomalgTable( TOPOS_METHOD_NAME_RECORD, COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

##
AppendToAhomalgTable( TOPOS_METHOD_NAME_RECORD, COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD );
