InstallValue( RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

CoclosedCoevaluationForCoDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  cache_name := "CoclosedCoevaluationForCoDualWithGivenTensorProduct",
  return_type := "morphism" ),

MorphismToCoBidualWithGivenCoBidual := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "MorphismToCoBidualWithGivenCoBidual",
  return_type := "morphism" ),

InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", IsList ],
  cache_name := "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
  return_type := "morphism" ),

MorphismFromTensorProductToInternalCoHomWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "MorphismFromTensorProductToInternalCoHomWithGivenObjects",
  return_type := "morphism" ),

CoTraceMap := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "u" ] ],
  cache_name := "CoTraceMap",
  return_type := "morphism",
  no_with_given := true ),

CoRankMorphism := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "u", "u" ] ],
  cache_name := "CoRankMorphism",
  return_type := "morphism",
  no_with_given := true ),

IsomorphismFromInternalCoHomToTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i", "t" ] ],
  cache_name := "IsomorphismFromInternalCoHomToTensorProduct",
  return_type := "morphism",
  no_with_given := true ),

IsomorphismFromTensorProductToInternalCoHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "t", "i" ] ],
  cache_name := "IsomorphismFromTensorProductToInternalCoHom",
  return_type := "morphism",
  no_with_given := true ),
  
) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
