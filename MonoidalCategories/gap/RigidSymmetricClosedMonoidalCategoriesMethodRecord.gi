InstallValue( RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

CoevaluationForDualWithGivenTensorProduct := rec(
  installation_name := "CoevaluationForDualWithGivenTensorProduct",
  filter_list := [ "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  cache_name := "CoevaluationForDualWithGivenTensorProduct",
  return_type := "morphism" ),

MorphismFromBidualWithGivenBidual := rec(
  installation_name := "MorphismFromBidualWithGivenBidual",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "MorphismFromBidualWithGivenBidual",
  return_type := "morphism" ),

TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects := rec(
  installation_name := "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
  filter_list := [ "object", "object", "object", "object", IsList ],
  io_type := [ [ "a", "ap", "b", "bp", "L" ], [ "L_2", "L_1" ] ],
  cache_name := "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
  return_type := "morphism" ),

MorphismFromInternalHomToTensorProductWithGivenObjects := rec(
  installation_name := "MorphismFromInternalHomToTensorProductWithGivenObjects",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "MorphismFromInternalHomToTensorProductWithGivenObjects",
  return_type := "morphism" ),

TraceMap := rec(
  installation_name := "TraceMap",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "u" ] ],
  cache_name := "TraceMap",
  return_type := "morphism",
  no_with_given := true ),

RankMorphism := rec(
  installation_name := "RankMorphism",
  filter_list := [ "object" ],
  io_type := [ [ "a" ], [ "u", "u" ] ],
  cache_name := "RankMorphism",
  return_type := "morphism",
  no_with_given := true ),

IsomorphismFromTensorProductToInternalHom := rec(
  installation_name := "IsomorphismFromTensorProductToInternalHom",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "b" ], [ "t", "i" ] ],
  cache_name := "IsomorphismFromTensorProductToInternalHom",
  return_type := "morphism",
  no_with_given := true ),

IsomorphismFromInternalHomToTensorProduct := rec(
  installation_name := "IsomorphismFromInternalHomToTensorProduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i", "t" ] ],
  cache_name := "IsomorphismFromInternalHomToTensorProduct",
  return_type := "morphism",
  no_with_given := true ),
  
) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
