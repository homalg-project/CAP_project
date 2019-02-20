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

InternalCoHomToTensorProductAdjunctionMap := rec(
  installation_name := "InternalCoHomToTensorProductAdjunctionMap",
  filter_list := [ "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "f" ], [ "a", "t" ] ],
  cache_name := "InternalCoHomToTensorProductAdjunctionMap",
  return_type := "morphism",
  no_with_given := true ),

TensorProductToInternalCoHomAdjunctionMap := rec(
  installation_name := "TensorProductToInternalCoHomAdjunctionMap",
  filter_list := [ "object", "object", "morphism" ],
  io_type := [ [ "b", "c", "g" ], [ "i", "c" ] ],
  cache_name := "TensorProductToInternalCoHomAdjunctionMap",
  return_type := "morphism",
  no_with_given := true ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
