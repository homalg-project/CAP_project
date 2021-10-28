InstallValue( HOMOMORPHISM_STRUCTURE_FROM_CLOSED_STRUCTURE_METHOD_NAME_RECORD, rec(

MorphismLiftingMorphismsFromTensorUnit := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  io_type := [ [ "a" ], [ "h", "a" ] ],
  is_merely_set_theoretic := true,
),

LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  return_type := "morphism",
  io_type := [ [ "iota", "eta" ], [ "iota_source", "eta_source" ] ],
  is_merely_set_theoretic := true,
),

MorphismUniquelyLiftingMorphismsFromTensorUnit := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "h", "a" ] ],
  return_type := "morphism",
),

LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  return_type := "morphism",
  io_type := [ [ "iota", "eta" ], [ "iota_source", "eta_source" ] ],
),

InterpretAsObjectInRangeCategoryOfHomomorphismStructure := rec(
  filter_list := [ "category", "object" ],
  return_type := "other_object",
),

InterpretAsMorphismInRangeCategoryOfHomomorphismStructure := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "other_morphism",
),

InterpretObjectFromRangeCategoryOfHomomorphismStructure := rec(
  filter_list := [ "category", "other_object" ],
  return_type := "object",
),

InterpretMorphismFromRangeCategoryOfHomomorphismStructure := rec(
  filter_list := [ "category", "other_morphism" ],
  return_type := "morphism",
),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( HOMOMORPHISM_STRUCTURE_FROM_CLOSED_STRUCTURE_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    HOMOMORPHISM_STRUCTURE_FROM_CLOSED_STRUCTURE_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "HomomorphismStructure.autogen.gd",
    "Monoidal Categories",
    "Homomorphism Structure"
);

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( HOMOMORPHISM_STRUCTURE_FROM_CLOSED_STRUCTURE_METHOD_NAME_RECORD );
