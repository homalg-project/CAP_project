# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD, rec(

CoexponentialOnObjects := rec(
  installation_name := "CoexponentialOnObjects",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i" ] ],
  cache_name := "CoexponentialOnObjects",
  return_type := "object",
  dual_operation := "ExponentialOnObjects",
  dual_arguments_reversed := true ),

CoexponentialOnMorphismsWithGivenCoexponentials := rec(
  installation_name := "CoexponentialOnMorphismsWithGivenCoexponentials",
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  cache_name := "CoexponentialOnMorphismsWithGivenCoexponentials",
  return_type := "morphism",
  dual_operation := "ExponentialOnMorphismsWithGivenExponentials",
  dual_arguments_reversed := true ),

CocartesianEvaluationMorphismWithGivenRange := rec(
  installation_name := "CocartesianEvaluationMorphismWithGivenRange",
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "r" ], [ "a", "r" ] ],
  cache_name := "CocartesianEvaluationMorphismWithGivenRange",
  return_type := "morphism" ),

CocartesianCoevaluationMorphismWithGivenSource := rec(
  installation_name := "CocartesianCoevaluationMorphismWithGivenSource",
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "s" ], [ "s", "b" ] ],
  cache_name := "CocartesianCoevaluationMorphismWithGivenSource",
  return_type := "morphism" ),

CoexponentialToCoproductAdjunctionMap := rec(
  installation_name := "CoexponentialToCoproductAdjunctionMap",
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "f" ], [ "a", "t" ] ],
  cache_name := "CoexponentialToCoproductAdjunctionMap",
  return_type := "morphism",
),

CoproductToCoexponentialAdjunctionMap := rec(
  installation_name := "CoproductToCoexponentialAdjunctionMap",
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "b", "c", "g" ], [ "i", "c" ] ],
  cache_name := "CoproductToCoexponentialAdjunctionMap",
  return_type := "morphism",
),

CocartesianPreCoComposeMorphismWithGivenObjects := rec(
  installation_name := "CocartesianPreCoComposeMorphismWithGivenObjects",
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "CocartesianPreCoComposeMorphismWithGivenObjects",
  return_type := "morphism" ),

CocartesianPostCoComposeMorphismWithGivenObjects := rec(
  installation_name := "CocartesianPostCoComposeMorphismWithGivenObjects",
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "CocartesianPostCoComposeMorphismWithGivenObjects",
  return_type := "morphism" ),

CocartesianDualOnObjects := rec(
  installation_name := "CocartesianDualOnObjects",
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "acd" ] ],
  cache_name := "CocartesianDualOnObjects",
  return_type := "object" ),

CocartesianDualOnMorphismsWithGivenCocartesianDuals := rec(
  installation_name := "CocartesianDualOnMorphismsWithGivenCocartesianDuals",
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  filter_list := [ "category", "object", "morphism", "object" ],
  cache_name := "CocartesianDualOnMorphismsWithGivenCocartesianDuals",
  return_type := "morphism" ),

CocartesianEvaluationForCocartesianDualWithGivenCoproduct := rec(
  installation_name := "CocartesianEvaluationForCocartesianDualWithGivenCoproduct",
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  cache_name := "CocartesianEvaluationForCocartesianDualWithGivenCoproduct",
  return_type := "morphism" ),

MorphismFromCocartesianBidualWithGivenCocartesianBidual := rec(
  installation_name := "MorphismFromCocartesianBidualWithGivenCocartesianBidual",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "MorphismFromCocartesianBidualWithGivenCocartesianBidual",
  return_type := "morphism" ),

CoexponentialCoproductCompatibilityMorphismWithGivenObjects := rec(
  installation_name := "CoexponentialCoproductCompatibilityMorphismWithGivenObjects",
  filter_list := [ "category", "object", "object", "object", "object", IsList ],
  cache_name := "CoexponentialCoproductCompatibilityMorphismWithGivenObjects",
  return_type := "morphism" ),

CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects := rec(
  installation_name := "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects",
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects",
  return_type := "morphism" ),

MorphismFromCoexponentialToCoproductWithGivenObjects := rec(
  installation_name := "MorphismFromCoexponentialToCoproductWithGivenObjects",
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "MorphismFromCoexponentialToCoproductWithGivenObjects",
  return_type := "morphism" ),

IsomorphismFromCocartesianDualToCoexponential := rec(
  installation_name := "IsomorphismFromCocartesianDualToCoexponential",
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "i", "d" ] ],
  cache_name := "IsomorphismFromCocartesianDualToCoexponential",
  return_type := "morphism",
),

IsomorphismFromCoexponentialToCocartesianDual := rec(
  installation_name := "IsomorphismFromCoexponentialToCocartesianDual",
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "d", "i" ] ],
  cache_name := "IsomorphismFromCoexponentialToCocartesianDual",
  return_type := "morphism",
),

UniversalPropertyOfCocartesianDual := rec(
  installation_name := "UniversalPropertyOfCocartesianDual",
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "t", "alpha" ], [ "d", "t" ] ],
  cache_name := "UniversalPropertyOfCocartesianDual",
  return_type := "morphism",
),

CocartesianLambdaIntroduction := rec(
  installation_name := "CocartesianLambdaIntroduction",
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "i" ] ],
  cache_name := "CocartesianLambdaIntroduction",
  return_type := "morphism",
),

CocartesianLambdaElimination := rec(
  installation_name := "CocartesianLambdaElimination",
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "alpha" ], [ "a", "b" ] ],
  cache_name := "CocartesianLambdaElimination",
  return_type := "morphism",
),

IsomorphismFromObjectToCoexponentialWithGivenCoexponential := rec(
  installation_name := "IsomorphismFromObjectToCoexponentialWithGivenCoexponential",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "IsomorphismFromObjectToCoexponentialWithGivenCoexponential",
  return_type := "morphism" ),

IsomorphismFromCoexponentialToObjectWithGivenCoexponential := rec(
  installation_name := "IsomorphismFromCoexponentialToObjectWithGivenCoexponential",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "IsomorphismFromCoexponentialToObjectWithGivenCoexponential",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD );
