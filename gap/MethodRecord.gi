#
# Toposes: method-record
#
# Implementations
#

##
InstallValue( TOPOS_METHOD_NAME_RECORD, rec(

IsHomSetInhabited := rec(
  installation_name := "IsHomSetInhabited",
  filter_list := [ "object", "object" ],
  return_type := "bool",
  is_merely_set_theoretic := true ),

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
  return_type := "morphism" ),

ClassifyingMorphismOfSubobject := rec(
  installation_name := "ClassifyingMorphismOfSubobject",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ] , [ "alpha_range" , "S" ] ],
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
