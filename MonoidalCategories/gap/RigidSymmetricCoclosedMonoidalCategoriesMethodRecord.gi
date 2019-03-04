InstallValue( RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

CoclosedCoevaluationForCoDualWithGivenTensorProduct := rec(
  installation_name := "CoclosedCoevaluationForCoDualWithGivenTensorProduct",
  filter_list := [ "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  cache_name := "CoclosedCoevaluationForCoDualWithGivenTensorProduct",
  return_type := "morphism" ),

MorphismToCoBidualWithGivenCoBidual := rec(
  installation_name := "MorphismToCoBidualWithGivenCoBidual",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "MorphismToCoBidualWithGivenCoBidual",
  return_type := "morphism" ),

InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects := rec(
  installation_name := "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
  filter_list := [ "object", "object", "object", "object", IsList ],
  io_type := [ [ "a", "ap", "b", "bp", "L" ], [ "L_2", "L_1" ] ],
  cache_name := "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
  return_type := "morphism" ),

MorphismFromTensorProductToInternalCoHomWithGivenObjects := rec(
  installation_name := "MorphismFromTensorProductToInternalCoHomWithGivenObjects",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "MorphismFromTensorProductToInternalCoHomWithGivenObjects",
  return_type := "morphism" ),

CoTraceMap := rec(
  installation_name := "CoTraceMap",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "u" ] ],
  cache_name := "CoTraceMap",
  return_type := "morphism",
  no_with_given := true ),

CoRankMorphism := rec(
  installation_name := "CoRankMorphism",
  filter_list := [ "object" ],
  io_type := [ [ "a" ], [ "u", "u" ] ],
  cache_name := "CoRankMorphism",
  return_type := "morphism",
  no_with_given := true ),

IsomorphismFromInternalCoHomToTensorProduct := rec(
  installation_name := "IsomorphismFromInternalCoHomToTensorProduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i", "t" ] ],
  cache_name := "IsomorphismFromInternalCoHomToTensorProduct",
  return_type := "morphism",
  no_with_given := true ),

IsomorphismFromTensorProductToInternalCoHom := rec(
  installation_name := "IsomorphismFromTensorProductToInternalCoHom",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "b" ], [ "t", "i" ] ],
  cache_name := "IsomorphismFromTensorProductToInternalCoHom",
  return_type := "morphism",
  no_with_given := true ),
  
) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
