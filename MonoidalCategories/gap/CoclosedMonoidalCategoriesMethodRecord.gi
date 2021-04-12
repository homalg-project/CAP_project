InstallValue( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

InternalCoHomOnObjects := rec(
  installation_name := "InternalCoHomOnObjects",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i" ] ],
  cache_name := "InternalCoHomOnObjects",
  return_type := "object" ),

InternalCoHomOnMorphismsWithGivenInternalCoHoms := rec(
  installation_name := "InternalCoHomOnMorphismsWithGivenInternalCoHoms",
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  cache_name := "InternalCoHomOnMorphismsWithGivenInternalCoHoms",
  return_type := "morphism" ),

CoclosedEvaluationMorphismWithGivenRange := rec(
  installation_name := "CoclosedEvaluationMorphismWithGivenRange",
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "r" ], [ "a", "r" ] ],
  cache_name := "CoclosedEvaluationMorphismWithGivenRange",
  return_type := "morphism" ),

CoclosedCoevaluationMorphismWithGivenSource := rec(
  installation_name := "CoclosedCoevaluationMorphismWithGivenSource",
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "s" ], [ "s", "b" ] ],
  cache_name := "CoclosedCoevaluationMorphismWithGivenSource",
  return_type := "morphism" ),

InternalCoHomToTensorProductAdjunctionMap := rec(
  installation_name := "InternalCoHomToTensorProductAdjunctionMap",
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "f" ], [ "a", "t" ] ],
  cache_name := "InternalCoHomToTensorProductAdjunctionMap",
  return_type := "morphism",
  no_with_given := true ),

TensorProductToInternalCoHomAdjunctionMap := rec(
  installation_name := "TensorProductToInternalCoHomAdjunctionMap",
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "b", "c", "g" ], [ "i", "c" ] ],
  cache_name := "TensorProductToInternalCoHomAdjunctionMap",
  return_type := "morphism",
  no_with_given := true ),

MonoidalPreCoComposeMorphismWithGivenObjects := rec(
  installation_name := "MonoidalPreCoComposeMorphismWithGivenObjects",
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "MonoidalPreCoComposeMorphismWithGivenObjects",
  return_type := "morphism" ),

MonoidalPostCoComposeMorphismWithGivenObjects := rec(
  installation_name := "MonoidalPostCoComposeMorphismWithGivenObjects",
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "MonoidalPostCoComposeMorphismWithGivenObjects",
  return_type := "morphism" ),

CoDualOnObjects := rec(
  installation_name := "CoDualOnObjects",
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "acd" ] ],
  cache_name := "CoDualOnObjects",
  return_type := "object" ),

CoDualOnMorphismsWithGivenCoDuals := rec(
  installation_name := "CoDualOnMorphismsWithGivenCoDuals",
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  filter_list := [ "category", "object", "morphism", "object" ],
  cache_name := "CoDualOnMorphismsWithGivenCoDuals",
  return_type := "morphism" ),

CoclosedEvaluationForCoDualWithGivenTensorProduct := rec(
  installation_name := "CoclosedEvaluationForCoDualWithGivenTensorProduct",
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  cache_name := "CoclosedEvaluationForCoDualWithGivenTensorProduct",
  return_type := "morphism" ),

MorphismFromCoBidualWithGivenCoBidual := rec(
  installation_name := "MorphismFromCoBidualWithGivenCoBidual",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "s", "a" ], [ "s", "a" ] ],
  cache_name := "MorphismFromCoBidualWithGivenCoBidual",
  return_type := "morphism" ),

InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects := rec(
  installation_name := "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects",
  filter_list := [ "category", "object", "object", "object", "object", IsList ],
  io_type := [ [ "a", "ap", "b", "bp", "L" ], [ "L_1", "L_2" ] ],
  cache_name := "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects",
  return_type := "morphism" ),

CoDualityTensorProductCompatibilityMorphismWithGivenObjects := rec(
  installation_name := "CoDualityTensorProductCompatibilityMorphismWithGivenObjects",
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "CoDualityTensorProductCompatibilityMorphismWithGivenObjects",
  return_type := "morphism" ),

MorphismFromInternalCoHomToTensorProductWithGivenObjects := rec(
  installation_name := "MorphismFromInternalCoHomToTensorProductWithGivenObjects",
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "MorphismFromInternalCoHomToTensorProductWithGivenObjects",
  return_type := "morphism" ),

IsomorphismFromCoDualToInternalCoHom := rec(
  installation_name := "IsomorphismFromCoDualToInternalCoHom",
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "i", "d" ] ],
  cache_name := "IsomorphismFromCoDualToInternalCoHom",
  return_type := "morphism",
  no_with_given := true ),

IsomorphismFromInternalCoHomToCoDual := rec(
  installation_name := "IsomorphismFromInternalCoHomToCoDual",
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "d", "i" ] ],
  cache_name := "IsomorphismFromInternalCoHomToCoDual",
  return_type := "morphism",
  no_with_given := true ),

UniversalPropertyOfCoDual := rec(
  installation_name := "UniversalPropertyOfCoDual",
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "t", "alpha" ], [ "d", "t" ] ],
  cache_name := "UniversalPropertyOfCoDual",
  return_type := "morphism",
  no_with_given := true ),

CoLambdaIntroduction := rec(
  installation_name := "CoLambdaIntroduction",
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "i" ] ],
  cache_name := "CoLambdaIntroduction",
  return_type := "morphism",
  no_with_given := true ),

CoLambdaElimination := rec(
  installation_name := "CoLambdaElimination",
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "alpha" ], [ "a", "b" ] ],
  cache_name := "CoLambdaElimination",
  return_type := "morphism",
  no_with_given := true ),

IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom := rec(
  installation_name := "IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom",
  return_type := "morphism" ),

IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom := rec(
  installation_name := "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
