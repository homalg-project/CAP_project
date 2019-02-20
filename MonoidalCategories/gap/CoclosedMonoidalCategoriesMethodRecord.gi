InstallValue( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

InternalCoHomOnObjects := rec(
  installation_name := "InternalCoHomOnObjects",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i" ] ],
  cache_name := "InternalCoHomOnObjects",
  return_type := "object" ),

InternalCoHomOnMorphismsWithGivenInternalCoHoms := rec(
  installation_name := "InternalCoHomOnMorphismsWithGivenInternalCoHoms",
  filter_list := [ "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  cache_name := "InternalCoHomOnMorphismsWithGivenInternalCoHoms",
  return_type := "morphism" ),

CoEvaluationMorphismWithGivenRange := rec(
  installation_name := "CoEvaluationMorphismWithGivenRange",
  filter_list := [ "object", "object", "object" ],
  io_type := [ [ "a", "b", "r" ], [ "a", "r" ] ],
  cache_name := "CoEvaluationMorphismWithGivenRange",
  return_type := "morphism" ),

DualCoEvaluationMorphismWithGivenSource := rec(
  installation_name := "DualCoEvaluationMorphismWithGivenSource",
  filter_list := [ "object", "object", "object" ],
  io_type := [ [ "a", "b", "s" ], [ "s", "b" ] ],
  cache_name := "DualCoEvaluationMorphismWithGivenSource",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
