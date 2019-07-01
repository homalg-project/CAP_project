InstallValue( CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

InternalHomOnObjects := rec(
  installation_name := "InternalHomOnObjects",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i" ] ],
  cache_name := "InternalHomOnObjects",
  return_type := "object" ),

InternalHomOnMorphismsWithGivenInternalHoms := rec(
  installation_name := "InternalHomOnMorphismsWithGivenInternalHoms",
  filter_list := [ "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  cache_name := "InternalHomOnMorphismsWithGivenInternalHoms",
  return_type := "morphism" ),

EvaluationMorphismWithGivenSource := rec(
  installation_name := "EvaluationMorphismWithGivenSource",
  filter_list := [ "object", "object", "object" ],
  io_type := [ [ "a", "b", "s" ], [ "s", "b" ] ],
  cache_name := "EvaluationMorphismWithGivenSource",
  return_type := "morphism" ),

CoevaluationMorphismWithGivenRange := rec(
  installation_name := "CoevaluationMorphismWithGivenRange",
  filter_list := [ "object", "object", "object" ],
  io_type := [ [ "a", "b", "r" ], [ "a", "r" ] ],
  cache_name := "CoevaluationMorphismWithGivenRange",
  return_type := "morphism" ),

TensorProductToInternalHomAdjunctionMap := rec(
  installation_name := "TensorProductToInternalHomAdjunctionMap",
  filter_list := [ "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "f" ], [ "a", "i" ] ],
  cache_name := "TensorProductToInternalHomAdjunctionMap",
  return_type := "morphism",
  no_with_given := true ),

InternalHomToTensorProductAdjunctionMap := rec(
  installation_name := "InternalHomToTensorProductAdjunctionMap",
  filter_list := [ "object", "object", "morphism" ],
  io_type := [ [ "b", "c", "g" ], [ "t", "c" ] ],
  cache_name := "InternalHomToTensorProductAdjunctionMap",
  return_type := "morphism",
  no_with_given := true ),

MonoidalPreComposeMorphismWithGivenObjects := rec(
  installation_name := "MonoidalPreComposeMorphismWithGivenObjects",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "MonoidalPreComposeMorphismWithGivenObjects",
  return_type := "morphism" ),

MonoidalPostComposeMorphismWithGivenObjects := rec(
  installation_name := "MonoidalPostComposeMorphismWithGivenObjects",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "MonoidalPostComposeMorphismWithGivenObjects",
  return_type := "morphism" ),

DualOnObjects := rec(
  installation_name := "DualOnObjects",
  filter_list := [ "object" ],
  io_type := [ [ "a" ], [ "ad" ] ],
  cache_name := "DualOnObjects",
  return_type := "object" ),

DualOnMorphismsWithGivenDuals := rec(
  installation_name := "DualOnMorphismsWithGivenDuals",
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  filter_list := [ "object", "morphism", "object" ],
  cache_name := "DualOnMorphismsWithGivenDuals",
  return_type := "morphism" ),

EvaluationForDualWithGivenTensorProduct := rec(
  installation_name := "EvaluationForDualWithGivenTensorProduct",
  filter_list := [ "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  cache_name := "EvaluationForDualWithGivenTensorProduct",
  return_type := "morphism" ),

MorphismToBidualWithGivenBidual := rec(
  installation_name := "MorphismToBidualWithGivenBidual",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "MorphismToBidualWithGivenBidual",
  return_type := "morphism" ),

TensorProductInternalHomCompatibilityMorphismWithGivenObjects := rec(
  installation_name := "TensorProductInternalHomCompatibilityMorphismWithGivenObjects",
  filter_list := [ "object", "object", "object", "object", IsList ],
  io_type := [ [ "a", "ap", "b", "bp", "L" ], [ "L_1", "L_2" ] ],
  cache_name := "TensorProductInternalHomCompatibilityMorphismWithGivenObjects",
  return_type := "morphism" ),

TensorProductDualityCompatibilityMorphismWithGivenObjects := rec(
  installation_name := "TensorProductDualityCompatibilityMorphismWithGivenObjects",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "TensorProductDualityCompatibilityMorphismWithGivenObjects",
  return_type := "morphism" ),

MorphismFromTensorProductToInternalHomWithGivenObjects := rec(
  installation_name := "MorphismFromTensorProductToInternalHomWithGivenObjects",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "MorphismFromTensorProductToInternalHomWithGivenObjects",
  return_type := "morphism" ),

IsomorphismFromInternalHomToDual := rec(
  installation_name := "IsomorphismFromInternalHomToDual",
  filter_list := [ "object" ],
  io_type := [ [ "a" ], [ "i", "d" ] ],
  cache_name := "IsomorphismFromInternalHomToDual",
  return_type := "morphism",
  no_with_given := true ),

IsomorphismFromDualToInternalHom := rec(
  installation_name := "IsomorphismFromDualToInternalHom",
  filter_list := [ "object" ],
  io_type := [ [ "a" ], [ "d", "i" ] ],
  cache_name := "IsomorphismFromDualToInternalHom",
  return_type := "morphism",
  no_with_given := true ),

UniversalPropertyOfDual := rec(
  installation_name := "UniversalPropertyOfDual",
  filter_list := [ "object", "object", "morphism" ],
  io_type := [ [ "t", "a", "alpha" ], [ "t", "d" ] ],
  cache_name := "UniversalPropertyOfDual",
  return_type := "morphism",
  no_with_given := true ),

LambdaIntroduction := rec(
  installation_name := "LambdaIntroduction",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "i" ] ],
  cache_name := "LambdaIntroduction",
  return_type := "morphism",
  no_with_given := true ),

LambdaElimination := rec(
  installation_name := "LambdaElimination",
  filter_list := [ "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "alpha" ], [ "a", "b" ] ],
  cache_name := "LambdaElimination",
  return_type := "morphism",
  no_with_given := true ),

IsomorphismFromObjectToInternalHomWithGivenInternalHom := rec(
  installation_name := "IsomorphismFromObjectToInternalHomWithGivenInternalHom",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "IsomorphismFromObjectToInternalHomWithGivenInternalHom",
  return_type := "morphism" ),

IsomorphismFromInternalHomToObjectWithGivenInternalHom := rec(
  installation_name := "IsomorphismFromInternalHomToObjectWithGivenInternalHom",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "IsomorphismFromInternalHomToObjectWithGivenInternalHom",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
