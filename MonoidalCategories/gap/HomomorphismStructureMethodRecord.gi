InstallValue( HOMOMORPHISM_STRUCTURE_FROM_CLOSED_STRUCTURE_METHOD_NAME_RECORD, rec(

MorphismLiftingMorphismsFromTensorUnit := rec(
  installation_name := "MorphismLiftingMorphismsFromTensorUnit",
  filter_list := [ "object" ],
  return_type := "morphism",
  io_type := [ [ "a" ], [ "h", "a" ] ],
  cache_name := "MorphismLiftingMorphismsFromTensorUnit",
  is_merely_set_theoretic := true,
),

LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism := rec(
  installation_name := "LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism",
  filter_list := [ "morphism", "morphism" ],
  return_type := "morphism",
  io_type := [ [ "iota", "eta" ], [ "iota_source", "eta_source" ] ],
  cache_name := "LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism",
  is_merely_set_theoretic := true,
),

MorphismUniquelyLiftingMorphismsFromTensorUnit := rec(
  installation_name := "MorphismUniquelyLiftingMorphismsFromTensorUnit",
  filter_list := [ "object" ],
  io_type := [ [ "a" ], [ "h", "a" ] ],
  return_type := "morphism",
  cache_name := "MorphismUniquelyLiftingMorphismsFromTensorUnit",
),

LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism := rec(
  installation_name := "LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism",
  filter_list := [ "morphism", "morphism" ],
  return_type := "morphism",
  io_type := [ [ "iota", "eta" ], [ "iota_source", "eta_source" ] ],
  cache_name := "LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism",
),

InterpretAsObjectInRangeCategoryOfHomomorphismStructure := rec(
  installation_name := "InterpretAsObjectInRangeCategoryOfHomomorphismStructure",
  filter_list := [ "object" ],
  return_type := "other_object",
  cache_name := "InterpretAsObjectInRangeCategoryOfHomomorphismStructure",
),

InterpretAsMorphismInRangeCategoryOfHomomorphismStructure := rec(
  installation_name := "InterpretAsMorphismInRangeCategoryOfHomomorphismStructure",
  filter_list := [ "morphism" ],
  return_type := "other_morphism",
  cache_name := "InterpretAsMorphismInRangeCategoryOfHomomorphismStructure",
),

InterpretObjectFromRangeCategoryOfHomomorphismStructure := rec(
  installation_name := "InterpretObjectFromRangeCategoryOfHomomorphismStructure",
  filter_list := [ "category", "other_object" ],
  return_type := "object",
  cache_name := "InterpretObjectFromRangeCategoryOfHomomorphismStructure",
),

InterpretMorphismFromRangeCategoryOfHomomorphismStructure := rec(
  installation_name := "InterpretMorphismFromRangeCategoryOfHomomorphismStructure",
  filter_list := [ "category", "other_morphism" ],
  return_type := "morphism",
  cache_name := "InterpretMorphismFromRangeCategoryOfHomomorphismStructure",
),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( HOMOMORPHISM_STRUCTURE_FROM_CLOSED_STRUCTURE_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( HOMOMORPHISM_STRUCTURE_FROM_CLOSED_STRUCTURE_METHOD_NAME_RECORD );
