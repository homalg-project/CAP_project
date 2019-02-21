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

MonoidalPreCoComposeMorphismWithGivenObjects := rec(
  installation_name := "MonoidalPreCoComposeMorphismWithGivenObjects",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "MonoidalPreCoComposeMorphismWithGivenObjects",
  return_type := "morphism" ),

MonoidalPostCoComposeMorphismWithGivenObjects := rec(
  installation_name := "MonoidalPostCoComposeMorphismWithGivenObjects",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "MonoidalPostCoComposeMorphismWithGivenObjects",
  return_type := "morphism" ),

CoDualOnObjects := rec(
  installation_name := "CoDualOnObjects",
  filter_list := [ "object" ],
  io_type := [ [ "a" ], [ "acd" ] ],
  cache_name := "CoDualOnObjects",
  return_type := "object" ),

CoDualOnMorphismsWithGivenCoDuals := rec(
  installation_name := "CoDualOnMorphismsWithGivenCoDuals",
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  filter_list := [ "object", "morphism", "object" ],
  cache_name := "CoDualOnMorphismsWithGivenCoDuals",
  return_type := "morphism" ),

CoEvaluationForCoDualWithGivenTensorProduct := rec(
  installation_name := "CoEvaluationForCoDualWithGivenTensorProduct",
  filter_list := [ "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  cache_name := "CoEvaluationForCoDualWithGivenTensorProduct",
  return_type := "morphism" ),

MorphismFromCoBidualWithGivenCoBidual := rec(
  installation_name := "MorphismFromCoBidualWithGivenCoBidual",
  filter_list := [ "object", "object" ],
  io_type := [ [ "s", "a" ], [ "s", "a" ] ],
  cache_name := "MorphismFromCoBidualWithGivenCoBidual",
  return_type := "morphism" ),

IsomorphismFromCoDualToInternalCoHom := rec(
  installation_name := "IsomorphismFromCoDualToInternalCoHom",
  filter_list := [ "object" ],
  io_type := [ [ "a" ], [ "i", "d" ] ],
  cache_name := "IsomorphismFromCoDualToInternalCoHom",
  return_type := "morphism",
  no_with_given := true ),

IsomorphismFromInternalCoHomToCoDual := rec(
  installation_name := "IsomorphismFromInternalCoHomToCoDual",
  filter_list := [ "object" ],
  io_type := [ [ "a" ], [ "d", "i" ] ],
  cache_name := "IsomorphismFromInternalCoHomToCoDual",
  return_type := "morphism",
  no_with_given := true ),
) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
